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

import com.planetearth.beans.Utilisateur;
import com.planetearth.beans.Voyage;
import com.planetearth.beans.VoyagePanier;
import com.planetearth.dao.DAOException;
import com.planetearth.dao.DAOFactory;
import com.planetearth.dao.VoyagePanierDao;

@WebServlet( "/panierAjouterVoyage" )
public class AjouterVoyagePanier extends HttpServlet {
    private static final String CONF_DAO_FACTORY          = "daoFactory";

    private static final String VUE                       = "/afficher_voyage.jsp";
    private static final String VUE_VOYAGE                = "/voyages.jsp";

    private static final String ATT_VOYAGE_PANIER         = "voyagePanier";
    private static final String ATT_VOYAGE                = "voyage";
    private static final String ATT_FORM                  = "form";

    private static final String ATT_SESSION_USER          = "sessionUtilisateur";
    private static final String ATT_SESSION_VOYAGE        = "voyages";
    private static final String ATT_SESSION_VOYAGE_PANIER = "voyagePaniers";

    private static final String CHAMP_NB_PERSONNE         = "nbPersonne";
    private static final String CHAMP_VOYAGE              = "idVoyage";

    private VoyagePanierDao     voyagePanierDao;

    private String              resultat;
    private Map<String, String> erreurs                   = new HashMap<String, String>();

    public String getResultat() {
        return resultat;
    }

    public Map<String, String> getErreurs() {
        return erreurs;
    }

    public void init() throws ServletException {
        this.voyagePanierDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) )
                .getVoyagePanierDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        /* Affichage de la page d'inscription */
        this.getServletContext().getRequestDispatcher( VUE_VOYAGE ).forward( request, response );
    }

    protected void doPost( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        String nbPersonne = getValeurChamp( request, CHAMP_NB_PERSONNE );
        String idVoyage = getValeurChamp( request, CHAMP_VOYAGE );

        HttpSession session = request.getSession();
        Map<Long, Voyage> mapVoyages = (HashMap<Long, Voyage>) session.getAttribute( ATT_SESSION_VOYAGE );

        Utilisateur utilisateur = (Utilisateur) session.getAttribute( ATT_SESSION_USER );
        Voyage voyage = null;

        VoyagePanier voyagePanier = new VoyagePanier();

        try {
            voyage = mapVoyages.get( Long.parseLong( idVoyage ) );

            voyagePanier.setNbPersonne( Integer.parseInt( nbPersonne ) );
            voyagePanier.setUtilisateur( utilisateur );
            voyagePanier.setVoyage( voyage );

            voyagePanierDao.create( voyagePanier );
        } catch ( DAOException e ) {
            setErreur( "imprévu ", "Erreur imprévue lors de la demande." );
            resultat = "Échec de la demande : une erreur imprévue est survenue, merci de réessayer dans quelques instants.";
            e.printStackTrace();
        } catch ( NumberFormatException e ) {
            setErreur( "imprévu ", "Erreur imprévue lors de la demande." );
            resultat = "Échec de la demande.";
            e.printStackTrace();
        }

        if ( erreurs.isEmpty() ) {
            Map<Long, VoyagePanier> mapVoyagePaniers = (HashMap<Long, VoyagePanier>) session
                    .getAttribute( ATT_SESSION_VOYAGE_PANIER );

            if ( mapVoyagePaniers == null ) {
                mapVoyagePaniers = new HashMap<Long, VoyagePanier>();
            }
            mapVoyagePaniers.put( voyage.getId(), voyagePanier );

            session.setAttribute( ATT_SESSION_VOYAGE_PANIER, mapVoyagePaniers );

            resultat = "Votre demande a été ajouté avec succès";
        }

        request.setAttribute( ATT_FORM, this );
        request.setAttribute( ATT_VOYAGE, voyage );

        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }

    private static String getValeurChamp( HttpServletRequest request, String nomChamp ) {
        String valeur = request.getParameter( nomChamp );
        if ( valeur == null || valeur.trim().length() == 0 ) {
            return null;
        } else {
            return valeur;
        }
    }

    private void setErreur( String champ, String message ) {
        erreurs.put( champ, message );
    }
}
