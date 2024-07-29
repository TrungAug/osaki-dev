$(document).ready(function () {
    $('#comment').click(function (e) {
        e.preventDefault();
        var selectedValue = $('#rating input[type="radio"]:checked').val();
        var ratecommentId = $("#ratecommentId").val();
        let productID = $(this).data('product-id');
        let isLoggedIn = $(this).data('user-id') !== '';
        console.log(productID)
        console.log(isLoggedIn)
        if (!isLoggedIn) {
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Bạn cần đăng nhập để thực hiển chức năng này!',
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
            console.log("half: " + productID + " comment: " + ratecommentId + " sao" + selectedValue)
            $.ajax({
                type: "POST",
                url: "/add_comment",
                data: {
                    productID: productID,
                    star: selectedValue,
                    content: ratecommentId
                },
                success: function (response) {
                    // Handle the success response here
                    var jsonComment = JSON.parse(response);
                    var messageResponse = jsonComment.message
                    var productResponse = jsonComment.productID;
                    var starResponse = jsonComment.star;
                    var contentResponse = jsonComment.content;
                    var fullname = jsonComment.fullName
                    if (messageResponse === "success") {
                        Swal.fire({
                            title: 'Thành công', text: "Bình luận thành công", showConfirmButton: true, timer: 3500
                        });
                        var commentHTML = '<li class="rate__item">\n' +
                            '                                    <div class="rate__info">\n' +
                            '                                        <img src="https://lh3.googleusercontent.com/ogw/ADGmqu9PFgn_rHIm9i3eIlVr5RwzwY2w8EystHF213wj=s32-c-mo"\n' +
                            '                                             alt="">\n' +
                            '                                        <h3 class="rate__user">' + fullname + '</h3>'
                        if (starResponse == 1) {
                            commentHTML += '  <div class="rate__star">\n' +
                                '                                                <div class="group-star">\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                </div>\n' +
                                '                                            </div>'
                        } else if (starResponse == 1.5) {
                            commentHTML += ' <div class="rate__star">\n' +
                                '                                                <div class="group-star">\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                    <i class="fas fa-star-half-alt"></i>\n' +
                                '                                                </div>\n' +
                                '                                            </div>'
                        } else if (starResponse == 2) {
                            commentHTML += '   <div class="rate__star">\n' +
                                '                                                <div class="group-star">\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                </div>\n' +
                                '                                            </div>'
                        } else if (starResponse == 2.5) {
                            commentHTML += '   <div class="rate__star">\n' +
                                '                                                <div class="group-star">\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                    <i class="fas fa-star-half-alt"></i>\n' +
                                '                                                </div>\n' +
                                '                                            </div>'
                        } else if (starResponse == 3) {
                            commentHTML += '    <div class="rate__star">\n' +
                                '                                                <div class="group-star">\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                </div>\n' +
                                '                                            </div>'
                        } else if (starResponse == 3.5) {
                            commentHTML += '  <div class="rate__star">\n' +
                                '                                                <div class="group-star">\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                    <i class="fas fa-star-half-alt"></i>\n' +
                                '                                                </div>\n' +
                                '                                            </div>'
                        } else if (starResponse == 4) {
                            commentHTML += '   <div class="rate__star">\n' +
                                '                                                <div class="group-star">\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                </div>\n' +
                                '                                            </div>'
                        } else if (starResponse == 4.5) {
                            commentHTML += '    <div class="rate__star">\n' +
                                '                                                <div class="group-star">\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                    <i class="fas fa-star-half-alt"></i>\n' +
                                '                                                </div>\n' +
                                '                                            </div>'
                        } else if (starResponse == 5) {
                            commentHTML += '   <div class="rate__star">\n' +
                                '                                                <div class="group-star">\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                    <i class="fas fa-star"></i>\n' +
                                '                                                </div>\n' +
                                '                                            </div>'
                        }
                        commentHTML += '</div>\n' +
                            '                                    <div class="rate__comment">' + contentResponse + '</div>\n' +
                            '                                </li>'
                        $('.rate__list').append(commentHTML)
                        // Redirect or perform actions for successful login
                        console.log("comment successful");
                    } else if (messageResponse === "fail") {
                        Swal.fire({
                            icon: "error",
                            title: 'Thất bại',
                            text: "Bình luận không thành công",
                            showConfirmButton: true,
                            timer: 3500
                        })

                    }
                },
                error: function (error) {
                    // Handle the error response here
                    Swal.fire({
                        icon: 'error', title: 'Lỗi', text: "Có lỗi xảy ra", showConfirmButton: true, timer: 3500
                    }).then(function () {
                        // Redirect to the home page
                        // Change '/home' to the actual URL of your home page
                    });
                }
            });
        }
    })
})