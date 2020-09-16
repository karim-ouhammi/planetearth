package com.planetearth.beans;

public class VoyagePanier {
    Voyage      voyage;
    Utilisateur utilisateur;
    int         nbPersonne;

    public Voyage getVoyage() {
        return voyage;
    }

    public void setVoyage( Voyage voyage ) {
        this.voyage = voyage;
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur( Utilisateur utilisateur ) {
        this.utilisateur = utilisateur;
    }

    public int getNbPersonne() {
        return nbPersonne;
    }

    public void setNbPersonne( int nbPersonne ) {
        this.nbPersonne = nbPersonne;
    }
}
