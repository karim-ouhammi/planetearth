package com.planetearth.servlets.liste;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet( "/liste_voyages" )
public class ListeVoyages extends HttpServlet {
    public static final String VUE = "/WEB-INF/espace_admin/voyages.jsp";

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        /* Affichage de la page des pays */
        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }

}
