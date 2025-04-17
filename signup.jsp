<!DOCTYPE html>
<html>

<head>
    <title>SignUp Form</title>
    <link rel="stylesheet" href="csignup.css">
    <script type="text/javascript">
        function Username() {
            var x = document.getElementById("t1").value;
            if (x.length < 3) {
                document.getElementById("s1").innerHTML = "Invalid name";
                return false;
            }
            document.getElementById("s1").innerHTML = "";
            return true;
        }

        function Password() {
            var x = document.getElementById("t2").value;
            var regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
            if (!regex.test(x)) {
                document.getElementById("s2").innerHTML = "Password must be at least 8 characters long, contain lowercase, uppercase, digit, and special character";
                return false;
            }
            document.getElementById("s2").innerHTML = "";
            return true;
        }

        function demo() {
            var isValid = true;
            document.getElementById("s1").innerHTML = "";
            document.getElementById("s2").innerHTML = "";

            if (!Username()) {
                isValid = false;
            }
            if (!Password()) {
                isValid = false;
            }

            return isValid;
        }
    </script>
</head>

<body>
    <form action="signup1.jsp" method="post" name="form1" onsubmit="return demo()">
        <div class="signup-container">
            <div class="content-wrapper">
                <div class="form-column">
                    <div class="signup-heading">Sign Up</div>
                    <div class="signup-wrapper">
                        <div class="form-group">
                            <label for="username">Username</label>
                            <input id="t1" name="u1" type="text" class="form-input" required aria-label="Username">
                            <span id="s1" class="error-message"></span>
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input id="t2" name="u2" type="password" class="form-input" required aria-label="Password">
                            <span id="s2" class="error-message"></span>
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input id="t3" name="u3" type="email" class="form-input" required aria-label="Email">
                        </div>
                        
                        <div class="form-group">
                            <label for="branch">Branch</label>
                            <input id="t4" name="u4" type="branch" class="form-input" required aria-label="Branch">
                        </div>
                        
                        <button type="submit" class="submit-button">Sign Up</button>
                    </div>
                </div>
                <div class="image-column"></div>
            </div>
        </div>
    </form>
</body>

</html>
