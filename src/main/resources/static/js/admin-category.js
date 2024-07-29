$(document).ready(function() {
    $('.add-new-category').click(function(event) {
        event.preventDefault(); 
        var formData = $('#add-category-form').serialize();
        $.ajax({
            url: '/admin/add-category',
            method: 'POST',
            data: formData,                
            dataType: 'json',
            success: function(data) {              
                if(data.status=='fail'){
                    Swal.fire({
                           icon: 'warning',
                           title: 'Vui lòng nhập tên danh mục !',
                           showConfirmButton: false,
                           timer: 2000
                        });
                }else if(data.status=='exist'){
                    Swal.fire({
                           icon: 'warning',
                           title: 'Tên danh mục đã tồn tại !',
                           showConfirmButton: false,
                           timer: 2000
                        });
                }else{
                    Swal.fire({
                       icon: 'success',
                       title: 'Thêm danh mục thành công !',
                       showConfirmButton: true,
                       confirmButtonText:'Làm mới'                      
                    }).then((result) =>{
                        if(result.isConfirmed){
                            location.reload();
                        }                    
                    });
                }
                
            },
            error: function(jqXHR, textStatus, errorThrown) {               
                console.error('Có lỗi:', errorThrown);
            }
        });
    });
});

$(document).ready(function (){
    $('.delete-category').click(function (e) {
        e.preventDefault();
        let deleteCategoryId = $(this).data('delete-id');
        Swal.fire({
            text: "Bạn có muốn xóa danh mục ?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            cancelButtonText: 'Trở lại',
            confirmButtonText: 'Có'
        }).then((rs) => {
            if(rs.isConfirmed){
                $.ajax({
                    type: 'GET',
                    url: '/admin/delete-category',
                    data: {
                        deleteCategoryId: deleteCategoryId
                    },
                    success: function(response) {                     
                       //console.log(response=='success');
                       if(response=='success'){
                            Swal.fire({
                               icon: 'success',
                               title: 'Xóa danh mục thành công !',
                               showConfirmButton: true,
                               confirmButtonText:'Làm mới'                      
                            }).then((result) =>{
                                if(result.isConfirmed){
                                    location.reload();
                                }                    
                            });
                        }else{
                            Swal.fire({
                               icon: 'warning',
                               title: 'Có lỗi !',
                               showConfirmButton: false,
                               timer: 2000
                            });
                        }
                    },
                    error: function(xhr, status, error) {
                        Swal.fire({
                               icon: 'warning',
                               title: 'Có lỗi, Kiểm tra lại nhé !',
                               showConfirmButton: false,
                               timer: 2000
                        });
                    }
                });
            }    
        });
        
    });
});


