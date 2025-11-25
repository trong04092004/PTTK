<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.List, Model.MenuFood, Model.TableOrder, Model.Customer, Model.Table, java.text.SimpleDateFormat, java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đặt món ăn trực tuyến</title>
<style>
/* CSS giữ nguyên */
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

.info-bar {
	display: flex;
	justify-content: center;
	gap: 30px;
	background-color: #eef5ff;
	padding: 10px 20px;
	border-radius: 8px;
	margin-bottom: 20px;
	width: 85%;
	margin: 0 auto 20px auto;
	border: 1px solid #d0e0f0;
}

.info-bar p {
	margin: 0;
	font-size: 15px;
	color: #333;
}

.controls-container {
	display: flex;
	justify-content: space-between;
	align-items: center;
	width: 85%;
	margin: 0 auto 25px auto;
}

.search-form {
	display: flex;
	gap: 8px;
	margin: 0;
}

.confirm-form {
	margin: 0;
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

.confirm-btn {
	background-color: #28a745;
}

.confirm-btn:hover {
	background-color: #218838;
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
}
</style>
</head>
<body>
	<%
	TableOrder tableOrder = (TableOrder) session.getAttribute("currentTableOrder");
	Customer customer = (tableOrder != null) ? tableOrder.getCustomer() : null;
	Table table = (tableOrder != null) ? tableOrder.getTable() : null;
	String tenKhachHang = (customer != null) ? customer.getName() : "N/A";
	String soBan = (table != null) ? table.getNumberTable() : "N/A";
	String tang = (table != null) ? table.getFloor() : "N/A";
	String ngayDat = (tableOrder != null && tableOrder.getDate() != null)
			? new SimpleDateFormat("dd/MM/yyyy").format(tableOrder.getDate())
			: new SimpleDateFormat("dd/MM/yyyy").format(new Date());
	%>

	<h1>Hệ thống nhà hàng RestMan</h1>
	<h2>Đặt món ăn trực tuyến</h2>

	<div class="info-bar">
		<p>
			<strong>Khách hàng:</strong>
			<%=tenKhachHang%></p>
		<p>
			<strong>Bàn:</strong>
			<%=soBan%>
			(Tầng
			<%=tang%>)
		</p>
		<p>
			<strong>Ngày:</strong>
			<%=ngayDat%></p>
	</div>

	<div class="controls-container">
		<form class="search-form"
			action="${pageContext.request.contextPath}/MenuFood2Servlet"
			method="get">
			<input type="text" name="key" placeholder="Nhập tên hoặc loại món..."
				value="<%=request.getParameter("key") != null ? request.getParameter("key") : ""%>">
			<button type="submit" name="action" value="search">Tìm kiếm</button>
		</form>

		<form class="confirm-form"
			action="${pageContext.request.contextPath}/MenuFood2Servlet"
			method="get">
			<button class="confirm-btn" type="submit" name="action"
				value="confirm">Xác nhận đơn đặt món ➔</button>
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
				<td><%=index++%></td>
				<td><%=food.getName()%></td>
				<td><%=String.format("%,.0f", food.getPrice())%></td>
				<td><%=food.getDes()%></td>
				<td><%=food.getType()%></td>
				<td><a
					href="${pageContext.request.contextPath}/MenuFood2Servlet?action=choose&id=<%= food.getId() %>"
					class="choose-link">Chọn</a></td>
			</tr>
			<%
			}
			}
			%>
		</tbody>
	</table>

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
        document.getElementById("popup-title").innerText = status === "success" ? "✅ Thành công" : "❌ Thất bại";
        document.getElementById("popup-msg").innerText = status === "success" ? "Đã thêm món thành công!" : "Không thể thêm món!";
    }
    function closePopup() {
        document.getElementById("popup").style.display = "none";
        const url = new URL(window.location.href);
        url.searchParams.delete("status");
        window.history.replaceState({}, document.title, url.toString());
    }
    let isInternalNavigation = false;
    document.querySelectorAll('a, button, input[type=submit]').forEach(el => {
        el.addEventListener('click', () => { isInternalNavigation = true; });
    });
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', () => { isInternalNavigation = true; });
    });
    function sendCleanupBeacon() {
        if (!isInternalNavigation) {
            const url = '${pageContext.request.contextPath}/FoodOrderServlet';
            const data = new Blob(['action=cleanup'], {type: 'application/x-www-form-urlencoded'});
            navigator.sendBeacon(url, data);
        }
    }
    window.addEventListener('pagehide', sendCleanupBeacon);
    </script>
</body>
</html>