<%@page import="java.util.List"%>
<%@page import="entities.SuiviColis"%>
<%@page import="dao.SuiviColisDao"%>
<%@page import="entities.Colis"%>
<%@page import="dao.ColisDao"%>
<%@page import="entities.Admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Suivi de Colis - Admin</title>
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
            
            /* Timeline Styles */
            .timeline {
                position: relative;
                padding-left: 50px;
                margin: 30px 0;
            }
            
            .timeline::before {
                content: '';
                position: absolute;
                left: 20px;
                top: 0;
                bottom: 0;
                width: 2px;
                background: #3498db;
            }
            
            .timeline-item {
                position: relative;
                margin-bottom: 30px;
            }
            
            .timeline-dot {
                position: absolute;
                left: -38px;
                width: 20px;
                height: 20px;
                border-radius: 50%;
                background: #3498db;
                border: 3px solid white;
            }
            
            .timeline-content {
                padding: 15px;
                background: white;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }
            
            /* Card Styles */
            .card {
                margin-bottom: 20px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
            }
            
            .card:hover {
                box-shadow: 0 8px 15px rgba(0, 0, 0, 0.15);
                transform: translateY(-5px);
            }
            
            .card-header {
                background-color: #2c3e50;
                color: white;
                padding: 15px;
                border-bottom: 1px solid #ddd;
            }
            
            .card-body {
                padding: 20px;
            }
            
            /* Alert Styles */
            .alert {
                padding: 15px;
                margin-bottom: 20px;
                border-radius: 4px;
                display: flex;
                align-items: center;
            }
            
            .alert-success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }
            
            .alert-danger {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
            
            .alert-warning {
                background-color: #fff3cd;
                color: #856404;
                border: 1px solid #ffeeba;
            }
            
            /* Badge Styles */
            .badge {
                padding: 5px 10px;
                border-radius: 3px;
                font-size: 12px;
                color: white;
            }
            
            .bg-primary {
                background-color: #3498db;
            }
            
            .bg-success {
                background-color: #2ecc71;
            }
            
            .bg-danger {
                background-color: #e74c3c;
            }
            
            /* Form Styles */
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
                transition: all 0.3s ease;
            }
            
            .btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }
            
            .btn-primary {
                background-color: #3498db;
                color: white;
                border: none;
                padding: 10px 15px;
                border-radius: 4px;
                cursor: pointer;
            }
            
            /* Responsive Styles */
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
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("Authentification.jsp?msg=Session expirée ou non autorisée");
            return;
        }
        Admin admin = (Admin) session.getAttribute("admin");
        String adminNom = admin.getNom();
        String adminInitial = adminNom.substring(0, 1).toUpperCase();
        %>
        
        <%@include file="sidebarAdmin.jsp" %>

        <div class="main-content">
            <div class="dashboard-header">
                <h1 class="dashboard-title"><i class="fas fa-search-location"></i> Suivi de Colis</h1>
                <div class="user-info">
                    <div class="user-avatar"><%= adminInitial %></div>
                    <div class="user-name"><%= adminNom %></div>
                </div>
            </div>

            <%
                // Display success/error messages
                String success = request.getParameter("success");
                String error = request.getParameter("error");
                if (success != null) {
            %>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> <%= success%>
            </div>
            <% }
                if (error != null) {
            %>
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i> <%= error%>
            </div>
            <% }
            %>

            <div class="card">
                <div class="card-header">
                    <h3><i class="fas fa-search"></i> Rechercher un colis</h3>
                </div>
                <div class="card-body">
                    <form method="GET" action="suiviColisAdmin.jsp">
                        <div class="form-group">
                            <label for="colisId">ID du colis</label>
                            <input type="text" id="colisId" name="colisId" class="form-control" 
                                   value="<%= request.getParameter("colisId") != null ? request.getParameter("colisId") : ""%>"
                                   placeholder="Entrez l'ID du colis">
                        </div>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-search"></i> Rechercher
                        </button>
                    </form>
                </div>
            </div>

            <%
                if (request.getParameter("colisId") != null && !request.getParameter("colisId").isEmpty()) {
                    try {
                        int colisId = Integer.parseInt(request.getParameter("colisId"));
                        ColisDao colisDao = new ColisDao();
                        Colis colis = colisDao.findById(colisId);

                        if (colis != null) {
            %>
            <div class="card">
                <div class="card-header">
                    <h3><i class="fas fa-info-circle"></i> Détails du colis #<%= colisId%></h3>
                </div>
                <div class="card-body">
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                        <div>
                            <p><strong><i class="fas fa-user"></i> Expéditeur:</strong> <%= colis.getExpediteur()%></p>
                            <p><strong><i class="fas fa-user-tag"></i> Destinataire:</strong> <%= colis.getDestinataire()%></p>
                        </div>
                        <div>
                            <p><strong><i class="fas fa-weight-hanging"></i> Poids:</strong> <%= colis.getPoids()%> kg</p>
                            <p><strong><i class="fas fa-info-circle"></i> Statut:</strong> 
                                <span class="badge bg-<%=colis.getStatut().equals("Livré") ? "success"
                                        : colis.getStatut().equals("Retourné") ? "danger"
                                                : "primary"%>">
                                    <%= colis.getStatut()%>
                                </span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <% if (colis.getTransporteur() != null) { %>
            <div class="card">
                <div class="card-header">
                    <h3><i class="fas fa-truck"></i> Transporteur assigné</h3>
                </div>
                <div class="card-body">
                    <p><strong>Nom:</strong> <%= colis.getTransporteur().getNom()%></p>
                    <p><strong>Véhicule:</strong> <%= colis.getTransporteur().getVehicule()%></p>
                </div>
            </div>
            <% } %>

            <%
                SuiviColisDao suivicolisDao = new SuiviColisDao();
                List<SuiviColis> suivis = suivicolisDao.findByColisId(colisId);

                if (suivis != null && !suivis.isEmpty()) {
            %>
            <div class="card">
                <div class="card-header">
                    <h3><i class="fas fa-history"></i> Historique de suivi</h3>
                </div>
                <div class="card-body">
                    <div class="timeline">
                        <% for (SuiviColis suivi : suivis) {%>
                        <div class="timeline-item">
                            <div class="timeline-dot"></div>
                            <div class="timeline-content">
                                <h5><%= suivi.getEtat()%></h5>
                                <p><i class="fas fa-map-marker-alt"></i> <%= suivi.getLieu()%></p>
                                <p><i class="fas fa-calendar-alt"></i> <%= suivi.getDate()%></p>
                                <% if (suivi.getLatitude() != 0 && suivi.getLongitude() != 0) {%>
                                <p><i class="fas fa-globe"></i> <%= suivi.getLatitude()%>, <%= suivi.getLongitude()%></p>
                                <% } %>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
            <%
                } else {
            %>
            <div class="alert alert-warning">
                <i class="fas fa-exclamation-triangle"></i> Aucun suivi trouvé pour ce colis
            </div>
            <%
                }
            } else {
            %>
            <div class="alert alert-danger">
                <i class="fas fa-times-circle"></i> Aucun colis trouvé avec cet ID
            </div>
            <%
                }
            } catch (NumberFormatException e) {
            %>
            <div class="alert alert-danger">
                <i class="fas fa-times-circle"></i> ID de colis invalide
            </div>
            <%
                }
            }
            %>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    </body>
</html>