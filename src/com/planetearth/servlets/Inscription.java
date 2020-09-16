package com.planetearth.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.planetearth.beans.Utilisateur;
import com.planetearth.dao.DAOFactory;
import com.planetearth.dao.UtilisateurDao;
import com.planetearth.forms.InscriptionForm;

@WebServlet( "/inscription" )
public class Inscription extends HttpServlet {
    private static final String CONF_DAO_FACTORY = "daoFactory";
    private static final String VUE              = "/WEB-INF/inscription.jsp";
    private static final String VUE_ACCUEIL      = "/index.jsp";
    private static final String VUE_SUCCES       = "/connexion.jsp";

    private static final String ATT_SESSION_USER = "sessionUtilisateur";

    private static final String ATT_USER         = "utilisateur";
    private static final String ATT_FORM         = "form";

    private UtilisateurDao      utilisateurDao;

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

        /* Affichage de la page d'inscription */
        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }

    protected void doPost( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        /* Préparation de l'objet formulaire */
        InscriptionForm form = new InscriptionForm( utilisateurDao );
        Utilisateur utilisateur = form.inscrireUtilisateur( request );

        request.setAttribute( ATT_USER, utilisateur );
        request.setAttribute( ATT_FORM, form );

        if ( form.getErreurs().isEmpty() ) {
            this.getServletContext().getRequestDispatcher( VUE_SUCCES ).forward( request, response );
        }

        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
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
