<%@page import="java.util.List"%>
<%@page import="entities.Transporteur"%>
<%@page import="service.ServiceTransporteur"%>
<%@page import="dao.ColisDao"%>
<%@page import="entities.Admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HTrak Logistics - Tableau de bord Admin</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

            .stats-container {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .stat-card {
                background-color: white;
                border-radius: 8px;
                padding: 20px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                display: flex;
                flex-direction: column;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
                border-bottom: 3px solid transparent;
            }

            .stat-card:nth-child(1) {
                border-bottom-color: #3498db;
            }

            .stat-card:nth-child(2) {
                border-bottom-color: #e74c3c;
            }

            .stat-card:nth-child(3) {
                border-bottom-color: #f39c12;
            }

            .stat-card:nth-child(4) {
                border-bottom-color: #2ecc71;
            }

            .stat-card:hover {
                transform: translateY(-10px) scale(1.02);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
            }

            .stat-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: linear-gradient(135deg, rgba(255,255,255,0.3) 0%, rgba(255,255,255,0) 50%);
                pointer-events: none;
            }

            .stat-card-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 15px;
            }

            .stat-card-icon {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 20px;
                color: white;
            }

            .stat-card:nth-child(1) .stat-card-icon {
                background-color: #3498db;
            }

            .stat-card:nth-child(2) .stat-card-icon {
                background-color: #e74c3c;
            }

            .stat-card:nth-child(3) .stat-card-icon {
                background-color: #f39c12;
            }

            .stat-card:nth-child(4) .stat-card-icon {
                background-color: #2ecc71;
            }

            .stat-card-title {
                color: #7f8c8d;
                font-size: 14px;
                margin-bottom: 5px;
            }

            .stat-card-value {
                font-size: 28px;
                font-weight: 600;
                color: #2c3e50;
            }

            .stat-card-footer {
                margin-top: 10px;
                font-size: 12px;
                color: #7f8c8d;
            }

            .stat-card-footer.positive {
                color: #2ecc71;
            }

            .stat-card-footer.negative {
                color: #e74c3c;
            }

            .chart-container {
                background-color: white;
                border-radius: 8px;
                padding: 20px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                margin-bottom: 30px;
                height: 400px; /* Fixed height */
                width: 100%; /* Full width */
                position: relative; /* Needed for chart.js responsive behavior */
                transition: all 0.3s ease;
            }

            .chart-container:hover {
                box-shadow: 0 8px 15px rgba(0, 0, 0, 0.15);
                transform: translateY(-5px);
            }

            .transporteurs-container {
                background-color: white;
                border-radius: 8px;
                padding: 20px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
            }

            .transporteurs-container:hover {
                box-shadow: 0 8px 15px rgba(0, 0, 0, 0.15);
            }

            .transporteurs-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .transporteurs-header h2 {
                display: flex;
                align-items: center;
            }

            .transporteurs-header h2 i {
                margin-right: 10px;
                color: #3498db;
            }

            .add-btn {
                background-color: #2ecc71;
                color: white;
                border: none;
                border-radius: 4px;
                padding: 8px 15px;
                cursor: pointer;
                transition: all 0.3s ease;
                font-weight: 500;
                display: flex;
                align-items: center;
            }

            .add-btn:hover {
                background-color: #27ae60;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            }

            .add-btn i {
                margin-right: 8px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            th, td {
                padding: 12px 15px;
                text-align: left;
                border-bottom: 1px solid #eee;
            }

            th {
                background-color: #f5f5f5;
                color: #2c3e50;
                font-weight: 500;
            }

            tr {
                transition: all 0.3s ease;
            }

            tr:hover {
                background-color: #f9f9f9;
                transform: scale(1.01);
            }

            .action-btn {
                padding: 6px 12px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                margin-right: 5px;
                font-size: 13px;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
            }

            .action-btn i {
                margin-right: 5px;
            }

            .edit-btn {
                background-color: #3498db;
                color: white;
            }

            .edit-btn:hover {
                background-color: #2980b9;
                transform: translateY(-2px);
                box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            }

            .delete-btn {
                background-color: #e74c3c;
                color: white;
            }

            .delete-btn:hover {
                background-color: #c0392b;
                transform: translateY(-2px);
                box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            }

            /* Modal Styles */
            .modal {
                display: none;
                position: fixed;
                z-index: 1050;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.5);
                animation: fadeIn 0.3s ease;
            }

            @keyframes fadeIn {
                from { opacity: 0; }
                to { opacity: 1; }
            }

            .modal-content {
                background-color: white;
                margin: 10% auto;
                padding: 20px;
                border-radius: 8px;
                width: 50%;
                max-width: 500px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
                position: relative;
                animation: slideIn 0.3s ease;
            }

            @keyframes slideIn {
                from { transform: translateY(-50px); opacity: 0; }
                to { transform: translateY(0); opacity: 1; }
            }

            .close-modal {
                position: absolute;
                right: 20px;
                top: 15px;
                font-size: 24px;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .close-modal:hover {
                color: #e74c3c;
                transform: rotate(90deg);
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: 500;
                color: #2c3e50;
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

            .form-actions {
                display: flex;
                justify-content: flex-end;
                margin-top: 20px;
            }

            .form-actions button {
                margin-left: 10px;
                display: flex;
                align-items: center;
            }

            .form-actions button i {
                margin-right: 5px;
            }

            .cancel-btn {
                background-color: #95a5a6;
                color: white;
                border: none;
                border-radius: 4px;
                padding: 8px 15px;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .cancel-btn:hover {
                background-color: #7f8c8d;
                transform: translateY(-2px);
            }

            .save-btn {
                background-color: #2ecc71;
                color: white;
                border: none;
                border-radius: 4px;
                padding: 8px 15px;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .save-btn:hover {
                background-color: #27ae60;
                transform: translateY(-2px);
            }

            /* Alert Messages */
            .alert {
                padding: 15px;
                margin-bottom: 20px;
                border-radius: 4px;
                display: flex;
                align-items: center;
                animation: slideDown 0.5s ease;
            }

            @keyframes slideDown {
                from { transform: translateY(-20px); opacity: 0; }
                to { transform: translateY(0); opacity: 1; }
            }

            .alert i {
                margin-right: 10px;
                font-size: 18px;
            }

            .alert-success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .alert-error {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

            /* Tabs for content switching */
            .content-tabs {
                display: none;
                animation: fadeIn 0.5s ease;
            }

            .content-tabs.active {
                display: block;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .sidebar {
                    width: 70px;
                    transform: translateX(0);
                }

                .sidebar.expanded {
                    width: 250px;
                }

                .sidebar-header, .menu-text, .user-name {
                    display: none;
                }

                .sidebar.expanded .sidebar-header, 
                .sidebar.expanded .menu-text, 
                .sidebar.expanded .user-name {
                    display: block;
                }

                .main-content {
                    margin-left: 70px;
                }

                .sidebar.expanded + .main-content {
                    margin-left: 250px;
                }

                .modal-content {
                    width: 90%;
                }

                .stats-container {
                    grid-template-columns: 1fr;
                }
            }

            /* Pulse animation for icons */
            @keyframes pulse {
                0% { transform: scale(1); }
                50% { transform: scale(1.1); }
                100% { transform: scale(1); }
            }

            .pulse {
                animation: pulse 2s infinite;
            }
            #statusBarChart {
                width: 100% !important;
                height: 100% !important;
            }
        </style>
    </head>
    <body>
        <%
            if (session == null || session.getAttribute("admin") == null) {
                response.sendRedirect("Authentification.jsp?msg=Session expirée ou non autorisée");
                return;
            }

            // Get admin from session
            Admin admin = (Admin) session.getAttribute("admin");
            String adminNom = admin.getNom();
            String adminEmail = admin.getEmail();
            String adminInitial = adminNom.substring(0, 1).toUpperCase();

            // Get data for stats
            ServiceTransporteur st = new ServiceTransporteur();
            List<Transporteur> transporteurs = st.findAll();
            int transporteurCount = transporteurs.size();

            // Get colis data
            ColisDao colisDao = new ColisDao();
            int enAttente = colisDao.findByStatut("En attente").size();
            int enCours = colisDao.findByStatut("En cours").size();  // Changed from "En transit" to "En cours"
            int livre = colisDao.findByStatut("Livré").size();
            int totalColis = enAttente + enCours + livre;
        %>

        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <div class="logo">
                    <i class="fas fa-box logo-icon"></i>
                    <span class="logo-text">HTrak Logistics</span>
                </div>
                <div>Admin Panel</div>
            </div>

            <div class="sidebar-menu">
                <a href="#" class="menu-item active" onclick="showTab('dashboard')">
                    <i class="fas fa-tachometer-alt"></i> <span class="menu-text">Tableau de bord</span>
                </a>
                <a href="#" class="menu-item" onclick="showTab('transporteurs')">
                    <i class="fas fa-truck"></i> <span class="menu-text">Transporteurs</span>
                </a>
                <a href="suiviColisAdmin.jsp" class="menu-item" onclick="showTab('suivi-colis')">
                    <i class="fas fa-search-location"></i> <span class="menu-text">Suivi Colis</span>
                </a>
                <a href="#" class="menu-item" onclick="showTab('parametres')">
                    <i class="fas fa-cog"></i> <span class="menu-text">Paramètres</span>
                </a>

            </div>

            <div class="sidebar-footer">
                <form action="Deconnexion" method="POST">
                    <button type="submit" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i> Déconnexion
                    </button>
                </form>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Success/Error Messages -->
            <% if (request.getParameter("success") != null) {%>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> <%= request.getParameter("success")%>
            </div>
            <% } %>
            <% if (request.getParameter("error") != null) {%>
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i> <%= request.getParameter("error")%>
            </div>
            <% }%>

            <div class="dashboard-header">
                <h1 class="dashboard-title"><i class="fas fa-tachometer-alt"></i> Tableau de bord Administrateur</h1>
                <div class="user-info">
                    <div class="user-avatar"><%= adminInitial%></div>
                    <div class="user-name"><%= adminNom%></div>
                </div>
            </div>

            <!-- Dashboard Tab -->
            <div id="dashboard-tab" class="content-tabs active">
                <!-- Stats Cards -->
                <div class="stats-container">
                    <div class="stat-card">
                        <div class="stat-card-header">
                            <div>
                                <div class="stat-card-title">Transporteurs</div>
                                <div class="stat-card-value"><%= transporteurCount%></div>
                            </div>
                            <div class="stat-card-icon">
                                <i class="fas fa-truck"></i>
                            </div>
                        </div>

                    </div>
                    <div class="stat-card">
                        <div class="stat-card-header">
                            <div>
                                <div class="stat-card-title">Colis en attente</div>
                                <div class="stat-card-value"><%= enAttente%></div>
                            </div>
                            <div class="stat-card-icon">
                                <i class="fas fa-clock"></i>
                            </div>
                        </div>

                    </div>
                    <div class="stat-card">
                        <div class="stat-card-header">
                            <div>
                                <div class="stat-card-title">Colis en cours</div>  <!-- Changed from "en transit" to "en cours" -->
                                <div class="stat-card-value"><%= enCours%></div>  <!-- Updated variable name -->
                            </div>
                            <div class="stat-card-icon">
                                <i class="fas fa-shipping-fast"></i>
                            </div>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-card-header">
                            <div>
                                <div class="stat-card-title">Colis livrés</div>
                                <div class="stat-card-value"><%= livre%></div>
                            </div>
                            <div class="stat-card-icon">
                                <i class="fas fa-check-circle"></i>
                            </div>
                        </div>

                    </div>
                </div>

                <!-- Chart -->
                <div class="chart-container">
                    <canvas id="statusBarChart"></canvas>
                </div>

                <!-- Transporteurs List Preview -->
                <div class="transporteurs-container">
                    <div class="transporteurs-header">
                        <h2><i class="fas fa-users"></i> Transporteurs récents</h2>
                        <button class="add-btn" onclick="showTab('transporteurs')">
                            <i class="fas fa-eye"></i> Voir tous
                        </button>
                    </div>

                    <table>
                        <thead>
                            <tr>
                                <th><i class="fas fa-id-card"></i> ID</th>
                                <th><i class="fas fa-user"></i> Nom</th>
                                <th><i class="fas fa-envelope"></i> Email</th>
                                <th><i class="fas fa-truck"></i> Véhicule</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                // Show only first 5 transporteurs in dashboard
                                int limit = Math.min(transporteurs.size(), 5);
                                for (int i = 0; i < limit; i++) {
                                    Transporteur t = transporteurs.get(i);
                            %>
                            <tr>
                                <td><%= t.getId()%></td>
                                <td><%= t.getNom()%></td>
                                <td><%= t.getEmail()%></td>
                                <td><%= t.getVehicule()%></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Transporteurs Tab -->
            <div id="transporteurs-tab" class="content-tabs">
                <div class="transporteurs-container">
                    <div class="transporteurs-header">
                        <h2><i class="fas fa-truck"></i> Gestion des Transporteurs</h2>
                        <button class="add-btn" onclick="showAddModal()">
                            <i class="fas fa-plus"></i> Ajouter un transporteur
                        </button>
                    </div>

                    <table>
                        <thead>
                            <tr>
                                <th><i class="fas fa-id-card"></i> ID</th>
                                <th><i class="fas fa-user"></i> Nom</th>
                                <th><i class="fas fa-envelope"></i> Email</th>
                                <th><i class="fas fa-truck"></i> Véhicule</th>
                                <th><i class="fas fa-cogs"></i> Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Transporteur t : transporteurs) {%>
                            <tr>
                                <td><%= t.getId()%></td>
                                <td><%= t.getNom()%></td>
                                <td><%= t.getEmail()%></td>
                                <td><%= t.getVehicule()%></td>
                                <td>
                                    <button class="action-btn edit-btn" 
                                            onclick="showEditModal(<%= t.getId()%>, '<%= t.getNom()%>', '<%= t.getEmail()%>', '<%= t.getVehicule()%>')">
                                        <i class="fas fa-edit"></i> Modifier
                                    </button>
                                    <button class="action-btn delete-btn" 
                                            onclick="confirmDelete(<%= t.getId()%>)">
                                        <i class="fas fa-trash"></i> Supprimer
                                    </button>
                                </td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Parametres Tab -->
            <div id="parametres-tab" class="content-tabs">
                <div class="transporteurs-container">
                    <h2><i class="fas fa-user-cog"></i> Paramètres du compte</h2>
                    <form action="UpdateAdmin" method="POST" class="mt-4">
                        <div class="form-group">
                            <label for="adminName"><i class="fas fa-user"></i> Nom d'utilisateur</label>
                            <input type="text" id="adminName" name="adminName" class="form-control" value="<%= adminNom%>" required>
                        </div>
                        <div class="form-group">
                            <label for="adminEmail"><i class="fas fa-envelope"></i> Email</label>
                            <input type="email" id="adminEmail" name="adminEmail" class="form-control" value="<%= adminEmail%>" required>
                        </div>
                        <div class="form-group">
                            <label for="currentPassword"><i class="fas fa-lock"></i> Mot de passe actuel</label>
                            <input type="password" id="currentPassword" name="currentPassword" class="form-control">
                        </div>
                        <div class="form-group">
                            <label for="newPassword"><i class="fas fa-key"></i> Nouveau mot de passe</label>
                            <input type="password" id="newPassword" name="newPassword" class="form-control">
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword"><i class="fas fa-check-circle"></i> Confirmer le mot de passe</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control">
                        </div>
                        <div class="form-actions">
                            <button type="submit" class="save-btn">
                                <i class="fas fa-save"></i> Enregistrer les modifications
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Add Transporteur Modal -->
            <div id="addModal" class="modal">
                <div class="modal-content">
                    <span class="close-modal" onclick="closeModal('addModal')">&times;</span>
                    <h2><i class="fas fa-plus-circle"></i> Ajouter un transporteur</h2>
                    <form action="CreateTransporteur" method="POST">
                        <div class="form-group">
                            <label for="nom"><i class="fas fa-user"></i> Nom</label>
                            <input type="text" id="nom" name="nom" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="email"><i class="fas fa-envelope"></i> Email</label>
                            <input type="email" id="email" name="email" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="password"><i class="fas fa-lock"></i> Mot de passe</label>
                            <input type="password" id="password" name="password" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="vehicule"><i class="fas fa-truck"></i> Véhicule</label>
                            <input type="text" id="vehicule" name="vehicule" class="form-control" required>
                        </div>
                        <div class="form-actions">
                            <button type="button" class="cancel-btn" onclick="closeModal('addModal')">
                                <i class="fas fa-times"></i> Annuler
                            </button>
                            <button type="submit" class="save-btn">
                                <i class="fas fa-plus"></i> Ajouter
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Edit Transporteur Modal -->
            <div id="editModal" class="modal">
                <div class="modal-content">
                    <span class="close-modal" onclick="closeModal('editModal')">&times;</span>
                    <h2><i class="fas fa-edit"></i> Modifier le transporteur</h2>
                    <form action="UpdateTransporteur" method="POST">
                        <input type="hidden" id="editId" name="id">
                        <div class="form-group">
                            <label for="editNom"><i class="fas fa-user"></i> Nom</label>
                            <input type="text" id="editNom" name="nom" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="editEmail"><i class="fas fa-envelope"></i> Email</label>
                            <input type="email" id="editEmail" name="email" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="editVehicule"><i class="fas fa-truck"></i> Véhicule</label>
                            <input type="text" id="editVehicule" name="vehicule" class="form-control" required>
                        </div>
                        <div class="form-actions">
                            <button type="button" class="cancel-btn" onclick="closeModal('editModal')">
                                <i class="fas fa-times"></i> Annuler
                            </button>
                            <button type="submit" class="save-btn">
                                <i class="fas fa-save"></i> Enregistrer
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Delete Confirmation Modal -->
            <div id="deleteModal" class="modal">
                <div class="modal-content">
                    <span class="close-modal" onclick="closeModal('deleteModal')">&times;</span>
                    <h2><i class="fas fa-exclamation-triangle"></i> Confirmer la suppression</h2>
                    <p>Êtes-vous sûr de vouloir supprimer ce transporteur ?</p>
                    <form action="DeleteTransporteur" method="GET">
                        <input type="hidden" id="deleteId" name="id">
                        <div class="form-actions">
                            <button type="button" class="cancel-btn" onclick="closeModal('deleteModal')">
                                <i class="fas fa-times"></i> Annuler
                            </button>
                            <button type="submit" class="delete-btn">
                                <i class="fas fa-trash"></i> Supprimer
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>



        <script>
    document.addEventListener('DOMContentLoaded', function() {
        const ctx = document.getElementById('statusBarChart').getContext('2d');
        const chart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['En attente', 'En cours', 'Livré'],
                datasets: [{
                    label: 'Nombre de colis',
                    data: [<%= enAttente%>, <%= enCours%>, <%= livre%>],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.7)',
                        'rgba(54, 162, 235, 0.7)',
                        'rgba(75, 192, 192, 0.7)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(75, 192, 192, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'Nombre de colis'
                        }
                    },
                    x: {
                        title: {
                            display: true,
                            text: 'Statut'
                        }
                    }
                },
                plugins: {
                    title: {
                        display: true,
                        text: 'Colis par statut',
                        font: {
                            size: 16
                        }
                    },
                    legend: {
                        display: false
                    }
                },
                animation: {
                    duration: 2000,
                    easing: 'easeOutBounce'
                }
            }
        });
        
        // Resize observer
        const resizeObserver = new ResizeObserver(() => {
            chart.resize();
        });
        resizeObserver.observe(document.querySelector('.chart-container'));
        
        // Animation pulse sur icônes
        const icons = document.querySelectorAll('.stat-card-icon i');
        icons.forEach(icon => {
            icon.classList.add('pulse');
        });
    });

    // Changement d'onglet
    function showTab(tabName) {
        const tabs = document.querySelectorAll('.content-tabs');
        tabs.forEach(tab => {
            tab.classList.remove('active');
        });
        document.getElementById(tabName + '-tab').classList.add('active');
        
        const menuItems = document.querySelectorAll('.menu-item');
        menuItems.forEach(item => {
            item.classList.remove('active');
        });
        
        const activeMenuItem = document.querySelector(`.menu-item[onclick="showTab('${tabName}')"]`);
        if (activeMenuItem) {
            activeMenuItem.classList.add('active');
        }
    }

    // Modals
    function showAddModal() {
        document.getElementById('addModal').style.display = 'block';
    }

    function showEditModal(id, nom, email, vehicule) {
        document.getElementById('editId').value = id;
        document.getElementById('editNom').value = nom;
        document.getElementById('editEmail').value = email;
        document.getElementById('editVehicule').value = vehicule;
        document.getElementById('editModal').style.display = 'block';
    }

    function confirmDelete(id) {
        document.getElementById('deleteId').value = id;
        document.getElementById('deleteModal').style.display = 'block';
    }

    function closeModal(modalId) {
        document.getElementById(modalId).style.display = 'none';
    }

    window.onclick = function(event) {
        const modals = document.querySelectorAll('.modal');
        modals.forEach(modal => {
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        });
    }

    // Mobile: toggle sidebar
    function toggleSidebar() {
        const sidebar = document.querySelector('.sidebar');
        sidebar.classList.toggle('expanded');
    }
</script>

    </body>
</html>