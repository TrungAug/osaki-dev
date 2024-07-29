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
                    <select name="address" required class="form-control">
                        <option value="">Chọn địa chỉ</option>
                        <c:forEach var="address" items="${addressList}">
                            <option id="address"
                                    value="${address.phoneID}">${address.phoneID},${address.address} </option>
                        </c:forEach>
                    </select>
                </h3>
                <div class="row" style="height: 100vh">
                    <h1>Thanh toan thanh cong</h1>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="grid wide mt-3" style="height: 100vh">
                <div class="main__notify-text"><a href="login">Vui long dang nhap</a></div>
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
    function minusProduct(index, cartId, productId, quantityInStock, price) {
        var inputQty = document.querySelectorAll('.input-qty')[index];
        var currentValue = parseInt(inputQty.value);
        var minValue = parseInt(inputQty.getAttribute('min'));
        if (currentValue > minValue) {
            inputQty.value = currentValue - 1;
            calculateTotal(index)
        }
        changeQuantityProduct(cartId, productId, currentValue - 1, quantityInStock, price)
    }

    function plusProduct(index, cartId, productId, quantityInStock, price) {
        var inputQty = document.querySelectorAll('.input-qty')[index];
        var currentValue = parseInt(inputQty.value);
        var maxValue = parseInt(inputQty.getAttribute('max'));
        if (currentValue < maxValue) {
            inputQty.value = currentValue + 1;
            calculateTotal(index)
        }
        changeQuantityProduct(cartId, productId, currentValue + 1, quantityInStock, price)
    }

    function calculateTotal(index) {
        var inputQty = document.querySelectorAll('.input-qty')[index];
        var quantity = parseInt(inputQty.value);
        var pricePerProduct = parseFloat(document.querySelectorAll('.total-moneyPrice')[index].innerText.replace(/[,.đ]/g, ''));
        var total = quantity * pricePerProduct;
        var formattedTotal = formatMoney(total);
        document.querySelectorAll('#calculateTotalPrice')[index].innerText = formattedTotal + ' đ';
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

    function formatMoney(amount) {
        return amount.toFixed(0).replace(/\d(?=(\d{3})+$)/g, '$&,');
    }
</script>
<script src="/js/cartCript.js"></script>
<script src="/js/checkout.js"></script>
</body>

</html>