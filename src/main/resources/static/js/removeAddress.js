$(document).ready(function () {
    console.log("this is remove product")
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
})