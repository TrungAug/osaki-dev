
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="comment" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="right_customer"  >
	<div class="recentCustomer">
		<div class="cardHeader">
			<h2>Tài khoản</h2>
		</div>

		<table class="table table-hover table-custom">
			<tr>
				<td width="60px">
					<div class="img-thumbnail imgBox">
						<img src="/images/${userLogin.image}">
					
					</div>
					 
				</td>
			 
				<!--  <p>Anh: ${userLogin.image}</p> -->
				<td>
					<h4>
						${userLogin.fullName} <br> <span>${userLogin.email}</span>
					</h4>
				</td>
				<td  >
				    <a href="#" class="btn btn-primary info-AccountModal"
				        data-bs-toggle="modal" data-bs-target="#infoAccountModal"
				        data-info-account='{"userID":"${userLogin.userID}", "email":"${userLogin.email}","name":"${userLogin.fullName}"    }'>
				        Xem thông tin
				    </a>
				</td>


			</tr>
		</table>
	</div>
</div>
<div class="modal fade" id="infoAccountModal" tabindex="-1"
	aria-labelledby="#infoAccountModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Thông tin</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<form action="edit-info-account" method="post" enctype="multipart/form-data">
				<div class="modal-body">
					<input name="idInput" id="idInput" type="hidden" /> <br> 
				<!---->  <label>Email</label>
					<br> <input name="email" id="emailInput" class="form-control"
						disabled="disabled" /> <br> 
						<label>Họ và tên </label> <br>
					<input name="fullName" id="nameInput" class="form-control" /> <br>
					 
					 
					
					  
					  
					<label>Thay doi hinh anh</label> <br>
					 <input type="file" name="file" id="imageInput"> <br>

				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Đóng</button>
					<button class="btn btn-primary">Lưu thay đổi</button>
				</div>
			</form>
		</div>
	</div>
</div>

<script>
	document.addEventListener('DOMContentLoaded', function() {
		const editLinks = document.querySelectorAll('.info-AccountModal');

		editLinks.forEach(function(link) {
			link.addEventListener('click', function() {
				const infoString = this.getAttribute('data-info-account');
				const info = JSON.parse(infoString);

				document.getElementById('idInput').value = info.userID;
				document.getElementById('nameInput').value = info.name;
				document.getElementById('emailInput').value = info.email; 
				 
				 
			});
		});
	});  
</script>

<!-- Chart -->