<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<!-- https://cocoshop.vn/ -->
<!-- http://mauweb.monamedia.net/vanihome/ -->

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ</title>
    <!-- Font roboto -->
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
    <%--     bootstrap --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Latest compiled JavaScript -->
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
    <%--     icon --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        .swal2-popup {
            font-size: 2rem;
        }

        .category {
            margin-left: 10px;
            position: absolute;
            left: 0;
            top: 0;
        }

        /* Ẩn thẻ <span> khi không hover vào <a> */
        a {
            text-decoration: none;
        }


        .header__nav-item {
            background-color: #523e02;
            margin-right: 20px;
            font-weight: bold;
        }

        #countdown {
            font-family: Arial, Helvetica, sans-serif;
            width: 400px;
            margin: 0 auto;
            text-align: center;
            padding: 2vh;
            background: red;
            border-radius: 100px;
            color: #fff;
            font-size: 20px;
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
</head>

<body>
<div id="loader">
    <div class="circle">
        <div class="circle1"></div>
        <div class="circle2"></div>
    </div>
</div>
<%-- header --%>
<div class="header scrolling" id="myHeader">
    <jsp:include page="./component/_grid.jsp"/>
    <%--menu --%>
    <jsp:include page="./component/_header.jsp"/>
</div>
<%-- main --%>
<div class="main">
    <!-- Slider -->
    <jsp:include page="./component/_slice.jsp"/>
    <!--Product Category -->
    <jsp:include page="./component/_tabnine.jsp"/>
    <!-- HightLight  -->
    <jsp:include page="./component/_outstanding.jsp"/>
</div>

<div class="main__policy">
    <div class="row">
        <div class="col l-3 m-6">
            <div class="policy bg-1">
                <img src="./images/policy/policy1.png" class="policy__img"></img>
                <div class="policy__info">
                    <h3 class="policy__title">GIAO HÀNG MIỄN PHÍ</h3>
                    <p class="policy__description">Cho tất cả các đơn hàng</p>
                </div>
            </div>
        </div>
        <div class="col l-3 m-6">
            <div class="policy bg-2">
                <img src="./images/policy/policy2.png" class="policy__img"></img>
                <div class="policy__info">
                    <h3 class="policy__title">ĐỔI TRẢ HÀNG</h3>
                    <p class="policy__description">Trong 3 ngày đầu tiên</p>
                </div>
            </div>
        </div>
        <div class="col l-3 m-6">
            <div class="policy bg-1">
                <img src="./images/policy/policy3.png" class="policy__img"></img>
                <div class="policy__info">
                    <h3 class="policy__title">HÀNG CHÍNH HÃNG</h3>
                    <p class="policy__description">Cam kết chất lượng</p>
                </div>
            </div>
        </div>
        <div class="col l-3 m-6">
            <div class="policy bg-2">
                <img src="./images/policy/policy4.png" class="policy__img"></img>
                <div class="policy__info">
                    <h3 class="policy__title">TƯ VẤN 24/24</h3>
                    <p class="policy__description">Giải đáp mọi thắc mắc</p>
                </div>
            </div>
        </div>

    </div>
</div>
<!--footer -->
<div class="footer">
    <jsp:include page="./component/_footer.jsp"/>
</div>
<div class="up-top" id="upTop" onclick="goToTop()">
    <i class="fas fa-chevron-up"></i>
</div>

<!-- Modal -->
<jsp:include page="component/_modal.jsp"/>

<%-- <script> --%>
<%--     $('.owl-carousel.hight').owlCarousel({ --%>
<%--         loop: true, --%>
<%--         margin: 20, --%>
<%--         nav: true, --%>
<%--         dots: false, --%>
<%--         autoplay: true, --%>
<%--         autoplayTimeout: 3000, --%>
<%--         autoplayHoverPause: true, --%>
<%--         responsive: { --%>
<%--             0: { --%>
<%--                 items: 2 --%>
<%--             }, --%>
<%--             600: { --%>
<%--                 items: 3 --%>
<%--             }, --%>
<%--             1000: { --%>
<%--                 items: 5 --%>
<%--             } --%>
<%--         } --%>
<%--     }) --%>
<%--     $('.owl-carousel.news').owlCarousel({ --%>
<%--         loop: true, --%>
<%--         margin: 20, --%>
<%--         nav: true, --%>
<%--         dots: false, --%>
<%--         autoplay: true, --%>
<%--         autoplayTimeout: 4000, --%>
<%--         autoplayHoverPause: true, --%>
<%--         responsive: { --%>
<%--             0: { --%>
<%--                 items: 1 --%>
<%--             }, --%>
<%--             600: { --%>
<%--                 items: 1 --%>
<%--             }, --%>
<%--             1000: { --%>
<%--                 items: 2 --%>
<%--             } --%>
<%--         } --%>
<%--     }) --%>
<%--     $('.owl-carousel.bands').owlCarousel({ --%>
<%--         loop: true, --%>
<%--         margin: 20, --%>
<%--         nav: false, --%>
<%--         dots: false, --%>
<%--         autoplay: true, --%>
<%--         autoplayTimeout: 2000, --%>
<%--         autoplayHoverPause: true, --%>
<%--         responsive: { --%>
<%--             0: { --%>
<%--                 items: 2 --%>
<%--             }, --%>
<%--             600: { --%>
<%--                 items: 3 --%>
<%--             }, --%>
<%--             1000: { --%>
<%--                 items: 6 --%>
<%--             } --%>
<%--         } --%>
<%--     }) --%>
<%-- </script> --%>
<!-- Script common -->
<script src="../../js/register.js"></script>
<script src="/js/contact.js"></script>
<script src="/js/homeScript.js"></script>
<script src="/js/login.js"></script>
<script src="/js/commonscript.js"></script>
<script src="/js/likeProduct.js"></script>
<script src="/js/cartCript.js"></script>
<script src="/js/checkout.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>