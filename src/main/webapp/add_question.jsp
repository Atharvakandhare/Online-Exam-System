<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="pkgExam.DBUtil" %>
<%
    if(session.getAttribute("username") == null || !"teacher".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Question</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', Arial, sans-serif;
            background: #f4f6fb;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 540px;
            margin: 48px auto 48px auto;
            background: #fff;
            padding: 38px 28px 28px 28px;
            border-radius: 18px;
            box-shadow: 0 8px 32px rgba(60,60,120,0.10), 0 1.5px 4px rgba(60,60,120,0.08);
        }
        h2 {
            text-align: center;
            color: #222b45;
            margin-bottom: 28px;
            font-size: 24px;
            font-weight: 600;
            letter-spacing: 1px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            font-weight: 500;
            margin-bottom: 8px;
            color: #185a9d;
            font-size: 15px;
        }
        select, textarea, input[type="text"] {
            width: 100%;
            padding: 13px 14px;
            border: 1.5px solid #e0e4ea;
            border-radius: 8px;
            font-size: 15px;
            background: #f9fbfd;
            transition: border 0.2s, box-shadow 0.2s;
            outline: none;
        }
        select:focus, textarea:focus, input[type="text"]:focus {
            border: 1.5px solid #43cea2;
            box-shadow: 0 2px 8px rgba(67,206,162,0.10);
            background: #fff;
        }
        textarea {
            resize: vertical;
            min-height: 100px;
        }
        .options-container {
            display: grid;
            gap: 10px;
        }
        .gradient-btn {
            width: 100%;
            padding: 13px;
            background: linear-gradient(90deg, #9b59b6 0%, #43cea2 100%);
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
            background: linear-gradient(90deg, #43cea2 0%, #9b59b6 100%);
            transform: translateY(-2px) scale(1.03);
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 22px;
            color: #185a9d;
            text-decoration: none;
            font-weight: 500;
            font-size: 15px;
            transition: color 0.2s;
        }
        .back-link:hover {
            color: #43cea2;
        }
        .error-message {
            color: #e74c3c;
            text-align: center;
            margin-bottom: 20px;
        }
        @media (max-width: 600px) {
            .container {
                padding: 12px 2px 12px 2px;
                margin: 18px 2px;
            }
            h2 {
                font-size: 18px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Add New Question</h2>
        <form action="AddQuestionServlet" method="post">
            <div class="form-group">
                <label for="exam_id">Select Exam:</label>
                <select name="exam_id" id="exam_id" required>
                    <option value="">-- Select an Exam --</option>
                    <%
                        java.sql.Connection conn = null;
                        java.sql.PreparedStatement ps = null;
                        java.sql.ResultSet rs = null;
                        try {
                            conn = DBUtil.getConnection();
                            String teacherUsername = (String) session.getAttribute("username");
                            ps = conn.prepareStatement("SELECT id, title FROM exams WHERE created_by = (SELECT id FROM users WHERE username = ?)");
                            ps.setString(1, teacherUsername);
                            rs = ps.executeQuery();
                            while(rs.next()) {
                    %>
                                <option value="<%= rs.getInt("id") %>"><%= rs.getString("title") %></option>
                    <%
                            }
                        } catch(Exception e) {
                    %>
                            <div class="error-message">Error loading exams: <%= e.getMessage() %></div>
                    <%
                        } finally {
                            if(rs != null) try { rs.close(); } catch(Exception ignore) {}
                            if(ps != null) try { ps.close(); } catch(Exception ignore) {}
                            if(conn != null) try { conn.close(); } catch(Exception ignore) {}
                        }
                    %>
                </select>
            </div>
            <div class="form-group">
                <label for="question_text">Question Text:</label>
                <textarea name="question_text" id="question_text" required></textarea>
            </div>
            <div class="form-group">
                <label>Options:</label>
                <div class="options-container">
                    <input type="text" name="option_a" placeholder="Option A" required>
                    <input type="text" name="option_b" placeholder="Option B" required>
                    <input type="text" name="option_c" placeholder="Option C" required>
                    <input type="text" name="option_d" placeholder="Option D" required>
                </div>
            </div>
            <div class="form-group">
                <label for="correct_option">Correct Option:</label>
                <select name="correct_option" id="correct_option" required>
                    <option value="">-- Select Correct Option --</option>
                    <option value="A">Option A</option>
                    <option value="B">Option B</option>
                    <option value="C">Option C</option>
                    <option value="D">Option D</option>
                </select>
            </div>
            <button type="submit" class="gradient-btn">Add Question</button>
        </form>
        <a href="teacher_dashboard.jsp" class="back-link">&larr; Back to Dashboard</a>
    </div>
</body>
</html>
