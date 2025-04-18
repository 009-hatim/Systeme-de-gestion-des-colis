/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.SuiviColis;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author hkoub
 */
public class SuiviColisDao extends AbstractDao<SuiviColis> {

    public SuiviColisDao() {
        super(SuiviColis.class);
    }

    public List<SuiviColis> findByEtat(String etat) {
        Session session = null;
        Transaction tx = null;
        List<SuiviColis> result = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            result = session.getNamedQuery("findByEtat")
                    .setParameter("et", etat)
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

}
