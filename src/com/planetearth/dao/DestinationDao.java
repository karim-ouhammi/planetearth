package com.planetearth.dao;

import java.util.List;

import com.planetearth.beans.Destination;

public interface DestinationDao {
    void create( Destination destination ) throws DAOException;

    Destination read( String destination ) throws DAOException;

    List<Destination> list() throws DAOException;

    void delete( String nomPays ) throws DAOException;
}
