<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="/WEB-INF/views/admin/__topbar.jsp" %>

<div class="cardBox">
    <div class="cardP">
        <div class="cardP-body">
            <div class="numbers">${totalInv}</div>
            <div class="cardName">Lượt mua</div>
        </div> 
        <div class="iconBox">
            <ion-icon name="cart-outline"></ion-icon>
        </div>      
    </div>
    
    <div class="cardP">
        <div class="cardP-body">
            <div class="numbers">${visitorCount}</div>
            <div class="cardName">Lượt xem</div>
        </div> 
        <div class="iconBox">
            <ion-icon name="eye-outline"></ion-icon>
        </div>      
    </div>
    <div class="cardP">
        <div class="cardP-body">
            <div class="numbers">${totalComments}</div>
            <div class="cardName">Bình luận</div>
        </div> 
        <div class="iconBox">
            <ion-icon name="chatbubbles-outline"></ion-icon>
        </div>      
    </div>
    <div class="cardP">
        <div class="cardP-body">
            <div class="numbers">${totalRevenue}</div>
            <div class="cardName">Doanh thu</div>
        </div> 
        <div class="iconBox">
            <ion-icon name="cash-outline"></ion-icon>
        </div>      
    </div>
</div>

<!-- Oder -->
<div class="details">
    <div class="recentOrders">
        <div class="cardHeader d-flex flex-row justify-content-between">
            <h2>Đơn hàng gần đây</h2>
            <a href="/admin?content=_content-order.jsp" class="btn btn-custom">Xem tất cả</a>
        </div>
        <table class="table table-hover table-custom">
            <thead>
                <tr>
                    <th>Mã đơn hàng</th>
                    <th>Tên khách hàng</th>
                    <th>Địa chỉ</th>
                    <th>Tổng tiền</th>
                    <th>Ngày đơn hàng</th>
                    <th>Trạng thái</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${recentProduct}">
                    <tr>
                        <td>${item.invoiceID}</td>
                        <td>${item.nameCustomer}</td> 
                        <td>${item.addressCustomer}</td>                      
                        <td>
                            <fmt:formatNumber value="${item.totalAmount}" pattern="#,### đ"></fmt:formatNumber>
                        </td>                        
                                               
                        <td>
                            <fmt:formatDate value="${item.createAt}" pattern="dd-MM-yyyy"/>                        
                        </td>
                        <td class="
                            <c:if test="${item.status eq 'Đặt hàng'}">text-primary</c:if>
                            <c:if test="${item.status eq 'Thành công'}">text-success</c:if>
                            <c:if test="${item.status eq 'Đã hủy'}">text-danger</c:if>
                           ">${item.status}</td>
                    </tr>
                </c:forEach>               
            </tbody>
        </table>
    </div>
    <div class="recentCustomer">
        <div class="cardHeader">
            <h2>Khách hàng vừa truy cập</h2>
        </div>
         <table class="table table-hover table-custom">
                <tr>
                    <td width="60px">
                        <div class="img-thumbnail imgBox">
                            <img src="/images/author-item.jpg">
                        </div>
                    </td>
                    <td>
                        <h4>
                            Trung nguyễn
                            <br>
                            <span>An Giang</span>
                        </h4>
                    </td>
                </tr>
        </table>
    </div>
</div>

<!-- Chart -->
<div class="graphicBox">
    <div class="box">        
        <canvas id="myChartDoughnut"></canvas>
    </div>
    <div class="box">
        <canvas id="myChartLine"></canvas>
    </div>
</div>