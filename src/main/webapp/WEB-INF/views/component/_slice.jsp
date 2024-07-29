<%--
  Created by IntelliJ IDEA.
  User: Hoang Tuan
  Date: 1/30/2024
  Time: 1:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="canvas" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="main__slice">
    <div class="main__slice">
        <div class="slider">
            <c:if test="${checkDay}">
                <div class="slide active" style="background-image:url(images/slider/slide-6.jpg)">
                    <div class="container">
                        <div class="caption">
                            <h1>Mua sam ua dai!
                            </h1>
                            <p>Chưa có san pham giam gia trong tháng ${now}!</p>
                        </div>
                    </div>
                </div>
                <div class="slide active" style="background-image:url(images/slider/slide-6.jpg)">
                    <div class="container">
                        <div class="caption">
                            <h1>Gia ca hap dan!
                            </h1>
                            <p>Chưa có san pham giam gia trong tháng ${now}!</p>
                        </div>
                    </div>
                </div>
                <div class="slide active" style="background-image:url(images/slider/slide-6.jpg)">
                    <div class="container">
                        <div class="caption">
                            <h1>Chat luong tot!
                            </h1>
                            <p>Chưa có san pham giam gia trong tháng ${now}!</p>
                        </div>
                    </div>
                </div>
            </c:if>
            <c:forEach var="listProduct" items="${listProduct}" varStatus="i">
                <c:if test="${!listProduct.isDelete}">
                    <c:forEach var="listPercent" items="${listPercent}">
                        <c:if test="${listProduct.productID ==listPercent.productID.productID}">
                            <div class="slide active"
                                 style="background-image:url(images/slider/slide-6.jpg)">
                                <div class="container">
                                    <div class="caption">
                                        <h1>Giảm giá
                                            <fmt:formatNumber
                                                    type="number"
                                                    pattern="##"
                                                    value="${listPercent.discountedPrice}"/>%
                                        </h1>
                                        <p>Giảm giá cực sốc trong tháng ${now}!</p>
                                        <a href="product/${listProduct.productID}"
                                           class="btn btn--default">Xem
                                                                    ngay</a>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:if>
            </c:forEach>

        </div>
        <div class="controls">
            <div class="prev">
                <i class="fas fa-chevron-left"></i>
            </div>
            <div class="next">
                <i class="fas fa-chevron-right"></i>
            </div>
        </div>
        <div class="indicator">
        </div>
    </div>
</div>