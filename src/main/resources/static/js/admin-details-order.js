$(document).ready(function() {
    $(".open-detail-order").click(function(){
       var invoiceID = $(this).data('invoice-id');
       //console.log("Giá trị của thẻ <a> khi click: " + invoiceID);
       
       $.ajax({
           url:'/admin/order-details',
           method:'POST',
           data:{
                invoiceID:invoiceID,                                    
           },
           success: function(response) {
                console.log("response " +response);
                console.log("typeof response " + typeof response);
                
                var modalBodyHtml = '';
                response.forEach(function(object) {
                   var formattedPrice = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(object.price);
                   var rowHtml = '<tr>' +
                                    '<td><img src="../imagesProduct/' + object.imageProduct + '" class="img-thumbnail" title="Ảnh sản phẩm" style="width: 50px;height: 50px"></td>' +
                                    '<td>' + object.nameProduct + '</td>' +
                                    '<td>' + object.quantity + '</td>' +
                                    '<td>' + formattedPrice + '</td>' +
                                    '</tr>';
                                       
                   modalBodyHtml += rowHtml;
                
                });
                
                $('.modal-body table tbody').html(modalBodyHtml);
                
                // Hiển thị modal
                $('#oderDetailModal').modal('show');
                
                 
            },                                         
       });
       
    });

});