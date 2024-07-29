<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="row mb-3 p-5">
    <div class="d-flex flex-row">
        <h4 class="me-2">Sản phẩm</h4>
        <a href="/admin/add-or-edit-product?action=add"
           class="btn btn-outline-primary">Thêm mới sản phẩm</a>
    </div>
</div>
<div class="row p-5">


    <div class="col-8 d-flex justify-content-end">
        <!-- <jsp:include page="__navigation-button.jsp" /> -->
        <input class="form-control me-2" value="${totalElements} sản phẩm"
               style="max-width: 15%; background-color: #b7a888;"
               disabled="disabled">
        <c:if test="${not booleanFirst}">
            <a class="btn btn-outline-secondary me-2"
               href="/admin?content=_content-product.jsp&p=0">Đầu</a>
            <a class="btn btn-outline-secondary me-2"
               href="/admin?content=_content-product.jsp&p=${prevPage}">Trước</a>
        </c:if>
        <input class="form-control" name="currentPage" value="${currentPage}"
               style="max-width: 8%; background-color: #b7a888;" disabled="disabled">
        <input class="form-control me-2" value="of ${totalPages}"
               style="max-width: 12%; background-color: #b7a888;"
               disabled="disabled">
        <c:if test="${not booleanLast}">
            <a class="btn btn-outline-secondary me-2"
               href="/admin?content=_content-product.jsp&p=${nextPage}">Tiếp</a>
            <a class="btn btn-outline-secondary me-2"
               href="/admin?content=_content-product.jsp&p=${totalPages}">Cuối</a>
        </c:if>
    </div>


    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
            <tr>
                <th>Mã sản phẩm</th>
                <th>Hình ảnh</th>
                <th>Tên sản phẩm</th>
                <th>Giá</th>
                <th>Tồn kho</th>
                <th>Trang thái</th>
                <th>Danh mục</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <!-- Vòng lặp c:forEach -->

            <c:forEach var="item" items="${item}">
                <tr>
                    <td>${item.id}</td>
                    <td>
                        <div class="d-flex">
                            <c:forEach var="imgProduct" items="${imagesProduct}">
                                <c:if test="${item.id ==imgProduct.productID.productID}">
                                    <img src="../imagesProduct/${imgProduct.imageName}" style="width: 40px">
                                </c:if>
                            </c:forEach>
                            <div class="row">
                                <div class="col-4">
                                    <i class="bi bi-bag"></i> <span>${item.countInvoice}</span>
                                </div>
                                <div class="col-4">
                                    <i class="bi bi-balloon-heart-fill"></i> <span>${item.countWishLists}</span>
                                </div>

                            </div>
                        </div>
                    </td>
                    <td>${item.name}</td>
                    <td>${item.price}</td>
                    <td>${item.quantity}
                    <td>${item.isDelete?'Ngưng hoạt động':'Đang hoạt động'}</td>
                    <!--  <td><c:choose>
							<c:when test="${item.isDelete}">Ngưng hoạt động</c:when>
							<c:otherwise>Đang hoạt động</c:otherwise>
						</c:choose></td> -->
                    <td>${item.categoryID.categoryName}</td>
                    <td><a href="/admin/add-or-edit/${item.id}"
                           class="btn btn-outline-primary">Sửa</a> | <a
                            href="/admin/delete/${item.id}" class="btn btn-outline-danger">Xóa</a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
