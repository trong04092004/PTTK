<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng nhập hệ thống</title>
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
        margin-bottom: 20px;
    }

    .login-container {
        display: inline-block;
        background-color: #ffffff;
        padding: 40px 60px;
        border-radius: 10px;
        box-shadow: 0 0 15px rgba(0,0,0,0.1);
        text-align: left;
    }

    label {
        display: block;
        font-weight: bold;
        margin-bottom: 8px;
        color: #333;
    }

    input[type="text"],
    input[type="password"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
    }

    .login-button {
        background-color: #00BFFF;
        color: black;
        font-size: 1.1em;
        font-weight: bold;
        border: none;
        border-radius: 5px;
        padding: 12px 25px;
        cursor: pointer;
        width: 100%;
        box-sizing: border-box;
    }

    .login-button:hover {
        background-color: #00aeee;
    }

    .error {
        color: red;
        text-align: center;
        margin-top: 15px;
        display: block;
    }
</style>
</head>
<body>
    <h1>Hệ thống nhà hàng RestMan</h1>
    <h1>Đăng nhập</h1>
    
    <div class="login-container">
        <form action="${pageContext.request.contextPath}/login" method="post">
            <label for="username">Tên đăng nhập:</label>
            <input type="text" id="username" name="username" placeholder="Nhập tên đăng nhập" required>

            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" required>

            <input type="submit" value="Đăng nhập" class="login-button">
        </form>

        <font class="error">${errorMessage}</font>
    </div>

</body>
</html>
