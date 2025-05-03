<%@page import="entities.Admin"%>
<div class="sidebar">
    <div class="sidebar-header">
        <div class="logo">
            <i class="fas fa-box logo-icon"></i>
            <span class="logo-text">HTrak Logistics</span>
        </div>
        <div>Admin Panel</div>
    </div>
    
    <div class="sidebar-menu">
        <a href="adminDashboard.jsp" class="menu-item">
            <i class="fas fa-tachometer-alt"></i> <span class="menu-text">Tableau de bord</span>
        </a>
        <a href="adminDashboard.jsp?tab=transporteurs" class="menu-item">
            <i class="fas fa-truck"></i> <span class="menu-text">Transporteurs</span>
        </a>
        <a href="suiviColisAdmin.jsp" class="menu-item active">
            <i class="fas fa-search-location"></i> <span class="menu-text">Suivi Colis</span>
        </a>
        <a href="adminDashboard.jsp?tab=parametres" class="menu-item">
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