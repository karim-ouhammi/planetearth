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

import com.planetearth.beans.Voyage;
import com.planetearth.dao.DAOFactory;
import com.planetearth.dao.DestinationDao;
import com.planetearth.dao.VoyageDao;
import com.planetearth.forms.ModifierVoyageForm;

@WebServlet( "/modificationVoyage" )
public class ModificationVoyage extends HttpServlet {
    private static final String CONF_DAO_FACTORY   = "daoFactory";

    public static final String  VUE                = "/WEB-INF/espace_admin/afficher_voyage.jsp";
    private static final String VUE_MODIFICATON    = "/WEB-INF/espace_admin/modification_voyage.jsp";

    private static final String ATT_VOYAGE         = "voyage";
    private static final String ATT_FORM           = "form";

    private static final String ATT_SESSION_VOYAGE = "voyages";

    private static final String PARAM_ID           = "idVoyage";

    private VoyageDao           voyageDao;
    private DestinationDao      destinationDao;

    public void init() throws ServletException {
        this.voyageDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getVoyageDao();
        this.destinationDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getDestinationDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        String idValeur = getValeurParam( request, PARAM_ID );

        HttpSession session = request.getSession();
        Map<Long, Voyage> voyages = (Map<Long, Voyage>) session.getAttribute( ATT_SESSION_VOYAGE );

        try {
            Voyage voyage = voyages.get( Long.parseLong( idValeur ) );
            request.setAttribute( ATT_VOYAGE, voyage );
        } catch ( NumberFormatException e ) {
            e.printStackTrace();
            this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
            return;
        }
        this.getServletContext().getRequestDispatcher( VUE_MODIFICATON ).forward( request, response );
    }

    protected void doPost( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        /* Préparation de l'objet formulaire */
        ModifierVoyageForm form = new ModifierVoyageForm( voyageDao, destinationDao );
        Voyage voyage = form.modifierVoyage( request );

        request.setAttribute( ATT_VOYAGE, voyage );
        request.setAttribute( ATT_FORM, form );

        if ( form.getErreurs().isEmpty() ) {
            HttpSession session = request.getSession();
            Map<Long, Voyage> mapVoyages = (HashMap<Long, Voyage>) session.getAttribute( ATT_SESSION_VOYAGE );

            if ( mapVoyages == null ) {
                mapVoyages = new HashMap<Long, Voyage>();
            }
            mapVoyages.put( voyage.getId(), voyage );

            session.setAttribute( ATT_SESSION_VOYAGE, mapVoyages );

            this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
            return;
        }

        this.getServletContext().getRequestDispatcher( VUE_MODIFICATON ).forward( request, response );
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
