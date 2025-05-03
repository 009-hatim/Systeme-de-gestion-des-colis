<%@page import="java.util.List"%>
<%@page import="entities.Colis"%>
<%@page import="dao.ColisDao"%>
<%@page import="entities.Transporteur"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Liste des Colis</title>
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
            }

            .sidebar {
                height: 100vh;
                width: 220px;
                position: fixed;
                top: 0;
                left: 0;
                background-color: #333;
                padding-top: 20px;
                color: white;
            }

            .sidebar h2 {
                text-align: center;
                margin-bottom: 30px;
            }

            .sidebar a {
                display: block;
                color: white;
                padding: 12px 20px;
                text-decoration: none;
            }

            .sidebar a:hover {
                background-color: #575757;
            }

            .main-content {
                margin-left: 240px;
                padding: 20px;
            }

            .logout-btn {
                margin-top: 30px;
                display: block;
                padding: 10px 20px;
                background-color: #cc0000;
                color: white;
                text-align: center;
                text-decoration: none;
                border-radius: 4px;
            }

            .logout-btn:hover {
                background-color: #a30000;
            }
            
            /* Add your existing table styles here */
            .container {
                max-width: 1000px;
                margin: 0 auto;
                padding: 20px;
            }
            
            table {
                width: 100%;
                border-collapse: collapse;
            }
            
            th, td {
                padding: 8px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }
        </style>
    </head>
    <body>
        <% 
        if (session == null || session.getAttribute("transporteur") == null) {
            response.sendRedirect("Authentification.jsp?msg=Session expirée ou non autorisée");
            return;
        }
        %>
        
        <%@include file="sidebar.jsp" %>
        
        <div class="main-content">
            <div class="container">
                <h1><i class="fas fa-list"></i> Liste des Colis</h1>
                
                <% if(request.getParameter("success") != null) { %>
                    <div class="alert alert-success">
                        <%= request.getParameter("success") %>
                    </div>
                <% } %>
                
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Expéditeur</th>
                            <th>Destinataire</th>
                            <th>Poids</th>
                            <th>Statut</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                        ColisDao colisDao = new ColisDao();
                        List<Colis> colisList = colisDao.findAll();
                        
                        for(Colis colis : colisList) { 
                        %>
                        <tr>
                            <td><%= colis.getId() %></td>
                            <td><%= colis.getExpediteur() %></td>
                            <td><%= colis.getDestinataire() %></td>
                            <td><%= colis.getPoids() %> kg</td>
                            <td><%= colis.getStatut() %></td>
                            <td>
                                <a href="suiviColis.jsp?id=<%= colis.getId() %>" class="btn btn-info">
                                    <i class="fas fa-eye"></i> Suivi
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>