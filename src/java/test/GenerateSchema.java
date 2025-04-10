package test;

import org.hibernate.SessionFactory;
import util.HibernateUtil;

public class GenerateSchema {
    public static void main(String[] args) {
        // Cette ligne suffit à déclencher la génération du schéma
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        sessionFactory.close();

        System.out.println(">>> Schéma de base de données généré avec succès !");
    }
}
