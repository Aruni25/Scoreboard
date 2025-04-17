<!DOCTYPE html>
<html>

<head>
    <title>Login Form</title>
    <link rel="stylesheet" href="clogin.css">
    <script type="text/javascript">
        function validateForm() {
            var username = document.getElementById("t1").value;
            var password = document.getElementById("t2").value;
            var usernameValid = username.length >= 3;
            var passwordValid = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/.test(password);

            if (!usernameValid || !passwordValid) {
                var message = "Please correct the following errors:\\n";
                if (!usernameValid) {
                    message += "- Username must be at least 3 characters long.\\n";
                }
                if (!passwordValid) {
                    message += "- Password must be at least 8 characters long and include at least one lowercase letter, one uppercase letter, one digit, and one special character.";
                }
                alert(message);
                return false; 
            }
            return true; 
        }
    </script>
</head>

<body>
    <form action="login11.jsp" method="post" onsubmit="return validateForm()">
        <%
            String errorMessage = request.getParameter("error");
            if (errorMessage != null) {
        %>
            <p style="color: red;"><%= errorMessage %></p>
        <% } %>
        <div class="login-container">
            <div class="content-wrapper">
                <div class="image-column"></div>
                <div class="form-column">
                    <div class="login-wrapper">
                        <h1 class="login-title">Log-In</h1>
                        
                        <input type="text" id="t1" name="u1" class="input-field" placeholder="Username" aria-label="Username">
                        <input type="password" id="t2" name="u2" class="input-field" placeholder="Password" aria-label="Password">
                        
                        <div class="form-group">
                            <input id="t4" name="u3" type="text" class="form-input" placeholder="Unique Code" required aria-label="Unique Code">
                        </div>
<input id="t5" name="classInput" type="text" class="form-input" placeholder="Enter Class(es) (e.g., CSIT-1, CSIT-2)">

                        <button type="submit" class="login-button">Login</button>
                        <div class="create-account">
                            <p>Create an account? <a href="signup.jsp">Sign Up</a></p>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </form>
</body>

</html>
