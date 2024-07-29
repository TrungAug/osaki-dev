<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <title>Thanh Toán</title>
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
    <!-- Owl Slider css -->
    <link rel="stylesheet" href="/owlCarousel/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="/owlCarousel/assets/owl.theme.default.min.css">
    <!-- Layout -->
    <link rel="stylesheet" href="/css/common.css">
    <!-- index -->
    <link rel="stylesheet" type="text/css" href="/css/pay.css">
    <!-- Jquery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Owl caroucel Js-->
    <script src="/owlCarousel/owl.carousel.min.js"></script>
</head>
<style>
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
    <div class="grid wide">
        <div class="row">
            <div class="col l-7 m-12 s-12">
                <div class="pay-information">
                    <div class="pay__heading">Thông tin thanh toán</div>
                    <div class="form-group">
                        <label for="account" class="form-label">Họ Tên *</label>
                        <input id="account" name="account" type="text" class="form-control">
                        <span class="form-message">Không hợp lệ !</span>
                    </div>
                    <div class="form-group">
                        <label for="account" class="form-label">Địa chỉ *</label>
                        <input id="account" name="account" type="text" class="form-control">
                        <span class="form-message"></span>
                    </div>
                    <div class="form-group">
                        <label for="account" class="form-label">Tỉnh / Thành phố *</label>
                        <input id="account" name="account" type="text" class="form-control">
                        <span class="form-message"></span>
                    </div>
                    <div class="form-group">
                        <label for="account" class="form-label">Email *</label>
                        <input id="account" name="account" type="text" class="form-control">
                        <span class="form-message"></span>
                    </div>
                    <div class="form-group">
                        <label for="account" class="form-label">Số điện thoại *</label>
                        <input id="account" name="account" type="text" class="form-control">
                        <span class="form-message"></span>
                    </div>
                    <div class="form-group">
                        <label for="account" class="form-label">Ghi chú cho đơn hàng</label>
                        <textarea class="form-control" name="" id="" cols="30" rows="20"></textarea>
                    </div>
                </div>
            </div>
            <div class="col l-5 m-12 s-12">
                <div class="pay-order">
                    <div class="pay__heading">Đơn hàng của bạn</div>
                    <div class="pay-info">
                        <div class="main__pay-text">
                            Azrouel dress variable
                        </div>
                        <div class="main__pay-price">
                            1,120,000 ₫
                        </div>
                    </div>
                    <div class="pay-info">
                        <div class="main__pay-text">
                            Azrouel dress variable
                        </div>
                        <div class="main__pay-amount">
                            3
                        </div>
                        <div class="main__pay-price">
                            1,120,000 ₫
                        </div>
                    </div>
                    <div class="pay-info">
                        <div class="main__pay-text">
                            Azrouel dress variable
                        </div>
                        <div class="main__pay-price">
                            1,120,000 ₫
                        </div>
                    </div>
                    <div class="pay-info">
                        <div class="main__pay-text special">
                            Giao hàng
                        </div>
                        <div class="main__pay-text">
                            Giao hàng miễn phí
                        </div>

                    </div>
                    <div class="pay-info">
                        <div class="main__pay-text special">
                            Tổng thành tiền
                        </div>
                        <div class="main__pay-price">
                            1,120,000 ₫
                        </div>
                    </div>
                    <div class="btn btn--default">Đặt hàng</div>
                </div>

            </div>
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


</body>

</html>