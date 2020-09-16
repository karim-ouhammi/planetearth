package com.planetearth.servlets;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.planetearth.beans.VoyagePanier;

@WebServlet( "/panier" )
public class Panier extends HttpServlet {
    private static final String VUE                       = "/WEB-INF/panier.jsp";

    private static final String ATT_SESSION_VOYAGE_PANIER = "voyagePaniers";

    private static final String ATT_MONTANT_TOTAL         = "total";

    private static final String ATT_NB_VOYAGES            = "nbVoyages";

    private static final String ATT_MONTANT_A_PAYER       = "montantAPayer";

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        double total = 0;
        double montantAPayer = 0;
        int nombreDeVoyages = 0;

        HttpSession session = request.getSession();

        Map<Long, VoyagePanier> voyagePaniers = (Map<Long, VoyagePanier>) session
                .getAttribute( ATT_SESSION_VOYAGE_PANIER );

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

            request.setAttribute( ATT_MONTANT_TOTAL, total );
            request.setAttribute( ATT_NB_VOYAGES, nombreDeVoyages );
            request.setAttribute( ATT_MONTANT_A_PAYER, montantAPayer );
        }

        /* Affichage de la page du panier */
        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }

    protected void doPost( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
    }
}
