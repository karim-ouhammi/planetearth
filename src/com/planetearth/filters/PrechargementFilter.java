package com.planetearth.filters;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.planetearth.beans.Destination;
import com.planetearth.beans.Theme;
import com.planetearth.beans.Titre;
import com.planetearth.beans.Type;
import com.planetearth.beans.Utilisateur;
import com.planetearth.beans.Voyage;
import com.planetearth.beans.VoyagePanier;
import com.planetearth.dao.DAOFactory;
import com.planetearth.dao.DestinationDao;
import com.planetearth.dao.ThemeDao;
import com.planetearth.dao.TitreDao;
import com.planetearth.dao.TypeDao;
import com.planetearth.dao.UtilisateurDao;
import com.planetearth.dao.VoyageDao;
import com.planetearth.dao.VoyagePanierDao;

@WebFilter( urlPatterns = "/*" )
public class PrechargementFilter implements Filter {
    private static final String CONF_DAO_FACTORY          = "daoFactory";

    private static final String ATT_SESSION_USER          = "sessionUtilisateur";

    private static final String ATT_SESSION_VOYAGE        = "voyages";
    private static final String ATT_SESSION_VOYAGE_PANIER = "voyagePaniers";
    private static final String ATT_SESSION_TITRE         = "titres";

    private static final String ATT_SESSION_DESTINATION   = "destinations";
    private static final String ATT_SESSION_TYPE          = "types";
    private static final String ATT_SESSION_THEME         = "themes";

    private DestinationDao      destinationDao;
    private TypeDao             typeDao;
    private ThemeDao            themeDao;
    private VoyageDao           voyageDao;
    private VoyagePanierDao     voyagePanierDao;
    private UtilisateurDao      utilisateurDao;
    private TitreDao            titreDao;

    public void init( FilterConfig config ) throws ServletException {
        /* Récupération d'une instance de nos DAO Client et Commande */
        this.destinationDao = ( (DAOFactory) config.getServletContext().getAttribute( CONF_DAO_FACTORY ) )
                .getDestinationDao();
        this.typeDao = ( (DAOFactory) config.getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getTypeDao();
        this.themeDao = ( (DAOFactory) config.getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getThemeDao();
        this.voyageDao = ( (DAOFactory) config.getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getVoyageDao();
        this.voyagePanierDao = ( (DAOFactory) config.getServletContext().getAttribute( CONF_DAO_FACTORY ) )
                .getVoyagePanierDao();
        this.utilisateurDao = ( (DAOFactory) config.getServletContext().getAttribute( CONF_DAO_FACTORY ) )
                .getUtilisateurDao();
        this.titreDao = ( (DAOFactory) config.getServletContext().getAttribute( CONF_DAO_FACTORY ) )
                .getTitreDao();
    }

    public void doFilter( ServletRequest req, ServletResponse resp, FilterChain chain )
            throws IOException, ServletException {
        /* Cast de l'objet request */
        HttpServletRequest request = (HttpServletRequest) req;

        /* Récupération de la session depuis la requête */
        HttpSession session = request.getSession();

        /*
         * Si la map des voyages n'existe pas en session, alors le
         * visiteur/utilisateur visite/se connecte pour la première fois et nous
         * devons précharger en session les infos contenues dans la BDD.
         */
        if ( session.getAttribute( ATT_SESSION_VOYAGE ) == null ) {
            List<Voyage> voyages = voyageDao.list( destinationDao, themeDao, typeDao );
            Map<Long, Voyage> mapVoyages = new HashMap<Long, Voyage>();
            for ( Voyage voyage : voyages ) {
                mapVoyages.put( voyage.getId(), voyage );
            }

            // Trie par keyValue = idVoyage dans l'ordre décroissant
            mapVoyages = mapVoyages.entrySet().stream().sorted( Collections.reverseOrder( Map.Entry.comparingByKey() ) )
                    .collect( Collectors.toMap( Map.Entry::getKey, Map.Entry::getValue,
                            ( oldValue, newValue ) -> oldValue, LinkedHashMap::new ) );

            session.setAttribute( ATT_SESSION_VOYAGE, mapVoyages );
        }
        /*
         * De même pour la map des voyagePaniers
         */
        Utilisateur user = (Utilisateur) request.getSession().getAttribute( ATT_SESSION_USER );
        if ( user != null && session.getAttribute( ATT_SESSION_VOYAGE_PANIER ) == null ) {
            List<VoyagePanier> voyagePaniers = voyagePanierDao.list( user.getIdPanier(), voyageDao, utilisateurDao,
                    destinationDao, themeDao, typeDao );

            Map<Long, VoyagePanier> mapVoyagePaniers = new HashMap<Long, VoyagePanier>();
            for ( VoyagePanier voyagePanier : voyagePaniers ) {
                mapVoyagePaniers.put( voyagePanier.getVoyage().getId(), voyagePanier );
            }
            session.setAttribute( ATT_SESSION_VOYAGE_PANIER, mapVoyagePaniers );
        }
        /*
         * De même pour la map des titres
         */
        if ( session.getAttribute( ATT_SESSION_TITRE ) == null ) {
            List<Titre> titres = titreDao.list();
            Map<Long, Titre> mapTitres = new HashMap<Long, Titre>();
            for ( Titre titre : titres ) {
                mapTitres.put( titre.getId(), titre );
            }
            session.setAttribute( ATT_SESSION_TITRE, mapTitres );
        }
        /*
         * De même pour la map des destinations
         */
        if ( session.getAttribute( ATT_SESSION_DESTINATION ) == null ) {
            /*
             * Récupération de la liste des destinations existants, et
             * enregistrement en session
             */
            List<Destination> Destinations = destinationDao.list();
            Map<String, List<Destination>> mapDestinations = new HashMap<String, List<Destination>>();
            List<Destination> afrique = new ArrayList<Destination>();
            List<Destination> amerique = new ArrayList<Destination>();
            List<Destination> asie = new ArrayList<Destination>();
            List<Destination> europe = new ArrayList<Destination>();
            List<Destination> oceanie = new ArrayList<Destination>();
            for ( Destination destination : Destinations ) { // foreach
                switch ( destination.getContinent() ) {
                case "Afrique":
                    afrique.add( destination );
                    break;
                case "Amérique":
                    amerique.add( destination );
                    break;
                case "Asie":
                    asie.add( destination );
                    break;
                case "Europe":
                    europe.add( destination );
                    break;
                case "Océanie":
                    oceanie.add( destination );
                    break;
                }
            }
            mapDestinations.put( "Afrique", afrique );
            mapDestinations.put( "Amérique", amerique );
            mapDestinations.put( "Asie", asie );
            mapDestinations.put( "Europe", europe );
            mapDestinations.put( "Océanie", oceanie );

            session.setAttribute( ATT_SESSION_DESTINATION, mapDestinations );
        }
        /*
         * De même pour la map des types
         */
        if ( session.getAttribute( ATT_SESSION_TYPE ) == null ) {
            List<Type> types = typeDao.list();
            Map<Long, Type> mapTypes = new HashMap<Long, Type>();
            for ( Type type : types ) { // foreach
                mapTypes.put( type.getId(), type );
            }
            session.setAttribute( ATT_SESSION_TYPE, mapTypes );
        }
        /*
         * De même pour la map des thèmes
         */
        if ( session.getAttribute( ATT_SESSION_THEME ) == null ) {
            List<Theme> themes = themeDao.list( typeDao );
            Map<Long, Theme> mapThemes = new HashMap<Long, Theme>();
            for ( Theme theme : themes ) {
                mapThemes.put( theme.getId(), theme );
            }

            session.setAttribute( ATT_SESSION_THEME, mapThemes );
        }

        /* Pour terminer, poursuite de la requête en cours */
        chain.doFilter( request, resp );
    }

    public void destroy() {
    }
}
