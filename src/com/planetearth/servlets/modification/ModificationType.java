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

import com.planetearth.beans.Type;
import com.planetearth.dao.DAOException;
import com.planetearth.dao.DAOFactory;
import com.planetearth.dao.TypeDao;
import com.planetearth.forms.ModifierTypeForm;

@WebServlet( "/modificationType" )
public class ModificationType extends HttpServlet {
    private static final String CONF_DAO_FACTORY  = "daoFactory";

    private static final String ATT_SESSION_TYPE  = "types";
    private static final String ATT_TYPE          = "type";
    private static final String ATT_FORM          = "form";

    private static final String CHAMP_ID          = "idType";
    private static final String CHAMP_NOM         = "nomType";
    private static final String CHAMP_DESCRIPTION = "description";

    public static final String  VUE               = "/WEB-INF/espace_admin/types.jsp";
    public static final String  VUE_MODIFICATION  = "/WEB-INF/espace_admin/modification_type.jsp";

    private TypeDao             typeDao;

    public void init() throws ServletException {
        this.typeDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getTypeDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {

        String idValeur = getValeurParam( request, CHAMP_ID );
        try {
            Long id = Long.parseLong( idValeur );
            request.setAttribute( ATT_TYPE, typeDao.read( id ) );
        } catch ( NumberFormatException e ) {
            e.printStackTrace();
        }
        this.getServletContext().getRequestDispatcher( VUE_MODIFICATION ).forward( request, response );
    }

    @Override
    protected void doPost( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {

        ModifierTypeForm form = new ModifierTypeForm( typeDao );
        Type type = form.modifierType( request );

        request.setAttribute( ATT_TYPE, type );
        request.setAttribute( ATT_FORM, form );

        if ( form.getErreurs().isEmpty() ) {
            try {
                HttpSession session = request.getSession();
                Map<Long, Type> mapTypes = (HashMap<Long, Type>) session.getAttribute( ATT_SESSION_TYPE );

                /* Mise a jour dans la base */
                typeDao.update( type );
                /* Puis Mise a jour dans la Map */
                mapTypes.replace( type.getId(), type );
                /*
                 * Et remplacement de l'ancienne Map en session par la nouvelle
                 */
                session.setAttribute( ATT_SESSION_TYPE, mapTypes );
                request.removeAttribute( ATT_TYPE );
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
