<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HTrak Logistics - Inscription</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <style>
            * {
                box-sizing: border-box;
                font-family: 'Poppins', sans-serif;
                margin: 0;
                padding: 0;
            }
            
            body {
                background-color: #f9f9f9;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                margin: 0;
                padding: 20px;
                background-image: linear-gradient(135deg, #f5f7fa 0%, #e4e8eb 100%);
            }
            
            .auth-container {
                width: 100%;
                max-width: 500px;
                background: white;
                border-radius: 12px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                transition: all 0.3s ease;
            }
            
            .auth-header {
                background-color: #2c3e50;
                color: white;
                padding: 25px;
                text-align: center;
                position: relative;
            }
            
            .logo {
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 15px;
            }
            
            .logo-icon {
                font-size: 28px;
                margin-right: 10px;
                color: #3498db;
            }
            
            .logo-text {
                font-size: 24px;
                font-weight: 600;
                letter-spacing: 1px;
            }
            
            .auth-header h2 {
                font-size: 18px;
                font-weight: 400;
                margin-top: 5px;
                opacity: 0.9;
            }
            
            .auth-body {
                padding: 30px;
            }
            
            .form-group {
                margin-bottom: 20px;
                position: relative;
            }
            
            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: #2c3e50;
                font-size: 14px;
            }
            
            .form-control {
                width: 100%;
                padding: 12px 15px;
                border: 1px solid #ddd;
                border-radius: 6px;
                font-size: 14px;
                transition: all 0.3s;
                background-color: #f9f9f9;
            }
            
            .form-control:focus {
                border-color: #3498db;
                outline: none;
                box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
                background-color: white;
            }
            
            .btn {
                width: 100%;
                padding: 12px;
                border: none;
                border-radius: 6px;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            
            .btn-primary {
                background-color: #2c3e50;
                color: white;
            }
            
            .btn-primary:hover {
                background-color: #1a252f;
                transform: translateY(-2px);
            }
            
            .auth-footer {
                text-align: center;
                padding: 20px;
                border-top: 1px solid #eee;
                font-size: 14px;
            }
            
            .auth-footer a {
                color: #3498db;
                text-decoration: none;
                transition: all 0.3s;
            }
            
            .auth-footer a:hover {
                color: #2c3e50;
                text-decoration: underline;
            }
            
            .links {
                display: flex;
                justify-content: space-between;
                margin-top: 15px;
            }
            
            .error-message {
                color: #e74c3c;
                background-color: #fde8e8;
                padding: 12px;
                border-radius: 6px;
                margin-bottom: 20px;
                font-size: 14px;
                text-align: center;
                border: 1px solid #f5c6cb;
            }
            
            .select-wrapper {
                position: relative;
            }
            
            .select-wrapper::after {
                content: "▼";
                font-size: 12px;
                color: #2c3e50;
                position: absolute;
                right: 15px;
                top: 50%;
                transform: translateY(-50%);
                pointer-events: none;
            }
            
            select {
                appearance: none;
                -webkit-appearance: none;
                -moz-appearance: none;
                cursor: pointer;
            }
            
            .hidden {
                display: none;
            }
            
            @media (max-width: 480px) {
                .auth-container {
                    max-width: 100%;
                    border-radius: 0;
                }
                
                body {
                    padding: 0;
                }
                
                .links {
                    flex-direction: column;
                    gap: 10px;
                }
            }
        </style>
    </head>
    <body>
        <div class="auth-container">
            <div class="auth-header">
                <div class="logo">
                    <span class="logo-icon">📦</span>
                    <span class="logo-text">HTrak Logistics</span>
                </div>
                <h2>Inscription Administrateur</h2>
            </div>
            
            <div class="auth-body">
                <% if(request.getParameter("msg") != null) { %>
                <div class="error-message">
                    <%= request.getParameter("msg") %>
                </div>
                <% } %>
                
                <form method="POST" action="InscriptionAdmin">
                    <div class="form-group">
                        <label for="userType">Type d'utilisateur</label>
                        <div class="select-wrapper">
                            <select class="form-control" id="userType" name="userType" required>
                                <option value="">-- Sélectionnez --</option>
                                <option value="admin">Administrateur</option>
                                <option value="transporteur">Transporteur</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="nom">Nom</label>
                        <input type="text" class="form-control" id="nom" name="nom" required placeholder="Entrez votre nom">
                    </div>
                    
                    <div class="form-group hidden" id="matriculeGroup">
                        <label for="matricule">Matricule</label>
                        <input type="text" class="form-control" id="matricule" name="matricule" placeholder="Matricule admin">
                    </div>
                    
                    <div class="form-group hidden" id="vehiculeGroup">
                        <label for="vehicule">Véhicule</label>
                        <input type="text" class="form-control" id="vehicule" name="vehicule" placeholder="Type de véhicule">
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" class="form-control" id="email" name="email" required placeholder="Entrez votre email">
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Mot de passe</label>
                        <input type="password" class="form-control" id="password" name="password" required placeholder="Entrez votre mot de passe">
                    </div>
                    
                    <div class="form-group">
                        <label for="confirmPassword">Confirmation mot de passe</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required placeholder="Confirmez le mot de passe">
                    </div>
                    
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">
                            <span>Enregistrer</span>
                        </button>
                    </div>
                    
                    <div class="links">
                        <a href="Authentification.jsp">Déjà un compte? Se connecter</a>
                    </div>
                </form>
            </div>
            
            <div class="auth-footer">
                © 2025 HTrak Logistics. Tous droits réservés.
            </div>
        </div>

        <script>
            document.getElementById('userType').addEventListener('change', function() {
                const type = this.value;
                document.getElementById('matriculeGroup').classList.toggle('hidden', type !== 'admin');
                document.getElementById('vehiculeGroup').classList.toggle('hidden', type !== 'transporteur');
                
                // Set required attribute based on visibility
                document.getElementById('matricule').required = (type === 'admin');
                document.getElementById('vehicule').required = (type === 'transporteur');
            });
        </script>
    </body>
</html>