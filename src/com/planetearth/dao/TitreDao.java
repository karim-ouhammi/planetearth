package com.planetearth.dao;

import java.util.List;

import com.planetearth.beans.Titre;

public interface TitreDao {
    Long create( Titre titre ) throws DAOException;

    List<Titre> list() throws DAOException;

    void delete( Long id ) throws DAOException;

}
