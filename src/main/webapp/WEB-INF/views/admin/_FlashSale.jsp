<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<div class="row mb-3 p-5">
    <div class="d-flex flex-row">
        <h4 class="me-2">Khuyến mãi</h4>
        <a href="/admin/add-or-edit-product-sale?action=add"
           class="btn btn-outline-primary">Thêm mới khuyến mãi</a>
    </div>
</div>
<div class="row p-5">


    <div class="table-responsive">
        <table class="table table-hover">

            <thead>
            <tr>
                <th>ID</th>
                <th>Ngày bắt đầu</th>
                <th>Ngày kết thúc</th>
                <th>Trạng thái</th>
                <th></th>

            </tr>
            </thead>
            <tbody>
            <c:forEach var="discount" items="${FlashSale}">
                <tr>
                    <td>${discount.id}</td>
                    <td>
                        <fmt:formatDate pattern="dd/MM/yyyy" value="${discount.startDay}"/>
                    </td>


                    <td>
                        <fmt:formatDate pattern="dd/MM/yyyy" value="${discount.endDay}"/>
                    </td>
                    <td><c:choose>
                        <c:when test="${discount.status}">Ngưng hoạt động</c:when>
                        <c:otherwise>Đang hoạt động</c:otherwise>
                    </c:choose></td>
                    <td>
                        <a href="admin/add-or-edit-sale/${discount.id }">Sửa</a>|
                        <a href="admin/delete-sale/${discount.id }">Xóa</a>
                    </td>


                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
