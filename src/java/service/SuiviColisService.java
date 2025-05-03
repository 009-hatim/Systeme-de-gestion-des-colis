package service;

import dao.SuiviColisDao;
import entities.SuiviColis;
import java.util.List;

public class SuiviColisService {
    
    private SuiviColisDao dao = new SuiviColisDao();
    
    public boolean create(SuiviColis suivi) {
        return dao.create(suivi);
    }
    
    public List<SuiviColis> findByColisId(int colisId) {
        return dao.findByColisId(colisId);
    }
    
    public List<SuiviColis> findByEtat(String etat) {
        return dao.findByEtat(etat);
    }
}