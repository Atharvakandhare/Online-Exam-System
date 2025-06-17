package pkgExam;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE username=? AND password=?");
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                boolean isVerified = rs.getBoolean("is_verified");
                if (!isVerified) {
                    response.sendRedirect("login.jsp?error=1");
                    return;
                }

                HttpSession session = request.getSession();
                session.setAttribute("userId", rs.getInt("id"));
                session.setAttribute("username", rs.getString("username"));
                session.setAttribute("role", rs.getString("role"));

                String role = rs.getString("role");
                if ("admin".equalsIgnoreCase(role)) {
                    response.sendRedirect("admin_dashboard.jsp");
                } else if ("teacher".equalsIgnoreCase(role)) {
                    response.sendRedirect("teacher_dashboard.jsp");
                } else {
                    response.sendRedirect("student_dashboard.jsp");
                }
            } else {
                response.sendRedirect("login.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Login failed due to server error.");
        }
    }
}
