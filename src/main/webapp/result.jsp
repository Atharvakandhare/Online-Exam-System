<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if(username == null || !"student".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }

    Integer score = (Integer) session.getAttribute("score");
    Integer totalQuestions = (Integer) session.getAttribute("totalQuestions");
    String examId = (String) session.getAttribute("examId");

    if(score == null || totalQuestions == null || examId == null) {
        response.sendRedirect("student_dashboard.jsp");
        return;
    }

    double percentage = (score * 100.0) / totalQuestions;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Exam Result</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f7f9fc; padding: 40px; }
        .result-container {
            max-width: 600px; margin: auto; background: white; padding: 30px; border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1); text-align: center;
        }
        h2 { color: #2c3e50; }
        .score { font-size: 48px; font-weight: bold; color: #27ae60; margin: 20px 0; }
        .details { font-size: 18px; color: #555; margin-bottom: 30px; }
        a.btn {
            display: inline-block; padding: 12px 25px; background-color: #2980b9; color: white; text-decoration: none;
            border-radius: 8px; font-size: 18px;
        }
    </style>
</head>
<body>
    <div class="result-container">
        <h2>Exam Result</h2>
        <p class="details">Exam ID: <b><%= examId %></b></p>
        <p class="score"><%= score %> / <%= totalQuestions %></p>
        <p class="details">Percentage: <%= String.format("%.2f", percentage) %> %</p>
        <a href="student_dashboard.jsp" class="btn">Back to Dashboard</a>
    </div>
</body>
</html>
