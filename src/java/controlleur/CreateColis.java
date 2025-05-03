package controlleur;

import entities.Colis;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.ColisDao;

@WebServlet(name = "CreateColis", urlPatterns = {"/CreateColis"})
public class CreateColis extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // 1. Get form parameters
            String expediteur = request.getParameter("expediteur");
            String destinataire = request.getParameter("destinataire");
            double poids = Double.parseDouble(request.getParameter("poids"));

            // 2. Validate inputs
            if (expediteur == null || expediteur.isEmpty() || 
                destinataire == null || destinataire.isEmpty()) {
                throw new IllegalArgumentException("Tous les champs sont obligatoires");
            }

            if (poids <= 0) {
                throw new IllegalArgumentException("Le poids doit être positif");
            }

            // 3. Create new Colis with default status
            Colis colis = new Colis(expediteur, destinataire, poids, "En attente");
            ColisDao colisDao = new ColisDao();

            // 4. Save to database
            if (colisDao.create(colis)) {
                response.sendRedirect("gestionColis.jsp?success=Colis créé avec succès");
            } else {
                response.sendRedirect("gestionColis.jsp?error=Erreur lors de la création du colis");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("gestionColis.jsp?error=Poids invalide");
        } catch (IllegalArgumentException e) {
            response.sendRedirect("gestionColis.jsp?error=" + e.getMessage());
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