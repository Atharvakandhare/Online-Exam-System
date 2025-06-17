package pkgExam;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/AddQuestionServlet")
public class AddQuestionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if(session == null || !"teacher".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String questionText = request.getParameter("question_text");
        String optionA = request.getParameter("option_a");
        String optionB = request.getParameter("option_b");
        String optionC = request.getParameter("option_c");
        String optionD = request.getParameter("option_d");
        String correctOption = request.getParameter("correct_option");

        int examId = 0;
        try {
            examId = Integer.parseInt(request.getParameter("exam_id"));
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid exam selected.");
            request.getRequestDispatcher("add_question.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBUtil.getConnection();

            String sql = "INSERT INTO questions (exam_id, question, optionA, optionB, optionC, optionD, correct_answer) VALUES (?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, examId);
            ps.setString(2, questionText);
            ps.setString(3, optionA);
            ps.setString(4, optionB);
            ps.setString(5, optionC);
            ps.setString(6, optionD);
            ps.setString(7, correctOption);

            int inserted = ps.executeUpdate();
            if(inserted > 0) {
                response.sendRedirect("add_question.jsp?msg=Question added successfully");
            } else {
                request.setAttribute("error", "Failed to add question.");
                request.getRequestDispatcher("add_question.jsp").forward(request, response);
            }

        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("add_question.jsp").forward(request, response);
        } finally {
            try { if(ps != null) ps.close(); } catch(Exception ignore) {}
            try { if(conn != null) conn.close(); } catch(Exception ignore) {}
        }
    }
}
