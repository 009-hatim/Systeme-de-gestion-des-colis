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
import service.SendMail;

@WebServlet(name = "Mdob", urlPatterns = {"/Mdob"})
public class Mdob extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String userType = request.getParameter("userType");
        
        if ("admin".equals(userType)) {
            ServiceAdmin sa = new ServiceAdmin();
            Admin admin = sa.getByEmail(email);
            
            if (admin != null) {
                String code = String.valueOf((int)(Math.random() * 9000) + 1000);
                admin.setMotDePasse(code); // Temporarily store code in password field
                sa.update(admin);
                
                HttpSession session = request.getSession();
                session.setAttribute("admin", admin);
                
                SendMail.send("Votre code de réinitialisation est: " + code, email);
                response.sendRedirect("verifier.jsp?userType=admin");
            } else {
                response.sendRedirect("forgotPassword.jsp?msg=Email introuvable&userType=admin");
            }
        } else if ("transporteur".equals(userType)) {
            ServiceTransporteur st = new ServiceTransporteur();
            Transporteur transporteur = st.getByEmail(email);
            
            if (transporteur != null) {
                String code = String.valueOf((int)(Math.random() * 9000) + 1000);
                transporteur.setMotDePasse(code); // Temporarily store code in password field
                st.update(transporteur);
                
                HttpSession session = request.getSession();
                session.setAttribute("transporteur", transporteur);
                
                SendMail.send("Votre code de réinitialisation est: " + code, email);
                response.sendRedirect("verifier.jsp?userType=transporteur");
            } else {
                response.sendRedirect("forgotPassword.jsp?msg=Email introuvable&userType=transporteur");
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