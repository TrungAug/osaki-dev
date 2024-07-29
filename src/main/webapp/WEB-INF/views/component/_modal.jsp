<%--
  Created by IntelliJ IDEA.
  User: Hoang Tuan
  Date: 1/30/2024
  Time: 1:56 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="input" uri="http://www.springframework.org/tags/form" %>
<div class="ModalForm">
    <div class="modal" id="my-Register">
        <a href="#" class="overlay-close"></a>
        <div class="authen-modal register">
            <h3 class="authen-modal__title">Đăng Kí</h3>
            <form:form modelAttribute="UserC" action="/account/register" method="post" id="formRegister">
                <div class="form-group">
                    <label class="form-label">Họ Tên *</label>
                    <form:input path="fullName"  class="form-control"/>
                    <small class="text-danger" id="fullNameError"></small>
                </div>
                <div class="form-group">
                    <label for="password" class="form-label">Tài khoản Email *</label>
                    <form:input path="email"  id="password" class="form-control"/>
                    <small class="text-danger" id="emailError"></small>
                </div>
                <div class="form-group">
                    <label for="password" class="form-label">Mật khẩu *</label>
                    <form:input path="password" class="form-control"/>
                    <small class="text-danger" id="passwordError"></small>
                </div>
                <div class="form-group">
                    <label for="password" class="form-label">Nhập lại mật khẩu *</label>
                    <input type="password" name="confirmPassword" required="required" class="form-control">
                    <small class="text-danger" id="confirmPasswordError"></small>
                </div>
                <div id="recaptchaContainer" style="display: none;">
                    <div class="g-recaptcha" data-sitekey="6LdosU4pAAAAAO_EzhGlRqWLJqns6eULivmzGWWE"></div>
                </div>

                <div id="error"></div>
                <div class="d-flex justify-content-center">
                    <button class="btn btn-primary" id="submitButton">ĐĂNG KÝ</button>
                </div>
            </form:form>
        </div>

    </div>
    <div class=" modal" id="my-Login">
        <a href="#" class="overlay-close"></a>
        <div class="authen-modal login">
            <h3 class="authen-modal__title">Đăng Nhập</h3>
            <form action="login" method="post" id="loginForm">
                <div class="form-group">
                    <label class="form-label">Địa chỉ email *</label>
                    <input name="LGemail" type="email" class="form-control" id="LGemail">
                    <span class="form-message" id="emailLGError"></span>
                </div>
                <div class="form-group">
                    <label for="password" class="form-label">Mật khẩu *</label>
                    <input name="LGPassword" type="password" class="form-control" id="LGPassword">
                    <span class="form-message" id="passLGError"></span>
                </div>
                <input type="checkbox" name="chkRemember" class="authen-checkbox" value="true" id="chkRemember">
                <label class="form-label">Ghi nhớ mật khẩu</label>
                <div class="d-flex justify-content-center">
                    <button class="btn btn-primary  ">ĐĂNG NHẬP</button>
                </div>
                <div class="row mt-3">
                    <div class="col-12 social-login d-flex justify-content-center">
                        <a class="btn btn-primary mx-3"
                           href="https://accounts.google.com/o/oauth2/auth?scope=profile&redirect_uri=http://localhost:8080/login&response_type=code
		   &client_id=696627188228-lppdd724j8bftrq7pi0pj6eefjqh8erl.apps.googleusercontent.com&approval_prompt=force"><i
                                class="bi bi-google google"></i>Login google</a>
                        <a class="btn btn-primary"
                           href="https://www.facebook.com/dialog/oauth?client_id=894672849328719&redirect_uri=http://localhost:8080/loginFB">
                            <i class="bi bi-facebook facebook"></i>Login facebook</a>
                    </div>
                </div>
            </form>


            <a class="authen__link">Quên mật khẩu ?</a>
        </div>
    </div>

</div>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>

