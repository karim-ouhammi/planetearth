package com.planetearth.dao;

import java.util.List;

import com.planetearth.beans.Type;

public interface TypeDao {
    void create( Type type ) throws DAOException;

    Type read( Long id ) throws DAOException;

    List<Type> list() throws DAOException;

    void delete( Long id ) throws DAOException;

    void update( Type type ) throws DAOException;
}
