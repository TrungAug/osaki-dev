<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" type="text/css" href="css/login.css"/>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link
            href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@100;200;300;400;500;600;700;800;900&display=swap"
            rel="stylesheet">
    <!-- Icon fontanwesome -->
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
          integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
    <!-- Reset css & grid sytem -->
    <link rel="stylesheet" href="/css/library.css">
    <link href="/owlCarousel/assets/owl.carousel.min.css" rel="stylesheet"/>
    <!-- Layout -->
    <link rel="stylesheet" href="/css/common.css">
    <!-- index -->
    <link href="/css/home.css" rel="stylesheet"/>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Owl caroucel Js-->
    <script src="/owlCarousel/owl.carousel.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <!-- Bao gồm thư viện Swal -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.16/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.16/dist/sweetalert2.all.min.js"></script>
</head>
<style>
    .swal2-popup {
        font-size: 2rem;
    }

    a {
        text-decoration: none;
    }
</style>
<body>
<div class="login-background">
    <div class="login-container">
        <div class="login-contain row">
            <div class="authen-modal login">
                <div class="d-flex justify-content-center mt-2"><h3 class="authen-modal__title  ">Đăng nhập</h3></div>
                <form action="login" method="post" id="loginForm">
                    <div class="form-group">
                        <label class="form-label" style="font-size: 16px">Địa chỉ email *</label>
                        <input name="LGemail" type="email" class="form-control" id="LGemail" value="${LGemail}"
                               style="font-size: 16px">
                        <span class="form-message" id="emailLGError"></span>
                    </div>
                    <div class="form-group">
                        <label for="LGPassword" class="form-label" style="font-size: 16px">Mật khẩu *</label>
                        <input name="LGPassword" type="password" class="form-control" id="LGPassword"
                               value="${LGPassword}" style="font-size: 16px">
                        <span class="form-message" id="passLGError"></span>
                    </div>
                    <input type="checkbox" name="chkRemember" class="authen-checkbox" value="true"
                           id="chkRemember" ${check? 'checked' : ''}>
                    <label class="form-label" style="font-size: 16px">Ghi nhớ mật khẩu</label>
                    <div class="d-flex justify-content-center">
                        <button class="btn btn-primary  " style="font-size: 16px">ĐĂNG NHẬP</button>
                    </div>
                    <div class="row mt-3">
                        <div class="col-12 social-login d-flex justify-content-center">
                            <a class="btn btn-primary mx-3"
                               href="https://accounts.google.com/o/oauth2/auth?scope=profile&redirect_uri=http://localhost:8080/loginGG&response_type=code
		   &client_id=696627188228-lppdd724j8bftrq7pi0pj6eefjqh8erl.apps.googleusercontent.com&approval_prompt=force"><i
                                    class="bi bi-google google"></i>Login google</a>
                            <a class="btn btn-primary"
                               href="https://www.facebook.com/dialog/oauth?client_id=894672849328719&redirect_uri=http://localhost:8080/loginFB">
                                <i class="bi bi-facebook facebook"></i>Login facebook</a>
                        </div>
                    </div>
                </form>
                <a class="authen__link" href="/forgot-password">Quên mật khẩu ?</a>
                <a class="authen__link" href="/register">Chưa có tài khoản</a>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
<script src="/js/login.js"></script>
</body>
</html>