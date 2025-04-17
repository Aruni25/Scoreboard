package com.upload;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class ViewExcelFromDBServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fileName = request.getParameter("file");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if (fileName == null || fileName.isEmpty()) {
            out.println("<h3> File name not provided.</h3>");
            return;
        }

        try {
            // Connect to database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/minor?useSSL=false", "root", "root");

            String sql = "SELECT file_data FROM uploaded_files WHERE file_name = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, fileName);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                InputStream inputStream = rs.getBinaryStream("file_data");

                // Read Excel using Apache POI
                Workbook workbook = new XSSFWorkbook(inputStream);
                Sheet sheet = workbook.getSheetAt(0);

                out.println("<html><head><title>Excel Preview</title>");
                out.println("<style>table { border-collapse: collapse; margin: auto; } th, td { border: 1px solid #ccc; padding: 8px; }</style>");
                out.println("</head><body><h2 style='text-align:center;'>Contents of " + fileName + "</h2><table>");

                for (Row row : sheet) {
                    out.println("<tr>");
                    for (Cell cell : row) {
                        String value = getCellValue(cell);
                        out.println("<td>" + value + "</td>");
                    }
                    out.println("</tr>");
                }

                out.println("</table></body></html>");
                workbook.close();
                inputStream.close();

            } else {
                out.println("<h3>❌ File not found in database.</h3>");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }

    private String getCellValue(Cell cell) {
        switch (cell.getCellType()) {
            case STRING: return cell.getStringCellValue();
            case NUMERIC: return String.valueOf(cell.getNumericCellValue());
            case BOOLEAN: return String.valueOf(cell.getBooleanCellValue());
            case FORMULA: return cell.getCellFormula();
            default: return "";
        }
    }
}
