package controlleur;

import entities.Admin;
import entities.Transporteur;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import service.ServiceAdmin;
import service.ServiceTransporteur;
import util.Util;

@WebServlet(name = "Authentification", urlPatterns = {"/Authentification"})
public class Authentification extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType"); // "admin" or "transporteur"

        if ("admin".equals(userType)) {
            ServiceAdmin sa = new ServiceAdmin();
            Admin admin = sa.getByEmail(email);
            
            if (admin != null) {
                if (admin.getMotDePasse().equals(Util.md5(password))) {
                    HttpSession session = request.getSession();
                    session.setAttribute("admin", admin);
                    response.sendRedirect("adminDashboard.jsp");
                } else {
                    response.sendRedirect("Authentification.jsp?msg=Mot de passe incorrect");
                }
            } else {
                response.sendRedirect("Authentification.jsp?msg=Email introuvable");
            }
        } else if ("transporteur".equals(userType)) {
            ServiceTransporteur st = new ServiceTransporteur();
            Transporteur transporteur = st.getByEmail(email);
            
            if (transporteur != null) {
                if (transporteur.getMotDePasse().equals(Util.md5(password))) {
                    HttpSession session = request.getSession();
                    session.setAttribute("transporteur", transporteur);
                    response.sendRedirect("transporteurDashboard.jsp");
                } else {
                    response.sendRedirect("Authentification.jsp?msg=Mot de passe incorrect");
                }
            } else {
                response.sendRedirect("Authentification.jsp?msg=Email introuvable");
            }
        } else {
            response.sendRedirect("Authentification.jsp?msg=Type d'utilisateur invalide");
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