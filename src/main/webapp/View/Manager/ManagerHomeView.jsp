<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang chủ Quản lý</title>
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

    .manage-button {
        display: inline-block;
        background-color: #00BFFF;
        color: black;
        padding: 15px 30px;
        text-decoration: none;
        font-size: 1.2em;
        font-weight: bold;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    .manage-button:hover {
        background-color: #00aeee;
    }
</style>
</head>
<body>
    <h1>Hệ thống nhà hàng RestMan</h1>
    <h1>Trang chủ Quản lý</h1>
    
    <a href="${pageContext.request.contextPath}/ManagerHome" class="manage-button">Quản lý thông tin món ăn</a>

</body>
</html>