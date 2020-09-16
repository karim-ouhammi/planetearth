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

import com.planetearth.beans.Type;
import com.planetearth.dao.DAOException;
import com.planetearth.dao.DAOFactory;
import com.planetearth.dao.TypeDao;

@WebServlet( "/suppressionType" )
public class SuppressionType extends HttpServlet {
    private static final String CONF_DAO_FACTORY = "daoFactory";

    private static final String PARAM_ID         = "idType";
    private static final String ATT_SESSION_TYPE = "types";

    public static final String  VUE              = "/WEB-INF/espace_admin/types.jsp";

    private TypeDao             typeDao;

    public void init() throws ServletException {
        this.typeDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getTypeDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        String idType = getValeurParametre( request, PARAM_ID );

        HttpSession session = request.getSession();
        Map<Long, Type> types = (HashMap<Long, Type>) session.getAttribute( ATT_SESSION_TYPE );

        /* Si l'id du type et la Map des types ne sont pas vides */
        if ( types != null ) {
            try {
                Long id = Long.parseLong( idType );

                /* Alors suppression de la base */
                typeDao.delete( id );
                /* Puis suppression du type de la Map */
                types.remove( id );

                /*
                 * Et remplacement de l'ancienne Map en session par la nouvelle
                 */
                session.setAttribute( ATT_SESSION_TYPE, types );
            } catch ( DAOException e ) {
                e.printStackTrace();
            } catch ( NumberFormatException e ) {
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
