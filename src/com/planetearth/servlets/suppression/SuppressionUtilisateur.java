package com.planetearth.servlets.suppression;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.planetearth.beans.Utilisateur;
import com.planetearth.dao.DAOException;
import com.planetearth.dao.DAOFactory;
import com.planetearth.dao.UtilisateurDao;

/**
 * Servlet implementation class SuppressionUtilisateur
 */
@WebServlet( "/suppressionUtilisateur" )
public class SuppressionUtilisateur extends HttpServlet {
    private static final String CONF_DAO_FACTORY        = "daoFactory";
    private static final String PARAM_EMAIL             = "email";
    private static final String ATT_SESSION_UTILISATEUR = "utilisateurs";

    public static final String  VUE                     = "/WEB-INF/espace_admin/utilisateurs.jsp";

    private UtilisateurDao      utilisateurDao;

    public void init() throws ServletException {
        this.utilisateurDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getUtilisateurDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        String email = getValeurParametre( request, PARAM_EMAIL );

        HttpSession session = request.getSession();
        Map<String, Utilisateur> utilisateurs = (HashMap<String, Utilisateur>) session
                .getAttribute( ATT_SESSION_UTILISATEUR );

        /*
         * Si l'email et la Map des utilisateurs ne sont pas vides
         */
        if ( email != null && utilisateurs != null ) {
            try {
                /* Alors suppression de la base */
                utilisateurDao.delete( email );
                /* Puis suppression de la Map */
                utilisateurs.remove( email );

                /*
                 * Et remplacement de l'ancienne Map en session par la nouvelle
                 */
                session.setAttribute( ATT_SESSION_UTILISATEUR, utilisateurs );
            } catch ( DAOException e ) {
                e.printStackTrace();
            }
        }
        /* Redirection vers la fiche récapitulative */
        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }

    private static String getValeurParametre( HttpServletRequest request, String nomChamp ) {
        String valeur = request.getParameter( nomChamp );
        if ( valeur == null || valeur.trim().length() == 0 ) {
            return null;
        } else {
            return valeur;
        }
    }
}
