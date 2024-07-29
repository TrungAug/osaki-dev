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
    <title>Danh sách sản phẩm</title>
    <!-- Font roboto -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link
            href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@100;200;300;400;500;600;700;800;900&display=swap"
            rel="stylesheet">
    <!-- Icon fontanwesome -->
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
          integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
    <!-- Reset css & grid sytem -->
    <link rel="stylesheet" type="text/css" href="/css/library.css">
    <!-- Layout -->
    <link rel="stylesheet" type="text/css" href="/css/common.css">
    <link href="/css/home.css" type="text/css" rel="stylesheet"/>
    <script src="https://cdn.jsdelivr.net/npm/autonumeric@4"></script>

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
    <%--     icon --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
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
    <link rel="stylesheet" type="text/css" href="/css/product.css">
    <link rel="stylesheet" type="text/css" href="/css/productSale.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">


</head>
<style>
    .swal2-popup {
        font-size: 2rem;
    }

    a {
        text-decoration: none;
    }

    .container {
        display: block;
        position: relative;
        padding-left: 35px;
        margin-bottom: 12px;
        cursor: pointer;
        font-size: 22px;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
    }

    /* Hide the browser's default checkbox */
    .container input {
        position: absolute;
        opacity: 0;
        cursor: pointer;
        height: 0;
        width: 0;
    }

    /* Create a custom checkbox */
    .checkmark {
        position: absolute;
        top: 0;
        left: 0;
        height: 25px;
        width: 25px;
        background-color: #eee;
    }

    /* On mouse-over, add a grey background color */
    .container:hover input ~ .checkmark {
        background-color: #ccc;
    }

    /* When the checkbox is checked, add a blue background */
    .container input:checked ~ .checkmark {
        background-color: #2196F3;
    }

    /* Create the checkmark/indicator (hidden when not checked) */
    .checkmark:after {
        content: "";
        position: absolute;
        display: none;
    }

    /* Show the checkmark when checked */
    .container input:checked ~ .checkmark:after {
        display: block;
    }

    /* Style the checkmark/indicator */
    .container .checkmark:after {
        left: 9px;
        top: 5px;
        width: 5px;
        height: 10px;
        border: solid white;
        border-width: 0 3px 3px 0;
        -webkit-transform: rotate(45deg);
        -ms-transform: rotate(45deg);
        transform: rotate(45deg);
    }

    .header__top {
        background-color: #523e02;
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

    .btn-primary.active {
        background-color: green; /* Đổi màu nền của nút khi nó được kích hoạt */
        color: white; /* Đổi màu chữ của nút khi nó được kích hoạt */
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
    <div class="mb-3"></div>
    <%--menu --%>
    <jsp:include page="./component/_header.jsp"/>
</div>
<div class="main">
    <div class="grid wide">
        <div class="main__taskbar">
            <div class="main__sort">
                <h3 class="sort__title">
                    Hiển thị kết quả theo
                </h3>

                <h3><a class="btn btn-primary m-md-2 " href="/list/product">Mới nhất</a></h3>
                <h3><a href="/product/filterByPrice?sort=asc" class="btn btn-primary m-md-2">Giá thấp đến cao</a></h3>
                <h3><a href="/product/filterByPrice?sort=desc" class="btn btn-primary m-md-2">Giá cao đến thấp</a></h3>
                <h3><a href="/product/filter-product-by-promotional" class="btn btn-primary m-md-2">Khuyến mãi</a></h3>
                <h3><a href="/product/bestselling" class="btn btn-primary m-md-2">Bán chạy</a></h3>
                <form action="/product/filterByPrice" style="white-space: nowrap;">
                    <input type="number" class="" style="font-size: 16px; width: 220px "
                           name="minPromotional" min="0"
                           placeholder="Phần trăm khuyến mãi từ" required>
                    <input type="number" class=" " style="font-size: 16px;width: 220px"
                           name="maxPromotional" max="100"
                           placeholder="Phần trăm khuyến mãi đến" required>
                    <button class="btn btn-primary" id="btn-primary-promotional"
                            style=" padding:6px; margin-bottom: 5px ">Áp dụng
                    </button>
                </form>
            </div>
        </div>
        <div class="productList">
            <div class="row">
                <div class="col-lg-3">
                    <h2>Lọc giá:</h2>
                    <form action="/product/filterByPrice">
                        <input type="text" class="form-control autonumeric" style="font-size: 16px" value="${minPrice}"
                               name="minPrice"
                               placeholder="Từ" required>
                        <input type="text" class="form-control autonumeric" style="font-size: 16px" value="${maxPrice}"
                               name="maxPrice"
                               placeholder="Đến" required>
                        <button class="btn btn-primary mt-2 kwSearchPrice" id="btn-primary">Áp dụng</button>
                    </form>


                    <h1>Danh mục</h1>
                    <c:forEach items="${listCategories }" var="c" varStatus="i">
                        <label class="container" data-category="${c.categoryID}">${c.categoryName}
                            <input type="checkbox" data-category="${c.categoryID}" class="category-checkbox"
                                   value="${c.categoryName}">
                            <span class="checkmark"></span>
                        </label>
                    </c:forEach>
                    <!-- Checkbox 2 -->
                </div>
                <div class="col-lg-9">
                    <div id="product-list"></div>
                    <div class="row" id="removeProduct">
                        <c:forEach var="p" items="${productPage.content}">
                            <c:if test="${!p.isDelete}">
                                <div class="col-lg-3 col-md-4 col-sm-6 mb-3">
                                    <a href="/product/${p.productID}">
                                        <div class="product">
                                            <c:set var="foundFirst" value="false"/>
                                            <c:forEach var="imgProduct" items="${imagesProduct}"
                                                       varStatus="i">
                                                <c:if test="${!foundFirst && p.productID == imgProduct.productID.productID}">
                                                    <c:set var="foundFirst" value="true"/>
                                                    <img src="/imagesProduct/${imgProduct.imageName}" alt="Không có"
                                                         style="width: 210px;height: 190px">
                                                </c:if>
                                            </c:forEach>

                                            <div class="product__info">
                                                <h3 class="product__name">${p.name}</h3>
                                                <div class="product__price">
                                                    <c:set var="checkListPromotionalDetail" value="false"/>
                                                    <c:forEach var="pdProduct" items="${listPromotionalDetail}">
                                                        <c:if test="${pdProduct.productID.productID == p.productID}">
                                                            <c:set var="checkListPromotionalDetail"
                                                                   value="true"/>
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:choose>
                                                        <c:when test="${checkListPromotionalDetail}">
                                                            <c:forEach var="pdProduct"
                                                                       items="${listPromotionalDetail}">
                                                                <c:if test="${pdProduct.productID.productID == p.productID}">
                                                                    <div class="product__price">
                                                                        <div class="price__old">
                                                                            <fmt:formatNumber
                                                                                    type="number"
                                                                                    pattern="###,###,###"
                                                                                    value="${p.price}"/> <span
                                                                                class="price__unit"> đ</span>
                                                                        </div>
                                                                        <c:choose>
                                                                            <c:when test="${p.quantityInStock>0}">
                                                                                <div class="price__new price"
                                                                                     style="margin-left: 30px">
                                                                                    <fmt:formatNumber
                                                                                            type="number"
                                                                                            pattern="###,###,###"
                                                                                            value="${pdProduct.discountedPrice}"/>
                                                                                    <span class="price__unit">đ</span>
                                                                                </div>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span class="price__unit">Tạm hết hàng</span>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </div>
                                                                    <div class="product__sale">
                                                                                    <span class="product__sale-percent">
                                                                                            -<fmt:formatNumber
                                                                                            type="number"
                                                                                            pattern="###,###,###"
                                                                                            value="${(p.price - pdProduct.discountedPrice)/p.price *100}"/>%
                                                                            </span>
                                                                        <span class="product__sale-text"
                                                                              style="font-size: 8px">Giảm</span>
                                                                    </div>
                                                                </c:if>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:choose>
                                                                <c:when test="${p.quantityInStock>0}">
                                                                    <div class="price__new price"><fmt:formatNumber
                                                                            type="number"
                                                                            pattern="###,###,###"
                                                                            value="${p.price}"/>
                                                                        <span class="price__unit">đ</span></div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="price__unit">Tạm hết hàng</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <c:forEach var="pdProduct" items="${listPromotionalDetail}">
                                                        <c:if test="${pdProduct.productID.productID == p.productID}">
                                                            <div class="product__sale">
                                                                            <span
                                                                                    class="product__sale-percent">
                                                                                            -<fmt:formatNumber
                                                                                    type="number"
                                                                                    pattern="###,###,###"
                                                                                    value="${(p.price - pdProduct.discountedPrice)/p.price *100}"/>%
                                                                            </span>
                                                                <span class="product__sale-text"
                                                                      style="font-size: 8px">Giảm</span>
                                                            </div>
                                                        </c:if>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                            <a href="/product/${p.productID}" class="viewDetail">Xem chi
                                                                                                 tiết</a>
                                            <a href="#" title="cart" data-product-id="${p.productID}"
                                               data-user-id="${userLogin.userID}" class="addToCart">Thêm vào
                                                                                                    giỏ</a>
                                            <c:set var="checkLike" value="false"/>
                                            <c:forEach items="${likeList }" var="lp" varStatus="i">
                                                <c:if test="${lp.productID.productID == p.productID }">
                                                    <c:set var="checkLike" value="true"/>
                                                </c:if>
                                            </c:forEach>
                                            <c:choose>
                                                <c:when test="${checkLike }">
                                                    <a title="Wishlist" href="#"
                                                       class="siteLikeProduct m-md-3"
                                                       data-product-id="${p.productID}"
                                                       data-user-id="${userLogin.userID}">
                                                        <i class="bi-heart-fill"></i>
                                                        <span class="title-like">Xóa yêu thích</span>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a title="Wishlist" href="#"
                                                       class="siteLikeProduct m-md-3"
                                                       data-product-id="${p.productID}"
                                                       data-user-id="${userLogin.userID}">
                                                        <i class="bi-heart"></i>
                                                        <span class="title-like">Thêm vào yêu thích</span>
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:forEach items="${listCategories }" var="c" varStatus="i">
                                                <c:if test="${c.categoryID == p.categoryID.categoryID}">
                                                    <span class="category">${c.categoryName}</span>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </a>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                    <c:if test="${countBrand>0}">
                        <div class="pagination">
                            <ul class="pagination__list">
                                <li class="pagination__item">
                                    <c:if test="${productPage.number != 0}">
                                        <a href="?page=${productPage.number - 1}&size=${productPage.size}"
                                           class="pagination__link">
                                            <i class="fas fa-chevron-left"></i>
                                        </a>
                                    </c:if>
                                </li>
                                <c:forEach begin="0" end="${productPage.totalPages - 1}" var="i">
                                    <li class="pagination__item ${productPage.number == i ? 'active' : ''}">
                                        <a href="?page=${i}&size=${productPage.size}"
                                           class="pagination__link">${i + 1}</a>
                                    </li>
                                </c:forEach>
                                <li class="pagination__item">
                                    <c:if test="${!productPage.last}">
                                        <a href="?page=${productPage.number + 1}&size=${productPage.size}"
                                           class="pagination__link">
                                            <i class="fas fa-chevron-right"></i>
                                        </a>
                                    </c:if>
                                </li>
                            </ul>
                        </div>
                    </c:if>
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
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var autoNumericInputs = document.getElementsByClassName('autonumeric');
        for (var i = 0; i < autoNumericInputs.length; i++) {
            new AutoNumeric(autoNumericInputs[i]);
        }
    });

    document.addEventListener('DOMContentLoaded', function () {
        var buttons = document.querySelectorAll('.btn-primary');

        buttons.forEach(function (button) {
            button.addEventListener('click', function () {
                buttons.forEach(function (btn) {
                    btn.classList.remove('active');
                });

                this.classList.add('active');

                // Lưu trạng thái của nút vào localStorage
                localStorage.setItem('activeButton', this.getAttribute('href'));
            });
        });

        // Kiểm tra nếu có trạng thái được lưu trước đó và áp dụng nó khi tải trang
        var activeButton = localStorage.getItem('activeButton');
        if (activeButton) {
            buttons.forEach(function (button) {
                if (button.getAttribute('href') === activeButton) {
                    button.classList.add('active');
                }
            });
        }
    });
</script>
<!-- Modal Form -->
<script src="/js/listProduct.js"></script>
<script src="../js/isotope.pkgd.js"></script>
<!-- Script common -->
<script src="/js/contact.js"></script>
<script src="/js/commonscript.js"></script>
<script src="../../js/register.js"></script>
<script src="/js/homeScript.js"></script>
<script src="/js/login.js"></script>
<script src="/js/commonscript.js"></script>
<script src="/js/likeProduct.js"></script>
<script src="/js/cartCript.js"></script>
<script src="/js/checkout.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
</body>

</html>