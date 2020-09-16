package com.planetearth.forms;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.joda.time.DateTime;

import com.planetearth.beans.Message;
import com.planetearth.beans.Utilisateur;
import com.planetearth.dao.DAOException;
import com.planetearth.dao.MessageDao;

public class MessageForm {
    private static final String CHAMP_NOM        = "nom";
    private static final String CHAMP_EMAIL      = "email";
    private static final String CHAMP_TITRE      = "titre";
    private static final String CHAMP_MESSAGE    = "message";

    private static final String ATT_SESSION_USER = "sessionUtilisateur";

    private MessageDao          messageDao;

    public MessageForm( MessageDao messageDao ) {
        this.messageDao = messageDao;
    }

    private String              resultat;
    private Map<String, String> erreurs = new HashMap<String, String>();

    public String getResultat() {
        return resultat;
    }

    public Map<String, String> getErreurs() {
        return erreurs;
    }

    public Message envoyerMessage( HttpServletRequest request ) {
        String titre = getValeurChamp( request, CHAMP_TITRE );
        String contenuMessage = getValeurChamp( request, CHAMP_MESSAGE );

        String nomPrenom = null;
        String email = null;

        DateTime dt = new DateTime();
        Message message = new Message();

        Utilisateur utilisateur = (Utilisateur) request.getSession().getAttribute( ATT_SESSION_USER );

        if ( utilisateur == null ) {
            nomPrenom = getValeurChamp( request, CHAMP_NOM );
            email = getValeurChamp( request, CHAMP_EMAIL );
        } else {
            message.setNomPrenom( utilisateur.getNom() + " " + utilisateur.getPrenom() );
            message.setEmail( utilisateur.getEmail() );
            message.setUtilisateur( utilisateur );
        }

        try {
            traiterTitre( titre, message );
            traiterMessage( contenuMessage, message );

            message.setDate( dt );

            if ( utilisateur == null ) {
                traiterNom( nomPrenom, message );
                traiterEmail( email, message );
                message.setUtilisateur( null );
            }

            if ( erreurs.isEmpty() ) {
                messageDao.create( message );
                resultat = "Message envoyé avec succès.";
            } else {
                resultat = "Échec de l'envoi du message.";
            }
        } catch ( DAOException e ) {
            setErreur( "imprévu ", "Erreur imprévue lors de la création du message." );
            resultat = "Échec de la création du message : une erreur imprévue est survenue, merci de réessayer dans quelques instants.";
            e.printStackTrace();
        }

        return message;
    }

    private void traiterTitre( String titre, Message message ) {
        try {
            validationTitre( titre );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_TITRE, e.getMessage() );
        }
        message.setTitre( titre );
    }

    private void traiterMessage( String contenuMessage, Message message ) {
        try {
            validationMessage( contenuMessage );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_MESSAGE, e.getMessage() );
        }
        message.setMessage( contenuMessage );
    }

    private void traiterNom( String nom, Message message ) {
        try {
            validationNom( nom );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_NOM, e.getMessage() );
        }
        message.setNomPrenom( nom );
    }

    private void traiterEmail( String email, Message message ) {
        try {
            validationEmail( email );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_EMAIL, e.getMessage() );
        }
        message.setEmail( email );
    }

    private void validationTitre( String titre ) throws FormValidationException {
        if ( titre != null && titre.length() < 5 ) {
            throw new FormValidationException( "Le titre du message doit contenir au moins 5 caractères." );
        } else if ( titre == null ) {
            throw new FormValidationException( "Merci de saisir le titre du message." );
        }
    }

    private void validationMessage( String message ) throws FormValidationException {
        if ( message != null && message.length() < 10 ) {
            throw new FormValidationException( "Le message doit contenir au moins 10 caractères." );
        } else if ( message == null ) {
            throw new FormValidationException( "Merci de saisir le message." );
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
        if ( nom != null && nom.length() < 6 ) {
            throw new FormValidationException( "Le nom et le prénom doit contenir au moins 6 caractères." );
        } else if ( nom == null ) {
            throw new FormValidationException( "Merci de saisir votre nom et prénom." );
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
