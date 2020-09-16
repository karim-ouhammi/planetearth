package com.planetearth.servlets.suppression;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.planetearth.beans.VoyagePanier;
import com.planetearth.dao.DAOException;
import com.planetearth.dao.DAOFactory;
import com.planetearth.dao.VoyagePanierDao;

@WebServlet( "/panierSuppressionVoyage" )
public class SuppressionVoyagePanier extends HttpServlet {
    private static final String CONF_DAO_FACTORY          = "daoFactory";

    private static final String PARAM_ID                  = "idVoyage";
    private static final String ATT_SESSION_VOYAGE_PANIER = "voyagePaniers";

    private static final String ATT_ECHEC                 = "echec";
    private static final String ATT_SUCCES                = "succes";

    private static final String VUE                       = "/panier";

    private VoyagePanierDao     voyagePanierDao;

    public void init() throws ServletException {
        this.voyagePanierDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) )
                .getVoyagePanierDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        String idVoyage = getValeurParametre( request, PARAM_ID );
        try {
            Long id = Long.parseLong( idVoyage );
            HttpSession session = request.getSession();
            Map<Long, VoyagePanier> voyagePaniers = (HashMap<Long, VoyagePanier>) session
                    .getAttribute( ATT_SESSION_VOYAGE_PANIER );

            /*
             * Si l'id du voyagePanier et la Map des voyagePaniers ne sont pas
             * vides
             */
            if ( id != null && voyagePaniers != null ) {
                VoyagePanier voyagePanier = voyagePaniers.get( id );

                if ( voyagePanier != null ) {
                    /* Alors suppression de la base */
                    voyagePanierDao.delete( voyagePanier.getVoyage().getId(),
                            voyagePanier.getUtilisateur().getIdPanier() );
                    /* Puis suppression du thème de la Map */
                    voyagePaniers.remove( id );

                    /*
                     * Et remplacement de l'ancienne Map en session par la
                     * nouvelle
                     */
                    session.setAttribute( ATT_SESSION_VOYAGE_PANIER, voyagePaniers );
                    request.setAttribute( ATT_SUCCES, "Suppression effectuée avec succès." );
                } else {
                    request.setAttribute( ATT_ECHEC, "Échec de la suppression." );
                }
            }
        } catch ( NumberFormatException e ) {
            request.setAttribute( ATT_ECHEC, "Échec de la suppression." );
            e.printStackTrace();
            this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
            return;
        } catch ( DAOException e ) {
            request.setAttribute( ATT_ECHEC, "Échec de la suppression." );
            e.printStackTrace();
            this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
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
