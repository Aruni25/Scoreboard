<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Individual Page</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Bodoni+Moda+SC:ital,opsz,wght@0,6..96,400..900;1,6..96,400..900&family=Luxurious+Roman&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="indivisual.css">
</head>
<body>
        <form action="individual1.jsp">

  <!-- Background Image Section -->
  <div class="background-image">
     <!--<img src="freepik__enhance__87284.png" alt="Background Image">--> 
  </div>

  <!-- Main Content Section -->
  <div class="heading-container">
    <h1 class="main-heading">Individual</h1>
  </div>
  
  <!--<form class="filter-container" action="processForm.jsp" method="POST">-->
    <div class="filter-panel">
      <div class="filter-content">
        <!-- Enrollment Number Section -->
        <label for="enrollmentNumber" class="filter-label">Enrollment Number</label>
        <input type="text" name="u1" id="s1"  class="text-input" aria-label="Enter Enrollment Number">

        <!-- Semester Section -->
        <div class="semester-wrapper">
          <label for="semester" class="filter-label">Semester</label>
          <select name="u2" id="s2"  class="dropdown-field" aria-label="Select Semester">
          <option value="null"></option>
            <% for (int i = 1; i <= 8; i++) { %>

              <option value="<%= i %>"><%= i %></option>
            <% } %>
          </select>
        </div>

        <!-- Branch Section -->
        <div class="branch-wrapper">
          <label for="branch" class="filter-label">Branch</label>
          <select name="u3" id="s3"  class="dropdown-field" aria-label="Select Branch">
              <option value="null"></option>

            <option value="CSIT-1">CSIT-1</option>
                        <option value="CSIT-2">CSIT-2</option>
            <option value="CY">CY</option>

            <!-- Additional branches can be added dynamically here -->
          </select>
        </div>

        <!-- Generate Button -->
        <button type="submit" class="generate-button" tabindex="0" target="_blank">Generate</button>
      </div>
    </div>
  </form>