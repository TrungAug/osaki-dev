<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="comment" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!-- Oder -->
<div class="details">
    <div class="recentOrders" style="width: 1000px">
        <h1>Đơn hàng thành công</h1>
        <div class="row">
            <div class="col l-8 m-12 s-12" style="font-size: 16px">
                <div class="main__cart">
                    <div class="row title">
                        <div class="col l-4 m-4 s-8">Mã đơn hàng</div>
                        <div class="col l-2 m-2 s-0">Tổng tiền</div>
                        <div class="col l-2 m-2 s-0">Ngày đặt</div>
                        <div class="col l-2 m-2 s-0">Trạng thái</div>
                    </div>
                    <c:forEach var="invoiceList" items="${invoiceList}">
                        <c:if test="${invoiceList.status == 'Thành công'}">
                            <div class="row item ${invoiceList.invoiceID}">
                                <div class="col l-4 m-4 s-8">
                                    <div class="main__cart-product">
                                        <div class="name">${invoiceList.invoiceID} </div>
                                    </div>
                                </div>
                                <div class="col l-2 m-2 s-0">
                                    <div class="main__cart-product">
                                        <div class="name">
                                            <fmt:formatNumber
                                                    type="number"
                                                    pattern="###,###,###"
                                                    value=" ${invoiceList.totalAmount} "/>
                                            ₫
                                        </div>
                                    </div>
                                </div>
                                <div class="col l-2 m-2 s-0">
                                    <div class="main__cart-product">
                                        <div class="name">
                                            <fmt:formatDate pattern="dd/MM/yyyy" value="${invoiceList.createAt}"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col l-2 m-2 s-0">
                                    <div class="main__cart-product">
                                        <div class="name">${invoiceList.status} </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="/js/cancelCart.js"></script>
<!-- Chart -->