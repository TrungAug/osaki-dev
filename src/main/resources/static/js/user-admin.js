$(document).ready(function (){
    $('.open-invoice-modal').click(function (e) {
        e.preventDefault();
        let userId = $(this).data('user-id');

        // Gửi yêu cầu Ajax đến endpoint '/admin/list-invoice-by-user'
        $.ajax({
            type: 'GET',
            url: '/admin/list-invoice-by-user',
            data: {
                userId: userId
            },
            success: function(response) {
                // Cập nhật nội dung của modal với dữ liệu hóa đơn
                $('#listInvoiceByUserModal .modal-body').html(response);

                // Hiển thị modal
                $('#listInvoiceByUserModal').modal('show');
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
            }
        });
    });
});