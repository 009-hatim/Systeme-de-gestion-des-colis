package service;

import dao.IDao;
import entities.Colis;
import entities.Transporteur;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

public class ServiceTransporteur implements IDao<Transporteur> {

    @Override
    public boolean create(Transporteur o) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(o);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            session.close();
        }
    }

    @Override
    public boolean delete(Transporteur o) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Transporteur managed = (Transporteur) session.merge(o);
            session.delete(managed);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            session.close();
        }
    }

    @Override
    public boolean update(Transporteur o) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.merge(o);  // Important: use merge instead of update
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            session.close();
        }
    }

    @Override
    public Transporteur findById(int id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            Transporteur transporteur = (Transporteur) session.get(Transporteur.class, id);
            // If you need to access collections later, initialize them here
            // Hibernate.initialize(transporteur.getColisList());
            return transporteur;
        } finally {
            session.close();
        }
    }

    @Override
    public List<Transporteur> findAll() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            // Use JOIN FETCH if you need to access collections
            List<Transporteur> transporteurs = session.createQuery(
                    "SELECT DISTINCT t FROM Transporteur t LEFT JOIN FETCH t.colisList")
                    .list();
            return transporteurs;
        } finally {
            session.close();
        }
    }

    public Transporteur getByEmail(String email) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            Transporteur t = (Transporteur) session.createQuery(
                    "FROM Transporteur WHERE email = :email")
                    .setParameter("email", email)
                    .uniqueResult();
            return t;
        } finally {
            session.close();
        }
    }
}
