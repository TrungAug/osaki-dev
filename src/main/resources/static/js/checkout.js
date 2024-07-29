$(document).ready(function () {
    $('#pay').click(function (e) {
        e.preventDefault();
        let isLoggedIn = $(this).data('user-id') !== '';
        // let phoneID = $('#address').val();
        var selectedOption = $("#address").find('option:selected');
        var phoneID = selectedOption.val();
        console.log("SDT: " + phoneID);
        var checkedValues = $("input[type='checkbox']:checked").map(function() {
            return $(this).val(); // Trả về giá trị của checkbox đã chọn
        }).get();

        // Hiển thị mảng giá trị đã lấy được
        console.log("Checked values: ", checkedValues);
        if (!isLoggedIn) {
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Bạn cần đăng nhập để sử dụng chức năng này!',
                confirmButtonColor: '#dc3545',
                confirmButtonText: 'Đăng nhập'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = '/login';
                }
            });
        } else {
            Swal.fire({
                title: 'Bạn có muốn đặt hàng không?',
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: 'Yes',
                cancelButtonText: 'No'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Nếu người dùng chọn Yes
                    $.ajax({
                        type: 'POST',
                        url: '/add-checkout',
                        data: {
                            checkedValues:JSON.stringify(checkedValues),
                            phoneID: phoneID
                        },
                        success: function (response) {
                            if (response == 'fail') {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Có lỗi xảy ra vui lòng thử lại !',
                                    showConfirmButton: true
                                });

                            } else if (response == 'failQuantity') {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Thanh toán thất bại !',
                                    text: 'Sản phẩm này đã hết hàng trong kho !',
                                    showConfirmButton: true
                                });

                            } else if (response == 'NotEnoughProducts') {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Thanh toán thất bại !',
                                    text: 'Không đủ sản phẩm để bán !',
                                    showConfirmButton: true
                                });

                            } else if (response == 'success') {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Đặt hàng thành công!',
                                    showConfirmButton: false,
                                    timer: 2500
                                });
                                $('.messageSuccessfully').html("<a href='/'>Tiếp tuc mua sắm</a>");
                                $('.checkout_').html("<h2>Đặt hàng thành công</h2>");
                                $('.header__cart-amount').html("0");
                                $('.order__list').html("<a href='/'>Tiếp tục mua sắm</a>");
                                //$('#out').html("");
                                checkedValues.forEach(function(value) {
                                    // Xóa class của các phần tử có giá trị là value
                                    $("." + value).remove();
                                });
                                $('.total-money').html("");

                            } else if (response == 'errorProduct') {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Oops...',
                                    text: 'Bạn cần mua sản phẩm để có thể thanh toán!',
                                    confirmButtonColor: '#dc3545',
                                    confirmButtonText: 'Tiếp tục mua sắm'
                                }).then((result) => {
                                    if (result.isConfirmed) {
                                        window.location.href = '/';
                                    }
                                });
                            } else if (response == 'failAddress') {
                                Swal.fire({
                                    icon: 'warning',
                                    title: 'Bạn cần thêm địa chỉ !',
                                    confirmButtonColor: '#dc3545',
                                    confirmButtonText: 'Thêm địa chỉ'
                                }).then((result) => {
                                    if (result.isConfirmed) {
                                        window.location.href = '/profile';
                                    }
                                });

                            }
                        },
                        error: function (xhr, status, error) {
                            Swal.fire({
                                icon: 'error',
                                title: 'Thanh toán thất bại',
                                text: "Có lỗi xảy ra, vui lòng thử lại !",
                                showConfirmButton: false,
                                timer: 1500
                            });
                        }
                    });
                    // Thực hiện các hành động cần thiết để đặt hàng
                } else {
                    // Người dùng chọn No hoặc nhấn nút đóng
                    // Có thể thực hiện các hành động khác ở đây nếu cần
                }
            });
        }

    })
    $('#vnpay').click(function (e) {
        e.preventDefault();
        let isLoggedIn = $(this).data('user-id') !== '';
        let phoneID = $('#address').val();

        console.log("phone: " + phoneID)
        if (!isLoggedIn) {
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Bạn cần đăng nhập để sử dụng chức năng này!',
                confirmButtonColor: '#dc3545',
                confirmButtonText: 'Đăng nhập'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = '/login';
                }
            });
        } else {
            Swal.fire({
                title: 'Bạn có muốn thanh toán không?',
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: 'Yes',
                cancelButtonText: 'No'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Nếu người dùng chọn Yes
                    $.ajax({
                        type: 'GET',
                        url: '/pay',
                        data: {
                            phoneID: phoneID
                        },
                        success: function (response) {
                            if (response == 'fail') {
                                Swal.fire({
                                    icon: 'warning',
                                    title: 'Something wrong !',
                                    showConfirmButton: true
                                });
                            } else if (response == 'failQuantity') {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Thanh toán thất bại !',
                                    text: 'Sản phẩm này đã hết hàng trong kho !',
                                    showConfirmButton: true
                                });

                            } else if (response == 'NotEnoughProducts') {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Thanh toán thất bại !',
                                    text: 'Không đủ sản phẩm để bán !',
                                    showConfirmButton: true
                                });

                            } else {
                                window.location.href = response;
                            }
                        },
                        error: function (xhr, status, error) {
                            Swal.fire({
                                icon: 'error',
                                title: 'Thanh toán thất bại',
                                text: "Có lỗi xảy ra, vui lòng thử lại !",
                                showConfirmButton: false,
                                timer: 1500
                            });
                        }
                    });
                    // Thực hiện các hành động cần thiết để đặt hàng
                } else {
                    // Người dùng chọn No hoặc nhấn nút đóng
                    // Có thể thực hiện các hành động khác ở đây nếu cần
                }
            });
        }
    })
    $('#vnpay1').click(function (e) {
        e.preventDefault();
        let isLoggedIn = $(this).data('user-id') !== '';
        let phoneID = $('#address').val();
        console.log("phone: " + phoneID)
        if (!isLoggedIn) {
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Bạn cần đăng nhập để sử dụng chức năng này!',
                confirmButtonColor: '#dc3545',
                confirmButtonText: 'Đăng nhập'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = '/login';
                }
            });
        } else {
            Swal.fire({
                title: 'Bạn có muốn thanh toán không?',
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: 'Yes',
                cancelButtonText: 'No'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Nếu người dùng chọn Yes
                    $.ajax({
                        type: 'GET',
                        url: '/pay',
                        data: {
                            phoneID: phoneID
                        },
                        success: function (response) {
                            window.location.href = response;
                        },
                        error: function (xhr, status, error) {
                            Swal.fire({
                                icon: 'error',
                                title: 'Thanh toán thất bại',
                                text: "Có lỗi xảy ra, vui lòng thử lại !",
                                showConfirmButton: false,
                                timer: 1500
                            });
                        }
                    });
                    // Thực hiện các hành động cần thiết để đặt hàng
                } else {
                    // Người dùng chọn No hoặc nhấn nút đóng
                    // Có thể thực hiện các hành động khác ở đây nếu cần
                }
            });
        }
    })
})