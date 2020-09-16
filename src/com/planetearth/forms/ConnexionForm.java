package com.planetearth.forms;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.jasypt.util.password.ConfigurablePasswordEncryptor;

import com.planetearth.beans.Utilisateur;
import com.planetearth.dao.DAOException;
import com.planetearth.dao.UtilisateurDao;

public final class ConnexionForm {
    private static final String CHAMP_EMAIL      = "email";
    private static final String CHAMP_PASS       = "motDePasse";

    private static final String ALGO_CHIFFREMENT = "SHA-256";

    private String              resultat;
    private Map<String, String> erreurs          = new HashMap<String, String>();

    private UtilisateurDao      utilisateurDao;

    public ConnexionForm( UtilisateurDao utilisateurDao ) {
        this.utilisateurDao = utilisateurDao;
    }

    public String getResultat() {
        return resultat;
    }

    public Map<String, String> getErreurs() {
        return erreurs;
    }

    public Utilisateur connecterUtilisateur( HttpServletRequest request ) {
        /* Récupération des champs du formulaire */
        String email = getValeurChamp( request, CHAMP_EMAIL );
        String motDePasse = getValeurChamp( request, CHAMP_PASS );

        Utilisateur utilisateur = new Utilisateur();
        Utilisateur user = new Utilisateur();

        try {
            traiterEmail( email, utilisateur );
            user = utilisateurDao.read( email );
            boolean passeCorrect = false;

            if ( user != null ) {
                passeCorrect = traiterMotsDePasse( motDePasse, user.getMotDePasse() );
            }
            /* Initialisation du résultat global de la validation. */
            resultat = "Échec de la connexion.";
            if ( erreurs.isEmpty() ) {
                if ( user == null ) {
                    setErreur( CHAMP_EMAIL, "L’e-mail entré ne correspond à aucun compte." );
                } else if ( !passeCorrect ) {
                    setErreur( CHAMP_PASS, "Mot de passe incorrect." );
                } else {
                    utilisateur.setAge( user.getAge() );
                    utilisateur.setDateInscription( user.getDateInscription() );
                    utilisateur.setIdPanier( user.getIdPanier() );
                    utilisateur.setNom( user.getNom() );
                    utilisateur.setPrenom( user.getPrenom() );
                    utilisateur.setTelephone( user.getTelephone() );
                    utilisateur.setAdmin( user.isAdmin() );

                    resultat = "Succès de la connexion.";
                }
            }
        } catch ( DAOException e ) {
            setErreur( "imprévu ", "Erreur imprévue lors de la création." );
            resultat = "Échec de la connexion : une erreur imprévue est survenue, merci de réessayer dans quelques instants.";
            e.printStackTrace();
        }

        return utilisateur;
    }

    private void traiterEmail( String email, Utilisateur utilisateur ) {
        /* Validation du champ email. */
        try {
            validationEmail( email );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_EMAIL, e.getMessage() );
        }
        utilisateur.setEmail( email );
    }

    private boolean traiterMotsDePasse( String motDePasse, String motDePasseChiffre ) {

        /* Validation du champ mot de passe. */
        try {
            validationMotDePasse( motDePasse );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_PASS, e.getMessage() );
        }

        /*
         * Verification du mot de passe entrée avec celui crypté dans la base de
         * données
         */
        ConfigurablePasswordEncryptor passwordEncryptor = new ConfigurablePasswordEncryptor();
        passwordEncryptor.setAlgorithm( ALGO_CHIFFREMENT );
        passwordEncryptor.setPlainDigest( false );
        return passwordEncryptor.checkPassword( motDePasse, motDePasseChiffre );
    }

    /**
     * Valide l'adresse email saisie.
     */
    private void validationEmail( String email ) throws FormValidationException {
        if ( email != null && !email.matches( "([^.@]+)(\\.[^.@]+)*@([^.@]+\\.)+([^.@]+)" ) ) {
            throw new FormValidationException( "Merci de saisir une adresse mail valide." );
        } else if ( email == null ) {
            throw new FormValidationException( "Merci de saisir votre adresse mail." );
        } else {

        }
    }

    /**
     * Valide le mot de passe saisi.
     */
    private void validationMotDePasse( String motDePasse ) throws FormValidationException {
        if ( motDePasse == null ) {
            throw new FormValidationException( "Merci de saisir votre mot de passe." );
        }
    }

    /*
     * Ajoute un message correspondant au champ spécifié à la map des erreurs.
     */
    private void setErreur( String champ, String message ) {
        erreurs.put( champ, message );
    }

    /*
     * Méthode utilitaire qui retourne null si un champ est vide, et son contenu
     * sinon.
     */
    private static String getValeurChamp( HttpServletRequest request, String nomChamp ) {
        String valeur = request.getParameter( nomChamp );
        if ( valeur == null || valeur.trim().length() == 0 ) {
            return null;
        } else {
            return valeur;
        }
    }
}