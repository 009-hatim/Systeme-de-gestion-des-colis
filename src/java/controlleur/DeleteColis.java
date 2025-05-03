package controlleur;

import entities.Colis;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.ColisDao;

@WebServlet(name = "DeleteColis", urlPatterns = {"/DeleteColis"})
public class DeleteColis extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // 1. Get the colis ID from request
            int id = Integer.parseInt(request.getParameter("id"));
            
            // 2. Initialize dao and find colis
            ColisDao colisDao = new ColisDao();
            Colis colis = colisDao.findById(id);
            
            if (colis != null) {
                // 3. Delete the colis
                boolean deleted = colisDao.delete(colis);
                
                if (deleted) {
                    response.sendRedirect("gestionColis.jsp?success=Colis supprimé avec succès");
                } else {
                    response.sendRedirect("gestionColis.jsp?error=Échec de la suppression");
                }
            } else {
                response.sendRedirect("gestionColis.jsp?error=Colis introuvable");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("gestionColis.jsp?error=ID invalide");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("gestionColis.jsp?error=Erreur serveur: " + e.getMessage());
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