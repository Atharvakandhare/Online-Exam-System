package pkgExam;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/CreateExamServlet")
public class CreateExamServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Role check
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String role = (String) session.getAttribute("role");
        if (role == null || !(role.equals("admin") || role.equals("teacher"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get parameters
        String title = request.getParameter("title");
        int duration = 0;
        try {
            duration = Integer.parseInt(request.getParameter("duration"));
        } catch(NumberFormatException e) {
            request.setAttribute("error", "Duration must be a number.");
            request.getRequestDispatcher("create_exam.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection(); // Use DBUtil to get connection

            // Get the created_by user ID from the session username
            String username = (String) session.getAttribute("username");
            int createdById = -1; // Default to -1 or handle as null if appropriate for your DB
            if (username != null) {
                PreparedStatement userPs = conn.prepareStatement("SELECT id FROM users WHERE username = ?");
                userPs.setString(1, username);
                rs = userPs.executeQuery();
                System.out.println("Logged-in username from session: " + username);
                if (rs.next()) {
                    createdById = rs.getInt("id");
                    System.out.println("Fetched createdById: " + createdById);
                } else {
                    System.out.println("User ID not found for username: " + username);
                }
                rs.close();
                userPs.close();
            }

            String sql = "INSERT INTO exams (title, duration, created_by) VALUES (?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, title);
            ps.setInt(2, duration);
            if (createdById != -1) {
                ps.setInt(3, createdById);
            } else {
                ps.setNull(3, java.sql.Types.INTEGER);
            }

            System.out.println("Attempting to insert exam with title: " + title + ", duration: " + duration + ", created_by: " + createdById);
            int inserted = ps.executeUpdate();
            if (inserted > 0) {
                // Redirect to correct dashboard based on role
                if(role.equals("admin")) {
                    response.sendRedirect("admin_dashboard.jsp?msg=Exam created successfully");
                } else {
                    response.sendRedirect("teacher_dashboard.jsp?msg=Exam created successfully");
                }
            } else {
                request.setAttribute("error", "Failed to add exam.");
                request.getRequestDispatcher("create_exam.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("create_exam.jsp").forward(request, response);
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}
