<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sửa thông tin món ăn</title>
<style>
    body {
        background-color: #f9f9ff;
        font-family: Arial, sans-serif;
        text-align: center;
        margin-top: 50px;
    }
    h1 {
        color: #111;
        font-size: 26px;
        margin-bottom: 20px;
    }
    form {
        display: inline-block;
        background-color: #f2f2f2;
        padding: 30px 50px;
        border-radius: 8px;
        box-shadow: 0 0 6px rgba(0, 0, 0, 0.2);
        text-align: left;
    }
    .form-row {
        display: flex;
        align-items: center;
        margin-bottom: 15px;
    }
    label {
        width: 100px;
        font-weight: bold;
        margin-right: 10px;
    }
    input[type="text"], textarea, select {
        width: 300px;
        padding: 5px;
        border: 1px solid #ccc;
        border-radius: 3px;
        font-size: 14px;
    }
    textarea {
        resize: none;
        height: 60px;
        font-family: Arial, sans-serif;
        font-size: 14px;
    }
    .btn {
        width: 100%;
        background-color: #00bfff;
        color: white;
        padding: 10px;
        border: none;
        border-radius: 3px;
        cursor: pointer;
        font-size: 16px;
        margin-top: 10px;
    }
    .btn:hover {
        background-color: #0099cc;
    }
    .back-btn {
        width: 100%;
        background-color: #6c757d;
        color: white;
        padding: 10px;
        border: none;
        border-radius: 3px;
        cursor: pointer;
        font-size: 16px;
        margin-top: 8px;
    }
    .back-btn:hover {
        background-color: #5a6268;
    }
    .overlay {
        display: none;
        position: fixed;
        top: 0; left: 0;
        width: 100%; height: 100%;
        background: rgba(0,0,0,0.5);
        justify-content: center;
        align-items: center;
    }
    .popup {
        background: white;
        padding: 30px;
        border-radius: 10px;
        text-align: center;
        box-shadow: 0 5px 10px rgba(0,0,0,0.3);
        animation: fadeIn 0.3s ease-in-out;
        width: 320px;
    }
    .popup h2 {
        margin-bottom: 10px;
    }
    .popup p {
        color: #333;
        font-size: 15px;
        margin-bottom: 20px;
    }
    .popup button {
        padding: 8px 16px;
        border: none;
        border-radius: 5px;
        background-color: #00bfff;
        color: white;
        cursor: pointer;
    }
    .popup button:hover {
        background-color: #0099cc;
    }
    @keyframes fadeIn {
        from { opacity: 0; transform: scale(0.9); }
        to { opacity: 1; transform: scale(1); }
    }
</style>
</head>
<body>
    <h1>Hệ thống nhà hàng RestMan</h1>
    <h1>Sửa Thông tin Món ăn</h1>

    <%
        java.text.DecimalFormat df = new java.text.DecimalFormat("#,###.###");
        String formattedPrice = df.format(((Model.MenuFood)request.getAttribute("food")).getPrice());
    %>

    <form action="<%= request.getContextPath() %>/MenuFoodServlet" method="post" id="editForm">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="${food.id}">
        <div class="form-row">
            <label>Tên Món:</label>
            <input type="text" name="name" value="${food.name}" required>
        </div>
        <div class="form-row">
            <label>Giá (VNĐ):</label>
            <input type="text" id="price" name="price" value="<%= formattedPrice %>" required>
        </div>
        <div class="form-row">
            <label>Mô tả:</label>
            <textarea name="des" required>${food.des}</textarea>
        </div>
        <div class="form-row">
            <label>Thể loại:</label>
            <select name="type" required>
                <option value="Khai vị" ${food.type == 'Khai vị' ? 'selected' : ''}>Khai vị</option>
                <option value="Món chính" ${food.type == 'Món chính' ? 'selected' : ''}>Món chính</option>
                <option value="Tráng miệng" ${food.type == 'Tráng miệng' ? 'selected' : ''}>Tráng miệng</option>
                <option value="Món phụ" ${food.type == 'Món phụ' ? 'selected' : ''}>Món phụ</option>
            </select>
        </div>
        <input type="submit" value="Lưu thay đổi" class="btn">
        <button type="button" class="back-btn" onclick="goBack()">← Quay lại</button>
    </form>

    <div class="overlay" id="popupOverlay">
        <div class="popup" id="popupBox">
            <h2 id="popupTitle"></h2>
            <p id="popupMessage"></p>
            <button onclick="closePopup()">Đóng</button>
        </div>
    </div>

    <script>
        const priceInput = document.getElementById("price");
        priceInput.addEventListener("input", function () {
            let value = this.value.replace(/,/g, "");
            if (!isNaN(value) && value !== "") {
                this.value = parseFloat(value).toLocaleString("en-US");
            }
        });

        function goBack() {
            const lastKey = "<%= (String) request.getSession().getAttribute("lastSearchKey") %>";
            let url = "<%= request.getContextPath() %>/MenuFoodServlet?action=search";
            if (lastKey && lastKey.trim() !== "") {
                url += "&key=" + encodeURIComponent(lastKey);
            }
            window.location.href = url;
        }

        function showPopup(title, message, success = true) {
            document.getElementById("popupOverlay").style.display = "flex";
            document.getElementById("popupTitle").innerText = title;
            document.getElementById("popupTitle").style.color = success ? "#28a745" : "#dc3545";
            document.getElementById("popupMessage").innerText = message;
        }

        function closePopup() {
            const lastKey = "<%= (String) request.getSession().getAttribute("lastSearchKey") %>";
            let url = "<%= request.getContextPath() %>/MenuFoodServlet?action=search";
            if (lastKey && lastKey.trim() !== "") {
                url += "&key=" + encodeURIComponent(lastKey);
            }
            window.location.href = url;
        }

        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get("status") === "success") {
            showPopup("Thành công", "Cập nhật món ăn thành công!");
        } else if (urlParams.get("status") === "fail") {
            showPopup("Thất bại", "Cập nhật món ăn thất bại!");
        }
    </script>
</body>
</html>
