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

@WebServlet(name = "Verifier", urlPatterns = {"/Verifier"})
public class Verifier extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        String userType = request.getParameter("userType");
        
        if ("admin".equals(userType)) {
            HttpSession session = request.getSession();
            Admin admin = (Admin) session.getAttribute("admin");
            
            if (admin != null && admin.getMotDePasse().equals(code)) {
                response.sendRedirect("updatemotdepasse.jsp?userType=admin");  // Changed to updatemotdepasse.jsp
            } else {
                response.sendRedirect("verifier.jsp?msg=Code incorrect&userType=admin");
            }
        } else if ("transporteur".equals(userType)) {
            HttpSession session = request.getSession();
            Transporteur transporteur = (Transporteur) session.getAttribute("transporteur");
            
            if (transporteur != null && transporteur.getMotDePasse().equals(code)) {
                response.sendRedirect("updatemotdepasse.jsp?userType=transporteur");  // Changed to updatemotdepasse.jsp
            } else {
                response.sendRedirect("verifier.jsp?msg=Code incorrect&userType=transporteur");
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