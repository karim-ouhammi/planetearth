package com.planetearth.servlets.modification;

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
import com.planetearth.dao.TypeDao;
import com.planetearth.forms.ModifierThemeForm;

@WebServlet( "/modificationTheme" )
public class ModificationTheme extends HttpServlet {
    private static final String CONF_DAO_FACTORY  = "daoFactory";

    private static final String ATT_SESSION_THEME = "themes";
    private static final String ATT_THEME         = "theme";
    private static final String ATT_FORM          = "form";

    private static final String PARAM_ID          = "idTheme";

    public static final String  VUE               = "/WEB-INF/espace_admin/themes.jsp";
    public static final String  VUE_MODIFICATION  = "/WEB-INF/espace_admin/modification_theme.jsp";

    private ThemeDao            themeDao;
    private TypeDao             typeDao;

    public void init() throws ServletException {
        this.themeDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getThemeDao();
        this.typeDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getTypeDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {

        String idValeur = getValeurParam( request, PARAM_ID );
        try {
            Long id = Long.parseLong( idValeur );
            request.setAttribute( ATT_THEME, themeDao.read( id, typeDao ) );
        } catch ( NumberFormatException e ) {
            e.printStackTrace();
        }
        this.getServletContext().getRequestDispatcher( VUE_MODIFICATION ).forward( request, response );
    }

    @Override
    protected void doPost( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {

        ModifierThemeForm form = new ModifierThemeForm( themeDao, typeDao );
        Theme theme = form.modifierTheme( request );

        request.setAttribute( ATT_THEME, theme );
        request.setAttribute( ATT_FORM, form );

        if ( form.getErreurs().isEmpty() ) {
            try {
                HttpSession session = request.getSession();
                Map<Long, Theme> mapThemes = (HashMap<Long, Theme>) session.getAttribute( ATT_SESSION_THEME );

                /* Mise a jour dans la base */
                themeDao.update( theme );
                /* Puis Mise a jour dans la Map */
                mapThemes.replace( theme.getId(), theme );
                /*
                 * Et remplacement de l'ancienne Map en session par la nouvelle
                 */
                session.setAttribute( ATT_SESSION_THEME, mapThemes );
                request.removeAttribute( ATT_THEME );
            } catch ( DAOException e ) {
                e.printStackTrace();
            }
            /* Redirection vers la fiche récapitulative */
            this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
        } else {
            this.getServletContext().getRequestDispatcher( VUE_MODIFICATION ).forward( request, response );
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
