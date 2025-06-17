package pkgExam;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;

public class TeacherDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if(session == null || !"teacher".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }
        request.getRequestDispatcher("teacher_dashboard.jsp").forward(request, response);
    }
}