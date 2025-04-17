<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invalid Unique Code</title>
    <style>
        body {
            background-color: rgb(106, 179, 219);
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 50px;
        }
        .error-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            display: inline-block;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
        }
        h2 {
            color: red;
        }
        p {
            font-size: 18px;
            color: #333;
        }
        a {
            display: inline-block;
            padding: 10px 20px;
            background-color: red;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 10px;
        }
        a:hover {
            background-color: darkred;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h2>Invalid Unique Code</h2>
        <p>The unique code you entered is incorrect.</p>
        <p>Please make sure you are using the correct code provided by the admin.</p>
        <a href="login.jsp">Go Back to Login</a>
    </div>
</body>
</html>
