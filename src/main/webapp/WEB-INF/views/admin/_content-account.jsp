<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ include file="/WEB-INF/views/admin/__topbar.jsp" %>

<div class="row mb-4 p-3 user-manager-title">
    <h2 class="text-center">Quản lý tài khoản khách hàng</h2>
</div>

<div class="row p-5">
    <div class="col-12">
        <div class="row justify-content-end">
            <div class="col-8 mb-3">
                <form action="/admin/user-search" method="get">
                    <div class="d-flex flex-row justify-content-end">
                        <input class="form-control me-2" placeholder="Tên khách hàng..." name="kwSearch"
                               value="${keywords}" style="max-width: 40%;">
                        <button class="btn btn-outline-primary" style="max-width: 40%;">Tìm kiếm</button>
                    </div>
                </form>
            </div>
            <div class="col-8 d-flex justify-content-end">
                
                <%@ include file="/WEB-INF/views/admin/__navigation-button.jsp" %>
            </div>
        </div>
        <div class="row">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>Ảnh đại diện</th>
                        <th>Họ và tên</th>
                        <th>Email</th>
                        <th>Số lượng hóa đơn</th>
                        <th>Số lượt thích</th>
                        <th>Kích hoạt tài khoản</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${users}">
                        <tr>
                            <td><img src="/images/${item.image}" class="img-thumbnail" alt="Ảnh đại diện"
                                     style="width: 50px;height: 50px">
                            </td>
                            <td>${item.name}</td>
                            <td>${item.email}</td>
                            <td>${item.countInvoice}</td>
                            <td>${item.countWishLists}</td>
                            <td>
                                <form action="/admin/edit-user/${item.userID}">
                                    <input type="checkbox" name="isDelete"
                                           id="userIsDelete" ${item.isDelete?'':'checked'}
                                           onclick="this.form.submit()"/>
                                    <label>${item.isDelete?'Chưa kích hoạt':'Kích hoạt'}</label>
                                </form>

                            </td>

                            <td>
                                <a href="#"
                                   data-bs-toggle="modal"
                                   data-bs-target="#listInvoiceByUserModal"
                                   class="open-invoice-modal" data-user-id="${item.userID}">Xem hóa đơn</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="listInvoiceByUserModal" tabindex="-1" aria-labelledby="listInvoiceByUserModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="listInvoiceByUserModalLabel">Danh sách hóa đơn</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>