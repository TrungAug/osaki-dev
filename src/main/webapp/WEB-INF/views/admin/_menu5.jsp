<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="navigation">           
    <ul>
        <li>
             <a href="/home" class="admin-logo">
                <img src="/imagesAdmin/hasagi-logo.jpg">               
            </a>
        </li>
        <li>
            <a href="/admin">
                <span class="icon"><ion-icon name="home-outline"></ion-icon></span>
                <span class="title">Dashboard</span>
            </a>
        </li>
        <li>          
            <a href="/admin?content=_content-account.jsp">
                <span class="icon"><ion-icon name="people-outline"></ion-icon></span>
                <span class="title">Tài khoản</span>
            </a>
        </li>
        <li>
            <a href="/admin?content=_content-product.jsp">
                <span class="icon"><ion-icon name="cart-outline"></ion-icon></span>
                <span class="title">Sản phẩm</span>
            </a>
        </li>
        <li>
            <a href="/admin?content=_FlashSale.jsp">
                <span class="icon"><ion-icon name="pie-chart-outline"></ion-icon></span>
                <span class="title">Sản phẩm khuyến mãi</span>
            </a>
        </li>
        <li>
            <a href="/admin?content=_content-category.jsp">
                <span class="icon"><ion-icon name="list-circle-outline"></ion-icon></span>
                <span class="title">Danh mục</span>
            </a>
        </li>
        <li>
            <a href="/admin?content=_content-order.jsp">
                <span class="icon"><ion-icon name="grid-outline"></ion-icon></span>
                <span class="title">Đơn hàng</span>
            </a>
        </li>     
        <li>
            <a href="/admin?content=_content-statistics.jsp">
                <span class="icon"><ion-icon name="pie-chart-outline"></ion-icon></span>
                <span class="title">Thống kê</span>
            </a>
        </li>
        <li>
            <a href="/admin/logout">
                <span class="icon"><ion-icon name="log-in-outline"></ion-icon></span>
                <span class="title">Đăng xuất</span>
            </a>
        </li>
    </ul>
</div>

