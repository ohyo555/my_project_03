<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MEMBER JOIN"></c:set>
<%@ include file="../common/head.jspf"%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="/resource/background.css" />
<style>

.signup-form {
	width: 500px;
	background-color: rgba(255, 255, 255, 0.4);
	margin: 100px auto;
	padding: 20px;
	border-radius: 8px;
}

.signup-form .text{
	font-size: 0.7rem;
	/* text-align: right; */
	margin-left: 15rem;
}

.signup-form div {
	display: inline-block;
	width: 100%;
	font-size: 1rem;
}

.signup-form label {
	width: 20%;
	display: inline-block;
}

.signup-form div .msg {
	display: inline;
	color: #800808;
	font-size: 0.75rem;
}

.signup-form input {
	padding: 8px;
	margin-bottom: 16px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}

.signup-form button {
	background-color: #800808;
	color: white;
	padding: 10px 15px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 0.75rem;
}

.signup-form button:hover {
	background-color: #260301;
}

</style>

<script>
        $(function() {
            $("#birthdate").datepicker({
            	dateFormat: 'yy-mm-dd',
                changeMonth: true,
                changeYear: true,
                yearRange: 'c-100:c+0'
        });
</script>

<script>
	function callByAjax(loginId) {
		
		var form = document.form1;
		
		var action = "../member/doAction";
		var loginId = form.loginId.value;
		
		$.get(action, {
			loginId : loginId,
		}, function(data) {
			$('.msg').text(data);
		}, 'html');
		
	}
</script>

<section class="mt-8 text-xl px-4">
	<div class="signup-form">
		<form name="form1" action="../member/doJoin" method="POST">
			<div class="text">*는 필수정보</div>
			<div>
				<label for="username">*아이디:</label> <input type="text" id="loginId" name="loginId" autocomplete="off" required>
				<div class="msg"></div>
			</div>

			<div>
				<label for="password">*비밀번호:</label> <input type="password" id="loginPw" name="loginPw" autocomplete="off" onclick="callByAjax();" required>
			</div>

			<div>
				<label for="birth">*생년월일:</label> <input type="date" id="birth" name="birth" required>
			</div>

			<div>
				<label for="name">*이름:</label> <input type="text" id="mname" name="mname" autocomplete="off" required>
			</div>

			<div>
				<label for="cellphoneNum">전화번호:</label> <input type="tel" id="cellphoneNum" name="cellphoneNum" autocomplete="off">
			</div>

			<div>
				<label for="email">이메일:</label> <input type="email" id="email" name="email" autocomplete="off">
			</div>

			<div>
				<label for="address">주소:</label> <input type="text" id="address" name="address" autocomplete="off">
			</div>

			<div class="center-text mt-5">
				<button type="submit">가입</button>
				<button type="button" onclick="history.back();">뒤로가기</button>
			</div>
		</form>

	</div>
</section>



<%@ include file="../common/foot.jspf"%>