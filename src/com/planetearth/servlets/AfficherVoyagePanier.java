package com.planetearth.servlets;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.planetearth.beans.VoyagePanier;

@WebServlet( "/panierAfficherVoyage" )
public class AfficherVoyagePanier extends HttpServlet {
    private static final String VUE                       = "/WEB-INF/afficher_voyage_panier.jsp";
    private static final String VUE_ECHEC                 = "/WEB-INF/panier.jsp";

    private static final String ATT_SESSION_VOYAGE_PANIER = "voyagePaniers";

    private static final String ATT_VOYAGE_PANIER         = "voyagePanier";
    private static final String ATT_VOYAGE                = "voyage";

    private static final String PARAM_ID                  = "idVoyage";

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        String idValeur = getValeurParam( request, PARAM_ID );

        if ( idValeur != null ) {
            try {
                Long id = Long.parseLong( idValeur );

                Map<Long, VoyagePanier> voyagePaniers = (Map<Long, VoyagePanier>) request.getSession()
                        .getAttribute( ATT_SESSION_VOYAGE_PANIER );
                VoyagePanier voyagePanier = voyagePaniers.get( id );
                if ( voyagePaniers != null && voyagePanier != null ) {
                    request.setAttribute( ATT_VOYAGE_PANIER, voyagePanier );
                    request.setAttribute( ATT_VOYAGE, voyagePanier.getVoyage() );
                } else {
                    this.getServletContext().getRequestDispatcher( VUE_ECHEC ).forward( request, response );
                    return;
                }
            } catch ( NumberFormatException e ) {
                e.printStackTrace();
                this.getServletContext().getRequestDispatcher( VUE_ECHEC ).forward( request, response );
                return;
            }
            this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
        } else {
            this.getServletContext().getRequestDispatcher( VUE_ECHEC ).forward( request, response );
        }
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
