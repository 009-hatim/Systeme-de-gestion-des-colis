<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nouveau mot de passe</title>
    </head>
    <body>
        <fieldset>
            <legend>Nouveau mot de passe</legend>
            <form action="UpdatePassword" method="POST">
                <input type="hidden" name="userType" value="<%= request.getParameter("userType") %>">
                <table>
                    <tr>
                        <td>Nouveau mot de passe :</td>
                        <td><input type="password" name="password" required></td>
                    </tr>
                    <tr>
                        <td>Confirmer mot de passe :</td>
                        <td><input type="password" name="confirmPassword" required></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Modifier"></td>
                    </tr>
                    <% if(request.getParameter("msg") != null) { %>
                    <tr>
                        <td colspan="2"><h4 style="color:red;"><%= request.getParameter("msg") %></h4></td>
                    </tr>
                    <% } %>
                </table>
            </form>
        </fieldset>
    </body>
</html>