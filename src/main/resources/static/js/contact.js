$(document).ready(function () {
    console.log("this is sendMessage")
    $('#sendMessage').click(function (e) {
        e.preventDefault();
        let fullName = $('#fullname').val();
        let email = $('#email').val();
        let message = $('#message').val();
        let isLoggedIn = $(this).data('user-id') !== '';
        let userID = $(this).data('user-id')
        console.log(isLoggedIn)
        if (!isLoggedIn) {
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Bạn cần đăng nhập để thực hiện chức năng này!',
                confirmButtonColor: '#dc3545',
                confirmButtonText: 'Đăng nhập'
            }).then((result) => {
                if (result.isConfirmed) {
                    localStorage.removeItem('returnUrl');
                    localStorage.setItem('returnUrl', window.location.href);
                    window.location.href = '/login';
                }
            });
        } else {
            $.ajax({
                type: "POST",
                url: "/post-contact",
                data: {
                    fullName: fullName,
                    email: email,
                    userID: userID,
                    message: message
                },
                success: function (response) {
                    if (response == 'success') {
                        $("#message").val("");
                        Swal.fire({
                            title: 'Thành công', text: "Liên hệ thông tin thành công", showConfirmButton: true, timer: 3500
                        })
                    } else {
                        Swal.fire({
                            icon: 'error', title: 'Lỗi', text: "Có lỗi xảy ra", showConfirmButton: true, timer: 3500
                        })
                    }

                },
                error: function (error) {
                    // Handle the error response here
                    Swal.fire({
                        icon: 'error', title: 'Lỗi', text: "Có lỗi xảy ra", showConfirmButton: true, timer: 3500
                    }).then(function () {
                        // Redirect to the home page
                        // Change '/home' to the actual URL of your home page
                    });
                }
            });
        }
    })
})