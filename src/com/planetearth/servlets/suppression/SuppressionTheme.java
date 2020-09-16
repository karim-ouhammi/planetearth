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

import com.planetearth.beans.Theme;
import com.planetearth.dao.DAOException;
import com.planetearth.dao.DAOFactory;
import com.planetearth.dao.ThemeDao;

@WebServlet( "/suppressionTheme" )
public class SuppressionTheme extends HttpServlet {
    private static final String CONF_DAO_FACTORY  = "daoFactory";

    private static final String PARAM_ID          = "idTheme";
    private static final String ATT_SESSION_THEME = "themes";

    public static final String  VUE               = "/WEB-INF/espace_admin/themes.jsp";

    private ThemeDao            themeDao;

    public void init() throws ServletException {
        this.themeDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getThemeDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        String idType = getValeurParametre( request, PARAM_ID );

        HttpSession session = request.getSession();
        Map<Long, Theme> themes = (HashMap<Long, Theme>) session.getAttribute( ATT_SESSION_THEME );

        /* Si l'id du thème et la Map des themes ne sont pas vides */
        if ( themes != null ) {
            try {
                Long id = Long.parseLong( idType );

                /* Alors suppression de la base */
                themeDao.delete( id );
                /* Puis suppression du thème de la Map */
                themes.remove( id );

                /*
                 * Et remplacement de l'ancienne Map en session par la nouvelle
                 */
                session.setAttribute( ATT_SESSION_THEME, themes );
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
