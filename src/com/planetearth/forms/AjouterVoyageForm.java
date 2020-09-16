package com.planetearth.forms;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import com.planetearth.beans.Theme;
import com.planetearth.beans.Voyage;
import com.planetearth.dao.DAOException;
import com.planetearth.dao.DestinationDao;
import com.planetearth.dao.VoyageDao;

import eu.medsea.mimeutil.MimeUtil;

public class AjouterVoyageForm {
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

    private static final String CHAMP_IMAGELISTE  = "imageListe";
    private static final String CHAMP_IMAGE1      = "image1";
    private static final String CHAMP_IMAGE2      = "image2";
    private static final String CHAMP_IMAGE3      = "image3";
    private static final int    X_LISTE           = 700;
    private static final int    Y_LISTE           = 300;
    private static final int    X_AFFICHAGE       = 750;
    private static final int    Y_AFFICHAGE       = 500;

    private static final int    TAILLE_TAMPON     = 10240;                                  // 10ko

    private static final String ATT_SESSION_THEME = "themes";

    private VoyageDao           voyageDao;
    private DestinationDao      destinationDao;

    public AjouterVoyageForm( VoyageDao voyageDao, DestinationDao destinationDao ) {
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

    public Voyage ajouterVoyage( HttpServletRequest request, String chemin ) {
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

        Voyage voyage = new Voyage();

        try {
            Long id = null;

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
                id = voyageDao.create( voyage );

                traiterImage( request, chemin, CHAMP_IMAGELISTE, X_LISTE, Y_LISTE, id );
                traiterImage( request, chemin, CHAMP_IMAGE1, X_AFFICHAGE, Y_AFFICHAGE, id );
                traiterImage( request, chemin, CHAMP_IMAGE2, X_AFFICHAGE, Y_AFFICHAGE, id );
                traiterImage( request, chemin, CHAMP_IMAGE3, X_AFFICHAGE, Y_AFFICHAGE, id );

                if ( erreurs.isEmpty() ) {
                    resultat = "Voyage ajouté avec succès.";
                } else {
                    voyageDao.delete( id );
                    resultat = "Échec de l'operation.";
                }
            } else {
                resultat = "Échec de l'operation.";
            }
        } catch ( DAOException e ) {
            setErreur( "imprévu ", "Erreur imprévue lors de l'ajout." );
            resultat = "Échec de l'ajout du voyage : une erreur imprévue est survenue, merci de réessayer dans quelques instants.";
            e.printStackTrace();
        } catch ( NumberFormatException e ) {
            setErreur( "imprévu ", "Erreur imprévue lors de l'ajout." );
            resultat = "Échec de l'operation.";
        }

        return voyage;
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

    private void traiterImage( HttpServletRequest request, String chemin, String champImage, int x, int y, Long id ) {
        try {
            validationImage( request, chemin, champImage, x, y, id );
        } catch ( FormValidationException e ) {
            setErreur( champImage, e.getMessage() );
        }
    }

    private void validationImage( HttpServletRequest request, String chemin, String champImage, int x, int y, Long id )
            throws FormValidationException {
        /*
         * Récupération du contenu du champ image du formulaire. Il faut ici
         * utiliser la méthode getPart().
         */
        String nomFichier = null;
        InputStream contenuFichier = null;
        try {
            Part part = request.getPart( champImage );
            nomFichier = getNomFichier( part );

            /*
             * Si la méthode getNomFichier() a renvoyé quelque chose, il s'agit
             * donc d'un champ de type fichier (input type="file").
             */
            if ( nomFichier != null && !nomFichier.isEmpty() ) {
                /*
                 * Antibug pour Internet Explorer, qui transmet le chemin du
                 * fichier local à la machine du client... Ex :
                 * C:/dossier/sous-dossier/fichier.ext On doit donc faire en
                 * sorte de ne sélectionner que le nom et l'extension du
                 * fichier, et de se débarrasser du superflu.
                 */
                nomFichier = nomFichier.substring( nomFichier.lastIndexOf( '/' ) + 1 )
                        .substring( nomFichier.lastIndexOf( '\\' ) + 1 );

                /* Récupération du contenu du fichier */
                contenuFichier = part.getInputStream();

                /* Extraction du type MIME du fichier depuis l'InputStream */
                MimeUtil.registerMimeDetector( "eu.medsea.mimeutil.detector.MagicMimeMimeDetector" );
                Collection<?> mimeTypes = MimeUtil.getMimeTypes( contenuFichier );

                /*
                 * Si le fichier est bien une image, alors son en-tête MIME
                 * commence par la chaîne "image"
                 */
                if ( mimeTypes.toString().startsWith( "image" ) ) {
                    /* Ecriture du fichier sur le disque */
                    ecrireFichier( chemin, champImage, contenuFichier, x, y, id );
                } else {
                    throw new FormValidationException( "Le fichier envoyé doit être une image." );
                }
            } else {
                throw new FormValidationException( "Merci d'ajouter une image en respectant la résolution." );
            }
        } catch ( IllegalStateException e ) {
            /*
             * Exception retournée si la taille des données dépasse les limites
             * définies dans la section <multipart-config> de la déclaration de
             * notre servlet d'upload dans le fichier web.xml
             */
            e.printStackTrace();
            throw new FormValidationException( "Le fichier envoyé ne doit pas dépasser 1Mo." );
        } catch ( IOException e ) {
            /*
             * Exception retournée si une erreur au niveau des répertoires de
             * stockage survient (répertoire inexistant, droits d'accès
             * insuffisants, etc.)
             */
            e.printStackTrace();
            throw new FormValidationException( "Erreur de configuration du serveur." );
        } catch ( ServletException e ) {
            /*
             * Exception retournée si la requête n'est pas de type
             * multipart/form-data.
             */
            e.printStackTrace();
            throw new FormValidationException(
                    "Ce type de requête n'est pas supporté, merci d'utiliser le formulaire prévu pour envoyer votre fichier." );
        }
    }

    /*
     * Méthode utilitaire qui a pour unique but d'analyser l'en-tête
     * "content-disposition", et de vérifier si le paramètre "filename" y est
     * présent. Si oui, alors le champ traité est de type File et la méthode
     * retourne son nom, sinon il s'agit d'un champ de formulaire classique et
     * la méthode retourne null.
     */
    private static String getNomFichier( Part part ) {
        /*
         * Boucle sur chacun des paramètres de l'en-tête "content-disposition".
         */
        for ( String contentDisposition : part.getHeader( "content-disposition" ).split( ";" ) ) {
            /* Recherche de l'éventuelle présence du paramètre "filename". */
            if ( contentDisposition.trim().startsWith( "filename" ) ) {
                /*
                 * Si "filename" est présent, alors renvoi de sa valeur,
                 * c'est-à-dire du nom de fichier sans guillemets.
                 */
                return contentDisposition.substring( contentDisposition.indexOf( '=' ) + 1 ).trim().replace( "\"", "" );
            }
        }
        /* Et pour terminer, si rien n'a été trouvé... */
        return null;
    }

    /*
     * Méthode utilitaire qui a pour but d'écrire le fichier passé en paramètre
     * sur le disque, dans le répertoire donné et avec le nom donné.
     */
    private void ecrireFichier( String chemin, String champImage, InputStream contenuFichier, int x, int y, Long id )
            throws FormValidationException {
        /* Prépare les flux. */
        BufferedInputStream entree = null;
        BufferedOutputStream sortie = null;
        /* Path d'enregistrement avec le nom de l'image */
        String path = chemin + id + "_" + champImage;
        try {
            /* Ouvre les flux. */
            entree = new BufferedInputStream( contenuFichier, TAILLE_TAMPON );
            sortie = new BufferedOutputStream( new FileOutputStream( new File( path ) ),
                    TAILLE_TAMPON );

            /*
             * Lit le fichier reçu et écrit son contenu dans un fichier sur le
             * disque.
             */
            byte[] tampon = new byte[TAILLE_TAMPON];
            int longueur = 0;
            while ( ( longueur = entree.read( tampon ) ) > 0 ) {
                sortie.write( tampon, 0, longueur );
            }
        } catch ( Exception e ) {
            e.printStackTrace();
            throw new FormValidationException( "Erreur lors de l'écriture du fichier sur le disque." );
        } finally {
            try {
                sortie.close();
            } catch ( Exception ignore ) {
            }
            try {
                entree.close();
            } catch ( Exception ignore ) {
            }
        }

        /* Vérification des résolutions des images */
        try {
            BufferedImage img = ImageIO.read( new File( path ) );

            if ( img.getWidth() != x || img.getHeight() != y ) {
                System.out.println( "File : " + Paths.get( path ) + " deleted." );

                Files.delete( Paths.get( path ) );

                throw new Exception( "L'image doit avoir une résolution de " + x + " x " + y );
            }
        } catch ( Exception e ) {
            throw new FormValidationException( e.getMessage() );
        }
    }
}
