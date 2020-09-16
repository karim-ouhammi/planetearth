package com.planetearth.servlets.addition;

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
import com.planetearth.dao.DAOFactory;
import com.planetearth.dao.ThemeDao;
import com.planetearth.dao.TypeDao;
import com.planetearth.forms.AjouterThemeForm;

@WebServlet( "/liste_themes" )
public class AjouterTheme extends HttpServlet {
    private static final String CONF_DAO_FACTORY = "daoFactory";
    private static final String VUE              = "/WEB-INF/espace_admin/themes.jsp";

    private static final String ATT_THEME        = "theme";
    private static final String ATT_FORM         = "form";
    private static final String ATT_SESSION_TYPE = "themes";

    private ThemeDao            themeDao;
    private TypeDao             typeDao;

    public void init() throws ServletException {
        this.themeDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getThemeDao();
        this.typeDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getTypeDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        /* Affichage de la page d'inscription */
        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }

    protected void doPost( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        /* Préparation de l'objet formulaire */
        AjouterThemeForm form = new AjouterThemeForm( themeDao, typeDao );
        Theme theme = form.ajouterTheme( request );

        request.setAttribute( ATT_THEME, theme );
        request.setAttribute( ATT_FORM, form );

        if ( form.getErreurs().isEmpty() ) {
            HttpSession session = request.getSession();
            Map<Long, Theme> mapThemes = (HashMap<Long, Theme>) session.getAttribute( ATT_SESSION_TYPE );

            if ( mapThemes == null ) {
                mapThemes = new HashMap<Long, Theme>();
            }
            mapThemes.put( theme.getId(), theme );

            session.setAttribute( ATT_SESSION_TYPE, mapThemes );
            request.removeAttribute( ATT_THEME );
        }

        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }
}
