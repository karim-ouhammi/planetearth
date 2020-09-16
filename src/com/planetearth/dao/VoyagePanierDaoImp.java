package com.planetearth.dao;

import static com.planetearth.dao.DAOUtility.close;
import static com.planetearth.dao.DAOUtility.initPreparedQuery;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.planetearth.beans.VoyagePanier;

public class VoyagePanierDaoImp implements VoyagePanierDao {
    private static final String SQL_SELECT           = "SELECT idVoyage, idPanier, nbPersonne FROM voyagepanier";
    private static final String SQL_SELECT_ID_PANIER = "SELECT idVoyage, idPanier, nbPersonne FROM voyagepanier WHERE idPanier = ?";
    private static final String SQL_SELECT_ID        = "SELECT idVoyage, idPanier, nbPersonne FROM voyagepanier WHERE idVoyage = ? and idPanier = ?";
    private static final String SQL_INSERT           = "INSERT INTO voyagepanier (idVoyage, idPanier, nbPersonne) VALUES (?, ?, ?)";
    private static final String SQL_DELETE           = "DELETE FROM voyagepanier WHERE idVoyage = ? and idPanier = ?";

    private DAOFactory          daoFactory;

    public VoyagePanierDaoImp( DAOFactory daoFactory ) {
        this.daoFactory = daoFactory;
    }

    @Override
    public void create( VoyagePanier voyagePanier ) throws DAOException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = daoFactory.getConnection();

            preparedStatement = initPreparedQuery( connection, SQL_INSERT, false, voyagePanier.getVoyage().getId(),
                    voyagePanier.getUtilisateur().getIdPanier(), voyagePanier.getNbPersonne() );
            int status = preparedStatement.executeUpdate();
            if ( status == 0 ) {
                throw new DAOException( "Échec de la création de la demande." );
            }
        } catch ( SQLException e ) {
            throw new DAOException( e );
        } catch ( Exception e ) {
            throw new DAOException( e );
        } finally {
            close( preparedStatement, connection );
        }
    }

    @Override
    public VoyagePanier read( Long idVoyage, Long idPanier, VoyageDao voyageDao, UtilisateurDao utilisateurDao,
            DestinationDao destinationDao, ThemeDao themeDao, TypeDao typeDao )
            throws DAOException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        VoyagePanier voyagePanier = null;

        try {
            connection = daoFactory.getConnection();

            preparedStatement = initPreparedQuery( connection, SQL_SELECT_ID, false, idVoyage, idPanier );

            rs = preparedStatement.executeQuery();
            if ( rs.next() ) {
                voyagePanier = map( rs, voyageDao, utilisateurDao, destinationDao, themeDao, typeDao );
            }
        } catch ( SQLException e ) {
            throw new DAOException( e );
        } finally {
            close( rs, preparedStatement, connection );
        }

        return voyagePanier;
    }

    @Override
    public List<VoyagePanier> listAdmin( VoyageDao voyageDao, UtilisateurDao utilisateurDao,
            DestinationDao destinationDao,
            ThemeDao themeDao, TypeDao typeDao ) throws DAOException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        List<VoyagePanier> voyagePaniers = new ArrayList<VoyagePanier>();

        try {
            connection = daoFactory.getConnection();
            preparedStatement = initPreparedQuery( connection, SQL_SELECT, false );

            rs = preparedStatement.executeQuery();
            while ( rs.next() ) {
                voyagePaniers.add( map( rs, voyageDao, utilisateurDao, destinationDao, themeDao, typeDao ) );
            }
        } catch ( SQLException e ) {
            throw new DAOException( e );
        } finally {
            close( rs, preparedStatement, connection );
        }

        return voyagePaniers;
    }

    @Override
    public List<VoyagePanier> list( Long idPanier, VoyageDao voyageDao, UtilisateurDao utilisateurDao,
            DestinationDao destinationDao, ThemeDao themeDao, TypeDao typeDao ) throws DAOException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        List<VoyagePanier> voyagePaniers = new ArrayList<VoyagePanier>();

        try {
            connection = daoFactory.getConnection();
            preparedStatement = initPreparedQuery( connection, SQL_SELECT_ID_PANIER, false, idPanier );

            rs = preparedStatement.executeQuery();
            while ( rs.next() ) {
                voyagePaniers.add( map( rs, voyageDao, utilisateurDao, destinationDao, themeDao, typeDao ) );
            }
        } catch ( SQLException e ) {
            throw new DAOException( e );
        } finally {
            close( rs, preparedStatement, connection );
        }

        return voyagePaniers;
    }

    @Override
    public void delete( Long idVoyage, Long idPanier ) throws DAOException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = daoFactory.getConnection();
            preparedStatement = initPreparedQuery( connection, SQL_DELETE, false, idVoyage, idPanier );

            int status = preparedStatement.executeUpdate();
            if ( status == 0 ) {
                throw new DAOException( "Échec de la suppression de la demande." );
            }
        } catch ( SQLException e ) {
            throw new DAOException( e );
        } finally {
            close( preparedStatement, connection );
        }
    }

    private static VoyagePanier map( ResultSet rs, VoyageDao voyageDao, UtilisateurDao utilisateurDao,
            DestinationDao destinationDao, ThemeDao themeDao, TypeDao typeDao )
            throws SQLException {
        VoyagePanier voyagePanier = new VoyagePanier();

        voyagePanier.setNbPersonne( rs.getInt( "nbPersonne" ) );
        voyagePanier.setUtilisateur( utilisateurDao.readIdPanier( rs.getLong( "idPanier" ) ) );
        voyagePanier.setVoyage( voyageDao.read( rs.getLong( "idVoyage" ), destinationDao, themeDao, typeDao ) );

        return voyagePanier;
    }
}
