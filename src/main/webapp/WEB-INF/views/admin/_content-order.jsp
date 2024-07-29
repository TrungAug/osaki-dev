<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="/WEB-INF/views/admin/__topbar.jsp" %>

<div class="row mb-4 p-3 order-manager-title">
    <h2 class="text-center">Quản lý đơn hàng</h2>
</div>

<div class="row p-5">
    <div class="col-12">
        <div class="row justify-content-end">
            <div class="col-8 mb-3">
                <form action="/admin/order-search" method="get">
                    <div class="d-flex flex-row justify-content-end">
                        <input class="form-control me-2" placeholder="Tên sản phẩm..." name="kwSearch"
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
                        <th>Mã đơn hàng</th>
                        <th>Ngày đặt hàng</th>
                        <!--  <th>Ảnh sản phẩm</th>
                        <th>Tên sản phẩm</th>-->
                        <th>Khách hàng</th>
                        <th>Địa chỉ</th>
                        <th>Số điện thoại</th>
                        
                        <th>Giá trị</th>
                        <th>Trạng thái</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${orders}">
                        <tr>
                            <td>${item.invoiceID}</td>
                            <td>
                                 <fmt:formatDate value="${item.createAt}" pattern="dd-MM-yyyy"/>                        
                            </td>
                            <td>${item.nameCustomer}</td>
                            <td style="max-width: 200px;">${item.addressCustomer}</td>
                            <td>${item.phoneCustomer}</td>                           
                            <td>
                                 <fmt:formatNumber value="${item.totalAmount}" pattern="#,### đ"></fmt:formatNumber>                           
                            </td>                                                       
                            <td style="max-width: 150px;">                    
                                    <input type="hidden" name="invoiceId" value="${item.invoiceID}">
                                    <select name="selectedValue" class="form-select order-select-form <c:if test="${item.status eq 'Đặt hàng'}">text-primary</c:if>
                                    <c:if test="${item.status eq 'Thành công'}">text-success</c:if>
                                    <c:if test="${item.status eq 'Đã hủy'}">text-danger</c:if>"> 
                                        <c:choose>
                                            <c:when test="${item.status eq 'Thành công'}">
                                                <option value="Thành công" <c:if test="${item.status eq 'Thành công'}">selected</c:if>>Thành công</option>
                                            </c:when>
                                            <c:when test="${item.status eq 'Đã hủy'}">
                                               <option value="Đã hủy" <c:if test="${item.status eq 'Đã hủy'}">selected</c:if>>Đã hủy</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="Đặt hàng" <c:if test="${item.status eq 'Đặt hàng'}">selected</c:if>>Đặt hàng</option>
                                                <option value="Thành công" <c:if test="${item.status eq 'Thành công'}">selected</c:if>>Thành công</option>
                                                <option value="Đã hủy" <c:if test="${item.status eq 'Đã hủy'}">selected</c:if>>Đã hủy</option>
                                            </c:otherwise>                                        
                                        </c:choose>                                                                                                        
                                    </select>                                                                                                                                                                      
                            </td>
                            <td>
                                <a href="#"
                                   data-bs-toggle="modal"
                                   data-bs-target="#oderDetailModal"
                                   class="open-detail-order" data-invoice-id="${item.invoiceID}">Xem chị tiết</a>                                                                 
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
<div class="modal fade" id="oderDetailModal" tabindex="-1" aria-labelledby="oderDetailModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="oderDetailModalLabel">Chi tiết đơn hàng</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <table class="table table-hover">
              <thead>
                   <tr>
                      <th>Ảnh sản phẩm</th>
                      <th>Tên sản phẩm</th>
                      <th>Số lượng</th>
                      <th>Giá</th>
                  </tr>
               </thead>
               <tbody>            
               </tbody>                                   
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>