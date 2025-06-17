<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <meta charset="UTF-8">
    <title>Teacher Dashboard</title>
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
            text-align: center;
        }
        .welcome-text {
            color: #1a73e8;
            font-size: 24px;
            font-weight: 500;
            margin-bottom: 10px;
        }
        .subtitle {
            color: #5f6368;
            font-size: 16px;
        }
        .card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.2s;
            text-align: center;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card-icon {
            font-size: 32px;
            margin-bottom: 15px;
        }
        .card-title {
            color: #202124;
            font-size: 18px;
            font-weight: 500;
            margin-bottom: 15px;
        }
        .card-link {
            display: inline-block;
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            color: white;
            font-size: 14px;
            transition: background 0.2s;
        }
        .create-exam {
            background: #1a73e8;
        }
        .create-exam:hover {
            background: #1557b0;
        }
        .add-question {
            background: #9b59b6;
        }
        .add-question:hover {
            background: #8e44ad;
        }
        .view-exams {
            background: #16a085;
        }
        .view-exams:hover {
            background: #138d75;
        }
        .view-results {
            background: #e67e22;
        }
        .view-results:hover {
            background: #d35400;
        }
        .logout {
            background: #dc3545;
        }
        .logout:hover {
            background: #c82333;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1 class="welcome-text">Teacher Dashboard</h1>
            <p class="subtitle">Create and manage exams and questions</p>
        </div>

        <div class="card-grid">
            <div class="card">
                <div class="card-icon">📝</div>
                <div class="card-title">Create New Exam</div>
                <a href="create_exam.jsp" class="card-link create-exam">Create Exam</a>
            </div>

            <div class="card">
                <div class="card-icon">✏️</div>
                <div class="card-title">Add Questions</div>
                <a href="add_question.jsp" class="card-link add-question">Add Questions</a>
            </div>

            <div class="card">
                <div class="card-icon">📚</div>
                <div class="card-title">View All Exams</div>
                <a href="view_exams.jsp" class="card-link view-exams">View Exams</a>
            </div>

            <div class="card">
                <div class="card-icon">📊</div>
                <div class="card-title">View Results</div>
                <a href="view_results.jsp" class="card-link view-results">View Results</a>
            </div>

            <div class="card">
                <div class="card-icon">🚪</div>
                <div class="card-title">Logout</div>
                <a href="logout.jsp" class="card-link logout">Logout</a>
            </div>
        </div>
    </div>
</body>
</html>