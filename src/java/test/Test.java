package test;

import entities.Colis;
import entities.SuiviColis;
import entities.Transporteur;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.Query;
import util.HibernateUtil;

import java.util.Date;
import java.util.List;

public class Test {

    public static void main(String[] args) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();

            // Création d'un transporteur
            Transporteur transporteur = new Transporteur("Van 01", "DHL Express", "dhl@transport.com", "dhl123");
            session.save(transporteur);
            System.out.println("Transporteur créé : " + transporteur.getNom());

            // Création d'un colis
            Colis colis = new Colis("Ali Express", "Hatim", 3.5, "En transit");
            colis.setTransporteur(transporteur);
            session.save(colis);
            System.out.println("Colis créé de " + colis.getExpediteur() + " vers " + colis.getDestinataire());

            // Ajout de suivi au colis
            SuiviColis suivi1 = new SuiviColis(0, new Date(), "Marrakech", "Déposé", 33.5731, -7.5898);
            suivi1.setColis(colis);
            session.save(suivi1);

            SuiviColis suivi2 = new SuiviColis(0, new Date(), "Rabat", "En cours de livraison", 34.0209, -6.8416);
            suivi2.setColis(colis);
            session.save(suivi2);

            System.out.println("Suivis enregistrés pour le colis.");

            tx.commit();

            // Requêtes de vérification simple
            System.out.println("\n--- VÉRIFICATIONS ---");

            // Filtrage par statut (statut = 'En transit') avec JOIN FETCH
            System.out.println("\nFiltrage - Statut 'En transit' :");
            Query queryStatus = session.createQuery("FROM Colis c JOIN FETCH c.transporteur WHERE c.statut = :s");
            queryStatus.setParameter("s", "En transit");
            List<Colis> colisByStatus = queryStatus.list();
            colisByStatus.forEach(c -> {
                System.out.println("Expéditeur: " + c.getExpediteur() + " → Destinataire: " + c.getDestinataire());
                System.out.println("Poids: " + c.getPoids() + "kg | Statut: " + c.getStatut());
            });

        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
            HibernateUtil.getSessionFactory().close();
        }
    }
}
