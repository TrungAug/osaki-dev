$(document).ready(function () {
    $('.siteLikeProduct').click(function (e) {
        e.preventDefault();
        let productId = $(this).data('product-id');
        let isLoggedIn = $(this).data('user-id') !== '';
        console.log(productId)
        if (!isLoggedIn) {
            Swal.fire({
                icon: 'error',
                title: 'Lỗi...',
                text: 'Bạn cần đăng nhập để sử dụng chức năng này !',
                confirmButtonColor: '#dc3545',
                confirmButtonText: 'Đăng nhập'
            }).then((result) => {
                if (result.isConfirmed) {
                    localStorage.setItem('returnUrl', window.location.href);
                    window.location.href = '/login';
                }
            });
        } else {
            var heartIcon = $(this).find('i');

            $.ajax({
                type: 'POST',
                url: '/like',
                data: {
                    productId: productId
                },
                success: function (response) {
                    var titleLike = heartIcon.siblings('.title-like');
                    if (response == 'save') {
                        heartIcon.removeClass('bi-heart').addClass('bi-heart-fill');
                        titleLike.empty().html('Xóa yêu thích');
                        const Toast = Swal.mixin({
                            toast: true,
                            position: 'top-start',
                            showConfirmButton: false,
                            timer: 1000,
                            timerProgressBar: true,
                        })

                        Toast.fire({
                            icon: 'success',
                            title: 'Đã thêm vào danh sách yêu thích'
                        })
                    } else if (response == 'delete') {
                        heartIcon.removeClass('bi-heart-fill').addClass('bi-heart');
                        titleLike.empty().html('Thêm vào yêu thích');
                        console.log(response)
                        const Toast = Swal.mixin({
                            toast: true,
                            position: 'top-start',
                            showConfirmButton: false,
                            timer: 1000,
                            timerProgressBar: true
                        })

                        Toast.fire({
                            icon: 'error',
                            title: 'Đã xóa khỏi danh sách yêu thích'
                        })
                    }
                },
                error: function (xhr, status, error) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Opps.... !',
                        text: "Có lỗi xảy ra, vui lòng thử lại !",
                        showConfirmButton: false,
                        timer: 1500
                    });
                }
            });
        }
    })
})