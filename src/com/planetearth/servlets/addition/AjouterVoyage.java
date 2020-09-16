package com.planetearth.servlets.addition;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.planetearth.beans.Voyage;
import com.planetearth.dao.DAOFactory;
import com.planetearth.dao.DestinationDao;
import com.planetearth.dao.VoyageDao;
import com.planetearth.forms.AjouterVoyageForm;

@WebServlet( urlPatterns = "/ajouterVoyage", initParams = @WebInitParam( name = "chemin", value = "/inc/images/" ) )
@javax.servlet.annotation.MultipartConfig( location = "c:/", maxFileSize = 100 * 1024 * 1024, maxRequestSize = 50 * 10
        * 1024
        * 1024, fileSizeThreshold = 1024 * 1024 )
public class AjouterVoyage extends HttpServlet {
    private static final String CONF_DAO_FACTORY   = "daoFactory";

    private static final String CHEMIN             = "chemin";

    private static final String VUE                = "/WEB-INF/espace_admin/ajouter_voyage.jsp";

    private static final String ATT_VOYAGE         = "voyage";
    private static final String ATT_FORM           = "form";

    private static final String ATT_SESSION_VOYAGE = "voyages";

    private VoyageDao           voyageDao;
    private DestinationDao      destinationDao;

    public void init() throws ServletException {
        this.voyageDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getVoyageDao();
        this.destinationDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getDestinationDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        /* Affichage de la page */
        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }

    protected void doPost( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        /*
         * Lecture du paramètre 'chemin' passé à la servlet via la déclaration
         * dans le web.xml
         */
        String chemin = getServletContext().getRealPath( this.getServletConfig().getInitParameter( CHEMIN ) );

        /* Préparation de l'objet formulaire */
        AjouterVoyageForm form = new AjouterVoyageForm( voyageDao, destinationDao );
        Voyage voyage = form.ajouterVoyage( request, chemin );

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
            request.removeAttribute( ATT_VOYAGE );
        }

        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }
}
