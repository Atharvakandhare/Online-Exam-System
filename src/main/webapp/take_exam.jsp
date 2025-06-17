<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    if(session.getAttribute("username") == null || !"student".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    String examId = request.getParameter("exam_id");
    if(examId == null || examId.trim().isEmpty()) {
%>
        <!DOCTYPE html>
        <html>
        <head><title>Enter Exam ID</title></head>
        <body style="font-family:sans-serif; text-align:center; padding: 50px;">
            <h2>Please enter the Exam ID to proceed</h2>
            <form method="get" action="take_exam.jsp">
                <input type="text" name="exam_id" placeholder="Exam ID" required style="padding:8px; font-size:16px;">
                <button type="submit" style="padding:8px 15px; font-size:16px;">Start Exam</button>
            </form>
            <p><a href="student_dashboard.jsp">← Back to Dashboard</a></p>
        </body>
        </html>
<%
        return;  
    }

    session.setAttribute("current_exam", examId);

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>


<html>
<head>
    <title>Take Exam</title>
    <script>
        let minutes = 10, seconds = 0;
        function startTimer() {
            const timer = setInterval(() => {
                if (seconds === 0) {
                    if (minutes === 0) {
                        clearInterval(timer);
                        alert("Time's up! Submitting exam.");
                        document.getElementById("examForm").submit();
                        return;
                    }
                    minutes--;
                    seconds = 59;
                } else {
                    seconds--;
                }
                document.getElementById("timer").innerText = `${minutes}m ${seconds}s`;
            }, 1000);
        }
        window.onload = startTimer;
    </script>
</head>
<body style="font-family:sans-serif; background:#f2f2f2;">
<div style="width:80%; margin:auto; padding:20px; background:white; border-radius:10px;">
    <h2>Exam</h2>
    <div id="timer" style="font-weight:bold; color:red;"></div>
    <form action="SubmitExamServlet" method="post" id="examForm">
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_exam", "root", "mysql12");
        ps = conn.prepareStatement("SELECT * FROM questions WHERE exam_id = ?");
        ps.setString(1, examId);
        rs = ps.executeQuery();
        int i = 1;
        boolean hasQuestions = false;
        while(rs.next()) {
            hasQuestions = true;
%>
        <div style="margin-bottom:20px;">
            <p><b>Q<%= i++ %>: <%= rs.getString("question") %></b></p>
            <input type="radio" name="q<%= rs.getInt("id") %>" value="A" required> <%= rs.getString("optionA") %><br>
            <input type="radio" name="q<%= rs.getInt("id") %>" value="B"> <%= rs.getString("optionB") %><br>
            <input type="radio" name="q<%= rs.getInt("id") %>" value="C"> <%= rs.getString("optionC") %><br>
            <input type="radio" name="q<%= rs.getInt("id") %>" value="D"> <%= rs.getString("optionD") %><br>
        </div>
<%
        }
        if(!hasQuestions){
            out.println("<p style='color:red;'>No questions found for this exam.</p>");
        }
    } catch(Exception e) {
        out.println("<p style='color:red;'>Error loading questions: " + e.getMessage() + "</p>");
    } finally {
        if(rs != null) rs.close();
        if(ps != null) ps.close();
        if(conn != null) conn.close();
    }
%>
        <button type="submit" style="padding:10px; background:green; color:white;">Submit Exam</button>
    </form>
    <p><a href="student_dashboard.jsp">← Back to Dashboard</a></p>
</div>
</body>
</html>
