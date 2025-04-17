package com.upload;

import java.io.*;
import java.nio.file.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024)
public class UploadExcelServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "C:\\Users\\LENOVO\\Desktop\\uploads";

    // ✅ Handle GET request with error
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported.");
    }

    // ✅ Handle POST request (file upload)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        File uploadDir = new File(UPLOAD_DIR);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        Part filePart = request.getPart("excelFile");
        String fileName = getFileName(filePart);

        out.println("<!DOCTYPE html>");
        out.println("<html><head><meta charset='UTF-8'><title>Upload Status</title>");
        out.println("<style>");
        out.println("body { background: #e3f2fd; font-family: 'Segoe UI', sans-serif; margin: 0; padding: 0; }");
        out.println(".container { display: flex; justify-content: center; align-items: center; height: 100vh; }");
        out.println(".status-card { background: #ffffff; padding: 40px; border-radius: 15px; box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1); text-align: center; max-width: 500px; }");
        out.println(".status-card h1 { color: #1976d2; font-size: 28px; margin-bottom: 20px; }");
        out.println(".status-card p { font-size: 18px; color: #333; margin-bottom: 30px; }");
        out.println(".button { background: #1976d2; color: white; padding: 12px 25px; border: none; border-radius: 8px; text-decoration: none; font-size: 16px; transition: background 0.3s; margin-right: 10px; }");
        out.println(".button:hover { background: #1565c0; }");
        out.println("</style></head><body><div class='container'><div class='status-card'>");

        if (fileName != null && fileName.endsWith(".xlsx")) {
            File file = new File(uploadDir, fileName);
            try (InputStream fileContent = filePart.getInputStream()) {

                Files.copy(fileContent, file.toPath(), StandardCopyOption.REPLACE_EXISTING);

                try (InputStream dbStream = filePart.getInputStream()) {
                    storeFileInDatabase(fileName, dbStream);
                }

                out.println("<h1>✅ Upload Successful</h1>");
                out.println("<p>Your Excel file <strong>" + fileName + "</strong> has been uploaded and stored.</p>");
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<h1 style='color: #d32f2f;'>❌ Upload Failed</h1>");
                out.println("<p>Error uploading file: " + e.getMessage() + "</p>");
            }
        } else {
            out.println("<h1 style='color: #d32f2f;'>⚠️ Invalid File Type</h1>");
            out.println("<p>Please upload a valid <strong>.xlsx</strong> file only.</p>");
        }

        out.println("<a href='upload.jsp' class='button'>Upload Another File</a>");
        out.println("<a href='h.jsp' class='button'>Go to Homepage</a>");

        out.println("</div></div></body></html>");
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String token : contentDisp.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    private void storeFileInDatabase(String fileName, InputStream inputStream) throws Exception {
        String dbURL = "jdbc:mysql://localhost:3306/minor?useSSL=false";
        String dbUser = "root";
        String dbPass = "root";

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
        String sql = "INSERT INTO uploaded_files (file_name, file_data) VALUES (?, ?)";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setString(1, fileName);
        statement.setBlob(2, inputStream);
        statement.executeUpdate();
        conn.close();
    }
}
