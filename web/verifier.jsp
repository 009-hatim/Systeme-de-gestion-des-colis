<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Vérification</title>
    </head>
    <body>
        <fieldset>
            <legend>Vérification</legend>
            <form action="Verifier" method="POST">
                <input type="hidden" name="userType" value="<%= request.getParameter("userType") %>">
                <table>
                    <tr>
                        <td><h3>Saisissez le code reçu par email :</h3></td>
                    </tr>
                    <tr>
                        <td>Code de validation :</td>
                        <td><input type="text" name="code" required></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Valider"></td>
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