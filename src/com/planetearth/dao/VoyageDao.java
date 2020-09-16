package com.planetearth.dao;

import java.util.List;

import com.planetearth.beans.Voyage;

public interface VoyageDao {
    Long create( Voyage voyage ) throws DAOException;

    Voyage read( Long id, DestinationDao destinationDao, ThemeDao themeDao, TypeDao typeDao ) throws DAOException;

    List<Voyage> list( DestinationDao destinationDao, ThemeDao themeDao, TypeDao typeDao ) throws DAOException;

    void delete( Long id ) throws DAOException;

    void update( Voyage voyage ) throws DAOException;
}
