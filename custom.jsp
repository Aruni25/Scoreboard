<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Custom Page</title>
  <link rel="stylesheet" href="custom.css">
</head>
<body>
  <div class="wrapper">
    <form action="custom1.jsp">
      <div class="background-image background-adjust">
      </div>

      <div class="heading-container">
        <h1 class="main-heading">Custom</h1>
      </div>
      
 <div class="filter-container">
  <div class="filter-panel">
    <div class="filter-content">
      <label for="className" class="filter-label">Class Name</label>
      <input type="text" id="className" class="text-input" name="className">

      <label for="semester" class="filter-label">Semester</label>
      <select id="semester" class="dropdown-field" name="semester">
        <c:forEach var="i" begin="1" end="8">
          <option value="${i}">${i}</option>
        </c:forEach>
      </select>

     <label for="session" class="filter-label">Session (e.g., 2022-2026)</label>
            <input type="text" id="session" name="session" class="text-input" placeholder="e.g., 2022-2026">

      <button type="submit" class="generate-button" target="_blank">Generate</button>
    </div>
  </div>
</div>
    </form>

    

    <div class="center-text error-message">
      <% if ( false) { %>
        No results found. Please adjust your filters and try again.
      <% } %>
    </div>
  </div>
</body>
</html>
