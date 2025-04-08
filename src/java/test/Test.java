/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import dao.ColisDao;
import entities.Colis;
import util.HibernateUtil;

/**
 *
 * @author hkoub
 */
public class Test {
    public static void main(String[] args) {
        ColisDao cd = new ColisDao();
        cd.create(new Colis("Hatim","Rayan",12.2,"livree"));
        //cd.delete(cd.findById(2));
        
        for(Colis c : cd.findALL()){
            System.out.println(c.getDestinataire());
        }
    }
            
}
