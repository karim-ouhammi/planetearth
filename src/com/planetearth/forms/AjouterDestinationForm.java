package com.planetearth.forms;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.planetearth.beans.Destination;
import com.planetearth.dao.DAOException;
import com.planetearth.dao.DestinationDao;

public final class AjouterDestinationForm {
    private static final String CHAMP_DESTINATION = "nomDestination";
    private static final String CHAMP_CONTINENT   = "listeContinents";

    private DestinationDao      destinationDao;

    public AjouterDestinationForm( DestinationDao destinationDao ) {
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

    public Destination ajouterDestination( HttpServletRequest request ) {
        String nom = getValeurChamp( request, CHAMP_DESTINATION );
        String continent = getValeurChamp( request, CHAMP_CONTINENT );

        Destination destination = new Destination();

        try {
            traiterNom( nom, destination );

            destination.setContinent( continent );

            if ( erreurs.isEmpty() ) {
                destinationDao.create( destination );
                resultat = "Destination ajouté avec succès.";
            } else {
                resultat = "Échec de l'operation.";
            }
        } catch ( DAOException e ) {
            setErreur( "imprévu ", "Erreur imprévue lors de l'ajout." );
            resultat = "Échec de l'ajout de la destination : une erreur imprévue est survenue, merci de réessayer dans quelques instants.";
            e.printStackTrace();
        }

        return destination;
    }

    private void traiterNom( String nom, Destination destination ) {
        try {
            validationNom( nom );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_DESTINATION, e.getMessage() );
        }
        destination.setNom( nom );
    }

    private void validationNom( String nom ) throws FormValidationException {
        if ( nom != null && nom.length() < 3 ) {
            throw new FormValidationException( "Le nom de la destination doit contenir au moins 3 caractères." );
        } else if ( nom == null ) {
            throw new FormValidationException( "Merci de saisir le nom d'une destination." );
        } else if ( destinationDao.read( nom ) != null ) {
            throw new FormValidationException(
                    "Cette destination existe déja dans la base de données." );
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
