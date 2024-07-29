$(document).ready(function() {
     $('select[name="selectedValue"]').change(function() {        
        var selectedValue = $(this).val();      
        
        var invoiceId = $(this).siblings('input[name="invoiceId"]').val();
        
        if(selectedValue=='Đã hủy'){
             
             Swal.fire({
                title: 'Xác nhận huỷ đơn hàng',
                text: 'Bạn có chắc muốn huỷ đơn hàng?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Đồng ý',
                cancelButtonText: 'Hủy bỏ'
            }).then((rs) => {
                
                if(rs.isConfirmed){
                     Swal.fire({
                        title: 'Nhập lý do huỷ đơn hàng',
                        input: 'text',
                        inputPlaceholder: 'Nhập lý do ở đây...',
                        showCancelButton: true,
                        confirmButtonText: 'Gửi',
                        cancelButtonText: 'Hủy bỏ',
                        showLoaderOnConfirm: true
                        }).then((reason) =>{
                            $.ajax({
                                url:'/admin/update-status-order',
                                method:'POST',
                                data:{
                                    selectedValue:selectedValue,
                                    invoiceId:invoiceId,
                                    reason:reason.value
                                },
                                 success: function(response) {
                                    console.log(response);
                                    Swal.fire('Thành công', 'Hủy đơn hàng thành công.', 'success');
                                    setTimeout(function() {
                                            location.reload();
                                        }, 3000);
                                  },
                                   error: function(xhr, status, error) {
                                    console.error(xhr.responseText);
                                    Swal.fire('Lỗi', 'Đã xảy ra lỗi khi hủy đơn hàng.', 'error');
                                  }                                
                            });
                        });                
                }
            
            });
            
        }else if(selectedValue=='Thành công'){
            Swal.fire({
                title: 'Xác nhận đơn hàng thành công',
                text: 'Bạn có chắc muốn cập nhật đơn hàng thành công?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Đồng ý',
                cancelButtonText: 'Hủy bỏ'
            }).then((rs) => {
                
                if(rs.isConfirmed){
                     Swal.fire({
                        title: 'Nhập ghi chú đơn hàng',
                        input: 'text',
                        inputPlaceholder: 'Nhập ghi chú ở đây...',
                        showCancelButton: true,
                        confirmButtonText: 'Gửi',
                        cancelButtonText: 'Hủy bỏ',
                        showLoaderOnConfirm: true
                        }).then((reason) =>{
                            $.ajax({
                                url:'/admin/update-status-order',
                                method:'POST',
                                data:{
                                    selectedValue:selectedValue,
                                    invoiceId:invoiceId,
                                    reason:reason.value
                                },
                                 success: function(response) {
                                    console.log(response);
                                    Swal.fire('Thành công', 'Xác nhận đơn hàng thành công.', 'success');
                                    setTimeout(function() {
                                            location.reload();
                                        }, 3000);
                                  },
                                   error: function(xhr, status, error) {
                                    console.error(xhr.responseText);
                                    Swal.fire('Lỗi', 'Đã xảy ra lỗi khi xác nhận đơn hàng.', 'error');
                                  }                                
                            });
                        });                
                }
            
            });
        }else {
            Swal.fire({
                   icon: 'warning',
                   title: 'Đơn hàng đang chờ xác nhận !',
                   showConfirmButton: false,
                   timer: 2000
                  });
        }
    });


});