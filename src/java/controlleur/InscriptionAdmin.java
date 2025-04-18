package controlleur;

import entities.Admin;
import entities.Transporteur;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.ServiceAdmin;
import service.ServiceTransporteur;
import util.Util;

@WebServlet(name = "InscriptionAdmin", urlPatterns = {"/InscriptionAdmin"})
public class InscriptionAdmin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userType = request.getParameter("userType");
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String matricule = request.getParameter("matricule");
        String vehicule = request.getParameter("vehicule");

        // Validate password match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("Inscription.jsp?msg=Les mots de passe ne correspondent pas");
            return;
        }

        if ("admin".equals(userType)) {
            // Handle admin registration
            if (matricule == null || matricule.isEmpty()) {
                response.sendRedirect("Inscription.jsp?msg=Le matricule est requis pour les administrateurs");
                return;
            }

            ServiceAdmin sa = new ServiceAdmin();
            if (sa.getByEmail(email) != null) {
                response.sendRedirect("Inscription.jsp?msg=Cet email est déjà utilisé");
                return;
            }

            Admin admin = new Admin();
            admin.setNom(nom);
            admin.setEmail(email);
            admin.setMotDePasse(Util.md5(password));
            admin.setMatricule(matricule);

            if (sa.create(admin)) {
                response.sendRedirect("Authentification.jsp?msg=Inscription réussie. Veuillez vous connecter");
            } else {
                response.sendRedirect("Inscription.jsp?msg=Erreur lors de l'inscription");
            }

        } else if ("transporteur".equals(userType)) {
            // Handle transporteur registration
            if (vehicule == null || vehicule.isEmpty()) {
                response.sendRedirect("Inscription.jsp?msg=Le type de véhicule est requis pour les transporteurs");
                return;
            }

            ServiceTransporteur st = new ServiceTransporteur();
            if (st.getByEmail(email) != null) {
                response.sendRedirect("Inscription.jsp?msg=Cet email est déjà utilisé");
                return;
            }

            Transporteur transporteur = new Transporteur();
            transporteur.setNom(nom);
            transporteur.setEmail(email);
            transporteur.setMotDePasse(Util.md5(password));
            transporteur.setVehicule(vehicule);

            if (st.create(transporteur)) {
                response.sendRedirect("Authentification.jsp?msg=Inscription réussie. Veuillez vous connecter");
            } else {
                response.sendRedirect("Inscription.jsp?msg=Erreur lors de l'inscription");
            }
        } else {
            response.sendRedirect("Inscription.jsp?msg=Type d'utilisateur invalide");
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