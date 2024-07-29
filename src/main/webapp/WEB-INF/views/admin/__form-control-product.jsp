<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:set var="action" value="${param.action}" />

<div class="container mt-5">
	<h3>${action=='add' ? 'Thêm' : 'Sửa'}sảnphẩm</h3>
	<form method="post"
		action="${action=='add' ? '/admin/add-product' : updateProduct.productID}"
		enctype="multipart/form-data">
		<div class="row">
			<div class="col-md-6">
				<div class="mb-3">
					<label for="productName" class="form-label">Tên sản phẩm
						${updateProduct.productID}</label> <input type="text" class="form-control"
						id="productName" value="${updateProduct.name}" name="productName"
						placeholder="Tên sản phẩm">
				</div>
				<div class="mb-3">
					<label for="price" class="form-label">Giá</label> <input
						type="number" class="form-control" id="price" name="price"
						value="${updateProduct.price}" placeholder="Giá">
				</div>
				<div class="mb-3">
					<label for="quantity" class="form-label">Số lượng trong kho</label>
					<input type="number" class="form-control" min="0" id="quantity"
						value="${updateProduct.quantityInStock}" name="quantity"
						placeholder="Số lượng">
				</div>
				<div class="mb-3">
					<label for="uses" class="form-label">Cách sử dụng</label> <input
						type="text" class="form-control" id="uses" name="uses"
						value="${updateProduct.uses}" placeholder="Cách sử dụng">
				</div>
				<div class="mb-3">
					<label for="preserve" class="form-label">Cách bảo quản</label> <input
						type="text" class="form-control" id="preserve" name="preserve"
						value="${updateProduct.preserve}" placeholder="Cách bảo quản">
				</div>
				<div class="mb-3">
					<label for="skinType" class="form-label">Loại da</label> <input
						type="text" class="form-control" id="skinType" name="skinType"
						value="${updateProduct.skinType}" placeholder="Loại da">
				</div>
				<div class="mb-3">
					<label for="certification" class="form-label">Chứng nhận</label> <input
						type="text" class="form-control" id="certification"
						value="${updateProduct.certification}" name="certification"
						placeholder="Chứng nhận">
				</div>
				<div class="mb-3">
					<label for="dateOfManufacture" class="form-label">Ngày sản
						xuất</label> <input type="date" class="form-control"
						value="${updateProduct.dateOfManufacture}" id="dateOfManufacture"
						name="dateOfManufacture">
				</div>
			</div>
			<div class="col-md-6">

				<div class="mb-3">
					<label for="expiry" class="form-label">Hạn sử dụng</label> <input
						type="text" class="form-control" id="expiry" name="expiry"
						value="${updateProduct.expiry}" placeholder="Hạn sử dụng">
				</div>
				<div class="mb-3">
					<label for="manufacturer" class="form-label">Nhà sản xuất</label> <input
						type="text" class="form-control" id="manufacturer"
						value="${updateProduct.manufacturer}" name="manufacturer"
						placeholder="Nhà sản xuất">
				</div>
				<div class="mb-3">
					<label for="ingredient" class="form-label">Thành phần</label> <input
						type="text" class="form-control" id="ingredient" name="ingredient"
						value="${updateProduct.ingredient}" placeholder="Thành phần">
				</div>
				<div class="mb-3">
					<label for="description" class="form-label">Mô tả</label>
					<textarea class="form-control" id="description" name="description"
						value="${updateProduct.description}" placeholder="Mô tả" rows="3"></textarea>
				</div>

				<div class="mb-3">
					<label for="categoryID" class="form-label">Danh mục sản
						phẩm</label> <select class="form-select" id="categoryID" name="categoryID"
						value="${updateProduct.categoryID}">
						<option value="">Chọn danh mục</option>

						<c:forEach var="category" items="${cateList}">
							<option value="${category.categoryID}"
								${updateProduct.categoryID.categoryID == category.categoryID ?'selected':''}>${category.categoryName}</option>
						</c:forEach>
					</select>
				</div>
				<div class="mb-3">
					<label for="imageFiles" class="form-label">Chọn hình ảnh</label> <input
						type="file" class="form-control" id="image" name="image"
						multiple>
				</div>

			</div>
		</div>
		<div class="d-flex justify-content-end">
			<button type="submit" class="btn btn-primary me-2">${action=='add' ? 'Thêm' : 'Sửa'}</button>
		</div>
	</form>
</div>
