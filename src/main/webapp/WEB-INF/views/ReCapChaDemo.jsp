<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>reCAPTCHA demo: Simple page</title>
    </head>
    <body>
        <form action="login/index" method="GET" id="form">
            <input type="text"/>
            <div id="recaptchaContainer" style="display: none;">
                <div class="g-recaptcha" data-sitekey="6LdosU4pAAAAAO_EzhGlRqWLJqns6eULivmzGWWE"></div>
            </div>
            <div id="error"></div>
            <br/>
            <input type="submit" value="Submit" id="submitButton">
        </form>

        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
        <script>
            window.onload = function () {
                let isValid = false;
                const form = document.getElementById("form");
                const error = document.getElementById("error");
                const recaptchaContainer = document.getElementById("recaptchaContainer");
                const submitButton = document.getElementById("submitButton");

                form.addEventListener("submit", function (event) {
                    event.preventDefault();
                    const response = grecaptcha.getResponse();
                    if (response) {
                        form.submit();
                    } else {
                        error.innerHTML = "<span style='color: red;'>Please check RECAPTCHA</span>";
                        recaptchaContainer.style.display = "block"; // Hiển thị reCAPTCHA khi có lỗi
                    }
                });

                submitButton.addEventListener("click", function () {
                    recaptchaContainer.style.display = "block"; // Hiển thị reCAPTCHA khi nút submit được nhấn
                });
            }
        </script>
    </body>
</html>
