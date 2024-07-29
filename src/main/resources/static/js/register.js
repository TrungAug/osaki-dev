$(document).ready(function () {
    $(document).on("submit", "#formRegister", function (event) {
        event.preventDefault();

        const form = this;
        const recaptchaContainer = $("#recaptchaContainer");
        const error = $("#error");

        const response = grecaptcha.getResponse();
        console.log(response);

        if (response) {
            submitForm(form);
        } else {
            error.html("<span style='color: red;'>Please check reCAPTCHA</span>");
            recaptchaContainer.show();
        }
    });

    $(document).on("click", "#submitButton", function () {
        $("#recaptchaContainer").show();
    });

    function submitForm(form) {
        Swal.fire({
            title: 'Mã xác nhận đang được gửi. </br> Vui lòng chờ trong giây lát !',
            showConfirmButton: false,
            allowOutsideClick: false,
            allowEscapeKey: false,
            timerProgressBar: true,
            timer: 0,
            html: `<div class="loadingspinner">
                    <div id="square1"></div>
                    <div id="square2"></div>
                    <div id="square3"></div>
                    <div id="square4"></div>
                    <div id="square5"></div>
                </div>`,
            onBeforeOpen: () => {
                Swal.showLoading();
            }
        });
        let userid = generateRandomString();
        var data = new FormData(form);
        data.append('userId', userid);
        data.append('confirmPassword', $('#confirmPassword').val());
        $.ajax({
            type: "POST",
            url: '/account/register',
            processData: false,
            contentType: false,
            cache: false,
            data: data,
            success: function (response) {
                console.log(response);
                handleRegistrationResponse(response);
            },
            error: function (xhr, status, error) {
                Swal.fire({
                    icon: 'error',
                    title: 'Lỗi',
                    text: 'Đã có lỗi xảy ra',
                    showConfirmButton: true,
                    timer: 1500
                });// Truyền thông báo lỗi từ server
            }
        });
    }

    function handleRegistrationResponse(response) {
        var verifyCode = response.verifyCode;
        console.log(verifyCode)
        if (response.message === 'success') {
            Swal.fire({
                title: 'Xác thực tài khoản',
                html: `<form action="/verify-code" method="post">
                        <input type="text" id="verificationCode" name="confirmPassword1" class="swal2-input" placeholder="Nhập mã xác nhận email" />
                    </form>`,
                showCancelButton: true,
                confirmButtonText: 'Xác nhận',
                cancelButtonText: 'Hủy',
                showLoaderOnConfirm: true,
                preConfirm: function () {
                    return new Promise(function (resolve, reject) {
                        const verificationCode = $("#verificationCode").val();
                        console.log(verificationCode);
                        if (verificationCode === verifyCode) {
                            console.log("thanh cong")
                            $.ajax({
                                type: 'POST',
                                url: '/verify-code',
                                data: {
                                    userID: response.userID,
                                    fullName: response.fullName,
                                    verifyCode: response.verifyCode,
                                    password: response.password,
                                    email: response.email
                                },
                                success: function (response) {
                                    window.location.href = '/login';
                                    resolve();

                                },
                                error: function (error) {
                                    reject('Lỗi khi cập nhật trạng thái');
                                }
                            });
                        } else {
                            reject();
                            console.log("loi")
                            Swal.fire({
                                icon: 'error',
                                title: 'Lỗi',
                                text: "Xác nhận tài khoản không thành công",
                                showConfirmButton: true,
                                timer: 1500
                            }).then(function () {
                                // Redirect to the home page
                                window.location.href = '/register'; // Change '/home' to the actual URL of your home page
                            });
                        }
                    });
                },
                allowOutsideClick: false,
                allowEscapeKey: false,
            }).then(function (result) {
                if (result.isConfirmed) {
                    showSuccessMessage('Xác thực tài khoản thành công', 'Bạn đã xác thực tài khoản thành công!');
                }
            });
        } else if (response.message === 'fail') {
            showErrorMessage('Có lỗi xảy ra!');
        } else {
            showValidationErrors(response);
        }
    }


    function showErrorMessage(message) {
        Swal.fire({
            icon: 'error',
            title: 'Lỗi',
            text: message,
            showConfirmButton: true,
            timer: 1500
        });
    }

    function showValidationErrors(errors) {
        Swal.close();
        // Clear previous error messages
        $('#fullNameError').html('');
        $('#emailError').html('');
        $('#passwordError').html('');
        $('#confirmPasswordError').html('');

        // Display new error messages
        $('#fullNameError').html(errors.fullName);
        $('#emailError').html(errors.email);
        $('#passwordError').html(errors.password);

        if (errors.password === undefined) {
            $('#confirmPasswordError').html(errors.confirmPassword);
        } else {
            $('#confirmPasswordError').html('');
        }
    }

    function showSuccessMessage(title, text) {
        Swal.fire({
            icon: 'success',
            title: title,
            text: text,
            timer: 1500,
            timerProgressBar: true
        });
    }

    function generateRandomString() {
        var randomString = '';
        var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        var charactersLength = characters.length;
        for (var i = 0; i < 8; i++) {
            randomString += characters.charAt(Math.floor(Math.random() * charactersLength));
        }

        var currentTimeMillis = new Date().getTime();
        var finalString = randomString + currentTimeMillis.toString();

        return finalString;
    }
});
