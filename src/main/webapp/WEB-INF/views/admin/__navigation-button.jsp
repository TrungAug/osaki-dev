<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<input class="form-control me-2" value="${totalElements} mục"
	style="max-width: 18%; background-color: #b7a888;" disabled="disabled">
<c:if test="${not booleanFirst}">
	<a class="btn btn-outline-secondary me-2"
		href="/admin?content=${content}&p=0">Đầu</a>
	<a class="btn btn-outline-secondary me-2"
		href="/admin?content=${content}&p=${prevPage}">Trước</a>
</c:if>
<input class="form-control" name="currentPage" value="${currentPage}"
	style="max-width: 8%; background-color: #b7a888;" disabled="disabled">
<input class="form-control me-2" value="of ${totalPages}"
	style="max-width: 12%; background-color: #b7a888;" disabled="disabled">
<c:if test="${not booleanLast}">
	<a class="btn btn-outline-secondary me-2"
		href="/admin?content=${content}&p=${nextPage}">Tiếp</a>
	<a class="btn btn-outline-secondary me-2"
		href="/admin?content=${content}&p=${totalPages}">Cuối</a>
</c:if>