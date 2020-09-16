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

import com.planetearth.beans.Type;
import com.planetearth.dao.DAOFactory;
import com.planetearth.dao.TypeDao;
import com.planetearth.forms.AjouterTypeForm;

@WebServlet( "/liste_types" )
public class AjouterType extends HttpServlet {
    private static final String CONF_DAO_FACTORY = "daoFactory";
    private static final String VUE              = "/WEB-INF/espace_admin/types.jsp";

    private static final String ATT_TYPE         = "type";
    private static final String ATT_FORM         = "form";
    private static final String ATT_SESSION_TYPE = "types";

    private TypeDao             typeDao;

    public void init() throws ServletException {
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
        AjouterTypeForm form = new AjouterTypeForm( typeDao );
        Type type = form.ajouterType( request );

        request.setAttribute( ATT_TYPE, type );
        request.setAttribute( ATT_FORM, form );

        if ( form.getErreurs().isEmpty() ) {
            HttpSession session = request.getSession();
            Map<Long, Type> mapTypes = (HashMap<Long, Type>) session.getAttribute( ATT_SESSION_TYPE );

            if ( mapTypes == null ) {
                mapTypes = new HashMap<Long, Type>();
            }
            mapTypes.put( type.getId(), type );

            session.setAttribute( ATT_SESSION_TYPE, mapTypes );
            request.removeAttribute( ATT_TYPE );
        }

        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }
}
