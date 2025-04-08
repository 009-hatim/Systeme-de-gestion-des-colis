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
public class ColisDao implements Idao<Colis>{

    @Override
    public boolean create(Colis o) {
        Session session = null;
        Transaction tx = null;
        boolean etat = false;
        try{
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            session.save(o);
            tx.commit();
            etat = true;
        }catch(HibernateException e){
            if(tx != null){
                tx.rollback();
            }
        }finally{
            if(session !=null)
                session.close();
        }
        return etat;
    }

    @Override
    public boolean delete(Colis o) {
        Session session = null;
        Transaction tx = null;
        boolean etat = false;
        try{
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            session.delete(o);
            tx.commit();
            etat = true;
        }catch(HibernateException e){
            if(tx != null){
                tx.rollback();
            }
        }finally{
            if(session !=null)
                session.close();
        }
        return etat;
    }

    @Override
    public boolean update(Colis o) {
        Session session = null;
        Transaction tx = null;
        boolean etat = false;
        try{
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            session.update(o);
            tx.commit();
            etat = true;
        }catch(HibernateException e){
            if(tx != null){
                tx.rollback();
            }
        }finally{
            if(session !=null)
                session.close();
        }
        return etat;
    }

    @Override
    public List<Colis> findALL() {
        Session session = null;
        Transaction tx = null;
        List<Colis> colises = null;
        try{
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            colises = session.createQuery("from Colis").list();
            tx.commit();
        }catch(HibernateException e){
            if(tx != null){
                tx.rollback();
            }
        }finally{
            if(session !=null)
                session.close();
        }
        return colises;
    }

    @Override
    public Colis findById(int id) {
        Session session = null;
        Transaction tx = null;
        Colis colis = null;
        try{
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            colis = (Colis) session.get(Colis.class,id);
            tx.commit();
        }catch(HibernateException e){
            if(tx != null){
                tx.rollback();
            }
        }finally{
            if(session !=null)
                session.close();
        }
        return colis;
    }
    
}
