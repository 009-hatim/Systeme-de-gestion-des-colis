/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import dao.ColisDao;
import entities.Colis;
import java.util.List;
/**
 *
 * @author hkoub
 */
public class TestStatut {
    public static void main(String[] args) {
        ColisDao cd = new ColisDao();
        
        for(Colis c: cd.findByStatut("En attente")){
            System.out.println(c.getDestinataire());
            
        }
    }
}