<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MEMBER LOGIN"></c:set>
<%@ include file="../common/head.jspf"%>
<link rel="stylesheet" href="/resource/background.css" />
<style>
        .login-container {
            max-width: 400px;
            margin: 100px auto;
            background-color: rgba(255, 255, 255, 0.4);
            padding: 20px;
            border-radius: 8px;
        }

		form {
			text-align:center;
		}
		
        .login-container input {
            width: 80%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .login-container button {
            background-color: #800808;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .login-container a {
            text-decoration: none;
            color: #800808;
            margin-left: 10px;
            display: inline-block;
        }
        
        #forgot-link2 {
            margin-left: 0px;
        }
        
       .center-text {
            text-align: center;
        }
        
        .login-container p:first-child {
			margin-top: 50px;
		}
	
    </style>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
</head>
<body>

<div class="login-container">
<!--     <h2>Login</h2><br> -->
    <form action="../member/doLogin" method="POST">
        <input type="text" id="loginId" name="loginId" placeholder="Username">
        <br>
        <input type="password" id="loginPw" name="loginPw" placeholder="Password">
        <br>
        <div class="center-text"><button type="submit">Login</button></div>
    </form>
    <div class="center-text">
        <p class = "text-xs">아직 회원이 아니신가요?<a href="../member/join" id="signup-link" class = "text-xs font-bold">회원가입</a></p>
        <p class = "text-xs mt-2">ID나 비밀번호를 잊어버리셨나요?<a href="${rq.findLoginIdUri }" id="forgot-link" class = "text-xs font-bold">아이디 찾기</a><a href="${rq.findLoginPwUri }" id="forgot-link2" class = "text-xs font-bold">/ 비밀번호 찾기</a></p>
    </div>
</div>

</body>
</html>

<%@ include file="../common/foot.jspf"%>