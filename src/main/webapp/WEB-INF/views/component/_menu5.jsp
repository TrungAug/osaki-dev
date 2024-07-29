<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="comment" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="navigation">
    <ul style="font-size: 16px">
        <li>
            <a href="">
                <div class="img-thumbnail imgBox mt-1">
                    <img src="/images/${userLogin.image}" style="width: 100px">
                </div>
                <h5 class="title">Xin chào: ${userLogin.fullName}</h5>
            </a>

        </li>
        <li>
            <a href="/profile?content=_dashboard3">
                <span class="icon"><i class="bi bi-person-lines-fill"></i></span>
                <span class="title">Tài khoản</span>
            </a>
        </li>
        <li>
            <c:if test="${userLogin.roleName.roleName == 'admin'}">
                <a href="/admin">
                    <span class="icon"><i class="bi bi-person-circle"></i></span>
                    <span class="title">Quản lý</span>
                </a>
            </c:if>
        </li>
        <li>
            <a href="/profile?content=_cart">
                <span class="icon"><i class="bi bi-bag-plus-fill"></i></span>
                <span class="title">Đơn hàng</span>
            </a>
        </li>
        <li>
            <a href="/profile?content=_cartCancel">
                <span class="icon"><i class="bi bi-cart-x-fill"></i></span>
                <span class="title">Đã hủy</span>
            </a>
        </li>
        <li>
            <a href="/profile?content=_successcart">
                <span class="icon"><i class="bi bi-bag-check-fill"></i></span>
                <span class="title">Đơn hàng thành công</span>
            </a>
        </li>
        <li>
            <a href="/profile?content=_likeProduct">
                <span class="icon"><i class="bi bi-chat-square-heart-fill"></i></span>
                <span class="title">Yêu thích</span>
            </a>
        </li>
    </ul>
</div>

