<%--
  Created by IntelliJ IDEA.
  User: Hoang Tuan
  Date: 1/30/2024
  Time: 1:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="header__nav">
    <ul class="header__nav-list">
        <li class="header__nav-item nav__search">
            <div class="nav__search-wrap">
                <input type="text" class="header__search-input" placeholder="Tìm kiếm" name="search"/>
              
                <i class="bi bi-search"  style="margin-left:240px"></i>
            </div>
            <div class="nav__search-btn">
                <i class="fas fa-search"></i>
            </div>
        </li>
        <li class="header__nav-item authen-form">
            <a href="#" class="header__nav-link"></a>
            <ul class="sub-nav">
                <c:choose>
                    <c:when test="${userLogin==null}">
                        <li class="sub-nav__item">
                            <a href="/login" class="sub-nav__link">Đăng Nhập</a>
                        </li>
                        <li class="sub-nav__item">
                            <a href="/register" class="sub-nav__link">Đăng Kí</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="sub-nav__item">
                            <a href="#my-Account" class="sub-nav__link">Tài khoản</a>
                        </li>
                        <li class="sub-nav__item">
                            <a href="/login" class="sub-nav__link" onclick="clearReturnUrl()">Đăng xuất</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </li>
        <li class="header__nav-item index">
            <a href="/" class="header__nav-link">Trang chủ</a>
        </li>
        <li class="header__nav-item">
            <a href="/list/product" class="header__nav-link">Sản phẩm</a>
        </li>
        <li class="header__nav-item">
            <a href="/list/product" class="header__nav-link">Danh mục</a>
            <div class="sub-nav-wrap grid wide">
                <c:forEach var="category" items="${listCategories}" varStatus="i">
                    <c:if test="${!category.isDelete}">
                        <ul class="sub-nav">
                            <li class="sub-nav__item">
                                <a href="/product/search-category/${category.categoryID}"
                                   class="sub-nav__link heading">${category.categoryName}</a>
                            </li>
                        </ul>
                    </c:if>
                </c:forEach>
            </div>
        </li>
        <li class="header__nav-item">
            <a href="/list/product" class="header__nav-link">Thương hiệu</a>
            <div class="sub-nav-wrap grid wide">
                <c:forEach var="brand" items="${listBrands}" varStatus="i">
                    <c:if test="${!brand.isDelete}">
                        <ul class="sub-nav">
                            <li class="sub-nav__item">
                                <a href="/product/search-brand/${brand.brandID}"
                                   class="sub-nav__link heading">${brand.brandName}</a>
                            </li>
                        </ul>
                    </c:if>
                </c:forEach>
            </div>
        </li>
        <li class="header__nav-item">
            <a href="/news" class="header__nav-link">Tin Tức</a>
        </li>
        <li class="header__nav-item">
            <a href="/contact" class="header__nav-link">Liên Hệ</a>
        </li>

        </body>
    </ul>
</div>
<script>
    function clearReturnUrl() {
        // Xóa mục 'returnUrl' khỏi localStorage
        localStorage.removeItem('returnUrl');
    }
</script>