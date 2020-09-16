package com.planetearth.beans;

import org.joda.time.DateTime;

public class Message {
    private Long        id;
    private Utilisateur utilisateur;
    private String      nomPrenom;
    private String      email;
    private String      titre;
    private String      message;
    private DateTime    date;
    private boolean     vu;

    public boolean isVu() {
        return vu;
    }

    public void setVu( boolean vu ) {
        this.vu = vu;
    }

    public DateTime getDate() {
        return date;
    }

    public void setDate( DateTime date ) {
        this.date = date;
    }

    public Long getId() {
        return id;
    }

    public void setId( Long id ) {
        this.id = id;
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur( Utilisateur utilisateur ) {
        this.utilisateur = utilisateur;
    }

    public String getNomPrenom() {
        return nomPrenom;
    }

    public void setNomPrenom( String nomPrenom ) {
        this.nomPrenom = nomPrenom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail( String email ) {
        this.email = email;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre( String titre ) {
        this.titre = titre;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage( String message ) {
        this.message = message;
    }
}
