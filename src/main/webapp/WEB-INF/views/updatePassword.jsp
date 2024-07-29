<%--
  Created by IntelliJ IDEA.
  User: Hoang Tuan
  Date: 1/23/2024
  Time: 3:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${title }</title>
    <!-- Title Tag  -->
    <!-- Favicon -->
    <link rel="icon" type="image/png" href="../../images/favicon.png">
    <!-- Web Font -->
    <link
            href="https://fonts.googleapis.com/css?family=Roboto:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap"
            rel="stylesheet">

    <!-- StyleSheet -->
    <script
            src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

    <!-- Bootstrap -->
    <link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
    <!-- Magnific Popup -->
    <link rel="stylesheet" href="../../css/magnific-popup.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../css/font-awesome.css">
    <!-- Fancybox -->
    <link rel="stylesheet" href="../../css/jquery.fancybox.min.css">
    <!-- Themify Icons -->
    <link rel="stylesheet" href="../../css/themify-icons.css">
    <!-- Nice Select CSS -->
    <link rel="stylesheet" href="../../css/niceselect.css">
    <!-- Animate CSS -->
    <link rel="stylesheet" href="../../css/animate.css">
    <!-- Flex Slider CSS -->
    <link rel="stylesheet" href="../../css/flex-slider.min.css">
    <!-- Owl Carousel -->
    <link rel="stylesheet" href="../../css/owl-carousel.css">
    <!-- Slicknav -->
    <link rel="stylesheet" href="../../css/slicknav.min.css">

    <!-- Eshop StyleSheet -->
    <link rel="stylesheet" href="../../css/reset.css">
    <link rel="stylesheet" href="../../style.css">
    <link rel="stylesheet" href="../../css/responsive.css">

    <link rel="stylesheet" href="../../css/custom-nav.css">
    <link rel="stylesheet" href="../css/register.css">
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link
            href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@100;200;300;400;500;600;700;800;900&display=swap"
            rel="stylesheet">
    <!-- Icon fontanwesome -->
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
          integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
    <!-- Reset css & grid sytem -->
    <link rel="stylesheet" href="/css/library.css">
    <link href="/owlCarousel/assets/owl.carousel.min.css" rel="stylesheet"/>
    <!-- Layout -->
    <link rel="stylesheet" href="/css/common.css">
    <!-- index -->
    <link href="/css/home.css" rel="stylesheet"/>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Owl caroucel Js-->
    <script src="/owlCarousel/owl.carousel.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <!-- Bao gồm thư viện Swal -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.16/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.16/dist/sweetalert2.all.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css"/>
    <%--     <script --%>
    <%--             src="<c:url value="/webjars/sweetalert2/11.7.12/dist/sweetalert2.min.js"/>"></script> --%>
    <%--     <link rel="stylesheet" --%>
    <%--           href="<c:url value="/webjars/sweetalert2/11.7.12/dist/sweetalert2.min.css"/>"> --%>
    <%--     <c:if test="${views =='address'}"> --%>
    <%--         <link rel="stylesheet" --%>
    <%--               href="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.15.2/css/selectize.default.min.css" --%>
    <%--               integrity="sha512-pTaEn+6gF1IeWv3W1+7X7eM60TFu/agjgoHmYhAfLEU8Phuf6JKiiE8YmsNC0aCgQv4192s4Vai8YZ6VNM6vyQ==" --%>
    <%--               crossorigin="anonymous" referrerpolicy="no-referrer"/> --%>
    <%--         <script --%>
    <%--                 src="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.15.2/js/selectize.min.js" --%>
    <%--                 integrity="sha512-IOebNkvA/HZjMM7MxL0NYeLYEalloZ8ckak+NDtOViP7oiYzG5vn6WVXyrJDiJPhl4yRdmNAG49iuLmhkUdVsQ==" --%>
    <%--                 crossorigin="anonymous" referrerpolicy="no-referrer"></script> --%>
    <%--     </c:if> --%>
    <%--     <c:if test="${views =='purchasedOrder'}"> --%>
    <%--         <link rel="stylesheet" href="../../css/purchased-order.css"> --%>
    <%--     </c:if> --%>
    <%--     <link rel="stylesheet" href="../../css/profile.css"> --%>
    <%--     <link rel="stylesheet" --%>
    <%--           href="<c:url value="/webjars/bootstrap-icons/1.10.5/font/bootstrap-icons.css" />"> --%>
    <style type="text/css">
        .loadingspinner {
            --square: 26px;
            --offset: 30px;
            --duration: 2.4s;
            --delay: 0.2s;
            --timing-function: ease-in-out;
            --in-duration: 0.4s;
            --in-delay: 0.1s;
            --in-timing-function: ease-out;
            width: calc(3 * var(--offset) + var(--square));
            height: calc(2 * var(--offset) + var(--square));
            padding: 0px;
            margin-left: auto;
            margin-right: auto;
            margin-top: 10px;
            margin-bottom: 30px;
            position: relative;
        }

        .swal2-popup {
            font-size: 2rem;
        }

        .loadingspinner div {
            display: inline-block;
            background: darkorange;
            /*background: var(--text-color);*/
            /*box-shadow: 1px 1px 1px rgba(0, 0, 0, 0.4);*/
            border: none;
            border-radius: 2px;
            width: var(--square);
            height: var(--square);
            position: absolute;
            padding: 0px;
            margin: 0px;
            font-size: 6pt;
            color: black;
        }

        .loadingspinner #square1 {
            left: calc(0 * var(--offset));
            top: calc(0 * var(--offset));
            animation: square1 var(--duration) var(--delay) var(--timing-function) infinite,
            squarefadein var(--in-duration) calc(1 * var(--in-delay)) var(--in-timing-function) both;
        }

        .loadingspinner #square2 {
            left: calc(0 * var(--offset));
            top: calc(1 * var(--offset));
            animation: square2 var(--duration) var(--delay) var(--timing-function) infinite,
            squarefadein var(--in-duration) calc(1 * var(--in-delay)) var(--in-timing-function) both;
        }

        .loadingspinner #square3 {
            left: calc(1 * var(--offset));
            top: calc(1 * var(--offset));
            animation: square3 var(--duration) var(--delay) var(--timing-function) infinite,
            squarefadein var(--in-duration) calc(2 * var(--in-delay)) var(--in-timing-function) both;
        }

        .loadingspinner #square4 {
            left: calc(2 * var(--offset));
            top: calc(1 * var(--offset));
            animation: square4 var(--duration) var(--delay) var(--timing-function) infinite,
            squarefadein var(--in-duration) calc(3 * var(--in-delay)) var(--in-timing-function) both;
        }

        .loadingspinner #square5 {
            left: calc(3 * var(--offset));
            top: calc(1 * var(--offset));
            animation: square5 var(--duration) var(--delay) var(--timing-function) infinite,
            squarefadein var(--in-duration) calc(4 * var(--in-delay)) var(--in-timing-function) both;
        }

        @keyframes square1 {
            0% {
                left: calc(0 * var(--offset));
                top: calc(0 * var(--offset));
            }

            8.333% {
                left: calc(0 * var(--offset));
                top: calc(1 * var(--offset));
            }

            100% {
                left: calc(0 * var(--offset));
                top: calc(1 * var(--offset));
            }
        }

        @keyframes square2 {
            0% {
                left: calc(0 * var(--offset));
                top: calc(1 * var(--offset));
            }

            8.333% {
                left: calc(0 * var(--offset));
                top: calc(2 * var(--offset));
            }

            16.67% {
                left: calc(1 * var(--offset));
                top: calc(2 * var(--offset));
            }

            25.00% {
                left: calc(1 * var(--offset));
                top: calc(1 * var(--offset));
            }

            83.33% {
                left: calc(1 * var(--offset));
                top: calc(1 * var(--offset));
            }

            91.67% {
                left: calc(1 * var(--offset));
                top: calc(0 * var(--offset));
            }

            100% {
                left: calc(0 * var(--offset));
                top: calc(0 * var(--offset));
            }
        }

        @keyframes square3 {
            0%, 100% {
                left: calc(1 * var(--offset));
                top: calc(1 * var(--offset));
            }

            16.67% {
                left: calc(1 * var(--offset));
                top: calc(1 * var(--offset));
            }

            25.00% {
                left: calc(1 * var(--offset));
                top: calc(0 * var(--offset));
            }

            33.33% {
                left: calc(2 * var(--offset));
                top: calc(0 * var(--offset));
            }

            41.67% {
                left: calc(2 * var(--offset));
                top: calc(1 * var(--offset));
            }

            66.67% {
                left: calc(2 * var(--offset));
                top: calc(1 * var(--offset));
            }

            75.00% {
                left: calc(2 * var(--offset));
                top: calc(2 * var(--offset));
            }

            83.33% {
                left: calc(1 * var(--offset));
                top: calc(2 * var(--offset));
            }

            91.67% {
                left: calc(1 * var(--offset));
                top: calc(1 * var(--offset));
            }
        }

        @keyframes square4 {
            0% {
                left: calc(2 * var(--offset));
                top: calc(1 * var(--offset));
            }

            33.33% {
                left: calc(2 * var(--offset));
                top: calc(1 * var(--offset));
            }

            41.67% {
                left: calc(2 * var(--offset));
                top: calc(2 * var(--offset));
            }

            50.00% {
                left: calc(3 * var(--offset));
                top: calc(2 * var(--offset));
            }

            58.33% {
                left: calc(3 * var(--offset));
                top: calc(1 * var(--offset));
            }

            100% {
                left: calc(3 * var(--offset));
                top: calc(1 * var(--offset));
            }
        }

        @keyframes square5 {
            0% {
                left: calc(3 * var(--offset));
                top: calc(1 * var(--offset));
            }

            50.00% {
                left: calc(3 * var(--offset));
                top: calc(1 * var(--offset));
            }

            58.33% {
                left: calc(3 * var(--offset));
                top: calc(0 * var(--offset));
            }

            66.67% {
                left: calc(2 * var(--offset));
                top: calc(0 * var(--offset));
            }

            75.00% {
                left: calc(2 * var(--offset));
                top: calc(1 * var(--offset));
            }

            100% {
                left: calc(2 * var(--offset));
                top: calc(1 * var(--offset));
            }
        }

        @keyframes squarefadein {
            0% {
                transform: scale(0.75);
                opacity: 0.0;
            }

            100% {
                transform: scale(1.0);
                opacity: 1.0;
            }
        }

    </style>
</head>
<body class="js">
<div class="container-fluid">
    <div class="row register-background">
        <div class="col-lg-12 d-flex align-items-center">
            <div class="container my-1 d-flex justify-content-center   formRegister">

                <form action="/account/register" method="post" id="formRegister" class="form-register">
                    <div class="form-group">
                        <label class="form-label pt-4">Mật khẩu *</label>
                        <input type="password" name="password" required="required" id="forgot_password"
                               class="form-control">
                        <small class="text-danger" id="passwordError"></small>
                    </div>
                    <div class="form-group">
                        <label class="form-label pt-4">Nhập lại mật khẩu *</label>
                        <input type="password" name="confirmPassword" required="required" id="forgot_confirm_password"
                               class="form-control">
                        <small class="text-danger" id="confirmPasswordError"></small>
                    </div>
                    <div id="error"></div>
                    <div class="d-flex justify-content-center mt-4 mb-3">
                        <button class="btn btn-primary form-control" id="submitUpdatePassword">Cap nhat mat khau
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="/js/updatePassword.js"></script>
<!-- Start Footer Area -->
<!-- /End Footer Area -->

<!-- Jquery -->

<script src="../../js/jquery-migrate-3.0.0.js"></script>
<script src="../../js/jquery-ui.min.js"></script>
<!-- Popper JS -->
<script src="../../js/popper.min.js"></script>
<!-- Bootstrap JS -->
<script src="../../js/bootstrap.min.js"></script>
<!-- Color JS -->
<!--
<script src="../../js/colors.js"></script> -->
<!-- Slicknav JS -->
<script src="../../js/slicknav.min.js"></script>
<!-- Owl Carousel JS -->
<script src="../../js/owl-carousel.js"></script>
<!-- Magnific Popup JS -->
<script src="../../js/magnific-popup.js"></script>
<!-- Waypoints JS -->
<script src="../../js/waypoints.min.js"></script>
<!-- Countdown JS -->
<script src="../../js/finalcountdown.min.js"></script>
<!-- Nice Select JS -->
<script src="../../js/nicesellect.js"></script>
<!-- Flex Slider JS -->
<script src="../../js/flex-slider.js"></script>
<!-- ScrollUp JS -->
<script src="../../js/scrollup.js"></script>
<!-- Onepage Nav JS -->
<script src="../../js/onepage-nav.min.js"></script>
<!-- Easing JS -->
<script src="../../js/easing.js"></script>
<!-- Active JS -->
<script src="../../js/active.js"></script>
<script src="../../js/hover-nav.js"></script>


</body>
</html>
