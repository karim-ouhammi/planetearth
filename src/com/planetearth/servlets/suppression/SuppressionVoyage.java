package com.planetearth.servlets.suppression;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.IIOException;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.planetearth.beans.Voyage;
import com.planetearth.dao.DAOException;
import com.planetearth.dao.DAOFactory;
import com.planetearth.dao.VoyageDao;

@WebServlet( urlPatterns = "/suppressionVoyage", initParams = @WebInitParam( name = "chemin", value = "/inc/images/" ) )
public class SuppressionVoyage extends HttpServlet {
    private static final String CONF_DAO_FACTORY   = "daoFactory";

    private static final String CHEMIN             = "chemin";

    private static final String CHAMP_IMAGELISTE   = "imageListe";
    private static final String CHAMP_IMAGE1       = "image1";
    private static final String CHAMP_IMAGE2       = "image2";
    private static final String CHAMP_IMAGE3       = "image3";

    private static final String PARAM_ID           = "idVoyage";
    private static final String ATT_SESSION_VOYAGE = "voyages";

    public static final String  VUE                = "/WEB-INF/espace_admin/voyages.jsp";

    private VoyageDao           voyageDao;

    public void init() throws ServletException {
        this.voyageDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getVoyageDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        String idVoyage = getValeurParametre( request, PARAM_ID );

        HttpSession session = request.getSession();
        Map<Long, Voyage> voyages = (HashMap<Long, Voyage>) session.getAttribute( ATT_SESSION_VOYAGE );

        /* Si l'id du voyage et la Map des voyages ne sont pas vides */
        if ( voyages != null ) {
            try {
                Long id = Long.parseLong( idVoyage );

                /* Alors suppression de la base */
                voyageDao.delete( id );
                /* Puis suppression du thème de la Map */
                voyages.remove( id );

                /*
                 * Et remplacement de l'ancienne Map en session par la nouvelle
                 */
                session.setAttribute( ATT_SESSION_VOYAGE, voyages );

                /* Suppression des images */
                String chemin = getServletContext().getRealPath( this.getServletConfig().getInitParameter( CHEMIN ) );
                String path = chemin + id + "_";
                String champs[] = { CHAMP_IMAGELISTE, CHAMP_IMAGE1, CHAMP_IMAGE2, CHAMP_IMAGE3 };

                for ( String champ : champs ) {
                    BufferedImage img = ImageIO.read( new File( path + champ ) );

                    Files.delete( Paths.get( path + champ ) );

                    System.out.println( "File : " + Paths.get( path + champ ) + " deleted." );
                }

            } catch ( DAOException ignore ) {
                ignore.printStackTrace();
            } catch ( NumberFormatException ignore ) {
                ignore.printStackTrace();
            } catch ( IIOException ignore ) {
                ignore.printStackTrace();
            } catch ( Exception e ) {
                e.printStackTrace();
            }
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
