<%--
  Created by IntelliJ IDEA.
  User: Hoang Tuan
  Date: 1/30/2024
  Time: 2:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="main__frame">
    <div class="grid wide">
        <h3 class="category__heading">SẢN PHẨM BÁN CHẠY</h3>

        <div class="row">

            <c:forEach var="p" items="${bestSellers}" varStatus="i">
                <c:if test="${!p[0].isDelete}">
                    <div class="col-lg-2 col-md-4 col-sm-6">
                        <a href="product/${p[0].productID}">
                            <div class="product mb-3">
                                <c:set var="foundFirst" value="false"/>
                                <c:forEach var="imgProduct" items="${imagesProduct}"
                                           varStatus="i">
                                    <c:if test="${!foundFirst && p[0].productID == imgProduct.productID.productID}">
                                        <c:set var="foundFirst" value="true"/>
                                        <div class="product__avt"
                                             style="background-image: url(../imagesProduct/${imgProduct.imageName});"></div>
                                    </c:if>
                                </c:forEach>
                                <div class="product__info">
                                    <h3 class="product__name">${p[0].name}</h3>
                                    <div class="product__price">
                                        <c:set var="checkListPromotionalDetail" value="false"/>
                                        <c:forEach var="pdProduct"
                                                   items="${promotionalDetailsList1}">
                                            <c:if test="${pdProduct.productID.productID == p[0].productID}">
                                                <c:set var="checkListPromotionalDetail" value="true"/>
                                            </c:if>
                                        </c:forEach>

                                        <c:choose>
                                            <c:when test="${checkListPromotionalDetail}">
                                                <c:forEach var="pdProduct"
                                                           items="${promotionalDetailsList1}">
                                                    <c:if test="${pdProduct.productID.productID == p[0].productID}">
                                                        <div class="price__old">
                                                            <fmt:formatNumber type="number" pattern="###,###,###"
                                                                              value="${p[0].price}"/>
                                                            <span class="price__unit">đ</span>
                                                        </div>

                                                        <c:choose>
                                                            <c:when test="${p[0].quantityInStock>0}">
                                                                <div class="price__new" style="margin-left: 30px">
                                                                    <fmt:formatNumber type="number"
                                                                                      pattern="###,###,###"
                                                                                      value="${pdProduct.discountedPrice}"/>
                                                                    <span class="price__unit">đ</span>
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="price__unit">Tạm hết hàng</div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:if>
                                                </c:forEach>
                                                <c:forEach var="pdProduct" items="${promotionalDetailsList1}">
                                                    <c:if
                                                            test="${pdProduct.productID.productID == p[0].productID}">
                                                        <div class="product__sale">
                                                <span class="product__sale-percent">
                                                -<fmt:formatNumber type="number" pattern="###,###,###"
                                                                   value="${(p[0].price - pdProduct.discountedPrice) / p[0].price *100}"/>%
                                                </span>
                                                            <span class="product__sale-text"
                                                                  style="font-size: 8px">Giảm</span>
                                                        </div>
                                                    </c:if>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <c:choose>
                                                    <c:when test="${p[0].quantityInStock>0}">
                                                        <div class="price__new">
                                                            <fmt:formatNumber type="number" pattern="###,###,###"
                                                                              value="${p[0].price}"/>
                                                            <span class="price__unit">đ </span>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="price__unit">Tạm hết hàng</div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <c:forEach var="pdProduct"
                                               items="${promotionalDetailsList1}">
                                        <c:if
                                                test="${pdProduct.productID.productID == p[0].productID}">
                                            <div class="product__sale">
                                                              <span class="product__sale-percent">
                                                                    -<fmt:formatNumber type="number"
                                                                                       pattern="###,###,###"
                                                                                       value="${(p[0].price - pdProduct.discountedPrice)/p[0].price *100}"/>%
                                                                </span>
                                                <span class="product__sale-text">Giảm</span>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                                <a href="product/${p[0].productID}" class="viewDetail">Xem chi tiết</a>
                                <a href="#" title="cart" data-product-id="${p[0].productID}"
                                   data-user-id="${userLogin.userID}" class="addToCart">Thêm vào
                                                                                        giỏ</a>
                                <c:set var="checkLike" value="false"/>
                                <c:forEach items="${likeList }" var="lp" varStatus="i">
                                    <c:if test="${lp.productID.productID == p[0].productID }">
                                        <c:set var="checkLike" value="true"/>
                                    </c:if>
                                </c:forEach>
                                <c:choose>
                                    <c:when test="${checkLike }">
                                        <a title="Wishlist" href="#"
                                           class="siteLikeProduct m-md-3"
                                           data-product-id="${p[0].productID}"
                                           data-user-id="${userLogin.userID}">
                                            <i class="bi-heart-fill"></i>
                                            <span class="title-like">Xóa yêu thích</span>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a title="Wishlist" href="#"
                                           class="siteLikeProduct m-md-3"
                                           data-product-id="${p[0].productID}"
                                           data-user-id="${userLogin.userID}">
                                            <i class="bi-heart"></i>
                                            <span class="title-like">Thêm vào yêu thích</span>
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                                    <%--                                             <span class="category">${c.categoryName}</span> --%>
                            </div>
                        </a>
                    </div>
                </c:if>
            </c:forEach>

        </div>
    </div>
</div>
