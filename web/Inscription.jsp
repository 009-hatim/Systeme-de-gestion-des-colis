<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Inscription Administrateur</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            
            body {
                background: url('images/ins.png') no-repeat center center fixed;
                background-size: cover; 
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                padding: 20px;
            }
            
            fieldset {
                border: none;
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                padding: 30px;
                width: 100%;
                max-width: 500px;
            }
            
            legend {
                font-size: 24px;
                font-weight: 600;
                color: #333;
                padding: 0 10px;
                margin-bottom: 20px;
                position: relative;
            }
            
            legend::after {
                content: '';
                display: block;
                width: 50px;
                height: 3px;
                background-color: #c92843;
                margin-top: 8px;
            }
            
            table {
                width: 100%;
                border-collapse: collapse;
            }
            
            td {
                padding: 12px 0;
                vertical-align: top;
            }
            
            td:first-child {
                width: 120px;
                font-weight: 500;
                color: #555;
                padding-top: 20px;
            }
            
            input[type="text"], 
            input[type="password"],
            input[type="email"],
            select {
                width: 100%;
                padding: 12px 15px;
                border: 1px solid #ddd;
                border-radius: 6px;
                font-size: 16px;
                transition: border-color 0.3s, box-shadow 0.3s;
            }
            
            input:focus, select:focus {
                border-color: #c93c54;
                box-shadow: 0 0 0 3px rgba(255, 201, 210);
                outline: none;
            }
            
            input[type="submit"] {
                background-color: #c92843;
                color: white;
                border: none;
                border-radius: 6px;
                padding: 12px 25px;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.3s;
                margin-top: 10px;
                width: 100%;
            }
            
            input[type="submit"]:hover {
                background-color: #ff8297;
            }
            
            .form-group {
                margin-bottom: 15px;
            }
            
            .dynamic-field {
                display: none;
            }
            
            @media (max-width: 600px) {
                fieldset {
                    padding: 20px;
                }
                
                td:first-child {
                    display: block;
                    width: 100%;
                    padding-top: 0;
                    padding-bottom: 5px;
                }
                
                td {
                    display: block;
                    padding: 5px 0;
                }
            }
        </style>
    </head>
    <body>
        <fieldset>
            <legend>Inscription Administrateur</legend>
            <form method="POST" action="InscriptionAdmin">
                <table>
                    <tr class="form-group">
                        <td><label for="userType">Type :</label></td>
                        <td>
                            <select id="userType" name="userType" required>
                                <option value="">-- Sélectionnez --</option>
                                <option value="admin">Administrateur</option>
                                <option value="transporteur">Transporteur</option>
                            </select>
                        </td>
                    </tr>
                    
                    <tr class="form-group">
                        <td><label for="nom">Nom :</label></td>
                        <td><input type="text" id="nom" name="nom" required placeholder="Entrez votre nom" /></td>
                    </tr>
                    
                    <tr class="form-group" id="matriculeRow">
                        <td><label for="matricule">Matricule :</label></td>
                        <td><input type="text" id="matricule" name="matricule" placeholder="Matricule admin" /></td>  
                    </tr>
                    
                    <tr class="form-group" id="vehiculeRow">
                        <td><label for="vehicule">Véhicule :</label></td>
                        <td><input type="text" id="vehicule" name="vehicule" placeholder="Type de véhicule" /></td>  
                    </tr>
                    
                    <tr class="form-group">
                        <td><label for="email">Email :</label></td>
                        <td><input type="email" id="email" name="email" required placeholder="Entrez votre email" /></td>  
                    </tr>
                    
                    <tr class="form-group">
                        <td><label for="password">Mot de passe :</label></td>
                        <td><input type="password" id="password" name="password" required placeholder="Entrez votre mot de passe" /></td>  
                    </tr>
                    
                    <tr class="form-group">
                        <td><label for="confirmPassword">Confirmation :</label></td>
                        <td><input type="password" id="confirmPassword" name="confirmPassword" required placeholder="Confirmez le mot de passe" /></td>  
                    </tr>
                    
                    <tr>
                        <td colspan="2"><input type="submit" value="Enregistrer" /></td>
                    </tr>
                </table>
            </form>
        </fieldset>

        <script>
            document.getElementById('userType').addEventListener('change', function() {
                const type = this.value;
                document.getElementById('matriculeRow').style.display = 
                    (type === 'admin') ? 'table-row' : 'none';
                document.getElementById('vehiculeRow').style.display = 
                    (type === 'transporteur') ? 'table-row' : 'none';
                
                // Set required attribute based on visibility
                document.getElementById('matricule').required = (type === 'admin');
                document.getElementById('vehicule').required = (type === 'transporteur');
            });
        </script>
    </body>
</html>