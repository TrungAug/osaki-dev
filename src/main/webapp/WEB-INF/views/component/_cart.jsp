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
        <h1>Đơn hàng</h1>
        <div class="row">
            <div class="col l-8 m-12 s-12">
                <div class="main__cart">
                    <div class="row title">
                        <div class="col l-4 m-4 s-8">Mã đơn hàng</div>
                        <div class="col l-2 m-2 s-0">Tổng tiền</div>
                        <div class="col l-2 m-2 s-0">Ngày đặt</div>
                        <div class="col l-2 m-2 s-0">Trạng thái</div>
                        <div class="col l-1 m-1 s-0"></div>
                    </div>
                    <c:forEach var="invoiceList" items="${invoiceList}">
                        <c:if test="${invoiceList.status == 'Đặt hàng'}">
                            <div class="row item ${invoiceList.invoiceID}">
                                <div class="col l-4 m-4 s-8">
                                    <div class="main__cart-product">
                                        <div class="name">
                                                ${invoiceList.invoiceID} </div>
                                    </div>
                                </div>
                                <div class="col l-2 m-2 s-0">
                                    <div class="main__cart-product">
                                        <div class="name">
                                            <fmt:formatNumber
                                                    type="number"
                                                    pattern="###,###,###"
                                                    value=" ${invoiceList.totalAmount}  "/>
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
                                <div class="col l-2 m-2 s-0">
                                    <div class="main__cart-product">
                                        <div class="container mt-3">
                                            <h5 href="#" class="detailCart" data-address-id="${invoiceList.invoiceID}">
                                                Chi tiết đơn hàng
                                            </h5>
                                        </div>
                                    </div>
                                    <div class="main__cart-product cancelCart${invoiceList.invoiceID}">
                                        <h2 class=" cancelCart"
                                            data-invoice-id="${invoiceList.invoiceID}"
                                        >Hủy đơn hàng
                                        </h2>
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


<!-- The Modal -->
<div class="modal" id="myModal">
    <div class="modal-dialog ">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title" style="font-size: 16px">Chi tiết đơn hàng</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">

            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>
<script src="/js/cancelCart.js"></script>
<!-- Chart -->