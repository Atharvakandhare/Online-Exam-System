package pkgExam;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.sql.*;
import java.util.Enumeration;

@WebServlet("/SubmitExamServlet")
public class SubmitExamServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("username") == null || !"student".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        String examId = (String) session.getAttribute("current_exam");
        if(examId == null) {
            response.sendRedirect("student_dashboard.jsp");
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        int totalQuestions = 0;
        int correctAnswers = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_exam", "root", "mysql12");

            // Get all questions for this exam
            ps = conn.prepareStatement("SELECT id, correct_answer FROM questions WHERE exam_id = ?");
            ps.setString(1, examId);
            rs = ps.executeQuery();

            while(rs.next()) {
                totalQuestions++;
                int qid = rs.getInt("id");
                String correctOption = rs.getString("correct_answer");

                // User's answer from form parameter
                String userAnswer = request.getParameter("q" + qid);

                if(userAnswer != null && userAnswer.equalsIgnoreCase(correctOption)) {
                    correctAnswers++;
                }
            }
            rs.close();
            ps.close();

            // Save result to DB (assuming a 'results' table with columns: username, exam_id, score, total)
            ps = conn.prepareStatement("INSERT INTO results(username, exam_id, score, total_questions) VALUES (?, ?, ?, ?)");
            ps.setString(1, username);
            ps.setString(2, examId);
            ps.setInt(3, correctAnswers);
            ps.setInt(4, totalQuestions);
            ps.executeUpdate();

            // Store score in session for showing in result page
            session.setAttribute("score", correctAnswers);
            session.setAttribute("totalQuestions", totalQuestions);
            session.setAttribute("examId", examId);

            response.sendRedirect("result.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error processing exam submission: " + e.getMessage());
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception ignored) {}
            try { if(ps != null) ps.close(); } catch(Exception ignored) {}
            try { if(conn != null) conn.close(); } catch(Exception ignored) {}
        }
    }
}
