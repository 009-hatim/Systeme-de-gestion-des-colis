package controlleur;

import entities.Colis;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.ColisDao;

@WebServlet(name = "UpdateColis", urlPatterns = {"/UpdateColis"})
public class UpdateColis extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // 1. Get parameters from request
            int id = Integer.parseInt(request.getParameter("id"));
            String expediteur = request.getParameter("expediteur");
            String destinataire = request.getParameter("destinataire");
            double poids = Double.parseDouble(request.getParameter("poids"));
            String statut = request.getParameter("statut");

            // 2. Get existing colis from database
            ColisDao colisDao = new ColisDao();
            Colis colis = colisDao.findById(id);
            
            if (colis != null) {
                // 3. Update the existing colis object
                colis.setExpediteur(expediteur);
                colis.setDestinataire(destinataire);
                colis.setPoids(poids);
                colis.setStatut(statut);
                
                // 4. Perform the update
                if (colisDao.update(colis)) {
                    response.sendRedirect("gestionColis.jsp?success=Colis mis à jour avec succès");
                } else {
                    response.sendRedirect("gestionColis.jsp?error=Erreur lors de la mise à jour du colis");
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