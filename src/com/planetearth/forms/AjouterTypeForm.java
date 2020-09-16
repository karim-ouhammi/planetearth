package com.planetearth.forms;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.planetearth.beans.Type;
import com.planetearth.dao.DAOException;
import com.planetearth.dao.TypeDao;

public class AjouterTypeForm {
    private static final String CHAMP_NOM         = "nomType";
    private static final String CHAMP_DESCRIPTION = "description";

    private TypeDao             typeDao;

    public AjouterTypeForm( TypeDao typeDao ) {
        this.typeDao = typeDao;
    }

    private String              resultat;
    private Map<String, String> erreurs = new HashMap<String, String>();

    public String getResultat() {
        return resultat;
    }

    public Map<String, String> getErreurs() {
        return erreurs;
    }

    public Type ajouterType( HttpServletRequest request ) {
        String nom = getValeurChamp( request, CHAMP_NOM );
        String description = getValeurChamp( request, CHAMP_DESCRIPTION );

        Type type = new Type();

        try {
            traiterNom( nom, type );
            traiterDescription( description, type );

            if ( erreurs.isEmpty() ) {
                typeDao.create( type );
                resultat = "Type ajouté avec succès.";
            } else {
                resultat = "Échec de l'operation.";
            }
        } catch ( DAOException e ) {
            setErreur( "imprévu ", "Erreur imprévue lors de l'ajout." );
            resultat = "Échec de l'ajout du type : une erreur imprévue est survenue, merci de réessayer dans quelques instants.";
            e.printStackTrace();
        }

        return type;
    }

    private void traiterDescription( String description, Type type ) {
        try {
            validationDescription( description );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_DESCRIPTION, e.getMessage() );
        }
        type.setDescription( description );
    }

    private void traiterNom( String nom, Type type ) {
        try {
            validationNom( nom );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_NOM, e.getMessage() );
        }
        type.setNom( nom );
    }

    private void validationNom( String nom ) throws FormValidationException {
        if ( nom != null && nom.length() < 5 ) {
            throw new FormValidationException( "Le nom du type doit contenir au moins 5 caractères." );
        } else if ( nom == null ) {
            throw new FormValidationException( "Merci de saisir le nom d'un type." );
        }
    }

    private void validationDescription( String description ) throws FormValidationException {
        if ( description != null && description.length() < 10 ) {
            throw new FormValidationException( "La description doit contenir au moins 10 caractères." );
        } else if ( description == null ) {
            throw new FormValidationException( "Merci de saisir la description du type." );
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
