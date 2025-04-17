<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <title>Excel Data Viewer</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f4f4f4; padding: 20px; }
        table { border-collapse: collapse; width: 90%; margin: auto; background: #fff; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: left; }
        th { background: #1976d2; color: #fff; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        .center { text-align: center; margin-top: 40px; }
    </style>
</head>
<body>
<% 
    List<List<String>> excelData = (List<List<String>>) request.getAttribute("excelData"); 
    if (excelData == null || excelData.isEmpty()) {
%>
    <h2 class="center">⚠️ No data found or failed to read file.</h2>
<% } else { %>
    <table>
        <% for (int i = 0; i < excelData.size(); i++) { 
            List<String> row = excelData.get(i);
            out.println("<tr>");
            for (String cell : row) {
                if (i == 0) {
                    out.println("<th>" + cell + "</th>");
                } else {
                    out.println("<td>" + cell + "</td>");
                }
            }
            out.println("</tr>");
        } %>
    </table>
<% } %>
</body>
</html>
