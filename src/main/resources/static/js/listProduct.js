$(document).ready(function () {

    $('#btn-primary-promotional').click(function (e) {
        e.preventDefault(); // Ngăn chặn hành động mặc định của nút submit

        var minPromotionalString =$('input[name="minPromotional"]').val(); // Lấy giá trị minPrice từ input
        var minPromotional = parseInt(minPromotionalString.replace(/,/g, ''));
        var maxPromotionaleString = $('input[name="maxPromotional"]').val(); // Lấy giá trị maxPrice từ input
        var maxPromotional = parseInt(maxPromotionaleString.replace(/,/g, '')); // Lấy giá trị maxPrice từ input
        console.log("min: "+ minPromotional+"max: "+ maxPromotional)
                $('.product').each(function () {
                    var productPromotional = parseFloat($(this).find('.product__sale-percent').text().replace(/\./g, '')) * -1;// Lấy giá sản phẩm
                    console.log(parseFloat(productPromotional))
                    if (productPromotional >= minPromotional && productPromotional <= maxPromotional) {
                        console.log(1)
                        $(this).parent('.col-lg-3').show(); // Hiển thị sản phẩm nếu nằm trong khoảng giá
                    } else {
                        $(this).parent('.col-lg-3').hide(); // Ẩn sản phẩm nếu không nằm trong khoảng giá
                    }
                });
                updatePagination();
        });



    $('#btn-primary').click(function (e) {
        e.preventDefault(); // Ngăn chặn hành động mặc định của nút submit

        var minPriceString =$('input[name="minPrice"]').val(); // Lấy giá trị minPrice từ input
        var minPrice = parseInt(minPriceString.replace(/,/g, ''));
        var maxPriceString = $('input[name="maxPrice"]').val(); // Lấy giá trị maxPrice từ input
        var maxPrice = parseInt(maxPriceString.replace(/,/g, '')); // Lấy giá trị maxPrice từ input
        console.log("min: "+ minPrice+"max: "+ maxPrice)
        $.ajax({
            type: 'GET',
            url: '/product/filterByPrice',
            success: function (response) {
                $('.product').each(function () {
                    var productPrice = parseFloat($(this).find('.price').text().replace(/\./g, ''));// Lấy giá sản phẩm
                    console.log(parseFloat(productPrice))
                    if (productPrice >= minPrice && productPrice <= maxPrice) {
                        console.log(1)
                        $(this).parent('.col-lg-3').show(); // Hiển thị sản phẩm nếu nằm trong khoảng giá
                    } else {
                        $(this).parent('.col-lg-3').hide(); // Ẩn sản phẩm nếu không nằm trong khoảng giá
                    }
                });
                updatePagination();
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
    });


    // Sự kiện thay đổi checkbox category hoặc brand
    $('.category-checkbox').change(function () {
        var selectedCategories = [];

        // Lấy danh sách các category được chọn
        $('.category-checkbox:checked').each(function () {
            selectedCategories.push($(this).val());
        });
        $.ajax({
            type: 'GET',
            url: '/product/search-all-category',
            success: function (response) {

                $('.product').each(function () {
                    var productCategory = $(this).find('.category').text();
                    if (selectedCategories.includes(productCategory)) {
                        $(this).parent('.col-lg-3').show(); // Hiển thị sản phẩm
                    } else {
                        $(this).parent('.col-lg-3').hide(); // Ẩn sản phẩm
                    }
                });
                updatePagination();
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
        // Hiển thị hoặc ẩn sản phẩm tùy thuộc vào category được chọn
    });

    function updatePagination() {
        // Ẩn tất cả các nút phân trang
        $('.pagination__item').hide();

        // Hiển thị các nút phân trang cho trang hiện tại
        var currentPage = parseInt('${productPage.number}');
        var totalPages = parseInt('${productPage.totalPages}');
        var maxPagesToShow = 5; // Số lượng nút phân trang tối đa muốn hiển thị
        var startPage = Math.max(0, currentPage - Math.floor(maxPagesToShow / 2));
        var endPage = Math.min(totalPages - 1, startPage + maxPagesToShow - 1);

        for (var i = startPage; i <= endPage; i++) {
            $('.pagination__item').eq(i).show();
        }

        // Hiển thị nút Previous nếu không phải trang đầu tiên
        if (currentPage > 0) {
            $('.pagination__item').first().show();
        }

        // Hiển thị nút Next nếu không phải trang cuối cùng
        if (currentPage < totalPages - 1) {
            $('.pagination__item').last().show();
        }
    }
});
