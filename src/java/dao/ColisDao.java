/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Colis;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;


/**
 *
 * @author hkoub
 */
public class ColisDao extends AbstractDao<Colis>{

    public ColisDao() {
        super(Colis.class);
    }
    public Colis findById(int id) {
    Session session = null;
    try {
        session = HibernateUtil.getSessionFactory().openSession();
        Colis colis = (Colis) session.createQuery(
            "SELECT c FROM Colis c LEFT JOIN FETCH c.transporteur WHERE c.id = :id")
            .setParameter("id", id)
            .uniqueResult();
        return colis;
    } finally {
        if (session != null) {
            session.close();
        }
    }
}
    
     public List<Colis> findByStatut(String statut) {
        Session session = null;
        Transaction tx = null;
        List<Colis> result = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            result = session.getNamedQuery("findByStatut")
                    .setParameter("st", statut)
                    .list();
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return result;
    }
     
     public int countByStatus(String status) {
        Session session = null;
        Transaction tx = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            Long count = (Long) session.createQuery(
                "SELECT COUNT(c) FROM Colis c WHERE c.statut = :status")
                .setParameter("status", status)
                .uniqueResult();
            tx.commit();
            return count != null ? count.intValue() : 0;
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
            return 0;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public int countDeliveredToday() {
        Session session = null;
        Transaction tx = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            Long count = (Long) session.createQuery(
                "SELECT COUNT(c) FROM Colis c WHERE c.statut = 'Livré' AND DATE(c.dateLivraison) = CURRENT_DATE")
                .uniqueResult();
            tx.commit();
            return count != null ? count.intValue() : 0;
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
            return 0;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    // Optional: Count packages assigned to specific transporter
    public int countByTransporteur(int transporteurId) {
        Session session = null;
        Transaction tx = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            Long count = (Long) session.createQuery(
                "SELECT COUNT(c) FROM Colis c WHERE c.transporteur.id = :transporteurId")
                .setParameter("transporteurId", transporteurId)
                .uniqueResult();
            tx.commit();
            return count != null ? count.intValue() : 0;
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
            return 0;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }
    
}
