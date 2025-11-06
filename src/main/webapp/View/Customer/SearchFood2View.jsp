<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="Model.MenuFood"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tìm kiếm món ăn trực tuyến</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f7f7f7;
	padding: 40px;
	text-align: center;
}

h1 {
	color: #333;
	margin-bottom: 20px;
}

.search-container {
	margin-bottom: 25px;
}

input[type="text"] {
	padding: 8px 12px;
	width: 220px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

button {
	padding: 8px 16px;
	background-color: #00bfff;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

button:hover {
	background-color: #0099cc;
}

table {
	width: 85%;
	margin: 0 auto;
	border-collapse: collapse;
	background-color: white;
	box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
}

th, td {
	border: 1px solid #ccc;
	padding: 10px;
	text-align: left;
}

th {
	background-color: #f0f0f0;
}

a {
	color: #00bfff;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}

.confirm-btn {
	margin-top: 25px;
	background-color: #28a745;
	padding: 10px 20px;
	border-radius: 6px;
	color: white;
	border: none;
	cursor: pointer;
}

.confirm-btn:hover {
	background-color: #218838;
}

.popup-overlay {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	justify-content: center;
	align-items: center;
	z-index: 9999;
}

.popup-content {
	background: white;
	padding: 25px 40px;
	border-radius: 10px;
	text-align: center;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
}

.popup-content h3 {
	margin-bottom: 10px;
}

.popup-content button {
	background: #00bfff;
	color: white;
	border: none;
	padding: 8px 16px;
	border-radius: 5px;
	cursor: pointer;
}
</style>
</head>
<body>
	<h1>Hệ thống nhà hàng RestMan</h1>
	<h2>Đặt món ăn trực tuyến</h2>

	<div class="search-container">
		<form action="${pageContext.request.contextPath}/MenuFood2Servlet"
			method="get">
			<input type="text" name="key" placeholder="Nhập tên hoặc loại món..."
				value="<%= request.getParameter("key") != null ? request.getParameter("key") : "" %>">
			<button type="submit" name="action" value="search">Tìm kiếm</button>
		</form>
	</div>

	<table>
		<thead>
			<tr>
				<th>STT</th>
				<th>Tên món ăn</th>
				<th>Giá (VNĐ)</th>
				<th>Mô tả</th>
				<th>Thể loại</th>
				<th>Thao tác</th>
			</tr>
		</thead>
		<tbody>
			<%
            List<MenuFood> listFood = (List<MenuFood>) request.getAttribute("listFood");
            if (listFood == null || listFood.isEmpty()) {
        %>
			<tr>
				<td colspan="6" style="text-align: center;">Không có dữ liệu
					món ăn.</td>
			</tr>
			<%
            } else {
                int index = 1;
                for (MenuFood food : listFood) {
        %>
			<tr>
				<td><%= index++ %></td>
				<td><%= food.getName() %></td>
				<td><%= String.format("%,.0f", food.getPrice()) %></td>
				<td><%= food.getDes() %></td>
				<td><%= food.getType() %></td>
				<td><a
					href="${pageContext.request.contextPath}/MenuFood2Servlet?action=choose&id=<%= food.getId() %>">Chọn</a></td>
			</tr>
			<%
                }
            }
        %>
		</tbody>
	</table>

	<form action="${pageContext.request.contextPath}/MenuFood2Servlet"
		method="get">
		<button class="confirm-btn" type="submit" name="action"
			value="confirm">Xác nhận đơn đặt món</button>
	</form>

	<div id="popup" class="popup-overlay">
		<div class="popup-content">
			<h3 id="popup-title"></h3>
			<p id="popup-msg"></p>
			<button onclick="closePopup()">Đóng</button>
		</div>
	</div>

	<script>
const params = new URLSearchParams(window.location.search);
const status = params.get("status");
if (status === "success" || status === "fail") {
    document.getElementById("popup").style.display = "flex";
    document.getElementById("popup-title").innerText =
        status === "success" ? "✅ Thành công" : "❌ Thất bại";
    document.getElementById("popup-msg").innerText =
        status === "success" ? "Đã thêm món thành công!" : "Không thể thêm món!";
}
function closePopup() {
    document.getElementById("popup").style.display = "none";
    const url = new URL(window.location.href);
    url.searchParams.delete("status");
    window.history.replaceState({}, document.title, url.toString());
}
</script>
</body>
</html>
