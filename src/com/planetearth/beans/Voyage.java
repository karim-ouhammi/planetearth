package com.planetearth.beans;

import org.joda.time.DateTime;

public class Voyage {
    private Long        id;
    private Destination destination;
    private Theme       theme;
    private String      titre;
    private String      hebergement;
    private DateTime    date;
    private Double      prix;
    private int         duree;
    private int         difficulte;
    private int         altitude;
    private String      description;

    public String getHebergement() {
        return hebergement;
    }

    public void setHebergement( String hebergement ) {
        this.hebergement = hebergement;
    }

    public int getDifficulte() {
        return difficulte;
    }

    public void setDifficulte( int difficulte ) {
        this.difficulte = difficulte;
    }

    public int getAltitude() {
        return altitude;
    }

    public void setAltitude( int altitude ) {
        this.altitude = altitude;
    }

    public Long getId() {
        return id;
    }

    public void setId( Long id ) {
        this.id = id;
    }

    public Destination getDestination() {
        return destination;
    }

    public void setDestination( Destination destination ) {
        this.destination = destination;
    }

    public Theme getTheme() {
        return theme;
    }

    public void setTheme( Theme theme ) {
        this.theme = theme;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre( String titre ) {
        this.titre = titre;
    }

    public DateTime getDate() {
        return date;
    }

    public void setDate( DateTime date ) {
        this.date = date;
    }

    public Double getPrix() {
        return prix;
    }

    public void setPrix( Double prix ) {
        this.prix = prix;
    }

    public int getDuree() {
        return duree;
    }

    public void setDuree( int duree ) {
        this.duree = duree;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription( String description ) {
        this.description = description;
    }
}
