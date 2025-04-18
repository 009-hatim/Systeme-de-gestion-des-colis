package controlleur;

import entities.Transporteur;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.ServiceTransporteur;

@WebServlet(name = "UpdateTransporteur", urlPatterns = {"/UpdateTransporteur"})
public class UpdateTransporteur extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // 1. Get parameters from the form
            int id = Integer.parseInt(request.getParameter("id"));
            String nom = request.getParameter("nom");
            String email = request.getParameter("email");
            String vehicule = request.getParameter("vehicule");
            
            // 2. Get the existing transporteur
            ServiceTransporteur service = new ServiceTransporteur();
            Transporteur transporteur = service.findById(id);
            
            if (transporteur != null) {
                // 3. Update the fields
                transporteur.setNom(nom);
                transporteur.setEmail(email);
                transporteur.setVehicule(vehicule);
                
                // 4. Save changes
                boolean updated = service.update(transporteur);
                
                if (updated) {
                    response.sendRedirect("adminDashboard.jsp?success=Transporteur mis à jour avec succès");
                } else {
                    response.sendRedirect("adminDashboard.jsp?error=Échec de la mise à jour");
                }
            } else {
                response.sendRedirect("adminDashboard.jsp?error=Transporteur introuvable");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("adminDashboard.jsp?error=ID invalide");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboard.jsp?error=Erreur serveur: " + e.getMessage());
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