<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tin tức</title>
    <!-- Font roboto -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link
            href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@100;200;300;400;500;600;700;800;900&display=swap"
            rel="stylesheet">
    <!-- Icon fontanwesome -->
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
          integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
    <!-- Reset css & grid sytem -->
    <link rel="stylesheet" href="./css/library.css">
    <!-- Owl Slider css -->
    <link rel="stylesheet" href="./owlCarousel/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="./owlCarousel/assets/owl.theme.default.min.css">
    <!-- Layout -->
    <link rel="stylesheet" href="./css/common.css">
    <!-- index -->
    <link rel="stylesheet" type="text/css" href="./css/new.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.16/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.16/dist/sweetalert2.all.min.js"></script>
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
    <!-- Owl caroucel Js-->
    <script src="./owlCarousel/owl.carousel.min.js"></script>
</head>
<style>
      .text-muted{
        text-decoration: line-through;
        margin-right: 54px;
    }
    .swal2-popup {
        font-size: 2rem;
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
<div class="main">
    <div class="grid wide">
        <div class="main__taskbar">
            <div class="main__breadcrumb">
                <div class="breadcrumb__item">
                    <a href="/" class="breadcrumb__link">Trang chủ</a>
                </div>
                <div class="breadcrumb__item">
                    <a href="/news" class="breadcrumb__link">Danh sách tin tức</a>
                </div>
            </div>
        </div>
        <div class="list-new">
            <div href="#" class="new-item">
                <c:forEach var="newsList" items="${newsList}">
                    <a href="#" class="new-item__img">
                        <img src="https://www.kosmebox.com/image/cache/data/BLOG/Nhung-item-makeup-nha-etude-house-gia-hat-de/Nhung-item-makeup-nha-etude-house-gia-hat-de-7-9-225x225.jpg"
                             alt="">
                    </a>
                    <div class="new-item__body">
                        <a href="#" class="new-item__title">
                                ${newsList.title}
                        </a>
                        <p class="new-item__time"> Ngày đăng: <fmt:formatDate pattern="dd/MM/yyyy"
                                                                              value="${newsList.dateAt}"/></p>
                        <h4 class="new-item__description">${newsList.message}</h4>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="footer">
        <jsp:include page="./component/_footer.jsp"/>
    </div>
    <div class="up-top" id="upTop" onclick="goToTop()">
        <i class="fas fa-chevron-up"></i>
    </div>
    <!-- Modal Form -->
    <div class="ModalForm">
        <jsp:include page="./component/_modal.jsp"/>
    </div>
    <!-- Sccipt for owl caroucel -->

    <!-- Script common -->
    <script src="/js/commonscript.js"></script>
    <script src="/js/contact.js"></script>
</div>

</body>
</html>