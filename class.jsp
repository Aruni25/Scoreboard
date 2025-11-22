<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<%
      

    
    String assignedClass = (String) session.getAttribute("assignedClass");
    String teacherUsername = (String) session.getAttribute("teacherUsername");

    if (assignedClass == null || teacherUsername == null) {
        out.println("<p style='color:red;'>❌ Session attributes missing. Redirecting to login...</p>");
        response.sendRedirect("login.jsp?error=Unauthorized access");
        return;
    }
%>

%>

%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Class Page</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/class.css">

  <script type="text/javascript">
    function validateForm() {
      var className = document.getElementById("className").value.trim();
      var semester = document.getElementById("semester").value.trim();
      var session = document.getElementById("session").value.trim();

      if (!className || !semester || !session) {
        alert("Please provide all required inputs: Class Name, Semester, and Session.");
        return false; 
      }

      return true; 
    }
  </script>
</head>
<body>
  
  <form action="class1.jsp" method="post" onsubmit="return validateForm()">

    <div class="background-image">
      <%-- <img src="<%= request.getContextPath() %>/images/background.png" alt="Background Image"> --%>
    </div>

    <div class="heading-container">
      <h1 class="main-heading">Class</h1>
    </div>

    <div class="filter-panel">
      <div class="filter-content">
        <label for="className" class="filter-label">Class Name</label>
        <input 
          type="text" 
          id="className" 
          name="className" 
          class="text-input" 
          value="<%= assignedClass %>"  
  readonly>
          required>
        
        <div class="semester-wrapper">
          <label for="semester" class="filter-label">Semester</label>
          <select 
            id="semester" 
            name="semester" 
            class="dropdown-field" 
            required>
            <option value="" disabled selected>Select Semester</option>
            <c:forEach var="i" begin="1" end="8">
              <option value="${i}">${i}</option>
            </c:forEach>
          </select>
        </div>

        <div class="session-wrapper">
          <label for="session" class="filter-label">Session</label>
          <input 
            type="text" 
            id="session" 
            name="session" 
            class="text-input" 
            required>
        </div>

        <button 
          type="submit" 
          class="generate-button" 
          tabindex="0" 
          aria-label="Click to generate report">
          Generate
        </button>
      </div>
    </div>
  </form>
</body>
</html>




