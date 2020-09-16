package com.planetearth.forms;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.jasypt.util.password.ConfigurablePasswordEncryptor;
import org.joda.time.DateTime;

import com.planetearth.beans.Utilisateur;
import com.planetearth.dao.DAOException;
import com.planetearth.dao.UtilisateurDao;

public final class InscriptionForm {
    private static final String CHAMP_EMAIL      = "email";
    private static final String CHAMP_PASS       = "motDePasseInsc";
    private static final String CHAMP_CONF       = "confirmation";
    private static final String CHAMP_NOM        = "nom";
    private static final String CHAMP_PRENOM     = "prenom";
    private static final String CHAMP_AGE        = "age";
    private static final String CHAMP_TELEPHONE  = "telephone";
    private static final String ALGO_CHIFFREMENT = "SHA-256";

    private UtilisateurDao      utilisateurDao;

    public InscriptionForm( UtilisateurDao utilisateurDao ) {
        this.utilisateurDao = utilisateurDao;
    }

    private String              resultat;
    private Map<String, String> erreurs = new HashMap<String, String>();

    public String getResultat() {
        return resultat;
    }

    public Map<String, String> getErreurs() {
        return erreurs;
    }

    public Utilisateur inscrireUtilisateur( HttpServletRequest request ) {
        String email = getValeurChamp( request, CHAMP_EMAIL );
        String motDePasse = getValeurChamp( request, CHAMP_PASS );
        String confirmation = getValeurChamp( request, CHAMP_CONF );
        String nom = getValeurChamp( request, CHAMP_NOM );
        String prenom = getValeurChamp( request, CHAMP_PRENOM );
        String age = getValeurChamp( request, CHAMP_AGE );
        String telephone = getValeurChamp( request, CHAMP_TELEPHONE );

        DateTime dt = new DateTime();
        Utilisateur utilisateur = new Utilisateur();

        try {
            traiterEmail( email, utilisateur );
            traiterMotsDePasse( motDePasse, confirmation, utilisateur );
            traiterNom( nom, utilisateur );
            traiterPrenom( prenom, utilisateur );
            traiterAge( age, utilisateur );
            traiterTelephone( telephone, utilisateur );

            utilisateur.setDateInscription( dt );

            if ( erreurs.isEmpty() ) {
                utilisateurDao.create( utilisateur );
                resultat = "Succès de l'inscription.";
            } else {
                resultat = "Échec de l'inscription.";
            }
        } catch ( DAOException e ) {
            setErreur( "imprévu ", "Erreur imprévue lors de la création." );
            resultat = "Échec de la création du client : une erreur imprévue est survenue, merci de réessayer dans quelques instants.";
            e.printStackTrace();
        }

        return utilisateur;
    }

    private void traiterTelephone( String telephone, Utilisateur utilisateur ) {
        try {
            validationTelephone( telephone );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_TELEPHONE, e.getMessage() );
        }
        utilisateur.setTelephone( telephone );
    }

    private void traiterAge( String age, Utilisateur utilisateur ) {
        int valeurAge = 0;
        try {
            valeurAge = validationAge( age );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_AGE, e.getMessage() );
        }
        utilisateur.setAge( valeurAge );
    }

    private void traiterPrenom( String prenom, Utilisateur utilisateur ) {
        try {
            validationPrenom( prenom );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_PRENOM, e.getMessage() );
        }
        utilisateur.setPrenom( prenom );
    }

    private void traiterEmail( String email, Utilisateur utilisateur ) {
        try {
            validationEmail( email );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_EMAIL, e.getMessage() );
        }
        utilisateur.setEmail( email );
    }

    private void traiterMotsDePasse( String motDePasse, String confirmation, Utilisateur utilisateur ) {
        try {
            validationMotsDePasse( motDePasse, confirmation );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_PASS, e.getMessage() );
            setErreur( CHAMP_CONF, null );
        }
        /*
         * Utilisation de la bibliothèque Jasypt pour chiffrer le mot de passe
         * efficacement.
         * 
         * L'algorithme SHA-256 est ici utilisé, avec par défaut un salage
         * aléatoire et un grand nombre d'itérations de la fonction de hashage.
         * 
         * La String retournée est de longueur 56 et contient le hash en Base64.
         */
        ConfigurablePasswordEncryptor passwordEncryptor = new ConfigurablePasswordEncryptor();
        passwordEncryptor.setAlgorithm( ALGO_CHIFFREMENT );
        passwordEncryptor.setPlainDigest( false );
        String motDePasseChiffre = passwordEncryptor.encryptPassword( motDePasse );
        utilisateur.setMotDePasse( motDePasseChiffre );
    }

    private void traiterNom( String nom, Utilisateur utilisateur ) {
        try {
            validationNom( nom );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_NOM, e.getMessage() );
        }
        utilisateur.setNom( nom );
    }

    private int validationAge( String age ) throws FormValidationException {
        int temp;
        if ( age != null ) {
            try {
                temp = Integer.parseInt( age );
                if ( temp < 10 ) {
                    throw new FormValidationException( "L'âge doit être un nombre supérieur à 10. " );
                } else if ( temp > 99 ) {
                    throw new FormValidationException( "L'âge doit être inférieur à 100. " );
                }
            } catch ( NumberFormatException e ) {
                temp = 0;
                throw new FormValidationException( "L'âge doit être un nombre." );
            }
        } else {
            temp = 0;
            throw new FormValidationException( "Merci d'entrer votre âge" );
        }

        return temp;
    }

    private void validationTelephone( String telephone ) throws FormValidationException {
        if ( telephone != null ) {
            if ( !telephone.matches( "^\\d+$" ) ) {
                throw new FormValidationException( "Le numéro de téléphone doit uniquement contenir des chiffres." );
            } else if ( telephone.length() < 4 || telephone.length() > 10 ) {
                throw new FormValidationException(
                        "Le numéro de téléphone doit contenir au moins 4 chiffres et 10 chiffres au plus." );
            }
        } else {
            throw new FormValidationException( "Merci d'entrer un numéro de téléphone." );
        }
    }

    private void validationEmail( String email ) throws FormValidationException {
        if ( email != null ) {
            if ( !email.matches( "([^.@]+)(\\.[^.@]+)*@([^.@]+\\.)+([^.@]+)" ) ) {
                throw new FormValidationException( "Merci de saisir une adresse mail valide." );
            } else if ( utilisateurDao.read( email ) != null ) {
                throw new FormValidationException(
                        "Cette adresse email est déjà utilisée, merci d'en choisir une autre." );
            }
        } else {
            throw new FormValidationException( "Merci de saisir une adresse mail." );
        }
    }

    private void validationMotsDePasse( String motDePasse, String confirmation ) throws FormValidationException {
        if ( motDePasse != null && confirmation != null ) {
            if ( !motDePasse.equals( confirmation ) ) {
                throw new FormValidationException(
                        "Les mots de passe entrés sont différents, merci de les saisir à nouveau." );
            } else if ( motDePasse.trim().length() < 3 ) {
                throw new FormValidationException( "Les mots de passe doivent contenir au moins 3 caractères." );
            }
        } else {
            throw new FormValidationException( "Merci de saisir et confirmer votre mot de passe." );
        }
    }

    private void validationNom( String nom ) throws FormValidationException {
        if ( nom != null && nom.length() < 3 ) {
            throw new FormValidationException( "Le nom d'utilisateur doit contenir au moins 3 caractères." );
        } else if ( nom == null ) {
            throw new FormValidationException( "Merci de saisir votre nom." );
        }
    }

    private void validationPrenom( String prenom ) throws FormValidationException {
        if ( prenom != null && prenom.length() < 3 ) {
            throw new FormValidationException( "Le prénom d'utilisateur doit contenir au moins 3 caractères." );
        } else if ( prenom == null ) {
            throw new FormValidationException( "Merci de saisir votre prénom." );
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
}
