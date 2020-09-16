package com.planetearth.servlets;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.planetearth.beans.Utilisateur;
import com.planetearth.beans.Voyage;
import com.planetearth.dao.DAOFactory;
import com.planetearth.dao.UtilisateurDao;
import com.planetearth.forms.ConnexionForm;

@WebServlet( "/connexion" )
public class Connexion extends HttpServlet {
    private static final String CONF_DAO_FACTORY   = "daoFactory";
    private static final String VUE                = "/WEB-INF/connexion.jsp";
    private static final String VUE_SUCCES         = "/index.jsp";
    private static final String VUE_VOYAGE         = "/afficher_voyage.jsp";
    private static final String VUE_ACCUEIL        = "/index.jsp";

    private static final String ATT_USER           = "utilisateur";
    private static final String ATT_FORM           = "form";
    private static final String ATT_VOYAGE         = "voyage";

    private static final String ATT_SESSION_USER   = "sessionUtilisateur";
    private static final String ATT_SESSION_VOYAGE = "voyages";

    private static final String PARAM_ID           = "idVoyage";

    private UtilisateurDao      utilisateurDao;
    private Long                idVoyage           = null;

    public void init() throws ServletException {
        this.utilisateurDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getUtilisateurDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute( ATT_SESSION_USER );
        if ( user != null ) {
            this.getServletContext().getRequestDispatcher( VUE_ACCUEIL ).forward( request, response );
            return;
        }

        try {
            idVoyage = Long.parseLong( getValeurParam( request, PARAM_ID ) );
        } catch ( NumberFormatException e ) {
            e.printStackTrace();
        }
        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }

    protected void doPost( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        /* Préparation de l'objet formulaire */
        ConnexionForm form = new ConnexionForm( utilisateurDao );
        Utilisateur utilisateur = form.connecterUtilisateur( request );

        HttpSession session = request.getSession();

        /**
         * Si aucune erreur de validation n'a eu lieu, alors ajout du bean
         * Utilisateur à la session, sinon suppression du bean de la session. ET
         * Stockage du formulaire et du bean dans l'objet request
         */
        request.setAttribute( ATT_USER, utilisateur );
        request.setAttribute( ATT_FORM, form );

        if ( form.getErreurs().isEmpty() ) {
            session.setAttribute( ATT_SESSION_USER, utilisateur );

            if ( idVoyage == null ) {
                this.getServletContext().getRequestDispatcher( VUE_SUCCES ).forward( request, response );
            } else {
                Map<Long, Voyage> voyages = (Map<Long, Voyage>) request.getSession()
                        .getAttribute( ATT_SESSION_VOYAGE );
                if ( voyages != null ) {
                    request.setAttribute( ATT_VOYAGE, voyages.get( idVoyage ) );
                }
                idVoyage = null;
                this.getServletContext().getRequestDispatcher( VUE_VOYAGE ).forward( request, response );
            }

        } else {
            session.setAttribute( ATT_SESSION_USER, null );

            this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
        }
    }

    private static String getValeurParam( HttpServletRequest request, String nomChamp ) {
        String valeur = request.getParameter( nomChamp );
        if ( valeur == null || valeur.trim().length() == 0 ) {
            return null;
        } else {
            return valeur.trim();
        }
    }
}
