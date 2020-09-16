package com.planetearth.dao;

import java.util.List;

import com.planetearth.beans.Theme;

public interface ThemeDao {

    void create( Theme theme ) throws DAOException;

    Theme read( Long id, TypeDao typeDao ) throws DAOException;

    List<Theme> list( TypeDao typeDao ) throws DAOException;

    void delete( Long id ) throws DAOException;

    void update( Theme theme ) throws DAOException;
}
