$(document).ready(function () {
    $('.order-close').click(function (e) {
        e.preventDefault();
        let cartId = $(this).data('product-id');
        let isLoggedIn = $(this).data('user-id') !== '';
        console.log("cart" + cartId)
        Swal.fire({
            text: "Bạn có muốn xóa sản phẩm đã chọn khỏi giỏ hàng ?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            cancelButtonText: 'Trở lại',
            confirmButtonText: 'Có'
        }).then((result) => {
            if (result.isConfirmed) {
                let quantity = 1; // Lấy số lượng từ ô nhập liệu
                console.log(quantity)
                $.ajax({
                    type: 'DELETE',
                    url: '/delete-to-cart',
                    data: {
                        cartId: cartId,
                        quantity: quantity
                    },
                    success: function (response) {
                        var jsonRemove = JSON.parse(response);
                        console.log("jsonRemove" + jsonRemove)
                        if (response == 'fail') {
                            Swal.fire({
                                icon: 'warning',
                                title: 'Something wrong !',
                                showConfirmButton: true
                            });
                        } else {
                            let cartCount = jsonRemove.cartCount;
                            let totalPrice = jsonRemove.totalPrice;
                            $('.header__cart-amount').append('  <div class="header__cart-amount">\n' +
                                '                            ' + cartCount + '\n' +
                                '                    </div>')
                            if (cartCount < 1) {
                                $('#ContinueShopping').html('<h2 class="c" style="text-align: center"><a href="/">Tiếp tục mua sắm</a></h2>')
                                $('.total-money').html("Tổng tiền: 0 đ")
                                $('#out').html("<h1><a href='/'>Tiếp tục mua sắm</a></h1>");
                                console.log("ok")
                            } else {
                                $('#ContinueShopping').html('<h2 class="c" style="text-align: center"><a href="/"></a></h2>')
                                var formattedPrice = totalPrice.toLocaleString('vi-VN', {
                                    style: 'currency',
                                    currency: 'VND'
                                });
                                $('.total-money').text("Tổng tiền: " + formattedPrice)
                            }

                            document.querySelector("." + cartId + "").remove();
                            document.querySelector("#" + cartId + "").remove();
                            Swal.fire({
                                icon: 'success',
                                title: 'Xóa sản phẩm thành công !',
                                showConfirmButton: false,
                                timer: 2000
                            });

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
    $('#apply').click(function (e) {
        e.preventDefault();
        var selectedOption = $("#voucher").find('option:selected');
        var voucherId = selectedOption.val();
        console.log("Voucher ID: " + voucherId);
        let isLoggedIn = $(this).data('user-id') !== '';
        console.log(isLoggedIn)
        if (!isLoggedIn) {
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Bạn cần đăng nhập để thêm sản phẩm vào giỏ hàng!',
                confirmButtonColor: '#dc3545',
                confirmButtonText: 'Đăng nhập'
            }).then((result) => {
                if (result.isConfirmed) {

                    localStorage.setItem('returnUrl', window.location.href);
                    window.location.href = '/login';
                }
            });
        } else {

        }
    });

    $('.addToCart').click(function (e) {
        e.preventDefault();
        let productID = $(this).data('product-id');
        let isLoggedIn = $(this).data('user-id') !== '';
        var cartId = generateRandomString();
        console.log(productID)
        console.log(isLoggedIn)
        if (!isLoggedIn) {
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Bạn cần đăng nhập để thêm sản phẩm vào giỏ hàng!',
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
            let quantity = $(".input-qty").val() === undefined ? 1 : $(".input-qty").val();
            //let quantity = 1;
            console.log(quantity)
            $.ajax({
                type: 'POST',
                url: '/add-to-cart',
                data: {
                    productID: productID,
                    quantity: quantity,
                    cartId: cartId,
                    // Gửi số lượng cùng với ID sản phẩm
                },
                success: function (response) {
                    if (response == 'errorQuantityInStock') {
                        Swal.fire({
                            icon: 'error',
                            title: 'Thêm sản phẩm thất bại',
                            text: "Số lượng thêm vào lớn hơn hàng tồn kho!",
                            showConfirmButton: false,
                            timer: 2000
                        });
                        return
                    }
                    if (response == 'errorQuantity_') {
                        Swal.fire({
                            icon: 'error',
                            title: 'Thêm sản phẩm thất bại',
                            text: "Số lượng không được vươt quá 100!",
                            showConfirmButton: false,
                            timer: 2000
                        });
                        return
                    }
                    var json = JSON.parse(response);
                    var message = json.message;
                    if (message == 'fail') {
                        Swal.fire({
                            icon: 'warning',
                            title: 'Something wrong !',
                            showConfirmButton: true
                        });
                    } else if (message == 'success') {
                        var cartID = json.cartID
                        Swal.fire({
                            icon: 'success',
                            title: 'Thêm vào giỏ hàng thành công !',
                            showConfirmButton: false,
                            timer: 2000
                        });

                        updateCartInfo(productID, quantity, response, false, cartID);
                    } else if (message == 'successUpdate') {
                        var cartID = json.cartID
                        Swal.fire({
                            icon: 'success',
                            title: 'Thêm số lượng vào giỏ hàng thành công !',
                            showConfirmButton: false,
                            timer: 2000
                        });

                        updateCartInfo(productID, quantity, response, true, cartID);
                    } else if (message == 'failQuantity') {
                        Swal.fire({
                            icon: 'error',
                            title: 'Thêm sản phẩm thất bại',
                            text: "Sản phẩm này là hết hàng!",
                            showConfirmButton: false,
                            timer: 2000
                        });
                    } else if (message == 'errorQuantityInStock') {
                        Swal.fire({
                            icon: 'error',
                            title: 'Thêm sản phẩm thất bại',
                            text: "Số lượng thêm vào lớn hơn hàng tồn kho!",
                            showConfirmButton: false,
                            timer: 2000
                        });
                    }
                },
                error: function (xhr, status, error) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Thêm vào giỏ hàng thất bại',
                        text: "Có lỗi xảy ra, vui lòng thử lại !",
                        showConfirmButton: false,
                        timer: 2000
                    });
                }
            });
        }
    });

    function updateCartInfo(productID, quantityInCart, response, check, cartID) {
        console.log(productID + " - " + quantityInCart);
        $.ajax({
            type: "GET",
            url: "/get-cart",
            data: {
                productID: productID,
                cartId: cartID,
            },
            success: function (response) {
                console.log("run successfully")
                var json = JSON.parse(response);
                console.log(json)
                let cartCount = json.cartCount;
                let cartId = json.cartID;
                let discountedPrice = json.discountedPrice;
                let image = json.image;
                let originalPrice = json.originalPrice;
                let productId = json.productId;
                let productName = json.productName;
                let quantity = json.quantity;
                let quantityInStock = json.quantityInStock;
                let totalPrice = json.totalPrice;

                console.log("cartCount:", json.cartCount);
                console.log("cartID:", json.cartID);
                console.log("discountedPrice:", json.discountedPrice);
                console.log("image:", json.image);
                console.log("originalPrice:", json.originalPrice);
                console.log("productId:", json.productId);
                console.log("productName:", json.productName);
                console.log("quantity:", json.quantity);
                console.log("quantityInStock:", json.quantityInStock);
                console.log("totalPrice:", json.totalPrice);
                if (!check) {
                    // html
                    var productHtml = '<li class="item-order ' + cartId + '"> <div class="order-wrap"><a href="product" class="order-img"><img src="../imagesProduct/' + image + '" alt=""></a><div class="order-main">';
                    productHtml += '<a href="/product/' + productId + '" class="order-main-name">' + productName + '</a><div class="order-main-price"><span id="quantity_' + cartID + '">' + quantity + '</span>';
                    productHtml += '   X   <span>'
                    if (originalPrice > discountedPrice) {
                        productHtml += '<del><span class="text-muted text-decoration-line-through me-2">' + formatCurrency(originalPrice) + ' </span></del>';
                        productHtml += ' <span class="total-amount">' + formatCurrency(discountedPrice) + ' </span>';
                    } else {
                        productHtml += ' <span class="total-amount" style="margin-left: 64px">' + formatCurrency(originalPrice) + ' </span>';
                    }
                    productHtml += '</span> ₫<a href="#" data-product-id="' + cartId + '" class="order-close"> <i class="far fa-times-circle"></i></a>';
                    productHtml += '</div> </div></div></li>'

                    // Định dạng giá tiền
                    if (cartCount < 1) {
                        $('#ContinueShopping').html('<h2 class="c" style="text-align: center"><a href="/">Tiếp tục mua sắm</a></h2>')
                        $('.total-money').html("Tổng tiền: 0 đ")
                        console.log("ok1")
                    } else {
                        $('#ContinueShopping').html('<h2 class="c" style="text-align: center"><a href="/"></a></h2>')
                        var formattedPrice = totalPrice.toLocaleString('vi-VN', {
                            style: 'currency',
                            currency: 'VND'
                        });
                        console.log("ok2")
                        $('.total-money').text("Tổng tiền: " + formattedPrice)
                    }
                    $('.order__list').append(productHtml);
                    $('.header__cart-amount').append('  <div class="header__cart-amount">\n' +
                        '                            ' + cartCount + '\n' +
                        '                    </div>')

                    var formattedPrice = totalPrice.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'});
                    $('#quantity_' + cartId).html(quantity)
                } else if (check) {
                    document.querySelector("." + cartId + "").remove();
                    var productHtml = '<li class="item-order ' + cartId + '"> <div class="order-wrap"><a href="product" class="order-img"><img src="../imagesProduct/' + image + '" alt=""></a><div class="order-main">';
                    productHtml += '<a href="/product/' + productId + '" class="order-main-name">' + productName + '</a><div class="order-main-price"><span id="quantity_${cartList.cartId}">' + quantity + '</span>';
                    productHtml += '   X   <span>'
                    if (originalPrice > discountedPrice) {
                        productHtml += '<del><span class="text-muted text-decoration-line-through me-2">' + formatCurrency(originalPrice) + ' </span></del>';
                        productHtml += ' <span class="total-amount">' + formatCurrency(discountedPrice) + ' </span>';
                    } else {
                        productHtml += ' <span class="total-amount" style="margin-left: 64px">' + formatCurrency(originalPrice) + ' </span>';
                    }
                    productHtml += '</span> ₫<a href="#" data-product-id="' + cartId + '" class="order-close"> <i class="far fa-times-circle"></i></a>';
                    productHtml += '</div> </div></div></li>'
                    $('.order__list').append(productHtml);
                    // Định dạng giá tiền
                    var formattedPrice = totalPrice.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'});
                    $('.total-money').text("Tổng tiền: " + formattedPrice)
                    if (cartCount < 1) {
                        $('#ContinueShopping').html('<h2 class="c" style="text-align: center"><a href="/">Tiếp tục mua sắm</a></h2>')

                    } else {
                        $('#ContinueShopping').html('<h2 class="c" style="text-align: center"><a href="/"></a></h2>')
                    }
                    $('#quantity_' + cartId).html(quantity)

                }
                $('.order-close').click(function (e) {
                    e.preventDefault();
                    let cartId = $(this).data('product-id');
                    console.log("cart" + cartId)
                    Swal.fire({
                        text: "Bạn có muốn xóa sản phẩm đã chọn khỏi giỏ hàng ?",
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        cancelButtonText: 'Trở lại',
                        confirmButtonText: 'Có'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            let quantity = 1; // Lấy số lượng từ ô nhập liệu
                            console.log(quantity)
                            $.ajax({
                                type: 'DELETE',
                                url: '/delete-to-cart',
                                data: {
                                    cartId: cartId,
                                    quantity: quantity
                                },
                                success: function (response) {
                                    var jsonRemove = JSON.parse(response);
                                    console.log("jsonRemove" + jsonRemove)
                                    if (response == 'fail') {
                                        Swal.fire({
                                            icon: 'warning',
                                            title: 'Something wrong !',
                                            showConfirmButton: true
                                        });
                                    } else {
                                        let cartCount = jsonRemove.cartCount;
                                        let totalPrice = jsonRemove.totalPrice;
                                        if (cartCount < 1) {
                                            $('#ContinueShopping').html('<h2 class="c" style="text-align: center"><a href="/">Tiếp tục mua sắm</a></h2>')
                                            $('.total-money').html("Tổng tiền: 0 đ")
                                        } else {
                                            $('#ContinueShopping').html('<h2 class="c" style="text-align: center"><a href="/"></a></h2>')
                                            var formattedPrice = totalPrice.toLocaleString('vi-VN', {
                                                style: 'currency',
                                                currency: 'VND'
                                            });
                                            $('.total-money').text("Tổng tiền: " + formattedPrice)
                                        }
                                        $('.header__cart-amount').append('  <div class="header__cart-amount">\n' +
                                            '                            ' + cartCount + '\n' +
                                            '                    </div>')
                                        document.querySelector("." + cartId + "").remove();
                                        Swal.fire({
                                            icon: 'success',
                                            title: 'Xóa sản phẩm thành công !',
                                            showConfirmButton: false,
                                            timer: 2000
                                        });

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
            },
            error: function (error) {
                console.log("Đã xảy ra lỗi khi thêm vào giỏ hàng: " + error);
            }
        });
    }


});


function formatCurrency(number) {
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}


function changeQuantityProduct(cartId, productId, quantity, quantityInStock, price) {
    console.log("this is changeQuantityProduct")
    console.log(cartId + " - Product: " + productId + " - Quantity: " + quantity + " - quantityInStock " + quantityInStock + " - price: " + price)

    if (parseInt(quantity) <= 0) {
        Swal.fire({
            icon: 'error',
            title: 'Opps....',
            text: "Vui lòng nhập số lượng lớn hơn 0 !",
            showConfirmButton: true,
        });
        $(".input-quantity").val(1);
        quantity = 1
    } else if (parseInt(quantity) > parseInt(quantityInStock)) {
        Swal.fire({
            icon: 'error',
            title: 'Opps....',
            text: "Số lượng vượt quá số lượng tồn kho !",
            showConfirmButton: true,
        });
        quantity = quantityInStock
        $(".input-quantity").val(quantityInStock);
    }
    $.ajax({
        url: "/update-cart",
        type: "POST",
        data: {
            cartId: cartId,
            productId: productId,
            quantity: quantity
        },
        success: function (resp) {
            if (resp == 'fail') {
                Swal.fire({
                    icon: 'error',
                    title: 'Opps....',
                    text: "Có lỗi xảy ra khi thay đổi số lượng !",
                    showConfirmButton: true,
                });
            } else {
                var json = JSON.parse(resp);
                console.log("json cartCount: " + json.cartCount);
                console.log("json totalPrice: " + json.totalPrice);

                let cartCount = json.cartCount;
                let totalPrice = json.totalPrice;
                let totalAmount = parseFloat(quantity) * parseFloat(price);
                console.log(totalAmount)
                $('.calculateTotalPrice').html(formatCurrency(totalAmount))
                $('#quantity_' + cartId).html(quantity)
                $('.total-money').html('Tổng tiền: ' + formatCurrency(totalPrice) + " ₫");
                // if (totalPrice > 3000000) {
                //     $('.total-money').html('Tổng tiền: ' + formatCurrency(totalPrice) + " ₫");
                // } else {
                //     $('.total-money').html('Tổng tiền: ' + formatCurrency(totalPrice+ 50000) + " ₫");
                // }

            }
        },
        error: function (error) {
            alert("Something error ! " + error);
        }
    })

}

function findVoucherName(cityId) {
    var cityName = "";
    $('#city option').each(function () {
        if ($(this).val() === cityId) {
            cityName = $(this).text();
            return false; // Dừng vòng lặp khi tìm thấy
        }
    });
    return cityName;
}


function generateRandomString() {
    var randomString = '';
    var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    var charactersLength = characters.length;
    for (var i = 0; i < 8; i++) {
        randomString += characters.charAt(Math.floor(Math.random() * charactersLength));
    }

    var currentTimeMillis = new Date().getTime();

    var finalString = randomString + currentTimeMillis.toString();

    return finalString;
}
