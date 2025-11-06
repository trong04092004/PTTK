<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="Model.MenuFood"%>

<%
    MenuFood food = (MenuFood) request.getAttribute("food");
    DecimalFormat df = new DecimalFormat("#,###");
%>

<div id="chooseQuantityModal" class="modal-overlay">
	<div class="modal-content">
		<h2>Chọn số lượng cho món</h2>
		<form action="<%= request.getContextPath() %>/FoodOrderServlet"
			method="post" id="quantityForm">
			<input type="hidden" name="id"
				value="<%= food != null ? food.getId() : "" %>">
			<table>
				<thead>
					<tr>
						<th>Tên món</th>
						<th>Giá (VNĐ)</th>
						<th>Thể loại</th>
						<th>Số lượng</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><%= food != null ? food.getName() : "" %></td>
						<td><%= food != null ? df.format(food.getPrice()) : "" %></td>
						<td><%= food != null ? food.getType() : "" %></td>
						<td>
							<button type="button" class="quantity-btn"
								onclick="changeQty(-1)">−</button> <input type="text"
							id="quantity" name="quantity" value="1" readonly>
							<button type="button" class="quantity-btn" onclick="changeQty(1)">+</button>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="btn-container">
				<button type="button" class="action-btn" onclick="closeModal()">Quay
					lại</button>
				<button type="submit" class="action-btn">Xác nhận</button>
			</div>
		</form>
	</div>
</div>

<style>
.modal-overlay {
	display: flex;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.6);
	justify-content: center;
	align-items: center;
	z-index: 9999;
}

.modal-content {
	background: white;
	padding: 30px 40px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
	text-align: center;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin: 15px 0;
}

th, td {
	border: 1px solid #ccc;
	padding: 10px;
}

th {
	background: #f0f0f0;
}

.quantity-btn {
	background: #00bfff;
	color: white;
	border: none;
	padding: 5px 12px;
	border-radius: 5px;
	cursor: pointer;
}

.quantity-btn:hover {
	background: #0099cc;
}

.btn-container {
	margin-top: 20px;
	display: flex;
	justify-content: space-between;
}

.action-btn {
	background-color: #00bfff;
	color: white;
	border: none;
	padding: 10px 25px;
	border-radius: 5px;
	cursor: pointer;
}

.action-btn:hover {
	background-color: #0099cc;
}
</style>

<script>
function changeQty(amount) {
    let qty = document.getElementById("quantity");
    let val = parseInt(qty.value) + amount;
    if (val < 1) val = 1;
    qty.value = val;
}
function closeModal() {
    window.location.href = "<%= request.getContextPath() %>/MenuFood2Servlet?action=search";
}
</script>
