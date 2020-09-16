package com.planetearth.beans;

import org.joda.time.DateTime;

public class Utilisateur {
    private String   email;
    private Long     idPanier;
    private String   motDePasse;
    private String   nom;
    private String   prenom;
    private int      age;
    private String   telephone;
    private DateTime dateInscription;
    private boolean  isAdmin;

    public void setAdmin( boolean isAdmin ) {
        this.isAdmin = isAdmin;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public DateTime getDateInscription() {
        return dateInscription;
    }

    public void setDateInscription( DateTime dateInscription ) {
        this.dateInscription = dateInscription;
    }

    public void setIdPanier( Long idPanier ) {
        this.idPanier = idPanier;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail( String email ) {
        this.email = email;
    }

    public long getIdPanier() {
        return idPanier;
    }

    public void setIdPanier( long idPanier ) {
        this.idPanier = idPanier;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    public void setMotDePasse( String motDePasse ) {
        this.motDePasse = motDePasse;
    }

    public String getNom() {
        return nom;
    }

    public void setNom( String nom ) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom( String prenom ) {
        this.prenom = prenom;
    }

    public int getAge() {
        return age;
    }

    public void setAge( int age ) {
        this.age = age;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone( String telephone ) {
        this.telephone = telephone;
    }
}
