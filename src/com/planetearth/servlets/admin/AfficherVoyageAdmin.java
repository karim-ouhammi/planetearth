package com.planetearth.servlets.admin;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.planetearth.beans.Voyage;

@WebServlet( "/adminAfficherVoyage" )
public class AfficherVoyageAdmin extends HttpServlet {
    private static final String ATT_SESSION_VOYAGE = "voyages";

    private static final String ATT_VOYAGE         = "voyage";

    private static final String PARAM_ID           = "idVoyage";

    public static final String  VUE                = "/WEB-INF/espace_admin/afficher_voyage.jsp";
    public static final String  VUE_ECHEC          = "/WEB-INF/espace_admin/voyages.jsp";

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        String idValeur = getValeurParam( request, PARAM_ID );
        try {
            Long id = Long.parseLong( idValeur );

            Map<Long, Voyage> voyages = (Map<Long, Voyage>) request.getSession().getAttribute( ATT_SESSION_VOYAGE );
            Voyage voyage = voyages.get( id );

            if ( voyage != null ) {
                request.setAttribute( ATT_VOYAGE, voyage );
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
    }

    @Override
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
