/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import dao.SuiviColisDao;
import entities.SuiviColis;
import java.util.List;
/**
 *
 * @author hkoub
 */
public class testSuivi {
    public static void main(String[] args) {
        SuiviColisDao sd = new SuiviColisDao();
        for(SuiviColis s : sd.findByEtat("En cours de livraison")){
            System.out.println(s.getLieu());
        }
    }
}