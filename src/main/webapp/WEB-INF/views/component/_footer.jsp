<%--
  Created by IntelliJ IDEA.
  User: Hoang Tuan
  Date: 1/30/2024
  Time: 1:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="grid wide">
    <div class="row">
        <div class="col l-3 m-6 s-12">
            <h3 class="footer__title" style="margin-left: 38px;">Danh mục</h3>
            <ul class="footer__list">
                <c:forEach var="c" items="${listCategories}" varStatus="i">
                    <c:if test="${i.index<5}">
                        <li class="footer__item">
                            <a href="/product/search-category/${c.categoryID}"
                               class="footer__link">${c.categoryName}</a>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
        </div>
        <div class="col l-3 m-6 s-12">
            <h3 class="footer__title" style="margin-left: 38px;">Thương hiệu</h3>
            <ul class="footer__list">
                <c:forEach var="listBrands" items="${listBrands}" varStatus="i">
                    <c:if test="${i.index<5}">
                        <li class="footer__item">
                            <a href="/product/search-brand/${listBrands.brandID}"
                               class="footer__link">${listBrands.brandName}</a>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
        </div>
        <div class="col l-3 m-6 s-12">
            <h3 class="footer__title" style="margin-left: 38px;">Liên hệ</h3>
            <ul class="footer__list">
                <li class="footer__item">
                    <span class="footer__text">
                        <i class="fas fa-map-marked-alt"></i> <a style=" color: var(--white-cl-2);"
                                                                 href="https://maps.google.com/?q=Thị trấn Ngã Sáu, Huyện Châu Thành, Tỉnh Hậu Giang"
                                                                 target="_blank">Thị trấn Ngã Sáu, Huyện Châu Thành, Tỉnh Hậu Giang</a>
                    </span>
                </li>
                <li class="footer__item">
                    <a href="tel:0969281254" class="footer__link">
                        <i class="fas fa-phone"></i> 0969 281 254
                    </a>
                </li>
                <li class="footer__item">
                    <a href="mailto:trung2894@gmail.com" class="footer__link">
                        <i class="fas fa-envelope"></i> trung2894@gmail.com
                    </a>
                </li>
                <li class="footer__item">
                    <div class="social-group">
                        <a href="https://www.facebook.com/profile.php?id=100010611220597" class="social-item"><i
                                class="fab fa-facebook-f"></i>
                        </a>
                        <a href="https://web.telegram.org/a/#6719344260" class="social-item"><i
                                class="fab fa-telegram"></i>
                        </a>
                        <a href="https://discord.com/channels/@me" class="social-item"><i
                                class="fab fa-discord"></i>
                        </a>
                        <a href="zalo://chat" class="social-item"> <img src="../images/zalo1.jpg"
                                                                        style="background-color:#565e64;"
                                                                        alt=""
                        />
                        </a>
                        <a href="https://www.youtube.com/channel/UC6tpDMcWw7Tyy9HdAOIvxCg" class="social-item"><i
                                class="fab fa-youtube"></i>
                        </a>
                    </div>
                </li>
            </ul>
        </div>
        <div class="col l-3 m-6 s-12">
            <h3 class="footer__title" style="margin-left: 38px;">Đăng kí</h3>
            <ul class="footer__list">
                <li class="footer__item">
                    <span class="footer__text">Đăng ký để nhận được được thông tin ưu đãi mới nhất từ chúng tôi.</span>
                </li>
                <li class="footer__item">
                    <div class="send-email">
                        <input class="send-email__input" type="email" id="email" placeholder="Nhập Email...">
                        <a href="#" class="send-email__link">
                            <i class="fas fa-paper-plane" id="sendMessage" data-user-id="${userLogin.userID}"></i>
                        </a>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>
<div class="copyright">
    <span class="footer__text"><a class="footer__link" href="#">Đặng Hoàng Tuấn</a></span>
</div>