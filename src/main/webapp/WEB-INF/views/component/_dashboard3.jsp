<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="comment" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Oder -->

<style>
    .removeAddress:hover {
        background-color: rgb(246, 245, 245);
        color: black;

        font-size: 110%;
        font-weight: bold;
    }
</style>
<div class="recentOrders">
    <div class="cardHeader d-flex flex-row justify-content-between">
        <h2 style="font-size: 24px">Địa chỉ của tôi</h2>

    </div>
    <jsp:include page="./_address.jsp"/>
    <table class="table table-hover table-custom" style="font-size: 16px">
        <thead>
        <tr>
            <th>SDT</th>
            <th>Địa chỉ</th>
            <th>Trạng thái</th>
        </tr>
        </thead>
        <tbody id="tbAddress">
        <c:forEach var="address" items="${address}" varStatus="i">
            <tr class="${address.phoneID}">
                <td>${address.phoneID}</td>
                <td>${address.address}</td>
                <td><a class="updateAddress " href="#" data-address-id="${address.phoneID}"
                       data-user-id="${userLogin.userID}">Cập nhật</a>
                </td>
                <td class="removeAddress " data-address-id="${address.phoneID}">Xóa</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script src="/js/removeAddress.js"></script>
<!-- Chart -->