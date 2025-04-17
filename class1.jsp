<%@ page import="java.sql.*, java.io.*" %>
<%@ page session="true" %>

<%
String className = request.getParameter("className");
String semester = request.getParameter("semester");
String classSession = request.getParameter("session");
String allowedClass = (String) session.getAttribute("assignedClass");

if (!className.equals(allowedClass)) {
    response.sendRedirect("invalidClass.jsp");
    return;
}
if (semester == null || semester.trim().isEmpty()) {
    semester = "4"; 
    semester = "4"; 
}
if (classSession == null || classSession.trim().isEmpty()) {
    classSession = "2024"; 
}

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minor?useSSL=false", "root", "root");

    int semesterInt = Integer.parseInt(semester);

    String query1 = "SELECT * FROM final WHERE Classname = ? AND Semester = ? AND Session = ?";
    PreparedStatement ps1 = con.prepareStatement(query1);
    ps1.setString(1, className);
    ps1.setInt(2, semesterInt);
    ps1.setString(3, classSession);

    ResultSet rs1 = ps1.executeQuery();

    String query2 = "SELECT * FROM finalCI2 WHERE Classname = ? AND Semester = ? AND Session = ?";
    PreparedStatement ps2 = con.prepareStatement(query2);
    ps2.setString(1, className);
    ps2.setInt(2, semesterInt);
    ps2.setString(3, classSession);

    ResultSet rs2 = ps2.executeQuery();
    
    String query3 = "SELECT * FROM finalCY WHERE Classname = ? AND Semester = ? AND Session = ?";
    PreparedStatement ps3 = con.prepareStatement(query3);
    ps3.setString(1, className);
    ps3.setInt(2, semesterInt);
    ps3.setString(3, classSession);

    ResultSet rs3 = ps3.executeQuery();

    out.println("<html>");
    out.println("<head>");
    out.println("<style>");
    out.println("body {");
    out.println("  background-image: url('" + request.getContextPath() + "/b.png');");
    out.println("  background-size: cover;"); 
    out.println("  background-position: center;");
    out.println("  background-attachment: fixed;");
    out.println("  color: white;"); 
    out.println("}");
    out.println("table {");
    out.println("  background-color: rgba(116, 176, 201, 0.7) !important;"); 
    out.println("  border-collapse: collapse;");
    out.println("  margin-top: 20px;");
    out.println("  width: 80%;");
    out.println("  margin-left: auto;");
    out.println("  margin-right: auto;");
    out.println("  z-index: 1;");
    out.println("}");
    out.println("th, td {");
    out.println("  padding: 10px;");
    out.println("  text-align: left;");
    out.println("  border: 1px solid white;");
    out.println("}");
    out.println("h3 {");
    out.println("  text-align: center;");
    out.println("  font-size: 24px;");
    out.println("  color: #fff;");  
    out.println("  margin-top: 20px;");
    out.println("}");
    out.println("</style>");
    out.println("</head>");
    out.println("<body>");

    out.println("<center>");
    out.println("<h3>Combined Results</h3>");
    out.println("<table>");
    out.println("<tr><th>Enrollment</th><th>BT401_T</th><th>CSIT402_T</th><th>CSIT403_T</th><th>CSIT404_T</th><th>CSIT405_T</th>");
    out.println("<th>CSIT402_P</th><th>CSIT403_P</th><th>CSIT404_P</th><th>CSIT405_P</th><th>CSIT406_P</th><th>ResultDesc</th><th>SGPA</th><th>CGPA</th></tr>");

   
    while (rs1.next()) {
        out.println("<tr>");
        out.println("<td>" + rs1.getString("Enrollment") + "</td>");
        out.println("<td>" + rs1.getString("BT401_T") + "</td>");
        out.println("<td>" + rs1.getString("CSIT402_T") + "</td>");
        out.println("<td>" + rs1.getString("CSIT403_T") + "</td>");
        out.println("<td>" + rs1.getString("CSIT404_T") + "</td>");
        out.println("<td>" + rs1.getString("CSIT405_T") + "</td>");
        out.println("<td>" + rs1.getString("CSIT402_P") + "</td>");
        out.println("<td>" + rs1.getString("CSIT403_P") + "</td>");
        out.println("<td>" + rs1.getString("CSIT404_P") + "</td>");
        out.println("<td>" + rs1.getString("CSIT405_P") + "</td>");
        out.println("<td>" + "N/A" + "</td>"); 
        out.println("<td>" + rs1.getString("ResultDesc") + "</td>");
        out.println("<td>" + rs1.getDouble("SGPA") + "</td>");
        out.println("<td>" + rs1.getDouble("CGPA") + "</td>");
        out.println("</tr>");
    }

    while (rs2.next()) {
        out.println("<tr>");
        out.println("<td>" + rs2.getString("Enrollment") + "</td>");
        out.println("<td>" + rs2.getString("BT401_[T]") + "</td>");
        out.println("<td>" + rs2.getString("CSIT402_[T]") + "</td>");
        out.println("<td>" + rs2.getString("CSIT403_[T]") + "</td>");
        out.println("<td>" + rs2.getString("CSIT404_[T]") + "</td>");
        out.println("<td>" + rs2.getString("CSIT405_[T]") + "</td>");
        out.println("<td>" + rs2.getString("CSIT402_[P]") + "</td>");
        out.println("<td>" + rs2.getString("CSIT403_[P]") + "</td>");
        out.println("<td>" + rs2.getString("CSIT404_[P]") + "</td>");
        out.println("<td>" + rs2.getString("CSIT405_[P]") + "</td>");
        out.println("<td>" + rs2.getString("CSIT406_[P]") + "</td>");
        out.println("<td>" + "N/A" + "</td>"); 
        out.println("<td>" + rs2.getDouble("SGPA") + "</td>");
        out.println("<td>" + rs2.getDouble("CGPA") + "</td>");
        out.println("</tr>");
    }

    while (rs3.next()) {
        out.println("<tr>");
        out.println("<td>" + rs3.getString("Enrollment") + "</td>");
        out.println("<td>" + rs3.getString("CY401_T") + "</td>");
        out.println("<td>" + rs3.getString("CY402_T") + "</td>");
        out.println("<td>" + rs3.getString("CY403_T") + "</td>");
        out.println("<td>" + rs3.getString("CY404_T") + "</td>");
        out.println("<td>" + rs3.getString("CY405_T") + "</td>");
        out.println("<td>" + rs3.getString("CY402_P") + "</td>");
        out.println("<td>" + rs3.getString("CY403_P") + "</td>");
        out.println("<td>" + rs3.getString("CY404_P") + "</td>");
        out.println("<td>" + rs3.getString("CY405_P") + "</td>");
        out.println("<td>" + rs3.getString("CY406_P") + "</td>");
        out.println("<td>" + "N/A" + "</td>"); 
        out.println("<td>" + rs3.getDouble("SGPA") + "</td>");
        out.println("<td>" + rs3.getDouble("CGPA") + "</td>");
        out.println("</tr>");
    }

    out.println("</table>");
    out.println("</center>");

    rs1.close();
    ps1.close();
    rs2.close();
    ps2.close();
    rs3.close();
    ps3.close();
    con.close();
} catch (Exception e) {
    out.println("Exception: " + e.getMessage());
}
%>