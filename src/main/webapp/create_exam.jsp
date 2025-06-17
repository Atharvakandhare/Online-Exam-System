<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || !"teacher".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Exam</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #f5f7fa;
            font-family: 'Poppins', Arial, sans-serif;
        }
        .form-card {
            max-width: 440px;
            margin: 60px auto;
            background: #fff;
            padding: 38px 32px 32px 32px;
            border-radius: 18px;
            box-shadow: 0 8px 32px rgba(60,60,120,0.10), 0 1.5px 4px rgba(60,60,120,0.08);
        }
        .form-title {
            text-align: center;
            color: #222b45;
            margin-bottom: 28px;
            font-size: 26px;
            font-weight: 600;
            letter-spacing: 1px;
        }
        .error-msg {
            color: #e74c3c;
            margin-bottom: 18px;
            text-align: center;
            font-size: 15px;
        }
        .styled-input {
            width: 100%;
            padding: 13px 14px;
            margin-bottom: 18px;
            border: 1.5px solid #e0e4ea;
            border-radius: 8px;
            font-size: 15px;
            background: #f9fbfd;
            transition: border 0.2s, box-shadow 0.2s;
            outline: none;
        }
        .styled-input:focus {
            border: 1.5px solid #43cea2;
            box-shadow: 0 2px 8px rgba(67,206,162,0.10);
            background: #fff;
        }
        .gradient-btn {
            width: 100%;
            padding: 13px;
            background: linear-gradient(90deg, #43cea2 0%, #185a9d 100%);
            color: #fff;
            font-size: 17px;
            font-weight: 500;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(67,206,162,0.10);
            transition: background 0.2s, transform 0.2s;
        }
        .gradient-btn:hover {
            background: linear-gradient(90deg, #185a9d 0%, #43cea2 100%);
            transform: translateY(-2px) scale(1.03);
        }
        .back-link {
            display: block;
            margin-top: 22px;
            text-align: center;
            color: #185a9d;
            text-decoration: none;
            font-weight: 500;
            font-size: 15px;
            transition: color 0.2s;
        }
        .back-link:hover {
            color: #43cea2;
        }
        @media (max-width: 600px) {
            .form-card {
                padding: 18px 6px 18px 6px;
                margin: 30px 4px;
            }
            .form-title {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="form-card">
        <h2 class="form-title">Create New Exam</h2>
        <% String error = (String) request.getAttribute("error"); 
           if(error != null) { %>
            <div class="error-msg"><%= error %></div>
        <% } %>
        <form action="CreateExamServlet" method="post">
            <input type="text" name="title" placeholder="Exam Title" required class="styled-input">
            <input type="number" name="duration" placeholder="Duration (minutes)" required class="styled-input">
            <input type="submit" value="Create Exam" class="gradient-btn">
        </form>
        <a href="<%= role.equals("admin") ? "admin_dashboard.jsp" : "teacher_dashboard.jsp" %>" class="back-link">&larr; Back to Dashboard</a>
    </div>
</body>
</html>
