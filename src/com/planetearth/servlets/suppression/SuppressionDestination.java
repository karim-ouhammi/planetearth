package com.planetearth.servlets.suppression;

import java.io.IOException;
import java.util.ArrayList;
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
import com.planetearth.dao.DAOException;
import com.planetearth.dao.DAOFactory;
import com.planetearth.dao.DestinationDao;

@WebServlet( "/suppressionDestination" )
public class SuppressionDestination extends HttpServlet {
    private static final String CONF_DAO_FACTORY        = "daoFactory";
    private static final String PARAM_NOM               = "nom";
    private static final String PARAM_CONTINENT         = "continent";
    private static final String ATT_SESSION_DESTINATION = "destinations";

    public static final String  VUE                     = "/WEB-INF/espace_admin/destinations.jsp";

    private DestinationDao      destinationDao;

    public void init() throws ServletException {
        this.destinationDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getDestinationDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        String nom = getValeurParametre( request, PARAM_NOM );
        String continent = getValeurParametre( request, PARAM_CONTINENT );

        HttpSession session = request.getSession();
        Map<String, List<Destination>> mapDestinations = (HashMap<String, List<Destination>>) session
                .getAttribute( ATT_SESSION_DESTINATION );
        List<Destination> destinations = new ArrayList<Destination>();

        if ( nom != null && destinations != null ) {
            try {
                /* Alors suppression de la base */
                destinationDao.delete( nom );
                /* Puis suppression du client de la Map */
                destinations = mapDestinations.get( continent );

                for ( int i = 0; i < destinations.size(); i++ ) {
                    if ( destinations.get( i ).getNom().equals( nom ) ) {
                        destinations.remove( i );
                        break;
                    }
                }
                mapDestinations.replace( continent, destinations );
                session.setAttribute( ATT_SESSION_DESTINATION, mapDestinations );
            } catch ( DAOException e ) {
                e.printStackTrace();
            }
        }
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
