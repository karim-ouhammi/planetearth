package com.planetearth.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.planetearth.beans.Message;
import com.planetearth.dao.DAOFactory;
import com.planetearth.dao.MessageDao;
import com.planetearth.forms.MessageForm;

@WebServlet( "/contact" )
public class Contact extends HttpServlet {
    private static final String CONF_DAO_FACTORY = "daoFactory";
    private static final String VUE              = "/contact.jsp";

    private static final String ATT_MESSAGE      = "message";
    private static final String ATT_FORM         = "form";

    private MessageDao          messageDao;

    public void init() throws ServletException {
        this.messageDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getMessageDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        /* Affichage de la page d'inscription */
        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }

    protected void doPost( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {

        /* Préparation de l'objet formulaire */
        MessageForm form = new MessageForm( messageDao );
        Message message = form.envoyerMessage( request );

        request.setAttribute( ATT_MESSAGE, message );
        request.setAttribute( ATT_FORM, form );

        if ( form.getErreurs().isEmpty() ) {
            request.removeAttribute( ATT_MESSAGE );
        }

        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }
}
