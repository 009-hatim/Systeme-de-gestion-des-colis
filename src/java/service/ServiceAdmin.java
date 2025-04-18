/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import dao.IDao;
import entities.Admin;

import java.util.List;
import util.HibernateUtil;
import org.hibernate.Session;


//Source : www.exelib.net
/**
 *
 * @author hkoub
 */
public class ServiceAdmin implements IDao<Admin>{
    
    @Override
    public boolean create(Admin o) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        session.save(o);
        session.getTransaction().commit();
        return true;
    }

    @Override
    public boolean delete(Admin o) {
       Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        session.delete(o);
        session.getTransaction().commit();
        return true;
    }

    @Override
    public boolean update(Admin o) {
          Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        session.update(o);
        session.getTransaction().commit();
        return true;
    }

    @Override
    public Admin findById(int id) {
        Admin client = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        client = (Admin) session.get(Admin.class, id);
        session.getTransaction().commit();
        return client;
    }

    @Override
    public List<Admin> findAll() {
        List<Admin> clients = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        clients = session.createQuery("from Admin").list();
        session.getTransaction().commit();
        return clients;
    }

    public Admin getByEmail(String email) {
        Admin c = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        c = (Admin) session.createQuery("from Admin where email = ?").setParameter(0, email).uniqueResult();
        session.getTransaction().commit();
        return c;
    }
}
