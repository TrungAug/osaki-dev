<%--
  Created by IntelliJ IDEA.
  User: Hoang Tuan
  Date: 2/13/2024
  Time: 10:29 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container mt-3">
    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#myModal"
            style="font-size: 16px">
        Thêm địa chỉ
    </button>
</div>

<!-- The Modal -->
<div class="modal" id="myModal">
    <div class="modal-dialog ">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title" style="font-size: 16px">Thêm địa chỉ</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <form id="formAddress">
                    <div class="row">
                        <div class="col-lg-12 mb-2">
                            <input class="form-control" id="phone" placeholder="Số điện thoại" style="font-size: 16px">
                        </div>
                        <div class="col-lg-4">
                            <select class="form-select form-select-sm mb-3" style="font-size: 16px" id="city"
                                    aria-label=".form-select-sm">
                                <option value="" style="font-size: 16px" class="form-control" selected>Chọn tỉnh thành
                                </option>
                            </select>
                        </div>
                        <div class="col-lg-4">
                            <select class="form-select form-select-sm mb-3" style="font-size: 16px" id="district"
                                    aria-label=".form-select-sm">
                                <option value="" style="font-size: 16px" selected>Chọn quận huyện</option>
                            </select>
                        </div>
                        <div class="col-lg-4">
                            <select class="form-select form-select-sm" style="font-size: 16px" id="ward"
                                    aria-label=".form-select-sm">
                                <option value=""style="font-size: 16px" selected>Chọn phường xã</option>
                            </select>
                        </div>
                        <div class="col-lg-12 mb-2">
                            <textarea id="addressSpecific" style="font-size: 16px" class="form-control"
                                      placeholder="Địa chỉ cụ thể"></textarea>
                        </div>
                    </div>
                    <button class="btn btn-primary" style="font-size: 16px" id="addAddress"
                            data-user-id="${userLogin.userID}">Add
                    </button>
                </form>
            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>


<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
<script>
    var citis = document.getElementById("city");
    var districts = document.getElementById("district");
    var wards = document.getElementById("ward");
    var Parameter = {
        url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
        method: "GET",
        responseType: "application/json",
    };
    var promise = axios(Parameter);
    promise.then(function (result) {
        renderCity(result.data);

        // Tự động chọn giá trị mặc định
        setCitiDefault("01"); // Thay đổi giá trị này thành ID của tỉnh/thành phố mặc định
        setDistrictDefault("001"); // Thay đổi giá trị này thành ID của quận/huyện mặc định
        setWardDefault("00001"); // Thay đổi giá trị này thành ID của phường/xã mặc định
    });

    function renderCity(data) {
        for (const x of data) {
            citis.options[citis.options.length] = new Option(x.Name, x.Id);
        }
        citis.onchange = function () {
            districts.length = 1;
            wards.length = 1;
            if (this.value != "") {
                const result = data.filter(n => n.Id === this.value);

                for (const k of result[0].Districts) {
                    districts.options[districts.options.length] = new Option(k.Name, k.Id);
                }
            }
        };
        districts.onchange = function () {
            wards.length = 1;
            const dataCity = data.filter((n) => n.Id === citis.value);
            if (this.value != "") {
                const dataWards = dataCity[0].Districts.filter(n => n.Id === this.value)[0].Wards;

                for (const w of dataWards) {
                    wards.options[wards.options.length] = new Option(w.Name, w.Id);
                }
            }
        };
    }

    // Hàm thiết lập giá trị mặc định cho tỉnh/thành phố
    function setCitiDefault(id) {
        citis.value = id;
        citis.dispatchEvent(new Event('change'));
    }

    // Hàm thiết lập giá trị mặc định cho quận/huyện
    function setDistrictDefault(id) {
        districts.value = id;
        districts.dispatchEvent(new Event('change'));
    }

    // Hàm thiết lập giá trị mặc định cho phường/xã
    function setWardDefault(id) {
        wards.value = id;
    }
</script>

<script src="/js/address.js"></script>

