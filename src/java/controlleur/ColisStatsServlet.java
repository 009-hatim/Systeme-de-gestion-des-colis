/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlleur;

import dao.ColisDao;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ColisStats")
public class ColisStatsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            ColisDao colisDao = new ColisDao();
            int enAttente = colisDao.findByStatut("En attente").size();
            int enTransit = colisDao.findByStatut("En transit").size();
            int livre = colisDao.findByStatut("Livré").size();

            String json = String.format("{\"enAttente\":%d,\"enTransit\":%d,\"livre\":%d}",
                    enAttente, enTransit, livre);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
            
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Failed to retrieve colis statistics\"}");
            e.printStackTrace();
        }
    }
}