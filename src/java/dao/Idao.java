/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.List;

/**
 *
 * @author hkoub
 */
public interface Idao <T> {
    
    boolean create(T o);
    boolean delete(T o);
    boolean update(T o);  
    List<T> findALL();
    T findById(int id);
    
}
