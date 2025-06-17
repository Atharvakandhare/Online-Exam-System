<%@ page session="true" %>
<%
    if(session.getAttribute("username")==null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
    }
%>
<html><head><title>Admin Dashboard</title></head>
<body style="background:#e3f2fd;padding:40px;">
    <h2 style="color:#007bff;">Welcome Admin - <%= session.getAttribute("username") %></h2>
    <div style="margin-top:30px;">
        <a href="create_exam.jsp" style="margin-right:20px;">Add Exam</a>
        <a href="view_questions.jsp" style="margin-right:20px;">View Questions</a>
        <a href="logout.jsp">Logout</a>
    </div>
</body></html>
