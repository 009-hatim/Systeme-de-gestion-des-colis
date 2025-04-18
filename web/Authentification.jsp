<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Authentification</title>
        <style>
            * {
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            
            body {
                background-color: #f5f5f5;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                margin: 0;
                padding: 20px;
            }
            
            fieldset {
                border: 2px solid #4CAF50;
                border-radius: 10px;
                padding: 30px;
                background: white;
                width: 100%;
                max-width: 800px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }
            
            legend {
                font-size: 24px;
                font-weight: bold;
                color: #4CAF50;
                padding: 0 15px;
            }
            
            table {
                width: 100%;
                border-collapse: collapse;
            }
            
            td {
                padding: 12px;
                vertical-align: middle;
            }
            
            input[type="email"],
            input[type="password"],
            select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 16px;
                transition: border 0.3s;
            }
            
            input[type="email"]:focus,
            input[type="password"]:focus,
            select:focus {
                border-color: #4CAF50;
                outline: none;
                box-shadow: 0 0 5px rgba(76, 175, 80, 0.5);
            }
            
            input[type="submit"] {
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 12px 20px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s;
                width: 100%;
            }
            
            input[type="submit"]:hover {
                background-color: #45a049;
            }
            
            a {
                color: #4CAF50;
                text-decoration: none;
                transition: color 0.3s;
            }
            
            a:hover {
                color: #45a049;
                text-decoration: underline;
            }
            
            .error-message {
                color: #f44336;
                text-align: center;
                padding: 10px;
                margin-top: 10px;
                background-color: #ffebee;
                border-radius: 5px;
                border: 1px solid #ef9a9a;
            }
            
            @media (max-width: 768px) {
                td {
                    display: block;
                    width: 100%;
                    padding: 8px 0;
                }
                
                input[type="submit"] {
                    margin-top: 10px;
                }
            }
        </style>
    </head>
    <body>
        <fieldset>
            <legend>Authentification</legend>
            <form action="Authentification" method="post">
                <table>
                    <tr>
                        <td>Email :</td>
                        <td colspan="3">
                            <input type="email" name="email" required 
                                   value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>"
                                   placeholder="Entrez votre email">
                        </td>
                    </tr>
                    <tr>
                        <td>Mot de passe :</td>
                        <td colspan="3">
                            <input type="password" name="password" required 
                                   placeholder="Entrez votre mot de passe">
                        </td>
                    </tr>
                    <tr>
                        <td>Type :</td>
                        <td colspan="3">
                            <select name="userType" required>
                                <option value="" disabled selected>Sélectionnez un type</option>
                                <option value="admin">Admin</option>
                                <option value="transporteur">Transporteur</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <input type="submit" value="Connexion">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="text-align: center;">
                            <a href="Mpob.jsp">Mot de passe oublié ?</a>
                        </td>
                    </tr>
                    <% if(request.getParameter("msg") != null) { %>
                    <tr>
                        <td colspan="4" class="error-message">
                            <%= request.getParameter("msg") %>
                        </td>
                    </tr>
                    <% } %>
                </table>
            </form>
        </fieldset>
    </body>
</html>