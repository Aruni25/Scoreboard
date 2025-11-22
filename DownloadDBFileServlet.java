package com.upload;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


public class DownloadDBFileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String fileId = request.getParameter("id");
        if (fileId == null || fileId.trim().isEmpty()) {
    response.getWriter().println(" No file ID provided in the request.");
    return;
}


        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/minor?useSSL=false", "root", "root");
            String sql = "SELECT file_name, file_data FROM uploaded_files WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, fileId);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String fileName = rs.getString("file_name");
                Blob fileBlob = rs.getBlob("file_data");
                InputStream inputStream = fileBlob.getBinaryStream();

                response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

                OutputStream out = response.getOutputStream();
                byte[] buffer = new byte[4096];
                int bytesRead;

                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }

                inputStream.close();
                out.flush();
            } else {
                response.getWriter().println("File not found.");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error downloading file: " + e.getMessage());
        }
        
       


    }
}
