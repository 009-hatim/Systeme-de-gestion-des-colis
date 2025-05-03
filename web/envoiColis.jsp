<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.Transporteur"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HTrak - Envoi de Colis</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            * {
                box-sizing: border-box;
                font-family: 'Poppins', sans-serif;
                margin: 0;
                padding: 0;
            }
            
            body {
                background-color: #f9f9f9;
                margin: 0;
                min-height: 100vh;
                display: flex;
            }
            
            /* Sidebar Styles */
            .sidebar {
                width: 250px;
                background-color: #2c3e50;
                color: white;
                height: 100vh;
                position: fixed;
                left: 0;
                top: 0;
                overflow-y: auto;
                transition: all 0.3s ease;
                z-index: 1000;
                box-shadow: 2px 0 10px rgba(0,0,0,0.1);
            }
            
            .sidebar-header {
                padding: 20px;
                text-align: center;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            }
            
            .logo {
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 10px;
            }
            
            .logo-icon {
                font-size: 24px;
                margin-right: 10px;
                color: #3498db;
            }
            
            .logo-text {
                font-size: 20px;
                font-weight: 600;
                letter-spacing: 1px;
            }
            
            .sidebar-menu {
                padding: 20px 0;
            }
            
            .menu-item {
                padding: 12px 20px;
                display: flex;
                align-items: center;
                color: rgba(255, 255, 255, 0.8);
                text-decoration: none;
                transition: all 0.3s ease;
                border-left: 3px solid transparent;
            }
            
            .menu-item:hover, .menu-item.active {
                background-color: rgba(255, 255, 255, 0.1);
                color: white;
                border-left-color: #3498db;
                transform: translateX(5px);
            }
            
            .menu-item i {
                margin-right: 10px;
                width: 20px;
                text-align: center;
            }
            
            .sidebar-footer {
                position: absolute;
                bottom: 0;
                width: 100%;
                padding: 15px;
                border-top: 1px solid rgba(255, 255, 255, 0.1);
            }
            
            .logout-btn {
                width: 100%;
                padding: 10px;
                background-color: #e74c3c;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: all 0.3s ease;
                font-weight: 500;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            
            .logout-btn:hover {
                background-color: #c0392b;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            }
            
            .logout-btn i {
                margin-right: 8px;
            }
            
            /* Main Content Styles */
            .main-content {
                flex: 1;
                margin-left: 250px;
                padding: 20px;
                transition: all 0.3s ease;
            }
            
            .dashboard-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 1px solid #eee;
            }
            
            .dashboard-title {
                font-size: 24px;
                color: #2c3e50;
                display: flex;
                align-items: center;
            }
            
            .dashboard-title i {
                margin-right: 10px;
                color: #3498db;
            }
            
            .user-info {
                display: flex;
                align-items: center;
                background-color: white;
                padding: 8px 15px;
                border-radius: 50px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                transition: all 0.3s ease;
            }
            
            .user-info:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }
            
            .user-avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background-color: #3498db;
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 600;
                margin-right: 10px;
            }
            
            .container {
                max-width: 800px;
                margin: 0 auto;
                padding: 20px;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }
            
            .form-group {
                margin-bottom: 15px;
            }
            
            .form-control {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 14px;
                transition: all 0.3s ease;
            }
            
            .form-control:focus {
                border-color: #3498db;
                box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
                outline: none;
            }
            
            .btn {
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
            }
            
            .btn i {
                margin-right: 8px;
            }
            
            .btn-primary {
                background-color: #3498db;
                color: white;
            }
            
            .btn-primary:hover {
                background-color: #2980b9;
                transform: translateY(-2px);
                box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            }
            
            /* Responsive */
            @media (max-width: 768px) {
                .sidebar {
                    width: 70px;
                }
                
                .sidebar-header, .menu-text {
                    display: none;
                }
                
                .main-content {
                    margin-left: 70px;
                }
            }
        </style>
    </head>
    <body>
        <% 
        if (session == null || session.getAttribute("transporteur") == null) {
            response.sendRedirect("Authentification.jsp?msg=Session expirée ou non autorisée");
            return;
        }
        
        Transporteur transporteur = (Transporteur) session.getAttribute("transporteur");
        String transporteurNom = transporteur.getNom();
        String transporteurInitial = transporteurNom.substring(0, 1).toUpperCase();
        %>
        
        <%@include file="sidebarTransporteur.jsp" %>
        
        <div class="main-content">
            <div class="dashboard-header">
                <h1 class="dashboard-title"><i class="fas fa-box"></i> Envoi de Colis</h1>
                <div class="user-info">
                    <div class="user-avatar"><%= transporteurInitial %></div>
                    <div class="user-name"><%= transporteurNom %></div>
                </div>
            </div>
            
            <div class="container">
                <form action="CreateColis" method="POST">
                    <div class="form-group">
                        <label for="expediteur"><i class="fas fa-user"></i> Expéditeur</label>
                        <input type="text" class="form-control" id="expediteur" name="expediteur" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="destinataire"><i class="fas fa-user-tag"></i> Destinataire</label>
                        <input type="text" class="form-control" id="destinataire" name="destinataire" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="poids"><i class="fas fa-weight-hanging"></i> Poids (kg)</label>
                        <input type="number" step="0.01" class="form-control" id="poids" name="poids" required>
                    </div>
                    
                    <div class="form-group" style="display: flex; justify-content: flex-end;">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Enregistrer le Colis
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>