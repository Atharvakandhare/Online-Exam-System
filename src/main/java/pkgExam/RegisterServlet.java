package pkgExam;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String email = request.getParameter("email");

        try (Connection conn = DBUtil.getConnection()) {
            // Check if username or email already exists
            PreparedStatement check = conn.prepareStatement("SELECT * FROM users WHERE username=? OR email=?");
            check.setString(1, username);
            check.setString(2, email);
            ResultSet rs = check.executeQuery();

            if (rs.next()) {
                response.sendRedirect("register.jsp?error=1");
                return;
            }

            PreparedStatement ps = conn.prepareStatement("INSERT INTO users (username, password, role, email, is_verified) VALUES (?, ?, ?, ?, ?)");
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, role);
            ps.setString(4, email);
            ps.setBoolean(5, true); // Set false if you want email verification flow
            ps.executeUpdate();

            response.sendRedirect("login.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Registration failed due to server error.");
        }
    }
}
