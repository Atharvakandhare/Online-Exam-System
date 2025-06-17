package pkgExam;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;

public class StudentDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if(session == null || !"student".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }
        request.getRequestDispatcher("student_dashboard.jsp").forward(request, response);
    }
}