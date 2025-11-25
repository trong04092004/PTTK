<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="java.util.*, Model.TableOrder"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tìm bàn đã đặt</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f5f7ff;
	margin: 0;
	padding: 0;
	text-align: center;
}

h1 {
	color: #111;
	margin-top: 30px;
	font-weight: bold;
}

.search-box {
	margin-top: 20px;
}

input[type="text"] {
	padding: 10px;
	width: 250px;
	border: 1px solid #aaa;
	border-radius: 4px;
	font-size: 15px;
}

button {
	background-color: #00bfff;
	border: none;
	padding: 10px 25px;
	color: white;
	font-weight: bold;
	font-size: 15px;
	border-radius: 5px;
	margin-left: 8px;
	cursor: pointer;
}

button:hover {
	background-color: #0099cc;
}

table {
	border-collapse: collapse;
	margin: 30px auto;
	background-color: white;
	width: 80%;
	box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
}

th, td {
	padding: 12px 20px;
	border: 1px solid #ddd;
	text-align: center;
}

th {
	background-color: #f2f2f2;
	font-weight: bold;
}

p {
	margin-top: 30px;
	color: #444;
	font-style: italic;
}

tr.clickable-row:hover {
	background-color: #f0f8ff;
	cursor: pointer;
}
</style>
</head>
<body>
	<h1>Hệ thống nhà hàng RestMan</h1>
	<h1>Tìm bàn đã đặt</h1>

	<div class="search-box">
		<form action="<%= request.getContextPath() %>/searchTableOrdered"
			method="get">
			<input type="text" name="infoCustomer"
				placeholder="Nhập tên hoặc SĐT khách hàng"
				value="<%= request.getAttribute("infoCustomer") != null ? request.getAttribute("infoCustomer") : "" %>">
			<button type="submit">Tìm kiếm</button>
		</form>
	</div>

	<%
    List<TableOrder> list = (List<TableOrder>) request.getAttribute("listTableOrder");
    if (list != null && !list.isEmpty()) {
    %>
	<table>
		<tr>
			<th>STT</th>
			<th>Tên</th>
			<th>SĐT</th>
			<th>Địa chỉ</th>
			<th>Bàn đã đặt</th>
			<th>Ngày đặt bàn</th>
		</tr>
		<%
            int i = 1;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            for (TableOrder order : list) {
                String name = order.getCustomer() != null ? order.getCustomer().getName() : "";
                String tel = order.getCustomer() != null ? order.getCustomer().getTel() : "";
                String address = order.getCustomer() != null ? order.getCustomer().getAddress() : "";
                String tableName = order.getTable() != null ? (order.getTable().getNumberTable() + ", tầng " + order.getTable().getFloor()) : "";
                String dateOrder = order.getDate() != null ? sdf.format(order.getDate()) : "";
        %>
		<tr class="clickable-row" onclick="goToFoodView(<%= i - 1 %>)">
			<td><%= i++ %></td>
			<td><%= name %></td>
			<td><%= tel %></td>
			<td><%= address %></td>
			<td><%= tableName %></td>
			<td><%= dateOrder %></td>
		</tr>
		<% } %>
	</table>
	<% } else if (request.getAttribute("infoCustomer") != null) { %>
	<p>Không tìm thấy kết quả phù hợp!</p>
	<% } %>

	<script>
    let isInternalNavigation = false;
    function goToFoodView(index) {
        isInternalNavigation = true;
        window.location.href = '<%= request.getContextPath() %>/searchTableOrdered?rowIndex=' + index;
    }
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', () => {
            isInternalNavigation = true;
        });
    });
    function sendCleanupBeacon() {
        if (!isInternalNavigation) {
            const url = '<%= request.getContextPath() %>/FoodOrderServlet';
            const data = new Blob(['action=cleanup'], {type: 'application/x-www-form-urlencoded'});
            navigator.sendBeacon(url, data);
        }
    }
    window.addEventListener('pagehide', sendCleanupBeacon);
    window.addEventListener('beforeunload', function() {
    });
    </script>
</body>
</html>