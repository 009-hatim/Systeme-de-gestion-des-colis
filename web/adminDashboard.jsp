<%@page import="java.util.List"%>
<%@page import="entities.Transporteur"%>
<%@page import="service.ServiceTransporteur"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tableau de bord Admin</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                background-color: #f5f5f5;
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            h1 {
                color: #333;
                border-bottom: 2px solid #4CAF50;
                padding-bottom: 10px;
            }
            .section {
                margin-bottom: 30px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: left;
            }
            th {
                background-color: #4CAF50;
                color: white;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            .action-buttons a {
                padding: 5px 10px;
                margin-right: 5px;
                text-decoration: none;
                color: white;
                border-radius: 4px;
                font-size: 14px;
            }
            .edit-btn {
                background-color: #2196F3;
            }
            .delete-btn {
                background-color: #f44336;
            }
            .add-btn {
                background-color: #4CAF50;
                padding: 8px 15px;
                text-decoration: none;
                color: white;
                border-radius: 4px;
                display: inline-block;
                margin-bottom: 15px;
            }
            .form-container {
                background: #e9e9e9;
                padding: 15px;
                border-radius: 5px;
                margin-top: 20px;
            }
            .form-group {
                margin-bottom: 10px;
            }
            .form-group label {
                display: inline-block;
                width: 100px;
                font-weight: bold;
            }
            input[type="text"], 
            input[type="email"], 
            input[type="password"] {
                padding: 8px;
                width: 250px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            input[type="submit"], button {
                background-color: #4CAF50;
                color: white;
                padding: 8px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                margin-right: 10px;
            }
            button.cancel {
                background-color: #f44336;
            }
            .alert {
                padding: 15px;
                margin-bottom: 20px;
                border-radius: 4px;
            }
            .alert-success {
                background-color: #dff0d8;
                color: #3c763d;
                border: 1px solid #d6e9c6;
            }
            .alert-error {
                background-color: #f2dede;
                color: #a94442;
                border: 1px solid #ebccd1;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <% 
            if (session == null || session.getAttribute("admin") == null) {
                response.sendRedirect("Authentification.jsp?msg=Session expirée ou non autorisée");
                return;
            }
            %>
            
            <%-- Success/Error Messages --%>
            <% if (request.getParameter("success") != null) { %>
                <div class="alert alert-success">
                    <%= request.getParameter("success") %>
                </div>
            <% } %>
            <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-error">
                    <%= request.getParameter("error") %>
                </div>
            <% } %>
            
            <h1>Tableau de bord Administrateur</h1>
            
            <div class="section">
                <h2>Gestion des Transporteurs</h2>
                
                <!-- Add Transporteur Form -->
                <h3>Ajouter un nouveau transporteur</h3>
                <form action="CreateTransporteur" method="POST" class="form-container">
                    <div class="form-group">
                        <label for="nom">Nom:</label>
                        <input type="text" id="nom" name="nom" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Mot de passe:</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    <div class="form-group">
                        <label for="vehicule">Véhicule:</label>
                        <input type="text" id="vehicule" name="vehicule" required>
                    </div>
                    <input type="submit" value="Ajouter">
                </form>
                
                <!-- Transporteurs List -->
                <h3>Liste des transporteurs</h3>
                <%
                    ServiceTransporteur st = new ServiceTransporteur();
                    List<Transporteur> transporteurs = st.findAll();
                %>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nom</th>
                            <th>Email</th>
                            <th>Véhicule</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Transporteur t : transporteurs) { %>
                        <tr>
                            <td><%= t.getId() %></td>
                            <td><%= t.getNom() %></td>
                            <td><%= t.getEmail() %></td>
                            <td><%= t.getVehicule() %></td>
                            <td class="action-buttons">
                                <a href="#" class="edit-btn" 
                                   onclick="showEditForm(<%= t.getId() %>, '<%= t.getNom() %>', '<%= t.getEmail() %>', '<%= t.getVehicule() %>')">
                                    Modifier
                                </a>
                                <a href="DeleteTransporteur?id=<%= t.getId() %>" class="delete-btn"
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce transporteur?')">
                                    Supprimer
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                
                <!-- Edit Form (Hidden by default) -->
                <div id="editFormContainer" class="form-container" style="display: none;">
                    <h3>Modifier transporteur</h3>
                    <form action="UpdateTransporteur" method="POST">
                        <input type="hidden" id="editId" name="id">
                        <div class="form-group">
                            <label for="editNom">Nom:</label>
                            <input type="text" id="editNom" name="nom" required>
                        </div>
                        <div class="form-group">
                            <label for="editEmail">Email:</label>
                            <input type="email" id="editEmail" name="email" required>
                        </div>
                        <div class="form-group">
                            <label for="editVehicule">Véhicule:</label>
                            <input type="text" id="editVehicule" name="vehicule" required>
                        </div>
                        <input type="submit" value="Enregistrer">
                        <button type="button" onclick="hideEditForm()" class="cancel">Annuler</button>
                    </form>
                </div>
            </div>
        </div>
        
        <script>
            function showEditForm(id, nom, email, vehicule) {
                document.getElementById('editId').value = id;
                document.getElementById('editNom').value = nom;
                document.getElementById('editEmail').value = email;
                document.getElementById('editVehicule').value = vehicule;
                document.getElementById('editFormContainer').style.display = 'block';
                // Scroll to the form
                document.getElementById('editFormContainer').scrollIntoView({ behavior: 'smooth' });
            }
            
            function hideEditForm() {
                document.getElementById('editFormContainer').style.display = 'none';
            }
        </script>
    </body>
</html>