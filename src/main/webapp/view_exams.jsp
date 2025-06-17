<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="pkgExam.DBUtil" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Exams</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f6fb;
        }
        .container {
            max-width: 1100px;
            margin: 40px auto;
            background: #fff;
            padding: 32px 24px 24px 24px;
            border-radius: 18px;
            box-shadow: 0 8px 32px rgba(60,60,120,0.10), 0 1.5px 4px rgba(60,60,120,0.08);
        }
        h1 {
            color: #222b45;
            text-align: center;
            margin-bottom: 36px;
            font-weight: 600;
            letter-spacing: 1px;
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
            padding: 16px 12px;
            font-size: 16px;
            border: none;
        }
        .modern-table td {
            padding: 14px 12px;
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
        .btn {
            padding: 9px 22px;
            background: linear-gradient(90deg, #43cea2 0%, #185a9d 100%);
            color: #fff;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            font-size: 15px;
            font-weight: 500;
            box-shadow: 0 2px 8px rgba(67,206,162,0.10);
            transition: background 0.2s, transform 0.2s;
            outline: none;
        }
        .btn:hover {
            background: linear-gradient(90deg, #185a9d 0%, #43cea2 100%);
            transform: translateY(-2px) scale(1.04);
        }
        .no-exams {
            text-align: center;
            color: #888;
            margin-top: 20px;
            font-size: 18px;
        }
        .back-link {
            display: block;
            margin-top: 32px;
            text-align: center;
            color: #185a9d;
            text-decoration: none;
            font-weight: 500;
            font-size: 16px;
            transition: color 0.2s;
        }
        .back-link:hover {
            color: #43cea2;
        }
        @media (max-width: 700px) {
            .container {
                padding: 10px 2px;
            }
            .modern-table th, .modern-table td {
                padding: 10px 6px;
                font-size: 13px;
            }
            h1 {
                font-size: 22px;
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
        <h1>Available Exams</h1>
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                conn = DBUtil.getConnection();
                String sql = "SELECT e.*, u.username as creator_name FROM exams e LEFT JOIN users u ON e.created_by = u.id ORDER BY e.created_at DESC";
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();
                if (!rs.isBeforeFirst()) {
        %>
                    <div class="no-exams">
                        <p>No exams are currently available.</p>
                    </div>
        <%
                } else {
        %>
                <table class="modern-table">
                    <thead>
                    <tr>
                        <th>Exam Title</th>
                        <th>Duration (minutes)</th>
                        <th>Created By</th>
                        <th>Created Date</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        while (rs.next()) {
                    %>
                        <tr>
                            <td data-label="Exam Title"><%= rs.getString("title") %></td>
                            <td data-label="Duration (minutes)"><%= rs.getInt("duration") %></td>
                            <td data-label="Created By"><%= rs.getString("creator_name") != null ? rs.getString("creator_name") : "System" %></td>
                            <td data-label="Created Date"><%= rs.getTimestamp("created_at") %></td>
                            <td data-label="Action">
                                <a href="take_exam.jsp?exam_id=<%= rs.getInt("id") %>" class="btn">Take Exam</a>
                            </td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
                <div class="no-exams">
                    <p>Error loading exams. Please try again later.</p>
                </div>
        <%
            } finally {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
        %>
        <a href="student_dashboard.jsp" class="back-link">Back to Dashboard</a>
    </div>
</body>
</html> 