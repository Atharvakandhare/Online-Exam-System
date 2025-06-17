package pkgExam;



import java.sql.*;

public class DBUtil {
    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/online_exam", "root", "mysql12");
    }
}
