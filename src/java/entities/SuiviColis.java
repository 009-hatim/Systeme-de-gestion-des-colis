/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.util.Date;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.hibernate.annotations.NamedNativeQuery;
import org.hibernate.annotations.NamedQuery;

/**
 *
 * @author hkoub
 */
@Entity
@Table(name = "suiviColis")

@NamedQuery (name = "findByEtat", query = "from SuiviColis where etat=:et")
@NamedNativeQuery(name = "findSuiviByColisId",query = "SELECT s.* FROM suivicolis s WHERE s.colis_id = :id",resultClass = SuiviColis.class)

public class SuiviColis {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Temporal(TemporalType.DATE)
    private Date date;
    private String lieu;
    private String etat;
    private double latitude;
    private double longitude;

    public SuiviColis() {
    }
    @ManyToOne
    @JoinColumn(name = "colis_id")
    private Colis colis;

    public SuiviColis(int id, Date date, String lieu, String etat, double latitude, double longitude) {
        this.id = id;
        this.date = date;
        this.lieu = lieu;
        this.etat = etat;
        this.latitude = latitude;
        this.longitude = longitude;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getLieu() {
        return lieu;
    }

    public void setLieu(String lieu) {
        this.lieu = lieu;
    }

    public String getEtat() {
        return etat;
    }

    public void setEtat(String etat) {
        this.etat = etat;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public Colis getColis() {
        return colis;
    }

    public void setColis(Colis colis) {
        this.colis = colis;
    }

    
}