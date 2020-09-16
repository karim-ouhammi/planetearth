package com.planetearth.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public final class DAOUtility {
    /*
     * Constructeur caché par défaut (car c'est une classe finale utilitaire,
     * contenant uniquement des méthode appelées de manière statique)
     */
    private DAOUtility() {
    }

    public static PreparedStatement initPreparedQuery( Connection connection, String sql, boolean returnGeneratedKey,
            Object... objects )
            throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement( sql,
                returnGeneratedKey ? Statement.RETURN_GENERATED_KEYS : Statement.NO_GENERATED_KEYS );
        for ( int i = 0; i < objects.length; i++ ) {
            preparedStatement.setObject( i + 1, objects[i] );
        }
        return preparedStatement;
    }

    public static void close( ResultSet rs ) {
        if ( rs != null ) {
            try {
                rs.close();
            } catch ( SQLException e ) {
                System.out.println( "Echec de la fermeture du ResultSet : " + e.getMessage() );
            }
        }
    }

    public static void close( Statement statement ) {
        if ( statement != null ) {
            try {
                statement.close();
            } catch ( SQLException e ) {
                System.out.println( "Echec de la fermeture du Statement : " + e.getMessage() );
            }
        }
    }

    public static void close( Connection connection ) {
        if ( connection != null ) {
            try {
                connection.close();
            } catch ( SQLException e ) {
                System.out.println( "Echec de la fermeture de la connexion : " + e.getMessage() );
            }
        }
    }

    public static void close( Statement statement, Connection connection ) {
        close( statement );
        close( connection );
    }

    public static void close( ResultSet rs, Statement statement, Connection connection ) {
        close( rs );
        close( statement );
        close( connection );
    }
}
