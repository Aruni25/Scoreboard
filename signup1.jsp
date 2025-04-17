<%@page import="java.sql.*, java.security.SecureRandom"%>
<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@ page isErrorPage="true" %>
<%= exception %>
<%
String s1 = request.getParameter("u1"); // Username
String s2 = request.getParameter("u2"); // Password
String s3 = request.getParameter("u3"); // Email
String s4 = request.getParameter("u4"); // Branch

    out.println("Starting signup process...<br>");

// Hash the password using BCrypt
String hashedPassword = BCrypt.hashpw(s2, BCrypt.gensalt(12));

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minor?useSSL=false", "root", "root");
  out.println("Connected to database.<br>");
    // Check if email already exists
    String checkQuery = "SELECT * FROM signup WHERE Email=?";
    PreparedStatement checkStmt = con.prepareStatement(checkQuery);
    checkStmt.setString(1, s3);
    ResultSet rs = checkStmt.executeQuery();

   if (rs.next()) {
            out.println("Email already exists!<br>");
            response.sendRedirect("signup.jsp?error=Email already exists");
        } else {
            // Insert new user
            String q = "INSERT INTO signup(Username, Password, Email, Branch) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setString(1, s1);
            ps.setString(2, hashedPassword);
            ps.setString(3, s3);
            ps.setString(4, s4);
            int result = ps.executeUpdate();

            if (result > 0) {
                out.println("User registered successfully! Redirecting to login...<br>");
                response.sendRedirect("login.jsp");
            } else {
                out.println("Failed to insert user.<br>");
            }
        }
        con.close();
    } catch (Exception e1) {
        out.println("<br><b>Error:</b> " + e1.getMessage() + "<br>");
    }
%>
