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

import com.planetearth.beans.Titre;
import com.planetearth.dao.DAOFactory;
import com.planetearth.dao.TitreDao;
import com.planetearth.forms.AjouterTitreForm;

@WebServlet( urlPatterns = "/liste_titres", initParams = @WebInitParam( name = "chemin", value = "/inc/images/titres/" ) )
@javax.servlet.annotation.MultipartConfig( location = "c:/", maxFileSize = 1024 * 1024 * 50, maxRequestSize = 1024
        * 1024 * 100, fileSizeThreshold = 1024 * 1024 * 10 ) // 50 Mb, 100 Mb,
                                                             // 10 Mb
public class AjouterTitre extends HttpServlet {
    private static final String CONF_DAO_FACTORY  = "daoFactory";

    private static final String VUE               = "/WEB-INF/espace_admin/titres.jsp";

    private static final String CHEMIN            = "chemin";

    private static final String ATT_TITRE         = "titre";
    private static final String ATT_FORM          = "form";

    private static final String ATT_SESSION_TITRE = "titres";

    private TitreDao            titreDao;

    public void init() throws ServletException {
        this.titreDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getTitreDao();
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
        AjouterTitreForm form = new AjouterTitreForm( titreDao );
        Titre titre = form.ajouterTitre( request, chemin );

        request.setAttribute( ATT_TITRE, titre );
        request.setAttribute( ATT_FORM, form );

        if ( form.getErreurs().isEmpty() ) {
            HttpSession session = request.getSession();
            Map<Long, Titre> mapTitres = (HashMap<Long, Titre>) session.getAttribute( ATT_SESSION_TITRE );

            if ( mapTitres == null ) {
                mapTitres = new HashMap<Long, Titre>();
            }
            mapTitres.put( titre.getId(), titre );

            session.setAttribute( ATT_SESSION_TITRE, mapTitres );
            request.removeAttribute( ATT_TITRE );
        }

        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }
}
