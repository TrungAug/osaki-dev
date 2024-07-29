$(document).ready(function () {
    $('#addAddress').click(function (e) {
        e.preventDefault();

        var city = $('#city').val();
        var district = $('#district').val();
        var ward = $('#ward').val();

        var phone = $('#phone').val();
        var address = $('#addressSpecific').val()
        var cityName = findCityName(city);
        var districtName = findDistrictName(district)
        var wardName = findWardName(ward)

        console.log("phone: " + phone + " city: " + cityName + " district: " + districtName + " ward: " + wardName);
        let isLoggedIn = $(this).data('user-id') !== '';
        if (!isLoggedIn) {
            Swal.fire({
                icon: 'error',
                title: 'Lỗi...',
                text: 'Bạn cần đăng nhập để sử dụng chức năng này !',
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
                url: "/address",
                data: {
                    phone: phone,
                    city: cityName,
                    district: districtName,
                    ward: wardName,
                    address: address
                },
                success: function (response) {
                    // Handle the success response here
                    console.log(response);
                    var jsonReponse = JSON.parse(response);
                    if (jsonReponse.message === "success") {
                        var phoneID = jsonReponse.phoneID;
                        var address = jsonReponse.address;
                        var count = jsonReponse.count;
                        var userID = jsonReponse.userID;
                        if (jsonReponse.updateAddress === 'true') {
                            Swal.fire({
                                title: 'Thành công',
                                text: "Cập nhật địa chỉ thành công",
                                showConfirmButton: true,
                                timer: 3500
                            })
                            var tableHTML =
                                '                    \n' +
                                '                    <td>' + phoneID + '</td>\n' +
                                '                    <td>' + address + '</td>\n' +
                                '                   <td><a class="updateAddress " href="#" data-address-id="' + phoneID + '"\n' +
                                '                       data-user-id="' + userID + '"\n' +
                                '                >Cập nhật</a>\n' +
                                '                </td>\n' +
                                '                <td class="removeAddress " data-address-id="' + phoneID + '">Xóa</td>'

                            $('.'+phoneID).html(tableHTML);
                        } else {
                            Swal.fire({
                                title: 'Thành công',
                                text: "Thêm địa chỉ thành công",
                                showConfirmButton: true,
                                timer: 3500
                            })
                            var tableHTML = ' <tr class="' + phoneID + '">\n' +
                                '                    \n' +
                                '                    <td>' + phoneID + '</td>\n' +
                                '                    <td>' + address + '</td>\n' +
                                '                   <td><a class="updateAddress " href="#" data-address-id="' + phoneID + '"\n' +
                                '                       data-user-id="' + userID + '"\n' +
                                '                >Cập nhật</a>\n' +
                                '                </td>\n' +
                                '                <td class="removeAddress " data-address-id="' + phoneID + '">Xóa</td>' +
                                '                </tr>'
                            $('#tbAddress').append(tableHTML);
                            // Redirect or perform actions for successful login
                            $('.removeAddress').click(function (e) {
                                e.preventDefault();
                                let addressID = $(this).data('address-id');
                                console.log("likeProduct: " + addressID)
                                Swal.fire({
                                    text: "Bạn có muốn xóa địa chỉ đã chọn này?",
                                    icon: 'warning',
                                    showCancelButton: true,
                                    confirmButtonColor: '#3085d6',
                                    cancelButtonColor: '#d33',
                                    cancelButtonText: 'Trở lại',
                                    confirmButtonText: 'Có'
                                }).then((result) => {
                                    if (result.isConfirmed) {
                                        $.ajax({
                                            type: 'DELETE',
                                            url: '/delete-to-address',
                                            data: {
                                                phoneID: addressID,

                                            },
                                            success: function (response) {
                                                if (response == 'fail') {
                                                    Swal.fire({
                                                        icon: 'warning',
                                                        title: 'Something wrong !',
                                                        showConfirmButton: true
                                                    });
                                                } else {

                                                    Swal.fire({
                                                        icon: 'success',
                                                        title: 'Thành công',
                                                        text: "Xóa địa chỉ thành công !",
                                                        showConfirmButton: false,
                                                        timer: 3500
                                                    });
                                                    $('.' + addressID).remove();
                                                }
                                            },
                                            error: function (xhr, status, error) {
                                                Swal.fire({
                                                    icon: 'error',
                                                    title: 'Xóa sản phẩm thất bại',
                                                    text: "Có lỗi xảy ra, vui lòng thử lại !",
                                                    showConfirmButton: false,
                                                    timer: 2000
                                                });
                                            }
                                        });
                                    }
                                })
                            })
                            $('.updateAddress').click(function () {
                                var addressId = $(this).data('address-id');
                                $.ajax({
                                    type: 'GET',
                                    url: '/profile/' + addressId,
                                    success: function (response) {
                                        console.log("ok")
                                        var json = JSON.parse(response);
                                        var phoneID = json.phoneID
                                        var address = json.address
                                        var ward = json.ward;
                                        var district = json.district;
                                        var cityName = json.cityName;
                                        $('#myModal').modal('show');
                                        $('#city').find('option').filter(function () {
                                            return $(this).text() === cityName;
                                        }).prop('selected', true);

                                        $('#district').find('option').filter(function () {
                                            return $(this).text() === district;
                                        }).prop('selected', true);

                                        $('#ward').find('option').filter(function () {
                                            return $(this).text() === ward;
                                        }).prop('selected', true);
                                        $('#phone').val(phoneID);
                                        $('#addressSpecific').val(address);
                                        // Mở modal
                                    },
                                    error: function (error) {
                                        console.log(error);
                                    }
                                });
                            });
                        }
                    } else if (response === "errorPhone1") {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: "Số điện thoại đã tồn tại",
                            showConfirmButton: true,
                            timer: 3500
                        });
                    } else if (response === "errorAddress") {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: "Địa chỉ chưa nhập",
                            showConfirmButton: true,
                            timer: 3500
                        });
                    } else if (response === "errorPhone") {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: "Số điện thoại chưa nhập",
                            showConfirmButton: true,
                            timer: 3500
                        });
                    } else if (response === "errorCity") {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: "Tỉnh thành chưa nhập",
                            showConfirmButton: true,
                            timer: 3500
                        });
                    } else if (response === "errorDistrict") {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: "Quận huyện chưa nhập",
                            showConfirmButton: true,
                            timer: 3500
                        });
                    } else if (response === "errorWard") {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: "Phường xã chưa nhập",
                            showConfirmButton: true,
                            timer: 3500
                        });
                    } else {
                        // Handle unsuccessful login
                        Swal.fire({
                            icon: 'error',
                            title: 'Lỗi',
                            text: "Thêm địa chỉ không thành công",
                            showConfirmButton: true,
                            timer: 3500
                        }).then(function () {
                            // Redirect to the home page
                            window.location.href = '/'; // Change '/home' to the actual URL of your home page
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
                        window.location.href = '/'; // Change '/home' to the actual URL of your home page
                    });
                }
            });
        }
    })

    $('.updateAddress').click(function () {
        var addressId = $(this).data('address-id');
        $.ajax({
            type: 'GET',
            url: '/profile/' + addressId,
            success: function (response) {
                console.log("ok")
                var json = JSON.parse(response);
                var phoneID = json.phoneID
                var address = json.address
                var ward = json.ward;
                var district = json.district;
                var cityName = json.cityName;
                $('#myModal').modal('show');
                $('#city').find('option').filter(function () {
                    return $(this).text() === cityName;
                }).prop('selected', true);

                $('#district').find('option').filter(function () {
                    return $(this).text() === district;
                }).prop('selected', true);

                $('#ward').find('option').filter(function () {
                    return $(this).text() === ward;
                }).prop('selected', true);
                $('#phone').val(phoneID);
                $('#addressSpecific').val(address);
                // Mở modal
            },
            error: function (error) {
                console.log(error);
            }
        });
    });

    function findCityName(cityId) {
        var cityOptions = document.getElementById("city").options;
        for (var i = 0; i < cityOptions.length; i++) {
            if (cityOptions[i].value === cityId) {
                return cityOptions[i].text;
            }
        }
        return ""; // Trong trường hợp không tìm thấy
    }

    function findDistrictName(districtId) {
        var districtOptions = document.getElementById("district").options;
        for (var i = 0; i < districtOptions.length; i++) {
            if (districtOptions[i].value === districtId) {
                return districtOptions[i].text;
            }
        }
        return ""; // Trong trường hợp không tìm thấy

    }

    function findWardName(districtId) {
        var districtOptions = document.getElementById("ward").options;
        for (var i = 0; i < districtOptions.length; i++) {
            if (districtOptions[i].value === districtId) {
                return districtOptions[i].text;
            }
        }
        return "";
    }
})