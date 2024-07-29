$(document).ready(function () {
    console.log("this is remove product")
    $('.cancelCart').click(function (e) {
        e.preventDefault();
        let invoiceID = $(this).data('invoice-id');
        Swal.fire({
            text: "Bạn có muốn hủy đơn hàng đã chọn này?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            cancelButtonText: 'Trở lại',
            confirmButtonText: 'Có'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    type: 'POST', url: '/update-cart-product', data: {
                        invoiceID: invoiceID,

                    }, success: function (response) {
                        if (response == 'fail') {
                            Swal.fire({
                                icon: 'warning', title: 'Something wrong !', showConfirmButton: true
                            });
                        } else {

                            Swal.fire({
                                icon: 'success',
                                title: 'Thành công',
                                text: "Cập nhật đơn hàng thành công !",
                                showConfirmButton: false,
                                timer: 3500
                            });
                            $('.' + invoiceID).remove();
                        }
                    }, error: function (xhr, status, error) {
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

    $('.RestoreCart').click(function (e) {
        e.preventDefault();
        let invoiceID = $(this).data('invoice-id');

        Swal.fire({
            text: "Bạn có muốn khôi phục đơn hàng đã chọn này?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            cancelButtonText: 'Trở lại',
            confirmButtonText: 'Có'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    type: 'POST', url: '/update-cart-product-restore', data: {
                        invoiceID: invoiceID
                    }, success: function (response) {
                        if (response == 'fail') {
                            Swal.fire({
                                icon: 'warning', title: 'Đã có lỗi xảy ra!', showConfirmButton: true
                            });
                        } else {

                            Swal.fire({
                                icon: 'success',
                                title: 'Thành công',
                                text: "Cập nhật đơn hàng thành công!",
                                showConfirmButton: false,
                                timer: 3500
                            });
                            $('.' + invoiceID).remove();
                        }
                    }, error: function (xhr, status, error) {
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

    $('.detailCart').click(function () {
        var invoiceID = $(this).data('address-id');
        console.log("invoiceID: " + invoiceID)
        $.ajax({
            type: 'GET', url: '/detailCart/' + invoiceID, success: function (response) {
                var invoiceDetails = response;
                $("#myModal .modal-body").empty();
                let table = $("<table>").addClass("table table-striped").css("font-size", "16px");
                let headerRow = $("<tr>");
                $("<th>").text("Mã đơn hàng").appendTo(headerRow);
                $("<th>").text("Số lượng").appendTo(headerRow);
                $("<th>").text("Giá").appendTo(headerRow);
                $("<th>").text("Tổng tiền").appendTo(headerRow);
                table.append(headerRow);
                invoiceDetails.forEach(item => {
                    let row = $("<tr>");
                    $("<td>").text(item.id).appendTo(row);
                    $("<td>").text(item.quantity).appendTo(row);
                    let priceTotal = item.price.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'});
                    $("<td>").text(priceTotal).appendTo(row);
                    let total = item.quantity * item.price;
                    let formattedTotal = total.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'});
                    $("<td>").text(formattedTotal).appendTo(row);
                    table.append(row);
                });
                $("#myModal .modal-body").append(table);
                $("#myModal").modal("show");
                console.log(invoiceDetails)
            }, error: function (error) {
                console.log(error);
            }
        });
    });
})