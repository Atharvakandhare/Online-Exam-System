<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    if(session.getAttribute("username") == null || !"teacher".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Student Results</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', Arial, sans-serif;
            background: #f4f6fb;
            padding: 20px;
            margin: 0;
        }
        .container {
            max-width: 900px;
            margin: 40px auto;
            background: #fff;
            padding: 36px 28px 28px 28px;
            border-radius: 18px;
            box-shadow: 0 8px 32px rgba(60,60,120,0.10), 0 1.5px 4px rgba(60,60,120,0.08);
        }
        h2 {
            color: #222b45;
            font-size: 26px;
            font-weight: 600;
            letter-spacing: 1px;
            margin-bottom: 28px;
            text-align: left;
        }
        .modern-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background: #fff;
            border-radius: 14px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(60,60,120,0.07);
        }
        .modern-table th {
            background: linear-gradient(90deg, #43cea2 0%, #185a9d 100%);
            color: #fff;
            font-weight: 600;
            padding: 15px 10px;
            font-size: 15px;
            border: none;
        }
        .modern-table td {
            padding: 13px 10px;
            font-size: 15px;
            color: #333;
            background: #f9fbfd;
            border-bottom: 1.5px solid #e6eaf3;
            transition: background 0.2s;
        }
        .modern-table tr:last-child td {
            border-bottom: none;
        }
        .modern-table tr {
            transition: box-shadow 0.2s, background 0.2s;
        }
        .modern-table tbody tr:hover {
            background: #e3f0fa;
            box-shadow: 0 2px 12px rgba(24,90,157,0.08);
        }
        .back-btn {
            display: inline-block;
            margin: 32px auto 0 auto;
            padding: 12px 32px;
            background: linear-gradient(90deg, #43cea2 0%, #185a9d 100%);
            color: #fff;
            font-size: 16px;
            font-weight: 500;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            box-shadow: 0 2px 8px rgba(67,206,162,0.10);
            transition: background 0.2s, transform 0.2s;
        }
        .back-btn:hover {
            background: linear-gradient(90deg, #185a9d 0%, #43cea2 100%);
            transform: translateY(-2px) scale(1.04);
        }
        @media (max-width: 700px) {
            .container {
                padding: 10px 2px;
            }
            .modern-table th, .modern-table td {
                padding: 10px 6px;
                font-size: 13px;
            }
            h2 {
                font-size: 20px;
            }
        }
        @media (max-width: 500px) {
            .container {
                padding: 2px 0;
            }
            .modern-table, .modern-table thead, .modern-table tbody, .modern-table th, .modern-table td, .modern-table tr {
                display: block;
                width: 100%;
            }
            .modern-table thead tr {
                display: none;
            }
            .modern-table tr {
                margin-bottom: 18px;
                box-shadow: 0 2px 8px rgba(24,90,157,0.08);
                border-radius: 10px;
                background: #fff;
            }
            .modern-table td {
                border: none;
                position: relative;
                padding-left: 50%;
                min-height: 38px;
                background: #f9fbfd;
            }
            .modern-table td:before {
                position: absolute;
                left: 12px;
                top: 12px;
                width: 45%;
                white-space: nowrap;
                font-weight: 600;
                color: #185a9d;
                content: attr(data-label);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Student Results</h2>
        <table class="modern-table">
            <thead>
            <tr>
                <th>Username</th>
                <th>Exam ID</th>
                <th>Score</th>
                <th>Total Questions</th>
                <th>Attempted On</th>
            </tr>
            </thead>
            <tbody>
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_exam", "root", "mysql12");
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT * FROM results");

                    while(rs.next()) {
            %>
            <tr>
                <td data-label="Username"><%= rs.getString("username") %></td>
                <td data-label="Exam ID"><%= rs.getInt("exam_id") %></td>
                <td data-label="Score"><%= rs.getInt("score") %></td>
                <td data-label="Total Questions"><%= rs.getInt("total_questions") %></td>
                <td data-label="Attempted On"><%= rs.getTimestamp("submission_time") %></td>
            </tr>
            <%
                    }
                } catch(Exception e) {
                    out.println("<tr><td colspan='5'>Error fetching results: " + e.getMessage() + "</td></tr>");
                } finally {
                    if(rs != null) rs.close();
                    if(stmt != null) stmt.close();
                    if(conn != null) conn.close();
                }
            %>
            </tbody>
        </table>
        <div style="text-align:center;">
            <a href="teacher_dashboard.jsp" class="back-btn">&larr; Back to Dashboard</a>
        </div>
    </div>
</body>
</html>
