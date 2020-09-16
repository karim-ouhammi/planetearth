package com.planetearth.servlets.addition;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.planetearth.beans.Destination;
import com.planetearth.dao.DAOFactory;
import com.planetearth.dao.DestinationDao;
import com.planetearth.forms.AjouterDestinationForm;

@WebServlet( "/liste_destinations" )
public class AjouterDestination extends HttpServlet {
    private static final String CONF_DAO_FACTORY        = "daoFactory";
    private static final String VUE                     = "/WEB-INF/espace_admin/destinations.jsp";
    private static final String ATT_DESTINATION         = "destination";
    private static final String ATT_FORM                = "form";
    private static final String ATT_SESSION_DESTINATION = "destinations";

    private DestinationDao      destinationDao;

    public void init() throws ServletException {
        this.destinationDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getDestinationDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        /* Affichage de la page d'inscription */
        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }

    protected void doPost( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        /* Préparation de l'objet formulaire */
        AjouterDestinationForm form = new AjouterDestinationForm( destinationDao );
        Destination destination = form.ajouterDestination( request );

        request.setAttribute( ATT_DESTINATION, destination );
        request.setAttribute( ATT_FORM, form );

        if ( form.getErreurs().isEmpty() ) {
            HttpSession session = request.getSession();
            Map<String, List<Destination>> mapDestinations = (HashMap<String, List<Destination>>) session
                    .getAttribute( ATT_SESSION_DESTINATION );

            if ( mapDestinations == null ) {
                mapDestinations = new HashMap<String, List<Destination>>();
            }
            List<Destination> destinations = mapDestinations.get( destination.getContinent() );
            destinations.add( destination );
            mapDestinations.put( destination.getContinent(), destinations );

            session.setAttribute( ATT_SESSION_DESTINATION, mapDestinations );
            request.removeAttribute( ATT_DESTINATION );
        }

        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }
}
