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
    <title>Chi tiêt sản phẩm</title>
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
    <!-- Owl Slider css -->
    <link rel="stylesheet" href="/owlCarousel/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="/owlCarousel/assets/owl.theme.default.min.css">
    <!-- Layout -->
    <link rel="stylesheet" type="text/css" href="/css/common.css">
    <!-- index -->
    <link rel="stylesheet" type="text/css" href="/css/product.css">
    <!-- Jquery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Owl caroucel Js-->
    <script src="/owlCarousel/owl.carousel.min.js"></script>
    <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css">

    <!-- Bao gồm thư viện Swal -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.16/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.16/dist/sweetalert2.all.min.js"></script>
</head>
<style>
    .text-decoration-line-through {
        text-decoration: line-through;
    }

    .swal2-popup {
        font-size: 2rem;
    }

    .product {
        height: auto;
        display: block;
        background-color: var(--white-cl-1);
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        position: relative;
        will-change: transform;
        transition: all linear 0.3s;
        border: 1px solid rgba(0, 0, 0, 0.1);
    }

    table {
        border-collapse: collapse;
        width: 100%;
    }

    th, td {
        text-align: left;
        padding: 8px;
    }

    tr:nth-child(even) {
        background-color: #f2f2f2;
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
        <div class="productInfo">
            <div class="row">
                <div class="col l-5 m-12 s-12">
                    <div class="owl-carousel owl-theme" id="sync1">
                        <c:forEach var="imgProduct" items="${imagesProduct}"
                                   varStatus="i">
                            <c:if test="${product.productID == imgProduct.productID.productID}">
                                <c:set var="foundFirst" value="true"/>
                                <a href="#" class="product">
                                    <div class="product__avt"
                                         style="background-image: url(../imagesProduct/${imgProduct.imageName});">
                                    </div>
                                </a>
                            </c:if>
                        </c:forEach>
                    </div>
                    <div class="owl-carousel owl-theme" id="sync2">
                        <c:forEach var="imgProduct" items="${imagesProduct}"
                                   varStatus="i">
                            <c:if test="${product.productID == imgProduct.productID.productID}">
                                <c:set var="foundFirst" value="true"/>
                                <a href="#" class="product">
                                    <div class="product__avt"
                                         style="background-image: url(../imagesProduct/${imgProduct.imageName});">
                                    </div>
                                </a>
                            </c:if>
                        </c:forEach>
                    </div>

                </div>
                <div class="col l-7 m-12s s-12 pl">
                    <div class="main__breadcrumb">
                        <div class="breadcrumb__item">
                            <a href="/" class="breadcrumb__link">Trang chủ</a>
                        </div>
                        <div class="breadcrumb__item">
                            <a href="/list/product" class="breadcrumb__link">Sản phẩm</a>
                        </div>
                        <div class="breadcrumb__item">
                            <a href="/product/search-brand/${product.brandID.brandID}"
                               class="breadcrumb__link">${product.brandID.brandName}</a>
                        </div>
                    </div>
                    <h3 class="productInfo__name">
                        ${product.name}
                    </h3>
                    <c:if test="${product.quantityInStock == 0}">
                        <h1 style="color: red">Hết hàng</h1>
                    </c:if>
                    <c:if test="${product.quantityInStock > 0}">
                        <h1 style="color: red">Còn hàng</h1>
                    </c:if>
                    <div class="productInfo__price">
                        <c:set var="checkLike" value="false"/>
                        <c:set var="checkLikePrice" value=""/>
                        <c:forEach var="promotionalDetailsList" items="${promotionalDetailsList1}">
                            <c:if test="${promotionalDetailsList.productID.productID == product.productID}">
                                <c:set var="checkLike" value="true"/>
                                <c:set var="checkLikePrice"
                                       value="${promotionalDetailsList.discountedPrice}"/>
                            </c:if>
                        </c:forEach>
                        <c:choose>
                            <c:when test="${checkLike }">
                                                <span class="total-amount main__cart-price text-muted text-decoration-line-through me-2"
                                                      style="text-decoration: line-through;">
                                                           Giá gốc: <fmt:formatNumber
                                                        type="number"
                                                        pattern="###,###,###"
                                                        value="${product.price}"/> ₫
                                                       </span><br>
                                <span class="total-amount main__cart-price total-moneyPrice">
                                                        Giảm giá còn: <fmt:formatNumber
                                        type="number"
                                        pattern="###,###,###"
                                        value="${checkLikePrice}"/>
                                                     </span>₫
                            </c:when>
                            <c:otherwise>
                                <div class="main__cart-price total-moneyPrice"><fmt:formatNumber
                                        type="number"
                                        pattern="###,###,###"
                                        value="${product.price}"/> đ
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="productInfo__addToCart">
                        <div class="buttons_added">
                            <input class="minus is-form" type="button" value="-"
                                   data-product-id="${product.productID}"
                                   data-user-id="${userLogin.userID}"
                                   onclick="minusProduct(0) ">
                            <input aria-label="quantity" class="input-qty" max="${product.quantityInStock}" min="1"
                                   name="" type="number" value="1">
                            <input class="plus is-form" type="button" value="+"
                                   data-product-id="${product.productID}"
                                   data-user-id="${userLogin.userID}"
                                   onclick="plusProduct(0) ">
                        </div>
                        <div class=" btn btn--default orange "><a href="#" title="cart"
                                                                  data-product-id="${product.productID}"
                                                                  data-user-id="${userLogin.userID}" class="addToCart">Thêm
                                                                                                                       vào
                                                                                                                       giỏ</a>
                        </div>

                    </div>
                    <div class="productIndfo__policy ">
                        <div class="policy bg-1 ">
                            <img src="/images/policy/policy1.png " class="productIndfo__policy-img "></img>
                            <div class="productIndfo__policy-info ">
                                <h3 class="productIndfo__policy-title ">Giao hàng miễn phí</h3>
                                <p class="productIndfo__policy-description ">Cho đơn hàng từ 300K</p>
                            </div>
                        </div>
                        <div class="policy bg-2 ">
                            <img src="/images/policy/policy2.png " class="productIndfo__policy-img "></img>
                            <div class="productIndfo__policy-info ">
                                <h3 class="productIndfo__policy-title ">Đổi trả hàng</h3>
                                <p class="productIndfo__policy-description ">Cho tất cả đơn hàng</p>
                            </div>
                        </div>
                        <div class="policy bg-1 ">
                            <img src="/images/policy/policy3.png " class="productIndfo__policy-img "></img>
                            <div class="productIndfo__policy-info ">
                                <h3 class="productIndfo__policy-title ">Cam kết chất lượng</h3>
                                <p class="productIndfo__policy-description ">Trong 3 ngày đầu tiên</p>
                            </div>
                        </div>
                        <div class="policy bg-2 ">
                            <img src="/images/policy/policy4.png " class="productIndfo__policy-img "></img>
                            <div class="productIndfo__policy-info ">
                                <h3 class="productIndfo__policy-title ">Tư vấn 24/24</h3>
                                <p class="productIndfo__policy-description ">Cam kết chất lượng</p>
                            </div>
                        </div>
                    </div>
                    <div class="productIndfo__category ">
                        <p class="productIndfo__category-text"> Danh mục : <a
                                href="/product/search-category/${product.categoryID.categoryID}"
                                class="productIndfo__category-link ">${product.categoryID.categoryName}</a>
                        </p>
                        <p class="productIndfo__category-text"> Thương hiệu : <a
                                href="/product/search-brand/${product.brandID.brandID}"
                                class="productIndfo__category-link ">${product.brandID.brandName}</a>
                        </p>
                        <p class="productIndfo__category-text"> Số lượng đã bán : ${count}</p>
                        <p class="productIndfo__category-text"> Số lượng trong kho : ${product.quantityInStock}</p>

                    </div>
                </div>
            </div>
        </div>
        <div class="productDetail ">
            <div class="main__tabnine ">
                <div class="grid wide ">

                    <div class="tabs ">
                        <div class="tab-item active ">
                            Thông số sản phẩm
                        </div>
                        <div class="line "></div>
                    </div>
                    <!-- Tab content -->
                    <div class="tab-content ">
                        <table class="table table-striped" style="font-size: 20px;">
                            <tbody>
                            <tr>
                                <td>Cách sử dụng</td>
                                <td>${product.uses}</td>
                            </tr>
                            <tr>
                                <td>Bảo quản</td>
                                <td>${product.preserve}</td>
                            </tr>
                            <tr>
                                <td>Loại da</td>
                                <td>${product.skinType}</td>
                            </tr>
                            <tr>
                                <td>Chứng nhận</td>
                                <td>${product.certification}</td>
                            </tr>
                            <tr>
                                <td>Ngày sản xuất</td>
                                <td>${product.formattedDateOfManufacture}</td>
                            </tr>
                            <tr>
                                <td>Ngày hết hạn</td>
                                <td>
                                    ${product.expiry}</td>
                            </tr>
                            <tr>
                                <td>Nhà sản xuất</td>
                                <td>${product.manufacturer}</td>
                            </tr>
                            <tr>
                                <td>Nguyên liệu</td>
                                <td>${product.ingredient}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                    <!-- Tab items -->
                    <div class="tabs ">
                        <div class="tab-item active ">
                            Mô tả
                        </div>
                        <div class="line "></div>
                    </div>
                    <!-- Tab content -->
                    <div class="tab-content ">
                        <div class="tab-pane active ">
                            <div class="productDes ">
                                <div class="productDes__title ">${product.name} là gì?</div>
                                <p class="productDes__text "><a href="/product/${product.productID}"
                                                                class="productDes__link ">${product.name}
                                </a> là ${product.description}
                                </p>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="tabs ">
                        <div class="tab-item acitve">
                            Đánh giá
                        </div>
                        <div class="line "></div>
                    </div>
                    <div class="productDes__ratting ">
                        <div class="productDes__ratting-title ">Đánh giá của bạn</div>
                        <div class="productDes__ratting-wrap">

                            <form method="post" action="danggia">
                                <div id="rating">
                                    <input type="radio" id="star5" name="rating" value="5"/>
                                    <label class="full" for="star5" title="Awesome - 5 stars"></label>
                                    <input type="radio" id="star4" name="rating" value="4"/>
                                    <label class="full" for="star4" title="Pretty good - 4 stars"></label>
                                    <input type="radio" id="star3" name="rating" value="3"/>
                                    <label class="full" for="star3" title="Meh - 3 stars"></label>
                                    <input type="radio" id="star2" name="rating" value="2"/>
                                    <label class="full" for="star2" title="Kinda bad - 2 stars"></label>
                                    <input type="radio" id="star1" name="rating" value="1"/>
                                    <label class="full" for="star1" title="Sucks big time - 1 star"></label>

                                </div>
                                <textarea class="ratecomment" name=" " id="ratecommentId" cols="30 " rows="1"
                                          placeholder="Vui lòng viết đánh giá của bạn "></textarea>

                                <input class="btn btn--default" id="comment" data-product-id="${product.productID}"
                                       data-user-id="${userLogin.userID}" value="Đánh giá" style="margin-top: 10px">
                            </form>

                        </div>
                        <ul class="rate__list">
                            <c:forEach var="listComment" items="${comment}">
                                <li class="rate__item">
                                    <div class="rate__info">
                                        <img src="https://lh3.googleusercontent.com/ogw/ADGmqu9PFgn_rHIm9i3eIlVr5RwzwY2w8EystHF213wj=s32-c-mo"
                                             alt="">
                                        <h3 class="rate__user">${listComment.user.fullName}</h3>
                                        <c:if test="${listComment.star == 1}">
                                            <div class="rate__star">
                                                <div class="group-star">
                                                    <i class="fas fa-star"></i>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${listComment.star == 1.5}">
                                            <div class="rate__star">
                                                <div class="group-star">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star-half-alt"></i>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${listComment.star == 2}">
                                            <div class="rate__star">
                                                <div class="group-star">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${listComment.star == 2.5}">
                                            <div class="rate__star">
                                                <div class="group-star">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star-half-alt"></i>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${listComment.star == 3}">
                                            <div class="rate__star">
                                                <div class="group-star">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${listComment.star == 3.5}">
                                            <div class="rate__star">
                                                <div class="group-star">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star-half-alt"></i>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${listComment.star == 4}">
                                            <div class="rate__star">
                                                <div class="group-star">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${listComment.star == 5}">
                                            <div class="rate__star">
                                                <div class="group-star">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                    <div class="rate__comment">${listComment.content}</div>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="main__frame ">
                <div class="grid wide ">
                    <h3 class="category__title ">Hoàng Tuấn Cometics</h3>
                    <h3 class="category__heading ">Sản Phẩm Tương tự</h3>
                    <div class="owl-carousel hight owl-theme ">
                        <c:forEach items="${listCategories }" var="c" varStatus="i">
                            <c:forEach var="p" items="${listProduct}">
                                <c:if test="${!c.isDelete }">
                                    <c:if test="${c.categoryID == product.categoryID.categoryID}">
                                        <a href="/product/${p.productID} " class="product ">

                                            <c:set var="foundFirst" value="false"/>
                                            <c:forEach var="imgProduct" items="${imagesProduct}"
                                                       varStatus="i">
                                                <c:if test="${!foundFirst && p.productID == imgProduct.productID.productID}">
                                                    <c:set var="foundFirst" value="true"/>
                                                    <div class="product__avt "
                                                         style="background-image: url(/imagesProduct/${imgProduct.imageName}) ">
                                                    </div>

                                                </c:if>
                                            </c:forEach>


                                            <div class="product__info ">
                                                <h3 class="product__name ">${p.name}</h3>
                                                <div class="product__price ">
                                                    <c:set var="checkListPromotionalDetail" value="false"/>
                                                    <c:forEach var="pdProduct"
                                                               items="${promotionalDetailsList1}">
                                                        <c:if test="${pdProduct.productID.productID == p.productID}">
                                                            <c:set var="checkListPromotionalDetail" value="true"/>
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:choose>
                                                        <c:when test="${checkListPromotionalDetail}">
                                                            <c:forEach var="pdProduct"
                                                                       items="${promotionalDetailsList1}">
                                                                <c:if test="${pdProduct.productID.productID == p.productID}">
                                                                    <div class="price__old "><fmt:formatNumber
                                                                            type="number" pattern="###,###,###"
                                                                            value=" ${p.price}"/>đ
                                                                    </div>
                                                                    <c:choose>
                                                                        <c:when test="${p.quantityInStock>0}">
                                                                            <div class="price__new"
                                                                                 style="margin-left: 30px">
                                                                                <fmt:formatNumber type="number"
                                                                                                  pattern="###,###,###"
                                                                                                  value="${pdProduct.discountedPrice}"/>đ
                                                                            </div>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <div class="price__unit "
                                                                                 style="margin-left: 10px">Hết hàng
                                                                            </div>
                                                                        </c:otherwise>
                                                                    </c:choose>

                                                                </c:if>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="price__new ">
                                                                <fmt:formatNumber type="number" pattern="###,###,###"
                                                                                  value="${p.price}"/>đ
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>

                                            <c:forEach var="pdProduct" items="${promotionalDetailsList1}">
                                                <c:if
                                                        test="${pdProduct.productID.productID == p.productID}">
                                                    <div class="product__sale">
                                                <span class="product__sale-percent">
                                                -<fmt:formatNumber type="number" pattern="###,###,###"
                                                                   value="${(p.price - pdProduct.discountedPrice) / p.price *100}"/>%
                                                </span>
                                                        <span class="product__sale-text"
                                                              style="font-size: 8px">Giảm</span>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </a>
                                    </c:if>
                                </c:if>
                            </c:forEach>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="footer ">
        <jsp:include page="./component/_footer.jsp"/>
    </div>
    <div class="up-top " id="upTop " onclick="goToTop() ">
        <i class="fas fa-chevron-up "></i>
    </div>
    <!-- Modal Form -->
    <div class="ModalForm ">
        <jsp:include page="./component/_modal.jsp"/>
    </div>
    <!-- Messenger Plugin chat Code -->
    <div id="fb-root"></div>

    <!-- Your Plugin chat code -->
    <div id="fb-customer-chat" class="fb-customerchat">
    </div>
    <script src="/js/cartCript.js"></script>
    <script src="/js/checkout.js"></script>
    <script>
        var chatbox = document.getElementById('fb-customer-chat');
        chatbox.setAttribute("page_id", "105913298384666");
        chatbox.setAttribute("attribution", "biz_inbox");
        window.fbAsyncInit = function () {
            FB.init({
                xfbml: true,
                version: 'v10.0'
            });
        };

        (function (d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s);
            js.id = id;
            js.src = 'https://connect.facebook.net/vi_VN/sdk/xfbml.customerchat.js';
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));
    </script>
    <script>
        $(document).ready(function () {
            var sync1 = $("#sync1 ");
            var sync2 = $("#sync2 ");
            var slidesPerPage = 4;
            var syncedSecondary = true;
            sync1.owlCarousel({
                items: 1,
                loop: true,
                margin: 20,
                nav: true,
                dots: false,
                autoplay: true,
                autoplayTimeout: 4000,
                autoplayHoverPause: true
            })
            sync2
                .on('initialized.owl.carousel', function () {
                    sync2.find(".owl-item ").eq(0).addClass("current ");
                })
                .owlCarousel({
                    items: 4,
                    dots: false,
                    nav: false,
                    margin: 30,
                    smartSpeed: 200,
                    slideSpeed: 500,
                    slideBy: 4,
                    responsiveRefreshRate: 100
                }).on('changed.owl.carousel', syncPosition2);

            function syncPosition(el) {
                var count = el.item.count - 1;
                var current = Math.round(el.item.index - (el.item.count / 2) - .5);

                if (current < 0) {
                    current = count;
                }
                if (current > count) {
                    current = 0;
                }

                //end block

                sync2
                    .find(".owl-item ")
                    .removeClass("current ")
                    .eq(current)
                    .addClass("current ");
                var onscreen = sync2.find('.owl-item.active').length - 1;
                var start = sync2.find('.owl-item.active').first().index();
                var end = sync2.find('.owl-item.active').last().index();

                if (current > end) {
                    sync2.data('owl.carousel').to(current, 100, true);
                }
                if (current < start) {
                    sync2.data('owl.carousel').to(current - onscreen, 100, true);
                }
            }

            function syncPosition2(el) {
                if (syncedSecondary) {
                    var number = el.item.index;
                    sync1.data('owl.carousel').to(number, 100, true);
                }
            }

            sync2.on("click ", ".owl-item ", function (e) {
                e.preventDefault();
                var number = $(this).index();
                sync1.data('owl.carousel').to(number, 300, true);
            });
        });

        $('.owl-carousel.hight').owlCarousel({
            loop: true,
            margin: 20,
            nav: true,
            dots: false,
            autoplay: true,
            autoplayTimeout: 2000,
            autoplayHoverPause: true,
            responsive: {
                0: {
                    items: 2
                },
                600: {
                    items: 3
                },
                1000: {
                    items: 6
                }
            }
        })
    </script>

    <!-- Script common -->
    <script src="./assets/js/commonscript.js ">
    </script>
    <script>
        function calcRate(r) {
            const f = ~~r, //Tương tự Math.floor(r)
                id = 'star' + f + (r % f ? 'half' : '')
            id && (document.getElementById(id).checked = !0)
        }
    </script>
    <script>
        function minusProduct(index) {
            var inputQty = document.querySelectorAll('.input-qty')[index];
            var currentValue = parseInt(inputQty.value);
            var minValue = parseInt(inputQty.getAttribute('min'));
            if (currentValue > minValue) {
                inputQty.value = currentValue - 1;
                calculateTotal(index)
            }
        }

        function plusProduct(index) {
            var inputQty = document.querySelectorAll('.input-qty')[index];
            var currentValue = parseInt(inputQty.value);
            var maxValue = parseInt(inputQty.getAttribute('max'));
            if (currentValue < maxValue) {
                inputQty.value = currentValue + 1;
                calculateTotal(index)
            }
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
    <script src="/js/comment.js"></script>
</body>

</html>