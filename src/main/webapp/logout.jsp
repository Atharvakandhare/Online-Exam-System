<%@ page session="true" %>
<%
    session.invalidate(); // Destroys session
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // I have used to Prevent back button access
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Logged Out</title>
</head>
<body style="font-family:sans-serif; background-color:#fceae8; display:flex; justify-content:center; align-items:center; height:100vh; margin:0;">
    <div style="background:#fff; padding:30px 50px; border-radius:12px; box-shadow:0 0 15px rgba(0,0,0,0.1); text-align:center;">
        <h2 style="color:#e74c3c;">You have been logged out</h2>
        <p style="margin: 20px 0;">Thank you for using the system.</p>
        <a href="login.jsp" style="text-decoration:none; color:white; background-color:#3498db; padding:10px 20px; border-radius:6px;">Login Again</a>
    </div>
</body>
</html>
