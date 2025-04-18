package controlleur;

import entities.Transporteur;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.ServiceTransporteur;
import util.Util;

@WebServlet(name = "CreateTransporteur", urlPatterns = {"/CreateTransporteur"})
public class CreateTransporteur extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // 1. Get form parameters
            String nom = request.getParameter("nom");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String vehicule = request.getParameter("vehicule");
            
            // 2. Create new Transporteur
            Transporteur t = new Transporteur(vehicule, nom, email, Util.md5(password));
            
            // 3. Save to database
            ServiceTransporteur service = new ServiceTransporteur();
            boolean created = service.create(t);
            
            if (created) {
                response.sendRedirect("adminDashboard.jsp?success=Transporteur ajouté avec succès");
            } else {
                response.sendRedirect("adminDashboard.jsp?error=Erreur lors de l'ajout");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboard.jsp?error=Erreur: " + e.getMessage());
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