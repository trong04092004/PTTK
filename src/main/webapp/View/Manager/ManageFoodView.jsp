<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý thông tin món ăn</title>
<style>
    body {
        background-color: #f7f7ff; 
        font-family: Arial, sans-serif;
        text-align: center;
        padding-top: 80px;
    }
    h1 {
        font-size: 2.5em;
        color: #333;
        margin-bottom: 30px;
    }

    .button-container {
        display: flex;
        flex-direction: column;
        align-items: center; 
        gap: 15px;
    }

    .manage-button {
        background-color: #00BFFF;
        color: black;
        padding: 15px 30px;
        text-decoration: none;
        font-size: 1.2em;
        font-weight: bold;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        width: 300px;
        box-sizing: border-box;
    }
    .manage-button:hover {
        background-color: #00aeee;
    }
</style>
</head>
<body>
    <h1>Hệ thống nhà hàng RestMan</h1>
    <h1>Quản lý thông tin món ăn</h1>
    
    <div class="button-container">
        <a href="${pageContext.request.contextPath}/ManageFood" class="manage-button">Sửa thông tin món ăn</a>
        <a href="#" class="manage-button">Thêm mới món ăn</a>
        <a href="#" class="manage-button">Xóa món ăn</a>
    </div>

</body>
</html>