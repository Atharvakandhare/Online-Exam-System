package pkgExam;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/TakeExamServlet")
public class TakeExamServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int examId = Integer.parseInt(request.getParameter("exam_id")); // Get selected exam ID
        HttpSession session = request.getSession();
        session.setAttribute("exam_id", examId); // Store exam ID for result submission

        List<Map<String, Object>> questionList = new ArrayList<>();

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_exam", "root", "mysql12");

            String sql = "SELECT * FROM questions WHERE exam_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, examId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> question = new HashMap<>();
                question.put("id", rs.getInt("id"));
                question.put("text", rs.getString("question_text"));
                question.put("optionA", rs.getString("option_a"));
                question.put("optionB", rs.getString("option_b"));
                question.put("optionC", rs.getString("option_c"));
                question.put("optionD", rs.getString("option_d"));
                question.put("correct", rs.getString("correct_option")); // this is only used on backend
                questionList.add(question);
            }

            if (questionList.isEmpty()) {
                request.setAttribute("error", "No questions found for this exam.");
                request.getRequestDispatcher("student_dashboard.jsp").forward(request, response);
                return;
            }

            // Store correct answers in session for later use
            session.setAttribute("questions", questionList);

            // Forward to JSP
            request.setAttribute("questionList", questionList);
            request.getRequestDispatcher("take_exam.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading exam: " + e.getMessage());
            request.getRequestDispatcher("student_dashboard.jsp").forward(request, response);
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}
