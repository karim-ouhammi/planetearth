package com.planetearth.servlets.admin;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.planetearth.beans.Utilisateur;
import com.planetearth.beans.VoyagePanier;

@WebServlet( "/visiterPanier" )
public class VisiterPanier extends HttpServlet {
    private static final String VUE                     = "/WEB-INF/espace_admin/visiter_panier.jsp";
    private static final String VUE_ECHEC               = "/WEB-INF/espace_admin/utilisateurs.jsp";

    private static final String ATT_SESSION_UTILISATEUR = "utilisateurs";

    private static final String ATT_PANIER_UTILISATEURS = "panierUtilisateurs";

    private static final String ATT_UTILISATEUR         = "user";
    private static final String ATT_VOYAGE_PANIER       = "voyagePaniers";

    private static final String ATT_MONTANT_TOTAL       = "total";
    private static final String ATT_NB_VOYAGES          = "nbVoyages";
    private static final String ATT_MONTANT_A_PAYER     = "montantAPayer";

    private static final String PARAM_ID_PANIER         = "idPanier";
    private static final String PARAM_ENAIL             = "email";

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        String idPanierValeur = getValeurParam( request, PARAM_ID_PANIER );
        String email = getValeurParam( request, PARAM_ENAIL );
        double total = 0;
        double montantAPayer = 0;
        int nombreDeVoyages = 0;

        HttpSession session = request.getSession();

        Map<String, Utilisateur> mapUsers = (Map<String, Utilisateur>) session.getAttribute( ATT_SESSION_UTILISATEUR );
        if ( mapUsers != null ) {
            Utilisateur user = mapUsers.get( email );
            if ( user != null ) {
                request.setAttribute( ATT_UTILISATEUR, user );
            } else {
                this.getServletContext().getRequestDispatcher( VUE_ECHEC ).forward( request, response );
                return;
            }
        } else {
            this.getServletContext().getRequestDispatcher( VUE_ECHEC ).forward( request, response );
            return;
        }

        Long id = null;
        try {
            id = Long.parseLong( idPanierValeur );
        } catch ( NumberFormatException e ) {
            e.printStackTrace();
            this.getServletContext().getRequestDispatcher( VUE_ECHEC ).forward( request, response );
            return;
        }

        Map<Long, Map<Long, VoyagePanier>> mapPanierUtilisateurs = (Map<Long, Map<Long, VoyagePanier>>) session
                .getAttribute( ATT_PANIER_UTILISATEURS );

        if ( mapPanierUtilisateurs != null ) {
            Map<Long, VoyagePanier> voyagePaniers = mapPanierUtilisateurs.get( id );

            if ( voyagePaniers != null ) {
                /*
                 * using for-each loop for iteration over Map.entrySet()
                 */
                for ( Map.Entry<Long, VoyagePanier> entry : voyagePaniers.entrySet() ) {
                    total += entry.getValue().getVoyage().getPrix() * entry.getValue().getNbPersonne()
                            * ( 1 + 0.02 + 0.01 + 0.005 );
                    nombreDeVoyages++;
                }

                /* Réduction de 30% maximum */
                if ( nombreDeVoyages > 30 ) {
                    nombreDeVoyages = 30;
                }

                montantAPayer = total - ( total * nombreDeVoyages / 100 );

                request.setAttribute( ATT_VOYAGE_PANIER, voyagePaniers );

                request.setAttribute( ATT_MONTANT_TOTAL, total );
                request.setAttribute( ATT_NB_VOYAGES, nombreDeVoyages );
                request.setAttribute( ATT_MONTANT_A_PAYER, montantAPayer );
            } else {
                this.getServletContext().getRequestDispatcher( VUE_ECHEC ).forward( request, response );
                return;
            }
        } else {
            this.getServletContext().getRequestDispatcher( VUE_ECHEC ).forward( request, response );
            return;
        }
        /* Affichage de la page du panier */
        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }

    protected void doPost( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
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
