<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if(username == null || !"student".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        body {
            background: #f0f2f5;
            padding: 40px 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        .header {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        .welcome-text {
            color: #1a73e8;
            font-size: 24px;
            font-weight: 500;
        }
        .section-title {
            color: #202124;
            font-size: 20px;
            margin-bottom: 20px;
            font-weight: 500;
        }
        .exam-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .exam-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.2s;
        }
        .exam-card:hover {
            transform: translateY(-5px);
        }
        .exam-id {
            color: #5f6368;
            font-size: 14px;
            margin-bottom: 8px;
        }
        .exam-title {
            color: #202124;
            font-size: 18px;
            font-weight: 500;
            margin-bottom: 15px;
        }
        .take-exam-btn {
            display: inline-block;
            background: #1a73e8;
            color: white;
            padding: 8px 16px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
            transition: background 0.2s;
        }
        .take-exam-btn:hover {
            background: #1557b0;
        }
        .logout-btn {
            background: #dc3545;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.2s;
        }
        .logout-btn:hover {
            background: #c82333;
        }
        .no-exams {
            text-align: center;
            color: #5f6368;
            padding: 40px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1 class="welcome-text">Welcome, <%= username %>!</h1>
        </div>
        
        <h2 class="section-title">Available Exams</h2>
        <div class="exam-grid">
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_exam", "root", "mysql12");
        ps = conn.prepareStatement("SELECT id, title FROM exams ORDER BY id");
        rs = ps.executeQuery();

        boolean noExams = true;
        while(rs.next()) {
            noExams = false;
%>
            <div class="exam-card">
                <div class="exam-id">Exam ID: <%= rs.getInt("id") %></div>
                <div class="exam-title"><%= rs.getString("title") %></div>
                <a href="take_exam.jsp?exam_id=<%= rs.getInt("id") %>" class="take-exam-btn">Take Exam</a>
            </div>
<%
        }
        if(noExams) {
%>
            <div class="no-exams">
                <p>No exams available currently.</p>
            </div>
<%
        }
    } catch(Exception e) {
%>
            <div class="no-exams">
                <p style="color: #dc3545;">Error loading exams: <%= e.getMessage() %></p>
            </div>
<%
    } finally {
        if(rs != null) try { rs.close(); } catch(Exception ignored) {}
        if(ps != null) try { ps.close(); } catch(Exception ignored) {}
        if(conn != null) try { conn.close(); } catch(Exception ignored) {}
    }
%>
        </div>

        <form action="logout.jsp" method="post" style="text-align: right; margin-top: 30px;">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </div>
</body>
</html>
