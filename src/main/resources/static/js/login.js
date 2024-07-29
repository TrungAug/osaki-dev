$(document).ready(function () {
    console.log("this is login")
    $("#loginForm").submit(function (e) {
        e.preventDefault();

        var LGEmail = $("#LGemail").val();
        var LGPassword = $("#LGPassword").val();
        var chkRemember = $("#chkRemember").prop("checked");
        var formData = new FormData(this);
        formData.append("LGemail", LGEmail);
        formData.append("LGPassword", LGPassword);
        formData.append("chkRemember", chkRemember);

        $.ajax({
            type: "POST",
            url: "/post-login",
            data: {
                LGemail:LGEmail,
                LGPassword:LGPassword,
                chkRemember:chkRemember
            },
            success: function (response) {
                // Handle the success response here
                console.log(response);
                if (response.message === "success") {
                    Swal.fire({
                        title: 'Thành công', text: "Đăng nhập thành công", showConfirmButton: true, timer: 3500
                    }).then(function () {
                        if (response.role === "admin") {
                            window.location.href = '/admin';
                        } else {
                            // Redirect to the home page
                            var returnUrl = localStorage.getItem('returnUrl');
                            if (returnUrl) {
                                window.location.href = returnUrl;
                            } else {
                                window.location.href = '/'; // Change '/home' to the actual URL of your home page
                            }
                        }// Change '/home' to the actual URL of your home page
                    });
                    // Redirect or perform actions for successful login
                    console.log("Login successful");
                } else if (response.message === 'Chua nhap email' || response.message === 'Chua nhap password') {
                    console.log('error email')
                    if (response.message === 'Chua nhap email') {
                        showValidationErrorsEmail(response.message)
                    }
                    if (response.message === 'Chua nhap password') {
                        showValidationErrorsPassword(response.message)
                    }
                } else {
                    // Handle unsuccessful login
                    Swal.fire({
                        icon: 'error', title: 'Lỗi', text: "Đăng nhập không thành công", showConfirmButton: true, timer: 3500
                    }).then(function () {
                        // Redirect to the home page
                        window.location.href = '/login'; // Change '/home' to the actual URL of your home page
                    });
                    console.log("Login failed");
                }
            },
            error: function (error) {
                // Handle the error response here
                Swal.fire({
                    icon: 'error', title: 'Lỗi', text: "Có lỗi xảy ra", showConfirmButton: true, timer: 3500
                }).then(function () {
                    // Redirect to the home page
                    window.location.href = '/login'; // Change '/home' to the actual URL of your home page
                });
            }
        });
    });

    $('#submitForgotPassword').click(function (e) {
        e.preventDefault();

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
        let ForgotEmail = $('#ForgotEmail').val();
        console.log("forgotEmail: " + ForgotEmail);
        $.ajax({
            type: "POST",
            url: "/post-forgot-password",
            data: {
                email: ForgotEmail
            },
            success: function (response) {
                // Handle the success response here
                handleRegistrationResponse(response);
            },
            error: function (error) {
                // Handle the error response here
                Swal.fire({
                    icon: 'error', title: 'Lỗi', text: "Có lỗi xảy ra", showConfirmButton: true, timer: 3500
                }).then(function () {
                    // Redirect to the home page
                    window.location.href = '/login'; // Change '/home' to the actual URL of your home page
                });
            }
        });
    })

    function handleRegistrationResponse(response) {
        var json = JSON.parse(response);
        var verifyCode1 = json.verifyCode;
        var message = json.message
        var userID = json.userID
        console.log(verifyCode1)
        if (message === 'success') {
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
                        if (verificationCode === verifyCode1) {
                            console.log("thanh cong")
                            window.location.href = '/update-password/' + userID;

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
        } else if (response === 'fail') {
            Swal.fire({
                icon: 'error', title: 'Lỗi', text: "Có lỗi xảy ra", showConfirmButton: true, timer: 3500
            })
        } else if (message === 'errorEmail') {
            Swal.fire({
                icon: 'error', title: 'Lỗi', text: "Email không tồn tại", showConfirmButton: true, timer: 3500
            })

        }
    }
});

function showValidationErrorsEmail(errors) {
    // Clear previous error messages
    $('#emailLGError').html('');
    $('#passLGError').html('');
    // Display new error messages
    $('#emailLGError').html(errors);

}

function showValidationErrorsPassword(errors) {
    // Clear previous error messages
    $('#passLGError').html('');
    $('#emailLGError').html('');
    $('#passLGError').html(errors);
}
