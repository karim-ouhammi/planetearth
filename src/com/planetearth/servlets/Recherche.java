package com.planetearth.servlets;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import com.planetearth.beans.Voyage;

@WebServlet( "/recherche" )
public class Recherche extends HttpServlet {
    private static final String ATT_SESSION_VOYAGE = "voyages";

    private static final String ATT_RECHERCHE      = "recherche";

    private static final String ATT_FORM           = "form";

    private static final String CHAMP_DESTINATION  = "destination";
    private static final String CHAMP_THEME        = "theme";
    private static final String CHAMP_DATE         = "date";
    private static final String CHAMP_DUREE        = "duree";
    private static final String CHAMP_DIFFICULTE   = "difficulte";
    private static final String CHAMP_BUDGET       = "budget";
    private static final String CHAMP_MOTSCLES     = "motsCles";

    private static final String VUE                = "/rechercheVoyages.jsp";
    private static final String VUE_VOYAGES        = "/voyages.jsp";

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        this.getServletContext().getRequestDispatcher( VUE_VOYAGES ).forward( request, response );
    }

    private String              resultat;
    private Map<String, String> erreurs = new HashMap<String, String>();

    public String getResultat() {
        return resultat;
    }

    public Map<String, String> getErreurs() {
        return erreurs;
    }

    @Override
    protected void doPost( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        resultat = null;
        erreurs = new HashMap<String, String>();

        String destination = getValeurChamp( request, CHAMP_DESTINATION );
        String themeString = getValeurChamp( request, CHAMP_THEME );
        String dateString = getValeurChamp( request, CHAMP_DATE );
        String dureeString = getValeurChamp( request, CHAMP_DUREE );
        String difficulteString = getValeurChamp( request, CHAMP_DIFFICULTE );
        String budgetString = getValeurChamp( request, CHAMP_BUDGET );
        String motsCles = getValeurChamp( request, CHAMP_MOTSCLES );

        Map<Long, Voyage> voyages = (Map<Long, Voyage>) request.getSession().getAttribute( ATT_SESSION_VOYAGE );
        Map<Long, Voyage> rechercheVoyages = new HashMap<Long, Voyage>();

        int nbVoyages = 0;

        if ( voyages != null ) {
            /*
             * using for-each loop for iteration over Map.entrySet()
             */
            for ( Map.Entry<Long, Voyage> entry : voyages.entrySet() ) {
                if ( traiterDestination( destination, entry.getValue() )
                        && traiterTheme( themeString, entry.getValue() )
                        && traiterdate( dateString, entry.getValue() )
                        && traiterdifficulte( difficulteString, entry.getValue() )
                        && traiterDuree( dureeString, entry.getValue() )
                        && traiterBudget( budgetString, entry.getValue() )
                        && traiterMotsCles( motsCles, entry.getValue() ) ) {

                    rechercheVoyages.put( entry.getValue().getId(), entry.getValue() );
                    nbVoyages++;
                }
            }

            if ( rechercheVoyages.isEmpty() ) {
                erreurs.put( "recherche", "Aucun résultat trouvé." );
                request.setAttribute( ATT_FORM, this );
            } else {
                resultat = nbVoyages + " résultat trouvé.";
                request.setAttribute( ATT_FORM, this );

                request.setAttribute( ATT_RECHERCHE, rechercheVoyages );
            }
        }
        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }

    private boolean traiterMotsCles( String motsCles, Voyage value ) {
        if ( motsCles == null ) {
            return true;
        }
        if ( value.getTitre().toLowerCase().contains( motsCles.toLowerCase() )
                || value.getDescription().toLowerCase().contains( motsCles.toLowerCase() ) ) {
            return true;
        } else {
            return false;
        }
    }

    private boolean traiterBudget( String budgetString, Voyage value ) {
        double budgetMin = 0;
        double budgetMax = 0;

        if ( budgetString == null ) {
            return true;
        }

        switch ( budgetString ) {
        case "1":
            budgetMin = 0;
            budgetMax = 4999;
            break;
        case "2":
            budgetMin = 5000;
            budgetMax = 9999;
            break;
        case "3":
            budgetMin = 10000;
            budgetMax = 19999;
            break;
        case "4":
            budgetMin = 20000;
            budgetMax = 29999;
            break;
        case "5":
            budgetMin = 30000;
            budgetMax = -1;
            break;
        default:
            break;
        }

        if ( budgetMax == -1 ) {
            if ( value.getPrix() >= budgetMin ) {
                return true;
            } else {
                return false;
            }
        } else {
            if ( value.getPrix() >= budgetMin && value.getPrix() <= budgetMax ) {
                return true;
            } else {
                return false;
            }
        }
    }

    private boolean traiterDuree( String dureeString, Voyage value ) {
        int dureeMin = 0;
        int dureeMax = 0;

        if ( dureeString == null ) {
            return true;
        }

        switch ( dureeString ) {
        case "1":
            dureeMin = 0;
            dureeMax = 4;
            break;
        case "2":
            dureeMin = 5;
            dureeMax = 10;
            break;
        case "3":
            dureeMin = 11;
            dureeMax = 16;
            break;
        case "4":
            dureeMin = 17;
            dureeMax = -1;
            break;
        default:
            break;
        }

        if ( dureeMax == -1 ) {
            if ( value.getDuree() >= dureeMin ) {
                return true;
            } else {
                return false;
            }
        } else {
            if ( value.getDuree() >= dureeMin && value.getDuree() <= dureeMax ) {
                return true;
            } else {
                return false;
            }
        }
    }

    private boolean traiterdifficulte( String difficulteString, Voyage value ) {
        try {
            if ( difficulteString == null ) {
                return true;
            }
            int difficulte = Integer.parseInt( difficulteString );

            if ( difficulte == value.getDifficulte() ) {
                return true;
            }
            return false;
        } catch ( NumberFormatException e ) {
            e.printStackTrace();
            return true;
        }
    }

    private boolean traiterdate( String dateString, Voyage value ) {
        try {
            if ( dateString != null ) {
                DateTime date = null;
                DateTimeFormatter formatter = DateTimeFormat.forPattern( "yyyy-MM-dd" );
                date = formatter.parseDateTime( dateString );

                if ( value.getDate().getYear() == date.getYear()
                        && value.getDate().getMonthOfYear() == date.getMonthOfYear()
                        && value.getDate().getDayOfMonth() == date.getDayOfMonth() ) {
                    return true;
                } else {
                    return false;
                }
            } else {
                return true;
            }
        } catch ( IllegalArgumentException e ) {
            e.printStackTrace();
            return true;
        }
    }

    private boolean traiterTheme( String themeString, Voyage value ) {
        try {
            if ( themeString == null ) {
                return true;
            }
            Long theme = Long.parseLong( themeString );
            if ( theme == null || theme == value.getTheme().getId() ) {
                return true;
            }
            return false;
        } catch ( NumberFormatException e ) {
            e.printStackTrace();
            return true;
        }
    }

    private boolean traiterDestination( String destination, Voyage value ) {
        if ( destination == null || value.getDestination().getNom().equalsIgnoreCase( destination ) ) {
            return true;
        }
        return false;
    }

    private static String getValeurChamp( HttpServletRequest request, String nomChamp ) {
        String valeur = request.getParameter( nomChamp );
        if ( valeur == null || valeur.trim().length() == 0 ) {
            return null;
        } else {
            return valeur.trim();
        }
    }
}
