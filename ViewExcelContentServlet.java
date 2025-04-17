package com.upload;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;
//import myapp.shaded.commons.io.input.BoundedInputStream;


public class ViewExcelContentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("XYZ");
        String idParam = request.getParameter("id");
        List<List<String>> excelData = new ArrayList<>();
          int fileId = -1;
        System.out.println("Requested file ID: " + fileId);
System.out.println("Data rows found: " + excelData.size());

        if (idParam == null || idParam.trim().isEmpty()) {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<h3 style='color:red; text-align:center;'> File ID not provided in URL. Please go back and select a file to view.</h3>");
            return;
        }

     

        try {
            fileId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<h3 style='color:red; text-align:center;'>Invalid file ID provided.</h3>");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/minor?useSSL=false", "root", "root");

           
           // PreparedStatement stmt = conn.prepareStatement("SELECT file_data FROM uploaded_files WHERE id = ?");
           PreparedStatement stmt = conn.prepareStatement("SELECT file_data FROM uploaded_files WHERE id = ?");
stmt.setInt(1, fileId);

            
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                InputStream is = rs.getBlob("file_data").getBinaryStream();
                Workbook workbook = new XSSFWorkbook(is);
                Sheet sheet = workbook.getSheetAt(0);

                for (Row row : sheet) {
                    List<String> rowData = new ArrayList<>();
                    for (Cell cell : row) {
                        rowData.add(getCellValue(cell));
                    }
                    excelData.add(rowData);
                }

                workbook.close();
                is.close();
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("excelData", excelData);
        RequestDispatcher dispatcher = request.getRequestDispatcher("viewExcel.jsp");
        dispatcher.forward(request, response);
    }

//@Override
//public void init() throws ServletException {
//    System.out.println("=== CLASSLOADER VERIFICATION ===");
//    System.out.println("BoundedInputStream loaded from: " +
//        myapp.shaded.commons.io.input.BoundedInputStream.class  // CHANGED
//            .getProtectionDomain()
//            .getCodeSource()
//            .getLocation());
//    
//    // Add this test
//    try {
//        Class.forName("myapp.shaded.commons.io.input.BoundedInputStream");
//        System.out.println("✅ Successfully loaded relocated BoundedInputStream");
//    } catch (ClassNotFoundException e) {
//        System.out.println("❌ Failed to load relocated BoundedInputStream");
//        e.printStackTrace();
//    }
//}
     
    private String getCellValue(Cell cell) {
        if (cell == null) return "";
        switch (cell.getCellType()) {
            case STRING: return cell.getStringCellValue();
            case NUMERIC: return String.valueOf(cell.getNumericCellValue());
            case BOOLEAN: return String.valueOf(cell.getBooleanCellValue());
            case FORMULA: return cell.getCellFormula();
            case BLANK: return "";
            default: return "Unsupported Cell";
        }
    }
}
