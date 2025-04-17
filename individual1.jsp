<%@page import="java.sql.*"%>
<%
String s1 = request.getParameter("u1");
String s2 = request.getParameter("u2");
String s3 = request.getParameter("u3");

if (s1 == null || s2 == null || s3 == null || s1.trim().isEmpty() || s2.trim().isEmpty() || s3.trim().isEmpty()) {
    out.println("<p style='color: red; font-weight: bold;'>Please provide all required inputs: Enrollment Number, Semester, and Branch.</p>");
    return;
}

// Check for valid branch input
if (!s3.equalsIgnoreCase("CSIT-1") && !s3.equalsIgnoreCase("CSIT-2") && !s3.equalsIgnoreCase("CY")) {
    out.println("<p style='color: red; font-weight: bold;'>Invalid branch input. Please specify either CSIT-1, CSIT-2, or CY.</p>");
    return;
}

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minor?useSSL=false", "root", "root");
    System.out.println("Connected to the database successfully!");

    String table = "";
    String enrollmentColumn = "";
    if (s3.equalsIgnoreCase("CSIT-1")) {
        table = "final";
        enrollmentColumn = "Enrollment";
    } else if (s3.equalsIgnoreCase("CSIT-2")) {
        table = "finalCI2";
        enrollmentColumn = "Enrollment";
    } else if (s3.equalsIgnoreCase("CY")) {
        table = "finalCY";
        enrollmentColumn = "Enrol_No";
    }

    String query = "SELECT * FROM " + table + " WHERE " + enrollmentColumn + " = UPPER(?) AND Semester = ?";
    PreparedStatement ps = con.prepareStatement(query);
    ps.setString(1, s1);
    ps.setString(2, s2);
    
    
      String table1 = "";
    String enrollmentColumn1 = "";
    if (s3.equalsIgnoreCase("CSIT-1")) {
        table1 = "CI15";
        enrollmentColumn1 = "Enrollment";
    } 
    else if (s3.equalsIgnoreCase("CSIT-2")) {
        table1 = "CI25";
        enrollmentColumn1 = "Enrollment";
    } else if (s3.equalsIgnoreCase("CY")) {
        table1 = "CY5";
        enrollmentColumn1 = "Enrollment";
    }

    String query1 = "SELECT * FROM " + table1 + " WHERE " + enrollmentColumn1 + " = UPPER(?) AND Semester = ?";
    PreparedStatement ps1 = con.prepareStatement(query1);
    ps1.setString(1, s1);
    ps1.setString(2, s2);

    ResultSet rs = ps.executeQuery();
ResultSet rs1 = ps1.executeQuery();
    out.println("<!DOCTYPE html>");
    out.println("<html>");
    out.println("<head>");
    out.println("<title>Individual</title>");
    out.println("<style>");
    out.println("body {");
    out.println("    margin: 0;");
    out.println("    padding: 0;");
    out.println("    background: url('b.png') no-repeat center center fixed;");
    out.println("    background-size: cover;");
    out.println("    display: flex;");
    out.println("    align-items: center;");
    out.println("    justify-content: center;");
    out.println("    height: 100vh;");
    out.println("    font-family: Arial, sans-serif;");
    out.println("}");
    out.println(".result-container {");
    out.println("    background-color: rgba(255, 255, 255, 0.9);");
    out.println("    padding: 10px;");  // Reduced padding
    out.println("    border-radius: 10px;");
    out.println("    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);");
    out.println("    width: 280px;");  // Reduced width for more compactness
    out.println("    max-width: 90%;"); // Add responsiveness for mobile view
    out.println("}");
    out.println("table {");
    out.println("    border-collapse: collapse;");
    out.println("    width: 100%;");
    out.println("    table-layout: fixed;");  // Fixed column widths
    out.println("    font-size: 11px;");  // Reduced font size
    out.println("}");
    out.println("th, td {");
    out.println("    padding: 3px;");  // Reduced padding for more compactness
    out.println("    text-align: left;");
    out.println("    border-bottom: 1px solid #ccc;");
    out.println("    word-wrap: break-word;");
    out.println("}");
    out.println("th {");
    out.println("    background-color: #007BFF;");
    out.println("    color: white;");
    out.println("    font-size: 12px;");  // Reduced font size for headers
    out.println("}");
    out.println("h3 {");
    out.println("    text-align: center;");
    out.println("    color: #007BFF;");
    out.println("    margin-bottom: 10px;");
    out.println("    font-size: 16px;");  // Reduced font size for the header
    out.println("}");
    out.println("</style>");
    out.println("</head>");
    out.println("<body>");

  if (rs.next() || rs1.next()) {
    out.println("<div style='display: flex; gap: 20px; flex-wrap: wrap;'>");

    if (rs.isBeforeFirst() || rs.getRow() == 1) { // check if rs had data
        out.println("<div class='result-container'>");
        out.println("<h3>Result...</h3>");
        out.println("<table>");
        ResultSetMetaData rsmd = rs.getMetaData();
        int columnCount = rsmd.getColumnCount();
        for (int i = 1; i <= columnCount; i++) {
            out.println("<tr>");
            out.println("<th style='width: 40%;'>" + rsmd.getColumnLabel(i) + "</th>");
            out.println("<td style='width: 60%;'>" + rs.getObject(i) + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
        out.println("</div>");
    }

    if (rs1.isBeforeFirst() || rs1.getRow() == 1) {
        out.println("<div class='result-container'>");
        out.println("<h3>Result...</h3>");
        out.println("<table>");
        ResultSetMetaData rsmd1 = rs1.getMetaData();
        int columnCount1 = rsmd1.getColumnCount();
        for (int i = 1; i <= columnCount1; i++) {
            out.println("<tr>");
            out.println("<th style='width: 40%;'>" + rsmd1.getColumnLabel(i) + "</th>");
            out.println("<td style='width: 60%;'>" + rs1.getObject(i) + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
        out.println("</div>");
    }

    out.println("</div>"); // close flex container
} else {
    out.println("<div class='result-container'>");
    out.println("<h3 style='color: red; text-align: center;'>No Data Found...</h3>");
    out.println("</div>");
}


    out.println("</body>");
    out.println("</html>");

    rs.close();
    ps.close();
    rs1.close();
    ps1.close();
    con.close();
} catch (Exception e) {
    e.printStackTrace();
    out.println("<p style='color: red; font-weight: bold;'>Error: " + e.getMessage() + "</p>");
}
%>
