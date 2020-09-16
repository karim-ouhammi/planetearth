package com.planetearth.dao;

import java.util.List;

import com.planetearth.beans.VoyagePanier;

public interface VoyagePanierDao {
    void create( VoyagePanier voyagePanier ) throws DAOException;

    VoyagePanier read( Long idVoyage, Long idPanier, VoyageDao voyageDao, UtilisateurDao utilisateurDao,
            DestinationDao destinationDao, ThemeDao themeDao, TypeDao typeDao )
            throws DAOException;

    List<VoyagePanier> listAdmin( VoyageDao voyageDao, UtilisateurDao utilisateurDao, DestinationDao destinationDao,
            ThemeDao themeDao, TypeDao typeDao ) throws DAOException;

    List<VoyagePanier> list( Long idPanier, VoyageDao voyageDao, UtilisateurDao utilisateurDao,
            DestinationDao destinationDao, ThemeDao themeDao, TypeDao typeDao ) throws DAOException;

    void delete( Long idVoyage, Long idPanier ) throws DAOException;
}
