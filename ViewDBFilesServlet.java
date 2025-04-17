package com.upload;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


public class ViewDBFilesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<html><head><title>Uploaded Files</title>");
        out.println("<style>");
        out.println("body { background: #e3f2fd; font-family: 'Segoe UI'; padding: 30px; }");
        out.println("table { width: 80%; margin: auto; border-collapse: collapse; }");
        out.println("th, td { padding: 12px; border-bottom: 1px solid #ccc; text-align: center; }");
        out.println("th { background: #1976d2; color: white; }");
        out.println("a.view { color: #388e3c; text-decoration: none; font-weight: bold; margin-right: 10px; }");
        out.println("a.download { color: #1976d2; text-decoration: none; font-weight: bold; }");
        out.println("a.delete {color: red; text-decoration: none; font-weight: bold;}");
        out.println("</style></head><body>");
        out.println("<h2 style='text-align:center;'> Uploaded Excel Files</h2>");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/minor?useSSL=false", "root", "root");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT id, file_name, upload_time FROM uploaded_files");

            out.println("<table>");
            out.println("<tr><th>ID</th><th>File Name</th><th>Uploaded Time</th><th>Actions</th></tr>");
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("file_name");
                Timestamp time = rs.getTimestamp("upload_time");

                out.println("<tr>");
                out.println("<td>" + id + "</td>");
                out.println("<td>" + name + "</td>");
                out.println("<td>" + time + "</td>");
out.println("<td><a class='view' href='ViewExcelContentServlet?id=" + id + "'>View</a> |");

               

                out.println("<a class='download' href='DownloadDBFileServlet?id=" + id + "'>Download |</a>");
                out.println("<a class='delete' href='DeleteFileServlet?id=" + id + "'>Delete</a></td>");
                out.println("</tr>");
            }
            out.println("</table>");
            conn.close();
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }

        out.println("</body></html>");
    }
}

