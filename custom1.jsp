<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.sql.*" %>
<%
String className = request.getParameter("className");
String semester = request.getParameter("semester");
String classSession = request.getParameter("session");
String sgpaFilter = request.getParameter("sgpaFilter");
String cgpaFilter = request.getParameter("cgpaFilter");

if (semester == null || semester.trim().isEmpty()) {
    semester = "4"; 
}
if (classSession == null || classSession.trim().isEmpty()) {
    classSession = "2024"; 
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Custom</title>
  <style>
    body {
      background-image: url('<%= request.getContextPath() %>/b.png');
      background-size: cover;
      background-position: center;
      background-attachment: fixed;
      color: black;
      font-family: 'Arial', sans-serif;
    }
    .filter-container {
      background-color: rgba(255, 255, 255, 0.9);
      padding: 20px;
      margin: 10px auto;
      width: 30%;
      border-radius: 8px;
      box-shadow: 0 0 8px rgba(0, 0, 0, 0.15);
    }
    .filter-container input,
    .filter-container select,
    .filter-container button {
      padding: 6px;
      margin: 4px 0;
      font-size: 0.85rem;
      border-radius: 5px;
      border: 1px solid #ccc;
      width: 100%;
      outline: none;
    }
    .filter-container button {
      background-color: #007BFF;
      color: white;
      border: none;
      cursor: pointer;
      padding: 8px;
    }
    .filter-container button:hover {
      background-color: #0056b3;
    }
    .filter-container label {
      font-weight: bold;
      display: block;
      margin-top: 6px;
      font-size: 0.9rem;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin: 20px 0;
    }
    table, th, td {
      border: 1px solid black;
    }
    th, td {
      padding: 8px 12px;
      text-align: center;
    }
    th {
      background-color: #f2f2f2;
    }
    tr:nth-child(even) {
      background-color: #f9f9f9;
    }
  </style>
</head>
<body>
<div class="filter-container">
  <form method="get" action="custom1.jsp">
    <label for="className">Class Name:</label>
    <input type="text" id="className" name="className" value="<%= className != null ? className : "" %>">

    <label for="semester">Semester:</label>
    <select id="semester" name="semester">
      <% for (int i = 1; i <= 8; i++) { %>
        <option value="<%= i %>" <%= semester != null && semester.equals(String.valueOf(i)) ? "selected" : "" %>><%= i %></option>
      <% } %>
    </select>

    <label for="session">Session:</label>
    <input type="text" id="session" name="session" value="<%= classSession != null ? classSession : "" %>">

    <label for="sgpaFilter">SGPA (Operator and Value):</label>
    <input type="text" id="sgpaFilter" name="sgpaFilter" placeholder="e.g. >= 7" value="<%= sgpaFilter != null ? sgpaFilter : "" %>">

    <label for="cgpaFilter">CGPA (Operator and Value):</label>
    <input type="text" id="cgpaFilter" name="cgpaFilter" placeholder="e.g. >= 7" value="<%= cgpaFilter != null ? cgpaFilter : "" %>">

    <button type="submit">Filter</button>
  </form>
</div>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minor?useSSL=false", "root", "root");
    int semesterInt = Integer.parseInt(semester);

    String[] tables = {"final", "finalCI2", "finalCY","CI15", "CI25", "CY5"};
    for (String table : tables) {

        StringBuilder queryBuilder = new StringBuilder("SELECT * FROM " + table + " WHERE Classname = ? AND Semester = ? AND Session = ?");
        List<Object> params = new ArrayList<Object>();
        params.add(className);
        params.add(semesterInt);
        params.add(classSession);

        if (sgpaFilter != null && !sgpaFilter.isEmpty()) {
            String[] parts = sgpaFilter.trim().split(" ");
            if (parts.length == 2) {
                String operator = parts[0];
                try {
                    double value = Double.parseDouble(parts[1]);
                    if (operator.matches("<=|>=|<|>|=|==")) {
                        queryBuilder.append(" AND SGPA " + operator + " ?");
                        params.add(value);
                    } else {
                        out.println("<p style='color: red;'>Invalid SGPA filter operator: " + operator + ". It must be one of <=, >=, <, >, =, ==.</p>");
                    }
                } catch (NumberFormatException e) {
                    out.println("<p style='color: red;'>Invalid SGPA filter value: " + parts[1] + ". It must be a valid number.</p>");
                }
            } else {
                out.println("<p style='color: red;'>SGPA filter should be in the format 'operator value'. For example, '> 7.5'.</p>");
            }
        }

        if (cgpaFilter != null && !cgpaFilter.isEmpty()) {
            String[] parts = cgpaFilter.trim().split(" ");
            if (parts.length == 2) {
                String operator = parts[0];
                try {
                    double value = Double.parseDouble(parts[1]);
                    if (operator.matches("<=|>=|<|>|=|==")) {
                        queryBuilder.append(" AND CGPA " + operator + " ?");
                        params.add(value);
                    } else {
                        out.println("<p style='color: red;'>Invalid CGPA filter operator: " + operator + ". It must be one of <=, >=, <, >, =,==.</p>");
                    }
                } catch (NumberFormatException e) {
                    out.println("<p style='color: red;'>Invalid CGPA filter value: " + parts[1] + ". It must be a valid number.</p>");
                }
            } else {
                out.println("<p style='color: red;'>CGPA filter should be in the format 'operator value'. For example, '> 8.0'.</p>");
            }
        }

        PreparedStatement ps = con.prepareStatement(queryBuilder.toString(), ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
%>
            <table>
              <tr>
                <% 
                if (table.equals("final")) {
                %>
                  <th>Enrollment</th>
                  <th>BT401_T</th>
                  <th>CSIT402_T</th>
                  <th>CSIT403_T</th>
                  <th>CSIT404_T</th>
                  <th>CSIT405_T</th>
                  <th>CSIT402_P</th>
                  <th>CSIT403_P</th>
                  <th>CSIT404_P</th>
                  <th>CSIT405_P</th>
                  <th>CSIT406_P</th>
                  <th>SGPA</th>
                  <th>CGPA</th>
                  <th>ResultDesc</th>
                  <th>Semester</th>
                  <th>Classname</th>
                  <th>Session</th>
                <% } else if (table.equals("finalCY")) { %>
                  <th>Enrollment</th>
                  <th>CY401_T</th>
                  <th>CY402_T</th>
                  <th>CY403_T</th>
                  <th>CY404_T</th>
                  <th>CY405_T</th>
                  <th>CY402_P</th>
                  <th>CY403_P</th>
                  <th>CY404_P</th>
                  <th>CY405_P</th>
                  <th>CY406_P</th>
                  <th>SGPA</th>
                  <th>CGPA</th>
                  <th>Result_Desc</th>
                  <th>Grace</th>
                  <th>Classname</th>
                  <th>Semester</th>
                  <th>Session</th>
                <% } else if (table.equals("finalCI2")) { %>
                  <th>Enrollment</th>
                  <th>BT401_[T]</th>
                  <th>CSIT402_[T]</th>
                  <th>CSIT403_[T]</th>
                  <th>CSIT404_[T]</th>
                  <th>CSIT405_[T]</th>
                  <th>CSIT402_[P]</th>
                  <th>CSIT403_[P]</th>
                  <th>CSIT404_[P]</th>
                  <th>CSIT405_[P]</th>
                  <th>CSIT406_[P]</th>
                  <th>SGPA</th>
                  <th>CGPA</th>
                  <th>Result_Des</th>
                  <th>Semester</th>
                  <th>Classname</th>
                  <th>Session</th>
                <% }else if (table.equals("CI15") || table.equals("CI25")) { %>
      <th>Enrollment_</th>
      <th>Subject</th>
      <th>CSIT501_T</th>
      <th>CSIT502_T</th>
      <th>CSIT503_T</th>
      <th>CSIT504_T</th>
      <th>BT407_P</th>
      <th>CSIT501_P</th>
      <th>CSIT502_P</th>
      <th>CSIT505_P</th>
      <th>CSIT506_P</th>
      <th>CSIT508_P</th>
      <th>SGPA</th>
      <th>CGPA</th>
      <th>ResultDesc</th>
      <th>Semester</th>
      <th>Classname</th>
      <th>Session</th>
      <th>Grace_or_No_Grace</th>
    <% } %>
  </tr>
  <% 
  do {
  %>

              <tr>
                <td><%= rs.getObject("Enrollment") %></td>
                
  
                
                <% if (table.equals("final")) { %>
                  <td><%= rs.getObject("BT401_T") %></td>
                  <td><%= rs.getObject("CSIT402_T") %></td>
                  <td><%= rs.getObject("CSIT403_T") %></td>
                  <td><%= rs.getObject("CSIT404_T") %></td>
                  <td><%= rs.getObject("CSIT405_T") %></td>
                  <td><%= rs.getObject("CSIT402_P") %></td>
                  <td><%= rs.getObject("CSIT403_P") %></td>
                  <td><%= rs.getObject("CSIT404_P") %></td>
                  <td><%= rs.getObject("CSIT405_P") %></td>
                  <td><%= rs.getObject("CSIT406_P") %></td>
                  <td><%= rs.getObject("SGPA") %></td>
                <td><%= rs.getObject("CGPA") %></td>
                <td><%= rs.getObject("ResultDesc") %></td>
                <% } else if (table.equals("finalCY")) { %>
                  <td><%= rs.getObject("CY401_T") %></td>
                  <td><%= rs.getObject("CY402_T") %></td>
                  <td><%= rs.getObject("CY403_T") %></td>
                  <td><%= rs.getObject("CY404_T") %></td>
                  <td><%= rs.getObject("CY405_T") %></td>
                  <td><%= rs.getObject("CY402_P") %></td>
                  <td><%= rs.getObject("CY403_P") %></td>
                  <td><%= rs.getObject("CY404_P") %></td>
                  <td><%= rs.getObject("CY405_P") %></td>
                  <td><%= rs.getObject("CY406_P") %></td>
                  <td><%= rs.getObject("SGPA") %></td>
                <td><%= rs.getObject("CGPA") %></td>
                <td><%= rs.getObject("Result_Desc") %></td>
                <% } 
                  else if (table.equals("finalCI2")) { %>
                  <td><%= rs.getObject("BT401_[T]") %></td>
                  <td><%= rs.getObject("CSIT402_[T]") %></td>
                  <td><%= rs.getObject("CSIT403_[T]") %></td>
                  <td><%= rs.getObject("CSIT404_[T]") %></td>
                  <td><%= rs.getObject("CSIT405_[T]") %></td>
                  <td><%= rs.getObject("CSIT402_[P]") %></td>
                  <td><%= rs.getObject("CSIT403_[P]") %></td>
                  <td><%= rs.getObject("CSIT404_[P]") %></td>
                  <td><%= rs.getObject("CSIT405_[P]") %></td>
                  <td><%= rs.getObject("CSIT406_[P]") %></td>
                  <td><%= rs.getObject("SGPA") %></td>
                <td><%= rs.getObject("CGPA") %></td>
                <td><%= rs.getObject("Result_Des") %></td>
                <% } else if (table.equals("CI15")) { %>
                <td><%= rs.getObject("Subject") %></td>
    <td><%= rs.getObject("CSIT501_T") %></td>
    <td><%= rs.getObject("CSIT502_T") %></td>
    <td><%= rs.getObject("CSIT503_T") %></td>
    <td><%= rs.getObject("CSIT504_T") %></td>
    <td><%= rs.getObject("BT407_P") %></td>
    <td><%= rs.getObject("CSIT501_P") %></td>
    <td><%= rs.getObject("CSIT502_P") %></td>
    <td><%= rs.getObject("CSIT505_P") %></td>
    <td><%= rs.getObject("CSIT506_P") %></td>
    <td><%= rs.getObject("CSIT508_P") %></td>
    <td><%= rs.getObject("SGPA") %></td>
    <td><%= rs.getObject("CGPA") %></td>
    <td><%= rs.getObject("ResultDesc") %></td>
  <% } else if (table.equals("CI25") ) { %>
    <td><%= rs.getObject("CSIT501_[T]") %></td>
    <td><%= rs.getObject("CSIT502_[T]") %></td>
    <td><%= rs.getObject("CSIT503_[T]") %></td>
    <td><%= rs.getObject("CSIT504_[T]") %></td>
    <td><%= rs.getObject("BT407_[P]") %></td>
    <td><%= rs.getObject("CSIT501_[P]") %></td>
    <td><%= rs.getObject("CSIT502_[P]") %></td>
    <td><%= rs.getObject("CSIT505_[P]") %></td>
    <td><%= rs.getObject("CSIT506_[P]") %></td>
    <td><%= rs.getObject("CSIT508_[P]") %></td>
    <td><%= rs.getObject("SGPA") %></td>
    <td><%= rs.getObject("CGPA") %></td>
    <td><%= rs.getObject("ResultDesc") %></td>
    <td><%= rs.getObject("Grace_or_No_Grace") %></td>
  <% }  %>
                <td><%= rs.getObject("Semester") %></td>
                <td><%= rs.getObject("Classname") %></td>
                <td><%= rs.getObject("Session") %></td>
              </tr>
              <% 
              } while (rs.next());
              %>
            </table>
<%
        } else {
            out.println("<p>  </p>");
        }
    }
} catch (Exception e) {
    out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
}
%>


</body>
</html>