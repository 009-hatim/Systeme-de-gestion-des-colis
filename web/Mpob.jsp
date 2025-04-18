<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mot de passe oublié</title>
    </head>
    <body>
        <fieldset>
            <legend>Mot de passe oublié</legend>
            <form action="Mdob" method="POST">
                <h3>Entrez votre E-mail pour recevoir un code de réinitialisation</h3>
                <table>
                    <tr>
                        <td>Type d'utilisateur:</td>
                        <td>
                            <select name="userType" required>
                                <option value="admin">Admin</option>
                                <option value="transporteur">Transporteur</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>E-mail:</td>
                        <td><input type="email" name="email" required></td>
                        <td><input type="submit" value="Envoyer"></td>
                    </tr>
                    <% if(request.getParameter("msg") != null) { %>
                    <tr>
                        <td colspan="3"><h4 style="color:red;"><%= request.getParameter("msg") %></h4></td>
                    </tr>
                    <% } %>
                </table>
            </form>
        </fieldset>
        <a href="Authentification.jsp">Retour à l'authentification</a>
    </body>
</html>