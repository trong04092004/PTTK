<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="Model.FoodOrder"%>
<%@ page import="Model.Bill"%>
<%@ page import="Model.Customer"%>
<%@ page import="Model.Table"%>
<%@ page import="Model.TableOrder" %>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%
    List<FoodOrder> orderedList = (List<FoodOrder>) request.getAttribute("orderedList");
    TableOrder tableOrder = (TableOrder) request.getAttribute("currentTableOrder");
    Customer customer = (tableOrder != null) ? tableOrder.getCustomer() : null;
    Table table = (tableOrder != null) ? tableOrder.getTable() : null;
    String tenKhachHang = (customer != null) ? customer.getName() : "N/A";
    String soBan = (table != null) ? table.getNumberTable() : "N/A";
    String tang = (table != null) ? table.getFloor() : "N/A";
    String ngayDat;
    if (tableOrder != null && tableOrder.getDate() != null) {
        ngayDat = new SimpleDateFormat("dd/MM/yyyy").format(tableOrder.getDate());
    } else {
        ngayDat = new SimpleDateFormat("dd/MM/yyyy").format(new Date());
    }
    double tongCong = 0;
    if (orderedList != null) {
        for (FoodOrder order : orderedList) {
            tongCong += order.getPrice() * order.getQuantity();
        }
    }
    DecimalFormat formatter = new DecimalFormat("###,###");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Xác nhận đơn đặt món</title>
<style>
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    body {
        font-family: "Segoe UI", Arial, sans-serif;
        background: linear-gradient(135deg, #f5f9ff, #eaf3ff);
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
    }

    .container {
        width: 850px;
        background: #ffffff;
        border-radius: 16px;
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
        padding: 40px 50px;
        transition: all 0.3s ease;
    }

    h1 {
        text-align: center;
        color: #2b2b2b;
        margin-bottom: 25px;
        font-size: 28px;
        letter-spacing: 0.5px;
        font-weight: 600;
    }

    .info {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 10px 30px;
        margin-bottom: 30px;
        background: #f7faff;
        padding: 20px;
        border-radius: 10px;
        border: 1px solid #e0e8f0;
    }

    .info p {
        color: #333;
        font-size: 16px;
        line-height: 1.6;
    }

    .info strong {
        color: #0056b3;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 25px;
        border-radius: 10px;
        overflow: hidden;
    }

    th {
        background-color: #00bfff;
        color: white;
        font-weight: 600;
        padding: 14px;
        font-size: 15px;
    }

    td {
        border-bottom: 1px solid #eaeaea;
        padding: 12px 14px;
        font-size: 15px;
        color: #333;
    }

    tr:nth-child(even) {
        background-color: #f9fbff;
    }

    tr:hover {
        background-color: #eef5ff;
        transition: background 0.3s ease;
    }

    td.number, th.number {
        text-align: right;
    }

    .total-row td {
        font-weight: 600;
        font-size: 16px;
        background-color: #f2f8ff;
        color: #0056b3;
    }

    .buttons {
        display: flex;
        justify-content: space-between;
        margin-top: 25px;
    }

    .btn {
        padding: 12px 30px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-size: 16px;
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .btn-back {
        background-color: #00bfff;
        color: #333;
    }

    .btn-back:hover {
        background-color: #0056d6;
        transform: translateY(-2px);
    }

    .btn-confirm {
        background-color: #00bfff;
        color: white;
        box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3);
    }

    .btn-confirm:hover {
        background-color: #0056d6;
        transform: translateY(-2px);
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
        z-index: 1000;
    }

    .popup-content {
        background: white;
        padding: 35px;
        border-radius: 10px;
        text-align: center;
        width: 350px;
        box-shadow: 0 4px 25px rgba(0, 0, 0, 0.2);
        animation: popupIn 0.3s ease;
    }

    .popup-content h3 {
        margin-bottom: 20px;
        font-size: 18px;
        color: #333;
    }

    .popup-content button {
        padding: 10px 25px;
        border: none;
        border-radius: 6px;
        background-color: #007bff;
        color: white;
        cursor: pointer;
        font-size: 15px;
        transition: all 0.3s;
    }

    .popup-content button:hover {
        background-color: #0056d6;
    }

    @keyframes popupIn {
        from { transform: scale(0.8); opacity: 0; }
        to { transform: scale(1); opacity: 1; }
    }
</style>
</head>
<body>

    <div class="container">
        <h1>Xác nhận đơn đặt món</h1>
        
        <div class="info">
            <p><strong>Tên khách hàng:</strong> <%= tenKhachHang %></p>
            <p><strong>Ngày đặt:</strong> <%= ngayDat %></p>
            <p><strong>Số bàn:</strong> <%= soBan %></p>
            <p><strong>Tầng:</strong> <%= tang %></p>
        </div>

        <table>
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Tên món</th>
                    <th class="number">Giá (VNĐ)</th>
                    <th class="number">Số lượng</th>
                    <th class="number">Thành tiền</th>
                </tr>
            </thead>
            <tbody>
                <% if (orderedList == null || orderedList.isEmpty()) { %>
                <tr>
                    <td colspan="5" style="text-align:center; color:#666;">Chưa có món nào được chọn.</td>
                </tr>
                <% } else {
                    int stt = 1;
                    for (FoodOrder order : orderedList) {
                        double thanhTien = order.getPrice() * order.getQuantity();
                %>
                <tr>
                    <td><%= stt++ %></td>
                    <td><%= order.getMenuFood().getName() %></td>
                    <td class="number"><%= formatter.format(order.getPrice()) %></td>
                    <td class="number"><%= order.getQuantity() %></td>
                    <td class="number"><%= formatter.format(thanhTien) %></td>
                </tr>
                <%  } } %>
                <tr class="total-row">
                    <td colspan="4" class="number">Tổng cộng</td>
                    <td class="number"><%= formatter.format(tongCong) %> VNĐ</td>
                </tr>
            </tbody>
        </table>

        <div class="buttons">
            <a href="${pageContext.request.contextPath}/MenuFood2Servlet?action=search" class="btn btn-back">⬅ Quay lại</a>
            <form action="${pageContext.request.contextPath}/BillServlet" method="POST" style="margin:0;">
                <button type="submit" class="btn btn-confirm">✔ Xác nhận đặt món</button>
            </form>
        </div>
    </div>

    <div id="popup" class="popup-overlay">
        <div class="popup-content">
            <h3 id="popup-title"></h3>
            <button onclick="closePopup()">OK</button>
        </div>
    </div>

    <script>
        const params = new URLSearchParams(window.location.search);
        const status = params.get("status");
        const popup = document.getElementById("popup");
        const popupTitle = document.getElementById("popup-title");

        if (status === "success") {
            popupTitle.innerText = "✅ Đặt món thành công!";
            popup.style.display = "flex";
        } else if (status === "fail") {
            popupTitle.innerText = "❌ Đặt món thất bại!";
            popup.style.display = "flex";
        }

        function closePopup() {
            popup.style.display = "none";
            const url = new URL(window.location.href);
            url.searchParams.delete("status");
            window.history.replaceState({}, document.title, url.toString());
            if (status === "success") {
                window.location.href = "${pageContext.request.contextPath}/searchTableOrdered";
            }
        }
    </script>

</body>
</html>