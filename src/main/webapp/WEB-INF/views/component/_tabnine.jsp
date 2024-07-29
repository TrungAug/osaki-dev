<%--
  Created by IntelliJ IDEA.
  User: Hoang Tuan
  Date: 1/30/2024
  Time: 1:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="main__tabnine">

    <div class="grid wide">

        <h3 class="category__heading">SẢN PHẨM FLASH SALE</h3>
        <c:if test="${!checkDay}">
            <h2 id="countdown"></h2>
            <%--             <a href="/product/flash-sale" class="h3 view-all-collection ml-auto bg-dark text-white ">Xem tất cả</a> --%>
        </c:if>
        <c:if test="${checkDay}">
            <div class="styleCountdown d-flex align-items-center mt-0">
                <span class="lof-clock-detail bg-warning text-dark rounded-3 p-2 fw-bold h2" id="not-now">Hết thời gian khuyến mãi</span>
            </div>
        </c:if>
        <div class="row mt-3">
            <c:if test="${!checkDay}">
                <c:forEach items="${listCategories }" var="c" varStatus="i">
                    <c:if test="${!c.isDelete }">
                        <c:forEach var="p" items="${listProduct}">
                            <c:forEach var="pdProduct" items="${listPromotionalDetail}">
                                <c:if test="${!p.isDelete}">
                                    <c:if test="${c.categoryID == p.categoryID.categoryID}">
                                        <c:if test="${pdProduct.productID.productID == p.productID}">
                                            <div class="col-lg-2 col-md-4 col-sm-6">
                                                <a href="/product/${p.productID}">
                                                    <div class="product">
                                                        <c:set var="foundFirst" value="false"/>
                                                        <c:forEach var="imgProduct" items="${imagesProduct}"
                                                                   varStatus="i">
                                                            <c:if test="${!foundFirst && p.productID == imgProduct.productID.productID}">
                                                                <c:set var="foundFirst" value="true"/>
                                                                <div class="product__avt"
                                                                     style="background-image: url(../imagesProduct/${imgProduct.imageName});"></div>
                                                            </c:if>
                                                        </c:forEach>
                                                        <div class="product__info">
                                                            <h3 class="product__name">${p.name}</h3>
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
                                                                        <div class="price__new"><fmt:formatNumber
                                                                                type="number"
                                                                                pattern="###,###,###"
                                                                                value="${pdProduct.discountedPrice}"/>
                                                                            <span class="price__unit">đ</span></div>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="price__unit">Tạm hết hàng</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <div class="product__sale">
                                                                        <span class="product__sale-percent">
                                                                                        -<fmt:formatNumber type="number"
                                                                                                           pattern="###,###,###"
                                                                                                           value="${(p.price - pdProduct.discountedPrice)/p.price *100}"/>%
                                                                        </span>
                                                                <span class="product__sale-text"
                                                                      style="font-size: 8px">Giảm</span>
                                                            </div>
                                                        </div>
                                                        <a href="product/${p.productID}" class="viewDetail">Xem chi
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
                                                        <span class="category">${c.categoryName}</span>
                                                    </div>
                                                </a>
                                            </div>
                                        </c:if>
                                    </c:if>
                                </c:if>
                            </c:forEach>
                        </c:forEach>
                    </c:if>
                </c:forEach>
            </c:if>
        </div>

        <h3 class="category__heading mt-5">SẢN PHẨM THEO DANH MỤC</h3>
        <div class="tabs">
            <c:forEach items="${listCategories }" var="c" varStatus="i">
                <c:if test="${!c.isDelete }">
                    <c:if test="${i.index<=5 }">
                        <div class="tab-item ${i.index== 0?'active':''}">
                                ${c.categoryName}
                        </div>
                    </c:if>
                </c:if>
            </c:forEach>
            <div class="line"></div>
        </div>
        <div class=" tab-content ">
            <c:forEach items="${listCategories }" var="c" varStatus="i">
                <c:if test="${!c.isDelete }">
                    <c:if test="${i.index<=5 }">
                        <div class="tab-pane  ${i.index== 0?'active':''}">
                            <div class="row">
                                <c:forEach var="p" items="${listProduct}">
                                    <c:if test="${!p.isDelete}">
                                        <c:if test="${c.categoryID == p.categoryID.categoryID}">
                                            <div class="col-lg-2 col-md-4 col-sm-6 mb-3">
                                                <a href="product/${p.productID}">
                                                    <div class="product">
                                                        <c:set var="foundFirst" value="false"/>
                                                        <c:forEach var="imgProduct" items="${imagesProduct}"
                                                                   varStatus="i">
                                                            <c:if test="${!foundFirst && p.productID == imgProduct.productID.productID}">
                                                                <c:set var="foundFirst" value="true"/>
                                                                <div class="product__avt"
                                                                     style="background-image: url(../imagesProduct/${imgProduct.imageName});"></div>
                                                            </c:if>
                                                        </c:forEach>
                                                        <div class="product__info">
                                                            <h3 class="product__name">${p.name}</h3>
                                                            <div class="product__price">
                                                                <c:set var="checkListPromotionalDetail" value="false"/>
                                                                <c:forEach var="pdProduct"
                                                                           items="${listPromotionalDetail}">
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
                                                                                                value="${p.price}"/>
                                                                                        <span
                                                                                                class="price__unit"> đ</span>
                                                                                    </div>
                                                                                    <c:choose>
                                                                                        <c:when test="${p.quantityInStock>0}">
                                                                                            <div class="price__new"
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
                                                                                        -<fmt:formatNumber type="number"
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
                                                                                <div class="price__new">
                                                                                    <fmt:formatNumber
                                                                                            type="number"
                                                                                            pattern="###,###,###"
                                                                                            value="${p.price}"/>
                                                                                    <span class="price__unit">đ</span>
                                                                                </div>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span class="price__unit">Tạm hết hàng</span>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </c:otherwise>
                                                                </c:choose>

                                                                <c:forEach var="pdProduct"
                                                                           items="${listPromotionalDetail}">
                                                                    <c:if test="${pdProduct.productID.productID == p.productID}">
                                                                        <div class="product__sale">
                                                                        <span
                                                                                class="product__sale-percent">
                                                                                        -<fmt:formatNumber type="number"
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
                                                        <a href="product/${p.productID}" class="viewDetail">Xem chi
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
                                                        <span class="category">${c.categoryName}</span>
                                                    </div>
                                                </a>
                                            </div>
                                        </c:if>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                </c:if>
            </c:forEach>
        </div>

        <h3 class="category__heading">SẢN PHẨM KHUYẾN MÃI</h3>
        <div class="row mt-3">
            <c:forEach items="${listCategories }" var="c" varStatus="i">
                <c:if test="${!c.isDelete }">
                    <c:forEach var="p" items="${listProduct}">
                        <c:forEach var="pdProduct" items="${listPromotionalDetail}">
                            <c:if test="${!p.isDelete}">
                                <c:if test="${c.categoryID == p.categoryID.categoryID}">
                                    <c:if test="${pdProduct.productID.productID == p.productID}">
                                        <div class="col-lg-2 col-md-4 col-sm-6">
                                            <a href="product/${p.productID}">
                                                <div class="product">
                                                    <c:set var="foundFirst" value="false"/>
                                                    <c:forEach var="imgProduct" items="${imagesProduct}"
                                                               varStatus="i">
                                                        <c:if test="${!foundFirst && p.productID == imgProduct.productID.productID}">
                                                            <c:set var="foundFirst" value="true"/>
                                                            <div class="product__avt"
                                                                 style="background-image: url(../imagesProduct/${imgProduct.imageName});"></div>
                                                        </c:if>
                                                    </c:forEach>
                                                    <div class="product__info">
                                                        <h3 class="product__name">${p.name}</h3>
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
                                                                    <div class="price__new"><fmt:formatNumber
                                                                            type="number"
                                                                            pattern="###,###,###"
                                                                            value="${pdProduct.discountedPrice}"/>
                                                                        <span class="price__unit">đ</span></div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="price__unit">Tạm hết hàng</span>
                                                                </c:otherwise>
                                                            </c:choose>

                                                        </div>
                                                        <div class="product__sale">
                                                              <span class="product__sale-percent">
                                                                    -<fmt:formatNumber type="number"
                                                                                       pattern="###,###,###"
                                                                                       value="${(p.price - pdProduct.discountedPrice)/p.price *100}"/>%
                                                                </span>
                                                            <span class="product__sale-text">Giảm</span>
                                                        </div>
                                                    </div>
                                                    <a href="product/${p.productID}" class="viewDetail">Xem chi tiết</a>
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
                                                    <span class="category">${c.categoryName}</span>
                                                </div>
                                            </a>
                                        </div>
                                    </c:if>
                                </c:if>
                            </c:if>
                        </c:forEach>
                    </c:forEach>
                </c:if>
            </c:forEach>
        </div>
    </div>
</div>


<script>
    function startCountdown(targetElement, targetTime) {
        let countdownInterval = setInterval(function () {
            let currentTime = new Date().getTime();
            let distance = targetTime - currentTime;

            if (distance < 0) {
                clearInterval(countdownInterval);
                targetElement.innerHTML = "Đã kết thúc";
            } else {
                targetElement.innerHTML = formatTime(distance);
            }
        }, 1000);
    }

    function formatTime(distance) {
        // Code để định dạng thời gian còn lại ở đây (ví dụ: ngày, giờ, phút, giây)
        // Ví dụ: tính số ngày, giờ, phút và giây từ khoảng cách distance
        let days = Math.floor(distance / (1000 * 60 * 60 * 24));
        let hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        let minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        let seconds = Math.floor((distance % (1000 * 60)) / 1000);

        // Trả về định dạng đã được xác định
        return days + " ngày " + hours + " giờ " + minutes + " phút " + seconds + " giây ";
    }

    let endDate = new Date("${flashSale.endDay}");
    let endTime = endDate.getTime();

    // Khởi động đồng hồ chạy ngược từ hiện tại đến thời gian kết thúc
    let countdownElement = document.getElementById("countdown");
    startCountdown(countdownElement, endTime);
</script>