<%-- 
    Document   : welcome
    Created on : [Today's Date]
    Author     : Your Name
--%>

<%@page import="entities.Admin, entities.Transporteur"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tableau de bord</title>
    </head>
    <body>
        <%
            HttpSession sess = request.getSession(false);
            if (sess == null || (sess.getAttribute("admin") == null 
                && sess.getAttribute("transporteur") == null) {
                response.sendRedirect("Authentification.jsp?msg=Session expirée");
                return;
            }

            Admin admin = (Admin) sess.getAttribute("admin");
            Transporteur transporteur = (Transporteur) sess.getAttribute("transporteur");
        %>

        <% if (admin != null) { %>
            <h1>Bienvenue Admin: <%= admin.getNom() %></h1>
            <p>Matricule: <%= admin.getMatricule() %></p>
        <% } else { %>
            <h1>Bienvenue Transporteur: <%= transporteur.getNom() %></h1>
            <p>Véhicule: <%= transporteur.getVehicule() %></p>
        <% } %>

        <form action="deconnexion">
            <input type="submit" value="Déconnexion">
        </form>
    </body>
</html>