package com.planetearth.dao;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DAOFactory {
    private static final String FILE_PROPERTIES    = "/com/planetearth/dao/dao.properties";
    private static final String PROPERTY_URL       = "url";
    private static final String PROPERTY_DRIVER    = "driver";
    private static final String PROPERTY_USER_NAME = "username";
    private static final String PROPERTY_PWD       = "pwd";

    private String              url;
    private String              username;
    private String              pwd;

    DAOFactory( String url, String username, String pwd ) {
        this.url = url;
        this.username = username;
        this.pwd = pwd;
    }

    /*
     * Méthode chargée de récupérer les informations de connexion à la base de
     * données, charger le driver JDBC et retourner une instance de la Factory
     */
    public static DAOFactory getInstance() throws DAOConfigurationException {
        Properties properties = new Properties();
        String url;
        String driver;
        String username;
        String pwd;

        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
        InputStream fileProperties = classLoader.getResourceAsStream( FILE_PROPERTIES );

        if ( fileProperties == null ) {
            throw new DAOConfigurationException( "Le fichier properties " + FILE_PROPERTIES + " est introuvable." );
        }

        try {
            properties.load( fileProperties );
            url = properties.getProperty( PROPERTY_URL );
            driver = properties.getProperty( PROPERTY_DRIVER );
            username = properties.getProperty( PROPERTY_USER_NAME );
            pwd = properties.getProperty( PROPERTY_PWD );
        } catch ( FileNotFoundException e ) {
            throw new DAOConfigurationException( "Le fichier properties " + FILE_PROPERTIES + " est introuvable.", e );
        } catch ( IOException e ) {
            throw new DAOConfigurationException( "Impossible de charger le fichier properties " + FILE_PROPERTIES, e );
        }

        try {
            Class.forName( driver );
        } catch ( ClassNotFoundException e ) {
            throw new DAOConfigurationException( "Le driver est introuvable dans le classpath.", e );
        }

        DAOFactory instance = new DAOFactory( url, username, pwd );
        return instance;
    }

    /* Méthode chargée de fournir une connexion à la base de données */
    /* package */ Connection getConnection() throws SQLException {
        return DriverManager.getConnection( url, username, pwd );
    }

    /*
     * Méthodes de récupération de l'implémentation des différents DAO
     */
    public UtilisateurDao getUtilisateurDao() {
        return new UtilisateurDaoImp( this );
    }

    public DestinationDao getDestinationDao() {
        return new DestinationDaoImp( this );
    }

    public TypeDao getTypeDao() {
        return new TypeDaoImp( this );
    }

    public ThemeDao getThemeDao() {
        return new ThemeDaoImp( this );
    }

    public MessageDao getMessageDao() {
        return new MessageDaoImp( this );
    }

    public VoyageDao getVoyageDao() {
        return new VoyageDaoImp( this );
    }

    public VoyagePanierDao getVoyagePanierDao() {
        return new VoyagePanierDaoImp( this );
    }

    public TitreDao getTitreDao() {
        return new TitreDaoImp( this );
    }
}
