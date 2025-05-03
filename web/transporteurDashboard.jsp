<%@page import="entities.Transporteur"%>
<%@page import="dao.ColisDao"%>
<%@page import="java.util.List"%>
<%@page import="entities.Colis"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session == null || session.getAttribute("transporteur") == null) {
        response.sendRedirect("Authentification.jsp?msg=Session expirée ou non autorisée");
        return;
    }

    Transporteur transporteur = (Transporteur) session.getAttribute("transporteur");
    String transporteurNom = transporteur.getNom();
    String transporteurInitial = transporteurNom.substring(0, 1).toUpperCase();
    
    ColisDao colisDao = new ColisDao();
    // Get counts for each status
    int enAttente = colisDao.countByStatus("En attente");
    int livres = colisDao.countByStatus("Livré");
    int enCours = colisDao.countByStatus("En cours");
    int aujourdhui = colisDao.countDeliveredToday();
    // Optional: Get transporter-specific counts
    int mesColis = colisDao.countByTransporteur(transporteur.getId());
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Tableau de bord - Transporteur</title>
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
                background-color: #f5f7fa;
                margin: 0;
                min-height: 100vh;
                display: flex;
            }

            /* Simplified Sidebar Styles (matches suiviColis.jsp) */
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

            /* Rest of your dashboard styling */
            .dashboard-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
                padding-bottom: 15px;
                border-bottom: 1px solid #e0e6ed;
            }

            .dashboard-title {
                font-size: 26px;
                color: #2c3e50;
                display: flex;
                align-items: center;
                font-weight: 600;
            }

            .dashboard-title i {
                margin-right: 12px;
                color: #3498db;
                font-size: 28px;
            }

            .user-info {
                display: flex;
                align-items: center;
                background-color: white;
                padding: 10px 18px;
                border-radius: 50px;
                box-shadow: 0 3px 10px rgba(0,0,0,0.08);
                transition: all 0.3s ease;
            }

            .user-info:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

            .user-avatar {
                width: 44px;
                height: 44px;
                border-radius: 50%;
                background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 600;
                margin-right: 12px;
                font-size: 18px;
            }

            .welcome-section {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 25px;
                margin-bottom: 30px;
            }

            .welcome-card {
                background: white;
                border-radius: 12px;
                padding: 30px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                transition: all 0.3s ease;
            }

            .welcome-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            }

            .welcome-card h2 {
                color: #2c3e50;
                margin-bottom: 20px;
                font-size: 22px;
                font-weight: 600;
                display: flex;
                align-items: center;
            }

            .welcome-card h2 i {
                margin-right: 12px;
                color: #3498db;
            }

            .info-item {
                display: flex;
                align-items: center;
                margin-bottom: 15px;
                padding-bottom: 15px;
                border-bottom: 1px dashed #e0e6ed;
            }

            .info-item:last-child {
                margin-bottom: 0;
                padding-bottom: 0;
                border-bottom: none;
            }

            .info-item i {
                width: 36px;
                height: 36px;
                background-color: #f5f7fa;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 15px;
                color: #3498db;
                font-size: 16px;
            }

            .info-content {
                flex: 1;
            }

            .info-label {
                font-size: 14px;
                color: #7f8c8d;
                margin-bottom: 3px;
            }

            .info-value {
                font-size: 16px;
                color: #2c3e50;
                font-weight: 500;
            }

            .quick-stats {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .stat-card {
                background: white;
                border-radius: 12px;
                padding: 25px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                transition: all 0.3s ease;
                text-align: center;
            }

            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            }

            .stat-icon {
                width: 60px;
                height: 60px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 15px;
                font-size: 24px;
                color: white;
            }

            .stat-value {
                font-size: 28px;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 5px;
            }

            .stat-label {
                font-size: 14px;
                color: #7f8c8d;
            }

            /* Responsive */
            @media (max-width: 992px) {
                .welcome-section {
                    grid-template-columns: 1fr;
                }
            }

            @media (max-width: 768px) {
                .sidebar {
                    width: 70px;
                }

                .sidebar-header, .menu-text {
                    display: none;
                }

                .main-content {
                    margin-left: 70px;
                    padding: 20px;
                }

                .dashboard-header {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .user-info {
                    margin-top: 15px;
                }

                .quick-stats {
                    grid-template-columns: 1fr 1fr;
                }
            }

            @media (max-width: 576px) {
                .quick-stats {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>
    <body>
      

        <%@include file="sidebarTransporteur.jsp" %>

        <div class="main-content">
            <div class="dashboard-header">
                <h1 class="dashboard-title"><i class="fas fa-tachometer-alt"></i> Tableau de bord</h1>
                <div class="user-info">
                    <div class="user-avatar"><%= transporteurInitial%></div>
                    <div class="user-name"><%= transporteurNom%></div>
                </div>
            </div>

            <div class="welcome-section">
                <div class="welcome-card">
                    <h2><i class="fas fa-user-circle"></i> Profil Transporteur</h2>

                    <div class="info-item">
                        <i class="fas fa-id-card"></i>
                        <div class="info-content">
                            <div class="info-label">Nom complet</div>
                            <div class="info-value"><%= transporteur.getNom()%></div>
                        </div>
                    </div>

                    <div class="info-item">
                        <i class="fas fa-envelope"></i>
                        <div class="info-content">
                            <div class="info-label">Email</div>
                            <div class="info-value"><%= transporteur.getEmail()%></div>
                        </div>
                    </div>

                    <div class="info-item">
                        <i class="fas fa-truck"></i>
                        <div class="info-content">
                            <div class="info-label">Véhicule</div>
                            <div class="info-value"><%= transporteur.getVehicule()%></div>
                        </div>
                    </div>
                </div>

                <div class="welcome-card">
                    <h2><i class="fas fa-info-circle"></i> Instructions</h2>

                    <div class="info-item">
                        <i class="fas fa-box-open"></i>
                        <div class="info-content">
                            <div class="info-label">Gestion des colis</div>
                            <div class="info-value">Utilisez le menu pour gérer vos colis</div>
                        </div>
                    </div>

                    <div class="info-item">
                        <i class="fas fa-search-location"></i>
                        <div class="info-content">
                            <div class="info-label">Suivi en temps réel</div>
                            <div class="info-value">Mettez à jour les statuts des colis</div>
                        </div>
                    </div>

                    <div class="info-item">
                        <i class="fas fa-question-circle"></i>
                        <div class="info-content">
                            <div class="info-label">Besoin d'aide?</div>
                            <div class="info-value">Contactez le support technique</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="quick-stats">
                <div class="stat-card">
                    <div class="stat-icon" style="background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="stat-value"><%= enAttente%></div>
                    <div class="stat-label">Colis en attente</div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon" style="background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="stat-value"><%= livres%></div>
                    <div class="stat-label">Colis livrés</div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon" style="background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);">
                        <i class="fas fa-shipping-fast"></i>
                    </div>
                    <div class="stat-value"><%= enCours%></div>
                    <div class="stat-label">En cours de livraison</div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon" style="background: linear-gradient(135deg, #9b59b6 0%, #8e44ad 100%);">
                        <i class="fas fa-calendar-alt"></i>
                    </div>
                    <div class="stat-value"><%= aujourdhui%></div>
                    <div class="stat-label">Livraisons aujourd'hui</div>
                </div>
            </div>
        </div>
    </body>
</html>