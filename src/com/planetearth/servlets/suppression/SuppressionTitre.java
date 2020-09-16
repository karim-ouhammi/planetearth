package com.planetearth.servlets.suppression;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.planetearth.beans.Type;
import com.planetearth.dao.DAOException;
import com.planetearth.dao.DAOFactory;
import com.planetearth.dao.TitreDao;

@WebServlet( urlPatterns = "/suppressionTitre", initParams = @WebInitParam( name = "chemin", value = "/inc/images/titres/" ) )
public class SuppressionTitre extends HttpServlet {
    private static final String CONF_DAO_FACTORY  = "daoFactory";

    private static final String CHEMIN            = "chemin";

    private static final String CHAMP_IMAGE       = "image";

    private static final String PARAM_ID          = "idTitre";
    private static final String ATT_SESSION_TITRE = "titres";

    public static final String  VUE               = "/WEB-INF/espace_admin/titres.jsp";

    private TitreDao            titreDao;

    public void init() throws ServletException {
        this.titreDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getTitreDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        String idTitre = getValeurParametre( request, PARAM_ID );

        HttpSession session = request.getSession();
        Map<Long, Type> titres = (HashMap<Long, Type>) session.getAttribute( ATT_SESSION_TITRE );

        try {
            Long id = Long.parseLong( idTitre );

            /* Si l'id du titre et la Map des types ne sont pas vides */
            if ( id != null && titres != null ) {
                /* Alors suppression de la base */
                titreDao.delete( id );
                /* Puis suppression du type de la Map */
                titres.remove( id );
                /*
                 * Et remplacement de l'ancienne Map en session par la nouvelle
                 */
                session.setAttribute( ATT_SESSION_TITRE, titres );

                /* Suppression des images */
                String chemin = getServletContext().getRealPath( this.getServletConfig().getInitParameter( CHEMIN ) );
                String path = chemin + id + "_" + CHAMP_IMAGE;

                BufferedImage img = ImageIO.read( new File( path ) );

                Files.delete( Paths.get( path ) );
            }

        } catch ( DAOException e ) {
            e.printStackTrace();
        } catch ( NumberFormatException e ) {
            e.printStackTrace();
        }
        /* Redirection vers la fiche récapitulative */
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