<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.MenuFood" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tìm kiếm Món ăn</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f7f7f7;
        padding: 40px;
        text-align: center;
    }

    h1 {
        color: #222;
        margin-bottom: 20px;
    }

    .search-container {
        margin-bottom: 25px;
    }

    input[type="text"] {
        padding: 8px 12px;
        width: 200px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 14px;
    }

    button {
        padding: 8px 16px;
        background-color: #00bfff;
        color: white;
        border: none;
        border-radius: 5px;
        font-size: 14px;
        cursor: pointer;
        margin-left: 5px;
    }

    button:hover {
        background-color: #0099cc;
    }

    table {
        width: 80%;
        margin: 0 auto;
        border-collapse: collapse;
        background-color: white;
        box-shadow: 0px 0px 5px rgba(0,0,0,0.1);
    }

    th, td {
        border: 1px solid #ccc;
        padding: 10px;
        text-align: left;
        font-size: 14px;
    }

    th {
        background-color: #f0f0f0;
        font-weight: bold;
    }

    a {
        color: #00bfff;
        text-decoration: none;
    }

    a:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>
    <h1>Hệ thống nhà hàng RestMan</h1>
    <h1>Tìm kiếm Món ăn</h1>

    <!-- Form tìm kiếm -->
    <div class="search-container">
        <form action="${pageContext.request.contextPath}/MenuFoodServlet" method="get">
            <input type="text" name="key" placeholder="Nhập tên món..." value="<%= request.getParameter("key") != null ? request.getParameter("key") : "" %>">
            <button type="submit" name="action" value="search">Tìm kiếm</button>
        </form>
    </div>

    <!-- Bảng danh sách món ăn -->
    <table>
        <thead>
            <tr>
                <th>STT</th>
                <th>Tên món ăn</th>
                <th>Giá (VND)</th>
                <th>Mô tả</th>
                <th>Thể loại</th>
                <th>Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Model.MenuFood> listFood = (List<Model.MenuFood>) request.getAttribute("listFood");
                if (listFood == null || listFood.isEmpty()) {
            %>
                <tr>
                    <td colspan="6" style="text-align:center;">Không có dữ liệu món ăn.</td>
                </tr>
            <%
                } else {
                    int index = 1;
                    for (Model.MenuFood food : listFood) {
            %>
                <tr>
                    <td><%= index++ %></td>
                    <td><%= food.getName() %></td>
                    <td>
    					<%
        					java.text.DecimalFormat df = new java.text.DecimalFormat("#,###.###");
        					String formattedPrice = df.format(food.getPrice());
   						 %>
    					<%= formattedPrice %>
					</td>
                    <td><%= food.getDes() %></td>
                    <td><%= food.getType() %></td>
                    <td>
                        <a href="<%= request.getContextPath() %>/MenuFoodServlet?action=edit&id=<%= food.getId() %>">Sửa</a>
                    </td>
                </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>

</body>
<div class="overlay" id="popupOverlay" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); justify-content:center; align-items:center;">
    <div class="popup" id="popupBox" style="background:white; padding:30px; border-radius:10px; text-align:center; box-shadow:0 5px 10px rgba(0,0,0,0.3); width:320px;">
        <h2 id="popupTitle"></h2>
        <p id="popupMessage"></p>
        <button onclick="closePopup()" style="padding:8px 16px; border:none; border-radius:5px; background-color:#00bfff; color:white; cursor:pointer;">Đóng</button>
    </div>
</div>

<script>
function showPopup(title, message, success = true) {
    document.getElementById("popupOverlay").style.display = "flex";
    document.getElementById("popupTitle").innerText = title;
    document.getElementById("popupTitle").style.color = success ? "#28a745" : "#dc3545";
    document.getElementById("popupMessage").innerText = message;
}

function closePopup() {
    document.getElementById("popupOverlay").style.display = "none";
}

const urlParams = new URLSearchParams(window.location.search);
if (urlParams.get("status") === "success") {
    showPopup("Thành công", "Cập nhật món ăn thành công!");
} else if (urlParams.get("status") === "fail") {
    showPopup("Thất bại", "Cập nhật món ăn thất bại!");
}
</script>
</html>
