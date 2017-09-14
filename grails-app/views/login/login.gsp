<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2017-09-11
  Time: 10:31
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<meta name="layout" content="main" />
<title>User Login</title>
</head>
<body>
    <div class="body">
<g:form action="doLogin" method="post">
    <div class="dialog">
        <p>Entry your login details below:</p>
        <table class="userForm">
            <tr class="prop">
                <td valign="top" style="text-align:left;" width="20%">
                    <label for="username">UserName:</label>
                </td>
                <td valign="top" style="text-align:left;" width="80%">
                    <input id="username" type="text" name="username" value="${user?.email}" />
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" style="text-align:left;" width="20%">
                    <label for="password">Password:</label>
                </td>
                <td valign="top" style="text-align:left;" width="80%">
                    <input id="password" type="password" name="password" value="${user?.password}" />
                </td>
            </tr>
        </table>
    </div>
    <div class="buttons">
        <span class="formButton">
            <input type="submit" value="Login"/>
        </span>
    </div>
</g:form>
    </div>
</body>
</html>