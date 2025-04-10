package entities;

import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "colis")
public class Colis {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String expediteur;
    private String destinataire;
    private Double poids;
    private String statut;

    @OneToMany(mappedBy = "colis", cascade = CascadeType.ALL)
    private List<SuiviColis> suiviColisList;

    @ManyToOne
    @JoinColumn(name = "transporteur_id")
    private Transporteur transporteur;

    public Transporteur getTransporteur() {
        return transporteur;
    }

    public void setTransporteur(Transporteur transporteur) {
        this.transporteur = transporteur;
    }

    public Colis() {
    }

    public Colis(String expediteur, String destinataire, Double poids, String statut) {
        this.expediteur = expediteur;
        this.destinataire = destinataire;
        this.poids = poids;
        this.statut = statut;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getExpediteur() {
        return expediteur;
    }

    public void setExpediteur(String expediteur) {
        this.expediteur = expediteur;
    }

    public String getDestinataire() {
        return destinataire;
    }

    public void setDestinataire(String destinataire) {
        this.destinataire = destinataire;
    }

    public Double getPoids() {
        return poids;
    }

    public void setPoids(Double poids) {
        this.poids = poids;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public List<SuiviColis> getSuiviColisList() {
        return suiviColisList;
    }

    public void setSuiviColisList(List<SuiviColis> suiviColisList) {
        this.suiviColisList = suiviColisList;
    }

}
