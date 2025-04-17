<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/h.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Bodoni+Moda+SC:ital,opsz,wght@0,6..96,400..900;1,6..96,400..900&family=Luxurious+Roman&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Bodoni+Moda+SC:ital,opsz,wght@0,6..96,400..900;1,6..96,400..900&family=Kaisei+Tokumin&family=Luxurious+Roman&display=swap" rel="stylesheet">   
    <title>ScoreBoard</title>
</head>
<body>
    <div class="hero-container">
        <nav class="nav-wrapper">
            <div class="nav-links">
                <a href="<%= request.getContextPath() %>/h.jsp" class="nav-link nav-link-home">Home</a>
                <a href="upload.jsp" class="nav-link nav-link-Upload">Upload</a>

                <a href="#" class="nav-link nav-link-about">About Us</a>
                
                <a href="#" class="nav-link nav-link-contact">Contact Us</a>
            </div>
        </nav>
        <main class="content-wrapper">
            <div class="content-columns">
                <div class="text-column">
                    <div class="text-content">
                        <h1 class="hero-title">
                            ScoreBoard
                            <br />
                            <span class="title-emphasis">
                                We simplify the way you access and manage academic results.
                            </span>
                        </h1>
                        <p class="hero-description">
                            Whether you're a faculty member looking to oversee student performance or a student eager to view your own achievements, our platform provides a user-friendly, efficient solution tailored to your needs.
                        </p>
                    </div>
                </div>
                <div class="image-column">
                    <img
                        loading="lazy"
                        src="<%= request.getContextPath() %>/scoreboard-platform-interface.png"
                        class="hero-image"
                        alt="ScoreBoard platform interface demonstration"
                    />
                </div>
            </div>
        </main>
    </div>
    <div class="features-section">
        <h1 class="features-heading">Explore Features</h1>
        <div class="features-grid">
            <div class="feature-card">
                <img
                    src="<%= request.getContextPath() %>/individual-performance.png"
                    class="feature-image"
                    alt="Individual student performance analysis dashboard"
                />
                <h2 class="feature-title">Individual</h2>
                <p class="feature-description">
                    Access a student's academic performance instantly with consolidated data like grades, SGPA, CGPA, and subject-wise results. This feature provides an easy-to-navigate format for reviewing progress, with options for PDF downloads and performance insights for focused guidance.
                </p>
                <a href="<%= request.getContextPath() %>/individual.jsp"><button class="generate-btn" tabindex="0">Generate</button></a>
            </div>
        
            <div class="feature-card">
                <img
                    src="<%= request.getContextPath() %>/class-transformed.png"
                    class="feature-image" 
                    alt="Class-wide performance analysis visualization"
                />
                <h2 class="feature-title">Class</h2>
                <p class="feature-description">
                    Analyze class-wise performance trends with ease, including CGPA, SGPA, and subject-wise results. Summaries and detailed tables help identify strengths and weaknesses, enabling academic support and improved outcomes. Export options streamline result management.
                </p>
                <a href="<%= request.getContextPath() %>/class.jsp"><button class="generate-btn" tabindex="0">Generate</button></a>
            </div>
        
            <div class="feature-card">
                <img
                    src="<%= request.getContextPath() %>/custom-transformed.png"
                    class="feature-image"
                    alt="Custom report generation interface"
                />
                <h2 class="feature-title">Custom</h2>
                <p class="feature-description">
                    Customize results with advanced filters like CGPA ranges, subject-specific scores, or pass/fail status. Generate department-wide or semester-specific analyses, complete with summaries and graphs. Flexible sorting and export options make data analysis simple and efficient.
                </p>
                <a href="<%= request.getContextPath() %>/custom.jsp"><button class="generate-btn" tabindex="0">Generate</button></a>
            </div>
        </div>
    </div>
    <div class="about-section">
        <h1 class="section-title">About us</h1>
        <div class="icon-container-exact">
            <img src="<%= request.getContextPath() %>/house.PNG" alt="House Icon" class="icon-exact icon-house" />
            <div class="icon-center-container">
                <img src="<%= request.getContextPath() %>/search.PNG" alt="Search Icon" class="icon-exact icon-search" />
            </div>
            <img src="<%= request.getContextPath() %>/phone.PNG" alt="Phone Icon" class="icon-exact icon-phone" />
        </div>
    </div>

    <!-- White Section -->
    <div class="white-section">
        <p class="description">
            Our result analysis platform streamlines academic performance management with efficient tools for evaluating student results. Featuring individual reports, class-wide analysis, and customizable filters, we simplify complex data into actionable insights. With advanced visualization and a user-friendly interface, we empower educators to make informed decisions, improve outcomes, and support student success effectively.
        </p>
    </div>

    <!-- Thin Blue Line at the Bottom -->
    <div class="bottom-line"></div>
</body>
</html>
