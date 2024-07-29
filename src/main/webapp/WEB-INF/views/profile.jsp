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
    <title>Thông tin người dùng</title>
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
    <script src="https://code.jquery.com/jquery-latest.js"></script>
    <script>
        var loader = function () {
            setTimeout(function () {
                $('#loader').css({'opacity': 0, 'visibility': 'hidden'});
            }, 1000); // Đặt thời gian tại đây, ví dụ: 3000ms (3 giây)
        };
        $(function () {
            loader();
        });
    </script>
    <!-- index -->
    <link rel="stylesheet" type="text/css" href="/css/cart.css">
    <!-- Jquery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Owl caroucel Js-->
    <script src="/owlCarousel/owl.carousel.min.js"></script>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
            crossorigin="anonymous">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- Bao gồm thư viện Swal -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.16/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.16/dist/sweetalert2.all.min.js"></script>
    <%--     bootstrap --%>
</head>
<style>
    .swal2-popup {
        font-size: 2rem;
    }

    .text-decoration-line-through {
        text-decoration: line-through;
    }

    a {
        text-decoration: none;
    }

    {
        margin: 0


    ;
        padding: 0


    ;
        box-sizing: border-box


    ;
        font-family: ' Ubuntu ',
        sans-serif


    ;
    }
    :root {
        /*--blue: #287bff;*/
        --blue: #b7a888;
        --white: #fff;
        --grey: #f5f5f5;
        --black1: #222;
        --black2: #999;
    }

    body {
        min-height: 100vh;
        overflow-x: hidden;
    }

    .container-fluid {
        position: relative;
        width: 100%;
    }

    .navigation {
        margin-top: 150px;
        position: fixed;
        width: 300px;
        height: 90%;
        background: var(--blue);
        border-left: 10px solid var(--blue);
        transform: 0.5s;
        overflow: hidden;
    }

    .navigation.active {
        width: 80px;
    }

    .navigation ul {
        position: absolute;
        padding: 0;
        top: 0;
        left: 0;
        width: 100%;
    }

    .navigation ul li {
        position: relative;
        list-style: none;
        width: 100%;
        border-top-left-radius: 30px;
        border-bottom-left-radius: 30px;
    }

    .navigation ul li:hover, .navigation ul li.hovered {
        background: var(--white);
    }

    .navigation ul li:nth-child(1) {
        margin-bottom: 50px;
        pointer-events: none;
    }

    .navigation ul li a {
        position: relative;
        display: block;
        width: 100%;
        display: flex;
        text-decoration: none;
        color: var(--white);
    }

    .navigation ul li:hover a, .navigation ul li.hovered a {
        color: var(--blue);
    }

    .navigation ul li a .icon {
        position: relative;
        display: block;
        min-width: 60px;
        height: 60px;
        line-height: 60px;
        text-align: center;
    }

    .navigation ul li a .icon ion-icon {
        font-size: 1.75rem;
    }

    .navigation ul li a .title {
        position: relative;
        display: block;
        min-width: 60px;
        padding: 0 10px;
        line-height: 60px;
        text-align: start;
        white-space: nowrap;
    }

    .navigation ul li:hover a::before, .navigation ul li.hovered a::before {
        content: '';
        position: absolute;
        right: 0;
        top: -50px;
        width: 50px;
        height: 50px;
        background: transparent;
        border-radius: 50%;
        box-shadow: 35px 35px 0 10px var(--white);
        pointer-events: none;
    }

    .navigation ul li:hover a::after, .navigation ul li.hovered a::after {
        content: '';
        position: absolute;
        right: 0;
        bottom: -50px;
        width: 50px;
        height: 50px;
        background: transparent;
        border-radius: 50%;
        box-shadow: 35px -35px 0 10px var(--white);
        pointer-events: none;
    }

    /*  >>>>>>>>>>main<<<<<<<<<<<<  */
    .main {
        position: absolute;
        width: calc(100% - 300px);
        left: 300px;
        min-height: 100vh;
        background: var(--white);
        transition: 0.5s;
    }

    .main.active {
        width: calc(100% - 80px);
        left: 80px;
    }

    .topbar {
        width: 100%;
        height: 60px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 10px;
    }

    .toggle {
        position: relative;
        top: 0;
        width: 60px;
        height: 60px;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 2.5em;
        cursor: pointer;
    }

    .search {
        position: relative;
        top: 0;
        width: 400px;
        margin: 0 10px;
    }

    .search label {
        position: relative;
        width: 100%;
    }

    .search label input {
        height: 40px;
        width: 100%;
        border-radius: 40px;
        padding: 5px 20px;
        padding-left: 35px;
        font-size: 18px;
        outline: none;
        border: 1px solid var(--black2);
    }

    .search label ion-icon {
        position: absolute;
        top: 10px;
        left: 10px;
        font-size: 1.2em;
    }

    .user {
        position: relative;
        width: 50px;
        height: 50px;
        border-radius: 50%;
        overflow: hidden;
        cursor: pointer;
    }

    .user img {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .cardBox {
        position: relative;
        width: 100%;
        padding: 20px;
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        grid-gap: 30px;
    }

    .cardBox .cardP {
        position: relative;
        background: var(--white);
        padding: 30px;
        border-radius: 20px;
        display: flex;
        justify-content: space-between;
        cursor: pointer;
        box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
    }

    .cardBox .cardP .numbers {
        position: relative;
        font-weight: 500;
        font-size: 2.5em;
        color: var(--blue);
    }

    .cardBox .cardP .cardName {
        color: var(--black2);
        font-size: 1.1em;
        margin-top: 5px;
    }

    .cardBox .cardP .iconBox {
        font-size: 3.5em;
        color: var(--black2);
    }

    .cardBox .cardP:hover {
        background: var(--blue);
    }

    .cardBox .cardP:hover .numbers, .cardBox .cardP:hover .cardName,
    .cardBox .cardP:hover .iconBox {
        color: var(--white);
    }

    .details {
        position: relative;
        width: 100%;
        padding: 20px;
        display: grid;
        grid-template-columns: 2fr 1fr;
        grid-gap: 30px;
    }

    .details .recentOrders {
        position: relative;
        min-height: 500px;
        padding: 20px;
        box-shadow: 0 7px 20px rgba(0, 0, 0, 0.08);
        border-radius: 20px;
    }

    .cardHeader h2 {
        font-weight: 600;
        color: var(--blue);
    }

    .btn-custom {
        position: relative;
        background: var(--blue);
        color: var(--white);
        border-radius: 6px;
    }

    .recentCustomer {
        position: relative;
        min-height: 500px;
        padding: 20px;
        box-shadow: 0 7px 20px rgba(0, 0, 0, 0.08);
        border-radius: 20px;
    }

    .recentCustomer .imgBox {
        position: relative;
        height: 50px;
        width: 50px;
        border-radius: 50%;
        overflow: hidden;
    }

    .recentCustomer .imgBox img {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .recentCustomer table tr td {
        padding: 10px;
    }

    .recentCustomer table tr td h4 {
        font-size: 16px;
        font-weight: 500;
        line-height: 1.2em;
    }

    .recentCustomer table tr td h4 span {
        font-size: 14px;
        color: var(--black2);
    }

    /*  Chart */
    .graphicBox {
        position: relative;
        width: 100%;
        padding: 20px;
        display: grid;
        grid-template-columns: 1fr 2fr;
        grid-gap: 30px;
        min-height: 200px;
    }

    .graphicBox .box {
        position: relative;
        background: var(--white);
        padding: 20px;
        width: 100%;
        box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
        border-radius: 20px;
    }

    @media ( max-width: 992px) {
        .navigation {
            left: -300px;
        }

        .navigation.active {
            width: 300px;
            left: 0;
        }

        .main {
            width: 100%;
            left: 0;
        }

        .main.active {
            left: 300px;
        }

        .cardBox {
            grid-template-columns: repeat(2, 1fr);
        }

        .graphicBox {
            grid-template-columns: 1fr;
            height: auto;
        }
    }

    @media ( max-width: 768px) {
        .details {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    @media ( max-width: 480px) {
        .cardBox {
            grid-template-columns: 1fr;
        }
    }

    /*  >>>>>>>>>><<<<<<<<<<<<  */
    .admin-menu {
        background-color: #787d62;;
        height: 100vh;
    }

    .admin-menu-accordion {
        width: 100%;
    }

    .bd-links {
        position: sticky;
        top: 5rem;
        display: block !important;
        height: calc(100vh - 7rem);
        padding-left: 0.25rem;
        margin-left: -0.25rem;
        overflow-y: auto;
    }

    .bd-links .btn {
        padding: 0.25rem 0.5rem;
        font-weight: 700;
        color: rgba(0, 0, 0, 0.65);
        background-color: transparent;
        border: 0;
    }

    .bd-links a {
        padding: 0.1875rem 0.5rem;
        margin-top: 0.125rem;
        margin-left: 1.25rem;
        color: rgba(0, 0, 0, 0.65);
        text-decoration: none;
        font-size: 1rem;
    }

    .admin-content {
        background-color: #c5c6b9;
        height: 100vh;
    }

    .panel {
        margin-bottom: 20px;
        background-color: #fff;
        border: 1px solid transparent;
        border-radius: 4px;
        -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
        box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
        cursor: pointer;
    }

    .panel-primary {
        border-color: #337ab7;
    }

    .panel-success {
        border-color: #5cb85c;
    }

    .panel-warning {
        border-color: #f0ad4e;
    }

    .panel-danger {
        border-color: #d9534f;
    }

    .panel-primary > .panel-heading {
        color: #fff;
        background-color: #337ab7;
        border-color: #337ab7;
    }

    .panel-success .panel-heading {
        border-color: #5cb85c;
        color: #fff;
        background-color: #5cb85c;
    }

    .panel-warning .panel-heading {
        border-color: #f0ad4e;
        color: #fff;
        background-color: #f0ad4e;
    }

    .panel-danger .panel-heading {
        border-color: #d9534f;
        color: #fff;
        background-color: #d9534f;
    }

    .panel-heading {
        padding: 10px 15px;
        border-bottom: 1px solid transparent;
        border-top-left-radius: 3px;
        border-top-right-radius: 3px;
    }

    .panel-footer {
        padding: 10px 15px;
        background-color: #f5f5f5;
        border-top: 1px solid #ddd;
        border-bottom-right-radius: 3px;
        border-bottom-left-radius: 3px;
    }

    .pull-left {
        float: left !important;
    }

    .pull-right {
        float: right !important;
    }

    .bi-5x {
        font-size: 5em;
    }

    .huge {
        font-size: 40px;
    }

    .col-sx-9 {
        width: 75%;
    }

    .col-sx-3 {
        width: 25%;
    }

    .text-right {
        text-align: right;
    }

    * {
        /* reset lại margin và padding cho các tag */
        margin: 0;
        padding: 0;
    }

    #loader {
        position: fixed;
        top: 0;
        left: 0;
        z-index: 99999;
        width: 100%;
        height: 100%;
        background-color: #fff;
        transition: all 0.3s ease-in-out;
    }

    .circle {
        height: 40px;
        margin: 300px auto;
        position: relative;
        text-align: center;
        width: 40px;
        -webkit-animation: circle_dot 3.0s infinite linear;
        /* Đặt thời gian tại đây, ví dụ: 3.0s */
        animation: circle_dot 3.0s infinite linear;
        /* Đặt thời gian tại đây, ví dụ: 3.0s */
    }

    .circle1,
    .circle2 {
        height: 60%;
        display: inline-block;
        background-color: #ef5f38;
        border-radius: 100%;
        position: absolute;
        top: 0;
        width: 60%;
        -webkit-animation: circle_bounce 3.0s infinite ease-in-out;
        /* Đặt thời gian tại đây, ví dụ: 3.0s */
        animation: circle_bounce 3.0s infinite ease-in-out;
        /* Đặt thời gian tại đây, ví dụ: 3.0s */
    }

    .circle2 {
        bottom: 0;
        top: auto;
        -webkit-animation-delay: -1.5s;
        /* Một nửa thời gian của thời gian chuyển động */
        animation-delay: -1.5s;
        /* Một nửa thời gian của thời gian chuyển động */
    }

    @-webkit-keyframes circle_dot {
        100% {
            -webkit-transform: rotate(360deg)
        }
    }

    @keyframes circle_dot {
        100% {
            transform: rotate(360deg);
            -webkit-transform: rotate(360deg)
        }
    }

    @-webkit-keyframes circle_bounce {

        0%,
        100% {
            -webkit-transform: scale(0.0)
        }

        50% {
            -webkit-transform: scale(1.0)
        }
    }

    @keyframes circle_bounce {

        0%,
        100% {
            -webkit-transform: scale(0.0);
            transform: scale(0.0);
        }

        50% {
            -webkit-transform: scale(1.0);
            transform: scale(1.0);
        }
    }

</style>
<body>
<div id="loader">
    <div class="circle">
        <div class="circle1"></div>
        <div class="circle2"></div>
    </div>
</div>
<div class="header scrolling" id="myHeader">
    <jsp:include page="./component/_grid.jsp"/>
    <%--menu --%>
    <jsp:include page="./component/_header.jsp"/>
</div>
<div class="main1">
    <jsp:include page="./component/_menu5.jsp"/>
    <div class="main">
        <div class="details">
            <jsp:include page="./component/${content}"/>
            <jsp:include page="./component/_rightCustomer.jsp"/>
        </div>
    </div>
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
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script type="text/javascript" src="/js/chart-admin.js"></script>
<script>
    //menu toggle
    let toggle = document.querySelector('.toggle');
    let navigation = document.querySelector('.navigation');
    let main = document.querySelector('.main');

    toggle.onclick = function () {
        navigation.classList.toggle('active');
        main.classList.toggle('active');
    }

    //add class
    let list = document.querySelectorAll('.navigation li');

    function activeLink() {
        list.forEach(
            (item) => item.classList.remove('hovered')
        );
        this.classList.add('hovered');
    }

    list.forEach(
        (item) => item.addEventListener('mouseover', activeLink)
    )

</script>
<script src="/js/contact.js"></script>
<script src="/js/cartCript.js"></script>
<script src="/js/checkout.js"></script>
</body>

</html>