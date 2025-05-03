/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlleur;

/**
 *
 * @author hkoub
 */

import entities.SuiviColis;
import entities.Colis;
import entities.Transporteur;
import service.SuiviColisService;
import java.io.IOException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateSuiviColis", urlPatterns = {"/UpdateSuiviColis"})
public class UpdateSuiviColis extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int colisId = Integer.parseInt(request.getParameter("colisId"));
            String etat = request.getParameter("etat");
            String lieu = request.getParameter("lieu");
            double latitude = request.getParameter("latitude") != null && !request.getParameter("latitude").isEmpty() 
                    ? Double.parseDouble(request.getParameter("latitude")) : 0;
            double longitude = request.getParameter("longitude") != null && !request.getParameter("longitude").isEmpty() 
                    ? Double.parseDouble(request.getParameter("longitude")) : 0;
            
            Transporteur transporteur = (Transporteur) request.getSession().getAttribute("transporteur");
            
            SuiviColis suivi = new SuiviColis();
            suivi.setDate(new Date());
            suivi.setEtat(etat);
            suivi.setLieu(lieu);
            suivi.setLatitude(latitude);
            suivi.setLongitude(longitude);
            
            Colis colis = new Colis();
            colis.setId(colisId);
            suivi.setColis(colis);
            
            SuiviColisService service = new SuiviColisService();
            if (service.create(suivi)) {
                response.sendRedirect("suiviColis.jsp?colisId=" + colisId + "&success=Statut mis à jour avec succès");
            } else {
                response.sendRedirect("suiviColis.jsp?colisId=" + colisId + "&error=Erreur lors de la mise à jour");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("suiviColis.jsp?error=Erreur: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}