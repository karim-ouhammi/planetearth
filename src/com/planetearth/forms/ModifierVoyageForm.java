package com.planetearth.forms;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import com.planetearth.beans.Theme;
import com.planetearth.beans.Voyage;
import com.planetearth.dao.DAOException;
import com.planetearth.dao.DestinationDao;
import com.planetearth.dao.VoyageDao;

public class ModifierVoyageForm {
    private static Pattern      DATE_PATTERN      = Pattern.compile(
            "^((2000|2400|2800|(19|2[0-9](0[48]|[2468][048]|[13579][26])))-02-29)$"
                    + "|^(((19|2[0-9])[0-9]{2})-02-(0[1-9]|1[0-9]|2[0-8]))$"
                    + "|^(((19|2[0-9])[0-9]{2})-(0[13578]|10|12)-(0[1-9]|[12][0-9]|3[01]))$"
                    + "|^(((19|2[0-9])[0-9]{2})-(0[469]|11)-(0[1-9]|[12][0-9]|30))$" );

    private static final String CHAMP_TITRE       = "titre";
    private static final String CHAMP_HEBERGEMENT = "hebergement";
    private static final String CHAMP_DESTINATION = "destination";
    private static final String CHAMP_THEME       = "theme";
    private static final String CHAMP_DATE        = "date";
    private static final String CHAMP_DUREE       = "duree";
    private static final String CHAMP_PRIX        = "prix";
    private static final String CHAMP_DIFFICULTE  = "difficulte";
    private static final String CHAMP_ALTITUDE    = "altitude";
    private static final String CHAMP_DESCRIPTION = "description";

    private static final String CHAMP_ID          = "idVoyage";

    private static final String ATT_SESSION_THEME = "themes";

    private VoyageDao           voyageDao;
    private DestinationDao      destinationDao;

    public ModifierVoyageForm( VoyageDao voyageDao, DestinationDao destinationDao ) {
        this.voyageDao = voyageDao;
        this.destinationDao = destinationDao;
    }

    private String              resultat;
    private Map<String, String> erreurs = new HashMap<String, String>();

    public String getResultat() {
        return resultat;
    }

    public Map<String, String> getErreurs() {
        return erreurs;
    }

    public Voyage modifierVoyage( HttpServletRequest request ) {
        String titre = getValeurChamp( request, CHAMP_TITRE );
        String hebergement = getValeurChamp( request, CHAMP_HEBERGEMENT );
        String nomDestination = getValeurChamp( request, CHAMP_DESTINATION );
        String idTheme = getValeurChamp( request, CHAMP_THEME );
        String dateValeur = getValeurChamp( request, CHAMP_DATE );
        String dureeValeur = getValeurChamp( request, CHAMP_DUREE );
        String prixValeur = getValeurChamp( request, CHAMP_PRIX );
        String difficulteValeur = getValeurChamp( request, CHAMP_DIFFICULTE );
        String altitudeValeur = getValeurChamp( request, CHAMP_ALTITUDE );
        String description = getValeurChamp( request, CHAMP_DESCRIPTION );

        String idVoyage = getValeurChamp( request, CHAMP_ID );

        Voyage voyage = new Voyage();

        try {
            traiterId( Long.parseLong( idVoyage ), voyage );

            traiterTitre( titre, voyage );
            traiterHebergement( hebergement, voyage );
            traiterDescription( description, voyage );

            voyage.setDestination( destinationDao.read( nomDestination ) );

            Map<Long, Theme> themes = (Map<Long, Theme>) request.getSession()
                    .getAttribute( ATT_SESSION_THEME );
            voyage.setTheme( themes.get( Long.parseLong( idTheme ) ) );

            traiterDate( dateValeur, voyage );
            traiterDuree( dureeValeur, voyage );
            traiterPrix( prixValeur, voyage );
            traiterDifficulte( difficulteValeur, voyage );
            traiterAltitude( altitudeValeur, voyage );

            if ( erreurs.isEmpty() ) {
                voyageDao.update( voyage );
                resultat = "Voyage modifié avec succès.";
            } else {
                resultat = "Échec de l'operation.";
            }
        } catch ( DAOException e ) {
            setErreur( "imprévu ", "Erreur imprévue lors de la modification." );
            resultat = "Échec de la modification du voyage : une erreur imprévue est survenue, merci de réessayer dans quelques instants.";
            e.printStackTrace();
        } catch ( NumberFormatException e ) {
            setErreur( "imprévu ", "Erreur imprévue lors de la modificatoin." );
            resultat = "Échec de l'operation.";
        }

        return voyage;
    }

    private void traiterId( Long id, Voyage voyage ) {
        try {
            validationId( id );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_ID, e.getMessage() );
        }
        voyage.setId( id );
    }

    private void traiterTitre( String titre, Voyage voyage ) {
        try {
            validationTitre( titre );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_TITRE, e.getMessage() );
        }
        voyage.setTitre( titre );
    }

    private void traiterHebergement( String hebergement, Voyage voyage ) {
        try {
            validationHebergement( hebergement );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_HEBERGEMENT, e.getMessage() );
        }
        voyage.setHebergement( hebergement );
    }

    private void traiterDescription( String description, Voyage voyage ) {
        try {
            validationDescription( description );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_DESCRIPTION, e.getMessage() );
        }
        voyage.setDescription( description );
    }

    private void traiterDate( String dateString, Voyage voyage ) {
        DateTime date = null;
        try {
            validationDate( dateString );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_DATE, e.getMessage() );
        }
        try {
            DateTimeFormatter formatter = DateTimeFormat.forPattern( "yyyy-MM-dd" );
            if ( dateString != null ) {
                date = formatter.parseDateTime( dateString );
            }
        } catch ( IllegalArgumentException e ) {
            setErreur( CHAMP_DATE, "La date doit être sous la forme : yyyy-MM-dd" );
            e.printStackTrace();
        }
        voyage.setDate( date );
    }

    private void traiterDuree( String dureeString, Voyage voyage ) {
        int duree = 0;
        try {
            duree = validationDuree( dureeString );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_DUREE, e.getMessage() );
        }
        voyage.setDuree( duree );
    }

    private void traiterPrix( String prixString, Voyage voyage ) {
        double prix = 0;
        try {
            prix = validationPrix( prixString );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_PRIX, e.getMessage() );
        }
        voyage.setPrix( prix );
    }

    private void traiterDifficulte( String difficulteString, Voyage voyage ) {
        int difficulte = 0;
        try {
            difficulte = validationDifficulte( difficulteString );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_DIFFICULTE, e.getMessage() );
        }
        voyage.setDifficulte( difficulte );
    }

    private void traiterAltitude( String altitudeString, Voyage voyage ) {
        int altitude = 0;
        try {
            altitude = validationAltitude( altitudeString );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_ALTITUDE, e.getMessage() );
        }
        voyage.setAltitude( altitude );
    }

    private void validationId( Long id ) throws FormValidationException {
        if ( id == null || id <= 0 ) {
            throw new FormValidationException( "ID invalide." );
        }
    }

    private void validationTitre( String titre ) throws FormValidationException {
        if ( titre != null && titre.length() < 5 ) {
            throw new FormValidationException( "Le titre du voyage doit contenir au moins 5 caractères." );
        } else if ( titre == null ) {
            throw new FormValidationException( "Merci de saisir le titre du voyage." );
        }
    }

    private void validationHebergement( String hebergement ) throws FormValidationException {
        if ( hebergement != null && hebergement.length() < 10 ) {
            throw new FormValidationException( "L'hébergement doit contenir au moins 10 caractères." );
        } else if ( hebergement == null ) {
            throw new FormValidationException( "Merci de saisir l'hébergement du voyage." );
        }
    }

    private void validationDescription( String description ) throws FormValidationException {
        if ( description != null && description.length() < 10 ) {
            throw new FormValidationException( "La description doit contenir au moins 10 caractères." );
        } else if ( description == null ) {
            throw new FormValidationException( "Merci de saisir la description du voyage." );
        }
    }

    private void validationDate( String dt ) throws FormValidationException {
        if ( dt != null ) {
            if ( !DATE_PATTERN.matcher( dt ).matches() ) {
                throw new FormValidationException( "Merci d'entrer une date de départ valide." );
            }
        } else {
            throw new FormValidationException( "Merci d'entrer une date de départ." );
        }
    }

    private int validationDuree( String dureeString ) throws FormValidationException {
        int duree;
        if ( dureeString != null ) {
            try {
                duree = Integer.parseInt( dureeString );
                if ( duree < 0 ) {
                    throw new FormValidationException( "La durée doit être un nombre positif." );
                }
            } catch ( NumberFormatException e ) {
                duree = 0;
                throw new FormValidationException( "La durée doit être un entier." );
            }
        } else {
            duree = 0;
            throw new FormValidationException( "Merci d'entrer la durée." );
        }
        return duree;
    }

    private double validationPrix( String prixString ) throws FormValidationException {
        double prix;
        if ( prixString != null ) {
            try {
                prix = Double.parseDouble( prixString );
                if ( prix < 0 ) {
                    throw new FormValidationException( "Le prix doit être un nombre positif." );
                }
            } catch ( NumberFormatException e ) {
                prix = 0;
                throw new FormValidationException( "Le prix doit être un nombre." );
            }
        } else {
            prix = 0;
            throw new FormValidationException( "Merci d'entrer le prix." );
        }
        return prix;
    }

    private int validationDifficulte( String difficulteString ) throws FormValidationException {
        int difficulte;
        if ( difficulteString != null ) {
            try {
                difficulte = Integer.parseInt( difficulteString );
                if ( difficulte < 1 || difficulte > 5 ) {
                    throw new FormValidationException( "La difficulté doit être un entier entre 1 et 5." );
                }
            } catch ( NumberFormatException e ) {
                difficulte = 0;
                throw new FormValidationException( "La difficulté doit être un entier entre 1 et 5." );
            }
        } else {
            difficulte = 0;
            throw new FormValidationException( "Merci d'entrer la difficulté." );
        }
        return difficulte;
    }

    private int validationAltitude( String altitudeString ) throws FormValidationException {
        int altitude;
        if ( altitudeString != null ) {
            try {
                altitude = Integer.parseInt( altitudeString );
                if ( altitude < 1 || altitude > 5 ) {
                    throw new FormValidationException( "L'altitude doit être un entier entre 1 et 5." );
                }
            } catch ( NumberFormatException e ) {
                altitude = 0;
                throw new FormValidationException( "L'altitude doit être un entier entre 1 et 5." );
            }
        } else {
            altitude = 0;
            throw new FormValidationException( "Merci d'entrer L'altitude." );
        }
        return altitude;
    }

    private void setErreur( String champ, String message ) {
        erreurs.put( champ, message );
    }

    private static String getValeurChamp( HttpServletRequest request, String nomChamp ) {
        String valeur = request.getParameter( nomChamp );
        if ( valeur == null || valeur.trim().length() == 0 ) {
            return null;
        } else {
            return valeur;
        }
    }
}
