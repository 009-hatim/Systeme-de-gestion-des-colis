<%@page import="entities.Transporteur"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tableau de bord Transporteur</title>
    </head>
    <body>
        <% 
        // Use the implicit session object (don't redeclare it)
        if (session == null || session.getAttribute("transporteur") == null) {
            response.sendRedirect("Authentification.jsp?msg=Session expirée ou non autorisée");
            return;
        }
        Transporteur transporteur = (Transporteur) session.getAttribute("transporteur");
        %>
        <h1>Bienvenue Transporteur : <%= transporteur.getNom() %></h1>
        <p>Véhicule : <%= transporteur.getVehicule() %></p>
        <p>Email : <%= transporteur.getEmail() %></p>
        
        <!-- Add transporteur-specific content here -->
        
        <form action="Deconnexion" method="POST">
            <input type="submit" value="Déconnexion">
        </form>
    </body>
</html>