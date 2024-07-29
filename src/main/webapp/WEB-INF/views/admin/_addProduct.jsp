<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="container mt-5">
        <h1>Thêm sản phẩm</h1>
        <form>
            <div class="row">
                <div class="col-md-6">
                    <div class="mb-3">
                        <label for="productName" class="form-label">Tên sản phẩm</label>
                        <input type="text" class="form-control" id="productName" placeholder="Tên sản phẩm">
                    </div>
                    <div class="mb-3">
                        <label for="price" class="form-label">Giá</label>
                        <input type="number" class="form-control" id="price" placeholder="Giá">
                    </div>
                    <div class="mb-3">
                        <label for="quantity" class="form-label">Số lượng trong kho</label>
                        <input type="number" class="form-control" id="quantity" placeholder="Số lượng">
                    </div>
                    <div class="mb-3">
                        <label for="uses" class="form-label">Cách sử dụng</label>
                        <input type="text" class="form-control" id="uses" placeholder="Cách sử dụng">
                    </div>
                    <div class="mb-3">
                        <label for="preserve" class="form-label">Cách bảo quản</label>
                        <input type="text" class="form-control" id="preserve" placeholder="Cách bảo quản">
                    </div>
                    <div class="mb-3">
                        <label for="skinType" class="form-label">Loại da</label>
                        <input type="text" class="form-control" id="skinType" placeholder="Loại da">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="mb-3">
                        <label for="certification" class="form-label">Chứng nhận</label>
                        <input type="text" class="form-control" id="certification" placeholder="Chứng nhận">
                    </div>
                    <div class="mb-3">
                        <label for="dateOfManufacture" class="form-label">Ngày sản xuất</label>
                        <input type="date" class="form-control" id="dateOfManufacture">
                    </div>
                    <div class="mb-3">
                        <label for="expiry" class="form-label">Hạn sử dụng</label>
                        <input type="text" class="form-control" id="expiry" placeholder="Hạn sử dụng">
                    </div>
                    <div class="mb-3">
                        <label for="manufacturer" class="form-label">Nhà sản xuất</label>
                        <input type="text" class="form-control" id="manufacturer" placeholder="Nhà sản xuất">
                    </div>
                    <div class="mb-3">
                        <label for="ingredient" class="form-label">Thành phần</label>
                        <input type="text" class="form-control" id="ingredient" placeholder="Thành phần">
                    </div>
                    <div class="mb-3">
                        <label for="description" class="form-label">Mô tả</label>
                        <textarea class="form-control" id="description" placeholder="Mô tả" rows="4"></textarea>
                    </div>
                </div>
            </div>
            <button type="submit" class="btn btn-primary">Thêm</button>
        </form>
    </div>