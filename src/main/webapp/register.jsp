<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Online Exam System</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            font-family: 'Poppins', Arial, sans-serif;
            background: linear-gradient(120deg, #43cea2 0%, #185a9d 100%);
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .register-card {
            background: #fff;
            padding: 44px 32px 32px 32px;
            border-radius: 18px;
            box-shadow: 0 8px 32px rgba(60,60,120,0.13), 0 1.5px 4px rgba(60,60,120,0.08);
            width: 100%;
            max-width: 420px;
        }
        .register-title {
            text-align: center;
            color: #222b45;
            margin-bottom: 28px;
            font-size: 26px;
            font-weight: 600;
            letter-spacing: 1px;
        }
        .form-group {
            margin-bottom: 18px;
        }
        label {
            display: block;
            margin-bottom: 7px;
            color: #185a9d;
            font-weight: 500;
            font-size: 15px;
        }
        input[type="text"], input[type="email"], input[type="password"], select {
            width: 100%;
            padding: 13px 14px;
            border: 1.5px solid #e0e4ea;
            border-radius: 8px;
            font-size: 15px;
            background: #f9fbfd;
            transition: border 0.2s, box-shadow 0.2s;
            outline: none;
        }
        input[type="text"]:focus, input[type="email"]:focus, input[type="password"]:focus, select:focus {
            border: 1.5px solid #43cea2;
            box-shadow: 0 2px 8px rgba(67,206,162,0.10);
            background: #fff;
        }
        .gradient-btn {
            width: 100%;
            padding: 13px;
            background: linear-gradient(90deg, #43cea2 0%, #185a9d 100%);
            color: #fff;
            font-size: 17px;
            font-weight: 500;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(67,206,162,0.10);
            transition: background 0.2s, transform 0.2s;
        }
        .gradient-btn:hover {
            background: linear-gradient(90deg, #185a9d 0%, #43cea2 100%);
            transform: translateY(-2px) scale(1.03);
        }
        .login-link {
            text-align: center;
            margin-top: 22px;
            color: #666;
            font-size: 15px;
        }
        .login-link a {
            color: #185a9d;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s;
        }
        .login-link a:hover {
            color: #43cea2;
        }
        .error-msg {
            color: #e74c3c;
            text-align: center;
            margin-bottom: 18px;
            font-size: 15px;
        }
        @media (max-width: 500px) {
            .register-card {
                padding: 18px 4px 18px 4px;
            }
            .register-title {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="register-card">
        <h2 class="register-title">Register</h2>
        <% if (request.getParameter("error") != null) { %>
            <div class="error-msg">Username or Email already exists</div>
        <% } %>
        <form action="RegisterServlet" method="post">
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" required>
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>
            <div class="form-group">
                <label>Role</label>
                <select name="role" required>
                    <option value="">-- Select Role --</option>
                    <option value="student">Student</option>
                    <option value="teacher">Teacher</option>
                    <option value="admin">Admin</option>
                </select>
            </div>
            <button type="submit" class="gradient-btn">Register</button>
        </form>
        <div class="login-link">
            Already have an account?
            <a href="login.jsp">Login here</a>
        </div>
    </div>
</body>
</html>
