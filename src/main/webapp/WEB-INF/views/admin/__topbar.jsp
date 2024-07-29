<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<div class="topbar">
    <div class="toggle">
        <ion-icon name="menu-outline"></ion-icon>
    </div>
    <div class="search">
        <label>
            <input type="text" placeholder="Tìm kiếm...">
            <ion-icon name="search-outline"></ion-icon>
        </label>
    </div>
    <div class="user">
        <a href="/profile">
            <img title="${userAdminLogin.fullName}" src="/images/${userAdminLogin.image}">
        </a>     
    </div>
</div>
<!--  <a class="notification-icon" href="/admin?content=_content-order.jsp">
  <ion-icon name="notifications-outline"></ion-icon>
  <span class="notification-badge">${quantityNotify}</span>
</a>  -->
<c:choose>
  <c:when test="${quantityNotify ne 0}">
    <a class="notification-icon" href="/admin?content=_content-order.jsp">
      <ion-icon name="notifications-outline"></ion-icon>
      <span class="notification-badge">${quantityNotify}</span>
    </a>
  </c:when>
  <c:otherwise>
    <a class="notification-icon" href="/admin?content=_content-order.jsp">
      <ion-icon name="notifications-outline"></ion-icon>
    </a>
  </c:otherwise>
</c:choose>

           