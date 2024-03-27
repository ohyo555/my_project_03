<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MEMBER JOIN"></c:set>
<%@ include file="../common/head.jspf"%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<link rel="stylesheet" href="/resource/background.css" />
<style>
.signup-form {
	width: 300px;
	background-color: rgba(255, 255, 255, 0.4);
	margin: 100px auto;
	padding: 20px;
	border-radius: 8px;
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

.signup-form input {
	padding: 5px;
	margin-bottom: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}

.signup-form .id {
	text-align:center;
}

.signup-form .id button {
	background-color: #800808;
	color: white;
	padding: 10px 15px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 0.75rem;
	font-weight: 400;
	height: 45px;
}

.signup-form .id button:hover {
	background-color: #260301;
	color: white;
}

.signup-form .url {
	display: flex;
	align-items: center;
	justify-content: space-around;
	margin-top: 30px;
}

.signup-form a {
	padding: 10px 15px;
	cursor: pointer;
	font-size: 0.75rem;
	font-weight: 600;
}

.signup-form a:hover {
	color: #800808;
}

.signup-form button {
	padding: 10px 15px;
	cursor: pointer;
	font-size: 0.75rem;
	font-weight: 600;
}

.signup-form button:hover {
	color: #800808;
}
</style>


<script type="text/javascript">
	let MemberFindLoginId__submitFormDone = false;
	function MemberFindLoginId__submit(form) {
		if (MemberFindLoginId__submitFormDone) {
			return;
		}
		form.mname.value = form.mname.value.trim();
		form.email.value = form.email.value.trim();
		if (form.name.value.length == 0) {
			alert('이름 써라');
			form.mname.focus();
			return;
		}
		if (form.email.value.length == 0) {
			alert('email 써라');
			form.email.focus();
			return;
		}
		MemberFindLoginId__submitFormDone = true;
		form.submit();
	}

</script>

<section class="mt-8 text-xl px-4">
	<div class="signup-form">
		<form action="../member/dofindId" method="POST" onsubmit="MemberFindLoginId__submit(this);">
			<input type="hidden" name="afterFindLoginIdUri" value="${param.afterFindLoginIdUri }" />
			<div>
				<label for="name">이름:</label> <input type="mname" id="mname" name="mname" autocomplete="off" required>
			</div>
			<div>
				<label for="email">이메일:</label> <input type="email" id="email" name="email" autocomplete="off" required>
			</div>
			<div class="id center-text mt-5">
				<button type="submit">아이디 찾기</button>
			</div>
			<div class="url">
				<a href="${rq.loginUri}">로그인</a>
				<a href="${rq.findLoginPwUri}">비밀번호 찾기</a>
				<button type="button" onclick="history.back();">뒤로가기</button>
			</div>
		</form>
	</div>
</section>



<%@ include file="../common/foot.jspf"%>