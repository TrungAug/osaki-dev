<%--
  Created by IntelliJ IDEA.
  User: Hoang Tuan
  Date: 1/30/2024
  Time: 1:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>

    .product1 {
        display: flex;
        align-items: center;
        cursor: pointer;
        padding-bottom: 15px;
    }

    .product1 img {
        width: 70px;
        height: 70px;
        object-fit: cover;
        border-radius: 5px;
    }

    .product1 .p-details {
        padding-left: 15px;
    }

    .product1 .p-details h2 {
        font-size: 20px;
        color: #1d1d1d;
    }

    .product1 .p-details h3 {
        font-size: 18px;
        white-space: nowrap;
    }

    .product-list {
        padding: 20px 0;
    }

    .menu {
        margin-top: 240px;
        position: absolute;
        background-color: #fff;
        border: 1px solid rgba(82, 74, 235);
        border-radius: 4px;
        width: 540px;
        max-height: 200px;
        overflow-y: auto;
        display: none;
        z-index: 999;
    }


    .menu.active {
        display: block;
    }
</style>
<div class="grid wide">
    <div class="header__top">
        <div class="navbar-icon">
            <span></span>
            <span></span>
            <span></span>
        </div>
        <a href="home" class="header__logo">
            <img src="/imagesAdmin/hasagi-logo.jpg" width="40px" style=" border-radius: 50%;">
        </a>
        <div class="header__search">
            <div class="header__search-wrap">
                <form action="/product/search">
                    <%--                     <label for="categoryId">Chọn danh mục:</label> --%>
                    <%--                     <select id="categoryId" name="categoryId"> --%>
                    <%--                         <option value="-1">Tất cả danh mục</option> --%>
                    <%--                         <option value="1">Danh mục 1</option> --%>
                    <%--                         <option value="2">Danh mục 2</option> --%>
                    <%--                         <!-- Thêm các tùy chọn danh mục khác nếu cần --> --%>
                    <%--                     </select> --%>
                    <input type="text" class="header__search-input" id="search-item" placeholder="Tìm kiếm"
                           name="search" onkeyup="search1()" onfocus="showMenu()" onblur="hideMenu(event)"/>

                </form>
                <div class="menu" id="menu">
                    <c:forEach var="productList" items="${listProduct}">
                        <!-- Your menu items go here -->
                        <div class="product1">
                            <c:set var="foundFirst" value="false"/>
                            <c:forEach var="imgProduct" items="${imagesProduct}"
                                       varStatus="i">
                                <c:if test="${!foundFirst && productList.productID == imgProduct.productID.productID}">
                                    <c:set var="foundFirst" value="true"/>
                                    <img src="/imagesProduct/${imgProduct.imageName}" alt="Không có">
                                </c:if>
                            </c:forEach>

                            <div class="p-details">
                                <h2><a href="/product/${productList.productID}">${productList.name}</a></h2>
                                <h3><fmt:formatNumber type="number" pattern="###,###,###"
                                                      value="${productList.price}"/> đ</h3>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div class="header__account">
            <c:choose>
                <c:when test="${userLogin==null}">
                    <a href="/login" class="header__account-login">Đăng Nhập</a>
                    <a href="/register" class="header__account-register">Đăng Kí</a>
                </c:when>
                <c:otherwise>
                    <a href="/profile" class="header__account-register">Tài khoản</a>
                    <a href="/logout" class="header__account-register">Đăng xuất</a>
                </c:otherwise>
            </c:choose>

        </div>


        <!-- Cart -->
        <div class="header__cart">
            <c:choose>
                <c:when test="${userLogin==null}">


                </c:when>
                <c:otherwise>
                    <a href="/profile?content=_likeProduct">
                        <i class="bi bi-heart-fill" style="width: 100px"></i>
                    </a>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="header__cart have" href="#">
            <c:choose>
                <c:when test="${userLogin==null}">
                    <i class="fas fa-shopping-basket"></i>
                    <div class="header__cart-wrap" style="height: 50px">
                        <a href="/login" class="header__account h2">Đăng Nhập</a>
                    </div>

                </c:when>
                <c:otherwise>
                    <i class="fas fa-shopping-basket"></i>
                    <div class="header__cart-amount">
                        <c:choose>
                            <c:when test="${cartList.size()  == null}">
                                0
                            </c:when>
                            <c:otherwise>
                                ${cartList.size()}
                            </c:otherwise>
                        </c:choose>

                    </div>
                    <div class="header__cart-wrap">
                        <ul class="order__list">
                            <c:forEach var="cartList" items="${cartList}" varStatus="loop">
                                <li class="item-order ${cartList.cartId}">
                                    <div class="order-wrap">
                                        <c:set var="foundFirst" value="false"/>
                                        <c:forEach var="imgProduct" items="${imagesProduct}"
                                                   varStatus="i">
                                            <c:if test="${!foundFirst && cartList.product.productID == imgProduct.productID.productID}">
                                                <c:set var="foundFirst" value="true"/>
                                                <a href="product" class="order-img">
                                                    <img src="../imagesProduct/${imgProduct.imageName}" alt="">
                                                </a>
                                            </c:if>
                                        </c:forEach>
                                        <div class="order-main">
                                            <a href="/product/${cartList.product.productID}"
                                               class="order-main-name">${cartList.product.name}</a>
                                            <div class="order-main-price">
                                                <span id="quantity_${cartList.cartId}">${cartList.quantity}</span>
                                                <span onclick="increaseQuantity(${loop.index})">X</span>
                                                <c:set var="checkLike" value="false"/>
                                                <c:set var="checkLikePrice" value=""/>
                                                <c:forEach var="promotionalDetailsList"
                                                           items="${promotionalDetailsList1}">
                                                    <c:if test="${promotionalDetailsList.productID.productID == cartList.product.productID}">
                                                        <c:set var="checkLike" value="true"/>
                                                        <c:set var="checkLikePrice"
                                                               value="${promotionalDetailsList.discountedPrice}"/>
                                                    </c:if>
                                                </c:forEach>
                                                <c:choose>
                                                    <c:when test="${checkLike }">
                                                        <span class="text-muted text-decoration-line-through me-2">
                                                                   <fmt:formatNumber
                                                                           type="number"
                                                                           pattern="###,###,###"
                                                                           value="${cartList.product.price}"/> ₫
                                                              </span>
                                                        <span class="total-amount">
                                                        <fmt:formatNumber
                                                                type="number"
                                                                pattern="###,###,###"
                                                                value="${checkLikePrice}"/>
                                                     </span>₫
                                                        <a href="#" data-product-id="${cartList.cartId}"
                                                           class="order-close"><i
                                                                class="far fa-times-circle"></i></a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="total-amount" style="margin-left: 64px">
                                                        <fmt:formatNumber
                                                                type="number"
                                                                pattern="###,###,###"
                                                                value="${cartList.product.price}"/>
                                                     </span>₫
                                                        <a href="#" data-product-id="${cartList.cartId}"
                                                           class="order-close"><i
                                                                class="far fa-times-circle"></i></a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                        <div id="ContinueShopping">
                            <c:if test="${cartList == []}">
                                <h2 class="c" style="text-align: center"><a href="/">Tiếp tục mua sắm</a></h2>
                            </c:if>
                        </div>
                        <div class="total-money">Tổng tiền: <fmt:formatNumber
                                type="number"
                                pattern="###,###,###"
                                value="${totalPrice}"/> ₫
                        </div>
                        <a href="http://localhost:8080/cart" class="btn btn--default cart-btn">Xem giỏ hàng</a>
                        <div class="btn btn--default cart-btn orange" id="vnpay1" data-user-id="${userLogin.userID}">
                            Thanh
                            toán
                            VNPAY<!-- norcart -->
                        </div>
                        <!-- <img class="header__cart-img-nocart" src="http://www.giaybinhduong.com/images/empty-cart.png" alt=""> -->
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <c:choose>
            <c:when test="${userLogin==null}">


            </c:when>
            <c:otherwise>

            </c:otherwise>
        </c:choose>
    </div>
</div>
<script>

    function increaseQuantity(index) {
        var quantityElement = document.getElementById("quantity_" + index);
        var currentQuantity = parseInt(quantityElement.innerText);
        quantityElement.innerText = currentQuantity + 1;
        // Bạn có thể thực hiện bất kỳ xử lý nào khác ở đây, ví dụ: cập nhật tổng tiền...
    }

    function decreaseQuantity(index) {
        var quantityElement = document.getElementById("quantity_" + index);
        var currentQuantity = parseInt(quantityElement.innerText);
        if (currentQuantity > 1) {
            quantityElement.innerText = currentQuantity - 1;
            // Bạn có thể thực hiện bất kỳ xử lý nào khác ở đây, ví dụ: cập nhật tổng tiền...
        } else {
            alert("Số lượng không thể nhỏ hơn 1");
        }
    }

    const search1 = () => {
        console.log("chaạy qua ok")
        const searchbox = document.getElementById('search-item').value.toUpperCase();
        const product = document.querySelectorAll(".product1");
        const pname = document.getElementsByTagName("h2");
        for (var i = 0; i < pname.length; i++) {
            let match = product[i].getElementsByTagName('h2')[0];
            if (match) {
                let textvalue = match.textContent || match.innerHTML;
                if (textvalue.toUpperCase().indexOf(searchbox) > -1) {
                    product[i].style.display = "";
                } else {
                    product[i].style.display = "none";
                }
            }
        }
    }

    const showMenu = () => {
        const menu = document.getElementById('menu');
        menu.classList.add('active');
    }

    const hideMenu = (event) => {
        // Kiểm tra xem sự kiện được kích hoạt có phải là một hành động click trên liên kết hay không
        const target = event.relatedTarget || event.explicitOriginalTarget || document.activeElement;
        if (target.tagName.toLowerCase() !== 'a') {
            const menu = document.getElementById('menu');
            menu.classList.remove('active');
        }
    }

</script>
