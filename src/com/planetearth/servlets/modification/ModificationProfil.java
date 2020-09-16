package com.planetearth.servlets.modification;

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
import com.planetearth.forms.ModificationProfilForm;

@WebServlet( "/modificationProfil" )
public class ModificationProfil extends HttpServlet {
    private static final String CONF_DAO_FACTORY = "daoFactory";

    private static final String VUE              = "/WEB-INF/profil.jsp";
    private static final String VUE_MODIFICATION = "/WEB-INF/modification_profil.jsp";

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

        request.setAttribute( ATT_USER, user );

        this.getServletContext().getRequestDispatcher( VUE_MODIFICATION ).forward( request, response );
    }

    protected void doPost( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute( ATT_SESSION_USER );

        /* Préparation de l'objet formulaire */
        ModificationProfilForm form = new ModificationProfilForm( utilisateurDao );
        Utilisateur utilisateur = form.modifierUtilisateur( request, user.getEmail() );

        request.setAttribute( ATT_USER, utilisateur );
        request.setAttribute( ATT_FORM, form );

        if ( form.getErreurs().isEmpty() ) {
            user.setEmail( utilisateur.getEmail() );
            user.setNom( utilisateur.getNom() );
            user.setPrenom( utilisateur.getPrenom() );
            user.setAge( utilisateur.getAge() );
            user.setTelephone( utilisateur.getTelephone() );

            session.setAttribute( ATT_SESSION_USER, user );

            this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
            return;
        }

        this.getServletContext().getRequestDispatcher( VUE_MODIFICATION ).forward( request, response );
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
