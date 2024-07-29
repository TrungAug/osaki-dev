<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<!-- https://cocoshop.vn/ -->
<!-- http://mauweb.monamedia.net/vanihome/ -->

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng</title>
    <!-- Font roboto -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link
            href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@100;200;300;400;500;600;700;800;900&display=swap"
            rel="stylesheet">
    <!-- Icon fontanwesome -->
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
          integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p"
          crossorigin="anonymous"/>
    <!-- Reset css & grid sytem -->
    <link rel="stylesheet" href="/css/library.css">
    <!-- Owl Slider css -->
    <link rel="stylesheet" href="/owlCarousel/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="/owlCarousel/assets/owl.theme.default.min.css">
    <!-- Layout -->
    <link rel="stylesheet" href="/css/common.css">
    <!-- index -->
    <link rel="stylesheet" type="text/css" href="/css/cart.css">
    <!-- Jquery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Owl caroucel Js-->
    <script src="/owlCarousel/owl.carousel.min.js"></script>

    <!-- Bao gồm thư viện Swal -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.16/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.16/dist/sweetalert2.all.min.js"></script>
    <%--     bootstrap --%>
</head>
<style>
    .text-decoration-line-through {
        text-decoration: line-through;
    }

    .swal2-popup {
        font-size: 2rem;
    }
</style>
<body>
<div class="header scrolling" id="myHeader">
    <jsp:include page="./component/_grid.jsp"/>
    <%--menu --%>
    <jsp:include page="./component/_header.jsp"/>
</div>
<div class="main">
    <c:choose>
        <c:when test="${userLogin !=null}">
            <div class="grid wide">
                <h3 class="main__notify">
                    <select name="address" id="address" required class="form-control">
                        <c:forEach var="address" items="${addressList}">
                            <option
                                    value="${address.phoneID}">${address.phoneID},${address.address} </option>
                        </c:forEach>
                    </select>
                </h3>
                <div class="row">
                    <div class="col l-8 m-12 s-12">
                        <div class="main__cart">
                            <div class="row title">
                                <div class="col l-1 m-1 s-0">STT</div>
                                <div class="col l-4 m-4 s-8">Sản phẩm</div>
                                <div class="col l-2 m-2 s-0">Giá</div>
                                <div class="col l-2 m-2 s-0">Số lượng</div>
                                <div class="col l-2 m-2 s-4">Tổng</div>
                                <div class="col l-1 m-1 s-0">Xóa</div>
                            </div>
                            <h2 class="messageSuccessfully"></h2>
                            <h2 class="checkout_"></h2>
                            <div id="out">
                                <c:set var="checkCart" value="false"/>
                                <c:forEach var="cartList" items="${cartList}" varStatus="loop">
                                    <c:if test="${!cartList.checkPay}">

                                        <div class="row item ${cartList.product.productID}" id="${cartList.cartId}">
                                            <div class="col l-1 m-1 s-0">
                                                <input type="checkbox" value="${cartList.product.productID}" checked>
                                            </div>
                                            <div class="col l-4 m-4 s-8">
                                                <div class="main__cart-product">
                                                    <c:set var="foundFirst" value="false"/>
                                                    <c:forEach var="imgProduct" items="${imagesProduct}"
                                                               varStatus="i">
                                                        <c:if test="${!foundFirst && cartList.product.productID == imgProduct.productID.productID}">
                                                            <c:set var="foundFirst" value="true"/>
                                                            <a href="product" class="order-img">
                                                                <img src="../imagesProduct/${imgProduct.imageName}"
                                                                     alt="">
                                                            </a>
                                                        </c:if>
                                                    </c:forEach>
                                                    <div class="name"><a
                                                            href="/product/${cartList.product.productID}">${cartList.product.name}</a>
                                                    </div>
                                                    <c:if test="${cartList.product.quantityInStock <=0}">
                                                        <div class="name" style="color: red; margin-left: 5px"> Hết hàng
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </div>
                                            <div class="col l-2 m-2 s-0">

                                                <c:set var="checkLike" value="false"/>
                                                <c:set var="checkLikePrice" value=""/>
                                                <c:forEach var="promotionalDetailsList"
                                                           items="${promotionalDetailsList}">
                                                    <c:if test="${promotionalDetailsList.productID.productID == cartList.product.productID}">
                                                        <c:set var="checkLike" value="true"/>
                                                        <c:set var="checkLikePrice"
                                                               value="${promotionalDetailsList.discountedPrice}"/>
                                                    </c:if>
                                                </c:forEach>
                                                <c:choose>
                                                    <c:when test="${checkLike }">
                                                <span class="total-amount main__cart-price text-muted text-decoration-line-through me-2">
                                                           <fmt:formatNumber
                                                                   type="number"
                                                                   pattern="###,###,###"
                                                                   value="${cartList.product.price}"/> ₫
                                                       </span>
                                                        <span class="total-amount main__cart-price total-moneyPrice">
                                                        <fmt:formatNumber
                                                                type="number"
                                                                pattern="###,###,###"
                                                                value="${checkLikePrice}"/>
                                                     </span>₫
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="main__cart-price total-moneyPrice"><fmt:formatNumber
                                                                type="number"
                                                                pattern="###,###,###"
                                                                value="${cartList.product.price}"/> đ
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="col l-2 m-2 s-0">
                                                <div class="buttons_added">
                                                    <input class="minus is-form" type="button" value="-"
                                                           data-product-id="${cartList.product.productID}"
                                                           data-user-id="${userLogin.userID}"
                                                           onclick="minusProduct(${loop.index},`${cartList.cartId}`, `${cartList.product.productID}`,`${cartList.product.quantityInStock}`,`${cartList.product.price }`) ">
                                                    <input aria-label="quantity" class="input-qty"
                                                           max="${cartList.product.quantityInStock}" min="1"
                                                           name="" type="number"
                                                           onblur="handleBlur(this,`${cartList.product.quantityInStock}`,`${loop.index}`)"
                                                           onchange="onchangeProduct(${loop.index},`${cartList.cartId}`, `${cartList.product.productID}`,`${cartList.product.quantityInStock}`,`${cartList.product.price }`)"
                                                           value="${cartList.quantity}">
                                                    <input class="plus is-form" type="button" value="+"
                                                           data-product-id="${cartList.product.productID}"
                                                           data-user-id="${userLogin.userID}"
                                                           onclick="plusProduct(${loop.index},`${cartList.cartId}`, `${cartList.product.productID}`,`${cartList.product.quantityInStock}`,`${cartList.product.price }`) ">
                                                </div>
                                            </div>
                                            <div class="col l-2 m-2 s-4">
                                                <c:choose>
                                                    <c:when test="${checkLike }">
                                                        <div id="calculateTotalPrice" class="main__cart-price">
                                                            <fmt:formatNumber
                                                                    type="number"
                                                                    pattern="###,###,###"
                                                                    value="${checkLikePrice * cartList.quantity}"/> ₫
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div id="calculateTotalPrice" class="main__cart-price">
                                                            <fmt:formatNumber
                                                                    type="number"
                                                                    pattern="###,###,###"
                                                                    value="${cartList.product.price * cartList.quantity}"/>
                                                            ₫
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <a href="#" data-product-id="${cartList.cartId}" class="order-close"><i
                                                    class="far fa-times-circle"></i></a>
                                        </div>
                                        <c:set var="checkCart" value="true"/>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${!checkCart}">
                                    <h2 class="c"><a href="/">Tiếp tục mua sắm</a></h2>
                                </c:if>
                                <c:if test="${checkCart}">
                                    <h2 class="c"><a href="/"></a></h2>
                                </c:if>
                                <h1>${payment}</h1>
                            </div>
                        </div>
                    </div>
                    <div class="col l-4 m-12 s-12">
                        <div class="main__pay">
                            <div class="main__pay-title">Chi tiết giỏ hàng</div>
                            <div class="pay-info">
                                <div class="main__pay-text">
                                    Giao hàng
                                </div>
                                <div class="main__pay-text">
                                    Giao hàng miễn phí
                                </div>
                            </div>
                            <div class="pay-info">
                                <div class="total-money">Tổng tiền: <fmt:formatNumber
                                        type="number"
                                        pattern="###,###,###"
                                        value="${totalPrice}"/> ₫
                                </div>
                            </div>

                            <div class="btn btn--default orange" id="pay" data-user-id="${userLogin.userID}">Thanh toán
                                                                                                             khi nhận
                                                                                                             hàng
                            </div>
                            <div class="btn btn--default orange" id="vnpay" data-user-id="${userLogin.userID}">Thanh
                                                                                                               toán
                                                                                                               VNPAY
                            </div>
                                <%--                             <div class="main__pay-title">Phiếu ưu đãi</div> --%>

                                <%--                             <select name="voucher" id="voucher" required class="form-control"> --%>
                                <%--                                 <option value="">Chọn voucher</option> --%>
                                <%--                                 <c:forEach var="voucherList" items="${voucherList}"> --%>
                                <%--                                     <option value="${voucherList.id}">Giam --%>
                                <%--                                                                       gia: ${voucherList.discount * 100}</option> --%>
                                <%--                                 </c:forEach> --%>
                                <%--                             </select> --%>
                                <%--                             <div class="btn btn--default" id="apply">Áp dụng</div> --%>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="grid wide mt-3" style="height: 100vh">
                <h1 class="main__notify-text"><a href="login" onclick="ReturnUrl()">Vui lòng đăng nhập</a></h1>
            </div>
        </c:otherwise>
    </c:choose>

</div>
<div class="footer">
    <jsp:include page="./component/_footer.jsp"/>
</div>
<!-- Modal Form -->
<!-- Sccipt for owl caroucel -->

<!-- Script common -->
<script src="/js/commonscript.js"></script>
<script>
    function ReturnUrl() {
        // Xóa mục 'returnUrl' khỏi localStorage
        localStorage.setItem('returnUrl', window.location.href);
    }

    function minusProduct(index, cartId, productId, quantityInStock, price) {
        var inputQty = document.querySelectorAll('.input-qty')[index];
        var currentValue = parseInt(inputQty.value);
        var minValue = parseInt(inputQty.getAttribute('min'));
        if (currentValue > minValue) {

            inputQty.value = currentValue - 1;
            calculateTotal(index, quantityInStock)

        }
        changeQuantityProduct(cartId, productId, currentValue - 1, quantityInStock, price)
    }

    function onchangeProduct(index, cartId, productId, quantityInStock, price) {
        var inputQty = document.querySelectorAll('.input-qty')[index];
        var currentValue = parseInt(inputQty.value);
        var maxValue = parseInt(inputQty.getAttribute('max'));
        var minValue = parseInt(inputQty.getAttribute('min'));
        if (currentValue > minValue && currentValue <= parseInt(quantityInStock)) {
            inputQty.value = currentValue;
            console.log(3)
        } else if (currentValue < 0) {
            inputQty.value = 1;
        }
        changeQuantityProduct(cartId, productId, currentValue, quantityInStock, price)
        calculateTotal(index, quantityInStock)
    }

    function plusProduct(index, cartId, productId, quantityInStock, price) {
        var inputQty = document.querySelectorAll('.input-qty')[index];
        var currentValue = parseInt(inputQty.value);
        var maxValue = parseInt(inputQty.getAttribute('max'));
        if (currentValue < maxValue) {

            inputQty.value = currentValue + 1;
            calculateTotal(index, quantityInStock)
            if (currentValue > parseInt(quantityInStock)) {
                inputQty.value = quantityInStock
            }
        }
        changeQuantityProduct(cartId, productId, currentValue + 1, quantityInStock, price)
    }

    function calculateTotal(index, quantityInStock) {
        var inputQty = document.querySelectorAll('.input-qty')[index];
        var quantity = parseInt(inputQty.value);
        var pricePerProduct = parseFloat(document.querySelectorAll('.total-moneyPrice')[index].innerText.replace(/[,.đ]/g, ''));
        var total = quantity * pricePerProduct;
        if (quantity <= parseInt(quantityInStock)) {
            var formattedTotal = formatMoney(total);
            document.querySelectorAll('#calculateTotalPrice')[index].innerText = formattedTotal + ' đ';
        }
    }

    function calculateTotal1(index, cartId, productId, quantityInStock, price) {
        var checkbox = document.querySelectorAll('input[name="a"]')[index];
        // Kiểm tra xem checkbox được chọn hay không
        if (checkbox.checked) {
            // Lấy thông tin số lượng và giá của sản phẩm
            var inputQty = document.querySelectorAll('.input-qty')[index];
            var quantity = parseInt(inputQty.value);
            var pricePerProduct = parseFloat(document.querySelectorAll('.total-moneyPrice')[index].innerText.replace(/[,.đ]/g, ''));
            // Tính tổng tiền
            var total = quantity * pricePerProduct;
            var formattedTotal = formatMoney(total);
            // Cập nhật tổng tiền
            document.querySelectorAll('#calculateTotalPrice')[index].innerText = formattedTotal + ' đ';
            changeQuantityProduct(cartId, productId, currentValue + 1, quantityInStock, price)
        }
    }

    function handleBlur(inputElement, quantityInStock, index) {
        // Lấy giá trị của trường nhập liệu
        var value = inputElement.value;

        // Kiểm tra nếu giá trị là không hợp lệ (ví dụ: rỗng hoặc không phải là số)
        if (isNaN(value) || value === "" || parseInt(value) > parseInt(quantityInStock)) {
            // Nếu giá trị không hợp lệ, đặt lại nó thành 1
            inputElement.value = quantityInStock;
            calculateTotal(index, quantityInStock)

        }
    }

    function formatMoney(amount) {
        return amount.toFixed(0).replace(/\d(?=(\d{3})+$)/g, '$&,');
    }
</script>
<script src="/js/contact.js"></script>
<script src="/js/cartCript.js"></script>
<script src="/js/checkout.js"></script>
</body>

</html>