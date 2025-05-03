<%@page import="entities.Transporteur"%>
<div class="sidebar">
    <div class="sidebar-header">
        <div class="logo">
            <i class="fas fa-truck logo-icon"></i>
            <span class="logo-text">HTrak Logistics</span>
        </div>
        <div>Transporteur Panel</div>
    </div>
    
    <div class="sidebar-menu">
        <a href="transporteurDashboard.jsp" class="menu-item">
            <i class="fas fa-tachometer-alt"></i> <span class="menu-text">Tableau de bord</span>
        </a>
        <a href="gestionColis.jsp" class="menu-item">
            <i class="fas fa-boxes"></i> <span class="menu-text">Gestion des Colis</span>
        </a>
        <a href="suiviColis.jsp" class="menu-item">
            <i class="fas fa-search-location"></i> <span class="menu-text">Suivi Colis</span>
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