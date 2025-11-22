<% session.setMaxInactiveInterval(30 * 60); // 30 minutes session timeout %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.*, java.util.*" %>

<%
    String username = request.getParameter("u1");
    String password = request.getParameter("u2");
    String uniqueCode = request.getParameter("u3");
    String userEnteredClass = request.getParameter("classInput");

    try {
        // Load MySQL Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Connect to Database
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minor?useSSL=false", "root", "root");

        // Query to check user credentials
        String query = "SELECT username, password, unique_code, allowed_class FROM faculty WHERE username = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            String storedUsername = rs.getString("username").trim().toLowerCase();
            String storedPassword = rs.getString("password").trim();
            String storedUniqueCode = rs.getString("unique_code").trim();
            String storedAllowedClass = rs.getString("allowed_class").trim().replaceAll("\\s", "");

            // Trim and process user input
            username = username.trim().toLowerCase();
            userEnteredClass = userEnteredClass != null ? userEnteredClass.replaceAll("\\s", "") : "";

            // Debugging Output
            out.println("<p><b>Stored Username:</b> " + storedUsername + "</p>");
            out.println("<p><b>Stored Password:</b> " + storedPassword + "</p>");
            out.println("<p><b>Stored Unique Code:</b> " + storedUniqueCode + "</p>");
            out.println("<p><b>Stored Allowed Class (Processed):</b> " + storedAllowedClass + "</p>");
            out.println("<p><b>User Entered Class (Processed):</b> " + userEnteredClass + "</p>");

            if (storedUsername.equals(username) && password.equals(storedPassword) && uniqueCode.equals(storedUniqueCode)) {
                if (!userEnteredClass.isEmpty()) {
                    if (storedAllowedClass.equalsIgnoreCase(userEnteredClass)) {
                        session.setAttribute("assignedClass", userEnteredClass);
                        session.setAttribute("teacherUsername", username);
                        out.println("<script>window.location='h.jsp';</script>");
                    } else {
                        out.println("<script>alert('Class Mismatch! Redirecting...'); window.location='h.jsp';</script>");
                    }
                } else {
                    out.println("<script>alert('No Class Entered! Redirecting...'); window.location='h.jsp';</script>");
                }
            } else {
                out.println("<script>alert('Invalid Password or Unique Code! Redirecting...'); window.location='invalidCode.jsp';</script>");
            }
        } else {
            out.println("<script>alert('User Not Found!'); window.location='login.jsp';</script>");
        }

        con.close();
    } catch (SQLException e) {
        out.println("<script>alert('SQL Error: " + e.getMessage() + "'); window.location='login.jsp';</script>");
        e.printStackTrace();
    } catch (Exception e) {
        out.println("<script>alert('Error: " + e.getMessage() + "'); window.location='login.jsp';</script>");
        e.printStackTrace();
    }
%>
