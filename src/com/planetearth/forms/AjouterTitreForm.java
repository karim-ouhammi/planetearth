package com.planetearth.forms;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

import com.planetearth.beans.Titre;
import com.planetearth.dao.DAOException;
import com.planetearth.dao.TitreDao;

import eu.medsea.mimeutil.MimeUtil;

public class AjouterTitreForm {
    private static final String CHAMP_TITRE   = "titre";
    private static final String CHAMP_IMAGE   = "image";

    private static final int    X             = 1900;
    private static final int    Y             = 1080;

    private static final int    TAILLE_TAMPON = 10240;  // 10ko

    private TitreDao            titreDao;

    public AjouterTitreForm( TitreDao titreDao ) {
        this.titreDao = titreDao;
    }

    private String              resultat;
    private Map<String, String> erreurs = new HashMap<String, String>();

    public String getResultat() {
        return resultat;
    }

    public Map<String, String> getErreurs() {
        return erreurs;
    }

    public Titre ajouterTitre( HttpServletRequest request, String chemin ) {
        String nomTitre = getValeurChamp( request, CHAMP_TITRE );

        Titre titre = new Titre();

        try {
            Long id = null;

            traiterTitre( nomTitre, titre );

            if ( erreurs.isEmpty() ) {
                id = titreDao.create( titre );

                traiterImage( request, chemin, CHAMP_IMAGE, X, Y, id );

                if ( erreurs.isEmpty() ) {
                    resultat = "Titre ajouté avec succès.";
                } else {
                    titreDao.delete( id );
                    resultat = "Échec de l'operation.";
                }
            } else {
                resultat = "Échec de l'operation.";
            }
        } catch ( DAOException e ) {
            setErreur( "imprévu ", "Erreur imprévue lors de l'ajout." );
            resultat = "Échec de l'ajout du type : une erreur imprévue est survenue, merci de réessayer dans quelques instants.";
            e.printStackTrace();
        }

        return titre;
    }

    private void traiterTitre( String nomTitre, Titre titre ) {
        try {
            validationTitre( nomTitre );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_TITRE, e.getMessage() );
        }
        titre.setTitre( nomTitre );
    }

    private void validationTitre( String nomTitre ) throws FormValidationException {
        if ( nomTitre != null && nomTitre.length() < 10 ) {
            throw new FormValidationException( "Le titre doit contenir au moins 10 caractères." );
        } else if ( nomTitre == null ) {
            throw new FormValidationException( "Merci de saisir le titre." );
        }
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
                throw new FormValidationException( "Merci d'ajouter une image." );
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
        /*
         * try { BufferedImage img = ImageIO.read( new File( path ) ); /* if (
         * img.getWidth() != x || img.getHeight() != y ) { System.out.println(
         * "File : " + Paths.get( path ) + " deleted." );
         * 
         * Files.delete( Paths.get( path ) );
         * 
         * throw new Exception( "L'image doit avoir une résolution de " + x +
         * " x " + y ); }
         * 
         * }catch(Exception e) { throw new FormValidationException(
         * e.getMessage() ); }
         */
    }
}
