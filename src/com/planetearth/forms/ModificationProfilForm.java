package com.planetearth.forms;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.planetearth.beans.Utilisateur;
import com.planetearth.dao.DAOException;
import com.planetearth.dao.UtilisateurDao;

public class ModificationProfilForm {
    private static final String CHAMP_EMAIL     = "email";
    private static final String CHAMP_NOM       = "nom";
    private static final String CHAMP_PRENOM    = "prenom";
    private static final String CHAMP_AGE       = "age";
    private static final String CHAMP_TELEPHONE = "telephone";

    private UtilisateurDao      utilisateurDao;

    public ModificationProfilForm( UtilisateurDao utilisateurDao ) {
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

    public Utilisateur modifierUtilisateur( HttpServletRequest request, String ancienEmail ) {
        String email = getValeurChamp( request, CHAMP_EMAIL );
        String nom = getValeurChamp( request, CHAMP_NOM );
        String prenom = getValeurChamp( request, CHAMP_PRENOM );
        String age = getValeurChamp( request, CHAMP_AGE );
        String telephone = getValeurChamp( request, CHAMP_TELEPHONE );

        Utilisateur utilisateur = new Utilisateur();

        try {
            traiterEmail( email, utilisateur );
            traiterNom( nom, utilisateur );
            traiterPrenom( prenom, utilisateur );
            traiterAge( age, utilisateur );
            traiterTelephone( telephone, utilisateur );

            if ( erreurs.isEmpty() ) {
                utilisateurDao.update( utilisateur, ancienEmail );
                resultat = "Succès de la modification.";
            } else {
                resultat = "Échec de la modification.";
            }
        } catch ( DAOException e ) {
            setErreur( "imprévu ", "Erreur imprévue lors de la modification." );
            resultat = "Échec de la modification du profil : une erreur imprévue est survenue, merci de réessayer dans quelques instants.";
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
            }
        } else {
            throw new FormValidationException( "Merci de saisir une adresse mail." );
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
