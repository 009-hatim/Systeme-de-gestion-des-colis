package controlleur;

import entities.Transporteur;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.ServiceTransporteur;

@WebServlet(name = "DeleteTransporteur", urlPatterns = {"/DeleteTransporteur"})
public class DeleteTransporteur extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // 1. Get the transporteur ID from request
            int id = Integer.parseInt(request.getParameter("id"));
            
            // 2. Initialize service and find transporteur
            ServiceTransporteur service = new ServiceTransporteur();
            Transporteur transporteur = service.findById(id);
            
            if (transporteur != null) {
                // 3. Delete the transporteur
                boolean deleted = service.delete(transporteur);
                
                if (deleted) {
                    response.sendRedirect("adminDashboard.jsp?success=Transporteur supprimé avec succès");
                } else {
                    response.sendRedirect("adminDashboard.jsp?error=Échec de la suppression");
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