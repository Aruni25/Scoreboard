package com.upload;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;


public class DeleteFileServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int fileId = Integer.parseInt(idParam);

                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/minor?useSSL=false", "root", "root");

               
                PreparedStatement deleteStmt = conn.prepareStatement("DELETE FROM uploaded_files WHERE id = ?");
                deleteStmt.setInt(1, fileId);
                deleteStmt.executeUpdate();

                
                Statement countStmt = conn.createStatement();
                ResultSet rs = countStmt.executeQuery("SELECT COUNT(*) FROM uploaded_files");

                if (rs.next() && rs.getInt(1) == 0) {
                    Statement resetStmt = conn.createStatement();
                    resetStmt.execute("ALTER TABLE uploaded_files AUTO_INCREMENT = 1");
                }

                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("ViewDBFilesServlet");
    }
}
