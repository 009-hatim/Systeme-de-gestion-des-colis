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

@WebServlet(name = "UpdatePassword", urlPatterns = {"/UpdatePassword"})
public class UpdatePassword extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String userType = request.getParameter("userType");

        if (!password.equals(confirmPassword)) {
            response.sendRedirect("updatemotdepasse.jsp?msg=Les+mots+de+passe+ne+correspondent+pas&userType=" + userType);
            return;
        }

        if ("admin".equals(userType)) {
            HttpSession session = request.getSession();
            Admin admin = (Admin) session.getAttribute("admin");

            if (admin != null) {
                ServiceAdmin sa = new ServiceAdmin();
                admin.setMotDePasse(Util.md5(password));
                sa.update(admin);
                session.invalidate();
                response.sendRedirect("Authentification.jsp?msg=Mot+de+passe+mis+à+jour+avec+succès");
            }
        } else if ("transporteur".equals(userType)) {
            HttpSession session = request.getSession();
            Transporteur transporteur = (Transporteur) session.getAttribute("transporteur");

            if (transporteur != null) {
                ServiceTransporteur st = new ServiceTransporteur();
                transporteur.setMotDePasse(Util.md5(password));
                st.update(transporteur);
                session.invalidate();
                response.sendRedirect("Authentification.jsp?msg=Mot+de+passe+mis+à+jour+avec+succès");
            }
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