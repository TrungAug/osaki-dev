<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HASAGI WEBSITE MANAGER</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
            crossorigin="anonymous">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="shortcut icon" href="/imagesAdmin/hasagi-logo.jpg">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" type="text/css" href="/css/admin.css"/>
</head>
<body>

<div class="container-fluid">
    <jsp:include page="_menu5.jsp"/>

    <div class="main">
        <jsp:include page="${content}"/>
    </div>
</div>


<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script type="text/javascript" src="/js/admin-chart.js"></script>
<script src="/js/admin-user.js"></script>
<script src="/js/admin-category.js"></script>
<script src="/js/admin-order.js"></script>
<script src="/js/admin-details-order.js"></script>
<script>
    //menu toggle
    let toggle = document.querySelector('.toggle');
    let navigation = document.querySelector('.navigation');
    let main = document.querySelector('.main');

    toggle.onclick = function () {
        navigation.classList.toggle('active');
        main.classList.toggle('active');
    }

    //add class
    let list = document.querySelectorAll('.navigation li');

    function activeLink() {
        list.forEach(
            (item) => item.classList.remove('hovered')
        );
        this.classList.add('hovered');
    }

    list.forEach(
        (item) => item.addEventListener('mouseover', activeLink)
    )
    
    

    var dataRevenueByCategory = ${dataRevenueByCategory};
    console.log(dataRevenueByCategory);
    var dataInventory = ${dataInventory};
    console.log(dataInventory);
    
</script>
</body>
</html>