<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MEMBER JOIN"></c:set>
<%@ include file="../common/head.jspf"%>
<script src="https://code.jquery.com/jquery-3.6.4.js"></script>

<link rel="stylesheet" href="/resource/background.css" />
<<<<<<< HEAD

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

.signup-form .text {
	color: #800808;
	text-align: center;
	margin-bottom: 30px;
	border: 1px solid #800808;
	border-radius: 4px;
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

.signup-form .pw {
	text-align:center;
}

.signup-form .pw button {
	background-color: #800808;
	color: white;
	padding: 0px 12px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 0.75rem;
	font-weight: 400;
	height: 35px;
}

.signup-form .pw button:hover {
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

=======

>>>>>>> 8f242d98f3bcc1fcd0da491d9c273e8f42a27bf9
<script type="text/javascript">
	let MemberFindLoginPw__submitFormDone = false;
	function MemberFindLoginPw__submit(form) {
		if (MemberFindLoginPw__submitFormDone) {
			return;
		}
		form.loginId.value = form.loginId.value.trim();
		form.email.value = form.email.value.trim();
		if (form.loginId.value.length == 0) {
			alert('아이디 써라');
			form.loginId.focus();
			return;
		}
		if (form.email.value.length == 0) {
			alert('email 써라');
			form.email.focus();
			return;
		}
		MemberFindLoginPw__submitFormDone = true;
		alert('메일로 임시 비밀번호를 발송했습니다');
		form.submit();
	}
</script>
<section class="mt-8 text-xl px-4">
<<<<<<< HEAD
	<div class="signup-form">
		<form action="../member/dofindPw" method="POST" onsubmit="MemberFindLoginPw__submit(this);">
			<input type="hidden" name="afterFindLoginPwUri" value="${param.afterFindLoginPwUri  }" />
			<div class = "text">비밀번호 찾기</div>
			<div>
				<label for="loginId">아이디:</label> <input type="loginId" id="loginId" name="loginId" autocomplete="off" required>
			</div>
			<div>
				<label for="email">이메일:</label> <input type="email" id="email" name="email" autocomplete="off" required>
			</div>
			<div class="pw center-text mt-5">
				<button type="submit">찾기</button>
			</div>
			<div class="url">
				<a href="${rq.loginUri}">로그인</a>
				<a href="${rq.findLoginIdUri}">아이디 찾기</a>
				<button type="button" onclick="history.back();">뒤로가기</button>
			</div>
		</form>
=======
	<div class="mx-auto">
		<form action="../member/dofindPw" method="POST" onsubmit="MemberFindLoginPw__submit(this);">
			<input type="hidden" name="afterFindLoginPwUri" value="${param.afterFindLoginPwUri  }" />
			<table class="login-box table-box-1" border="1">
				<tbody>
					<tr>
						<th>아이디</th>
						<td>
							<input class="input input-bordered w-full max-w-xs" autocomplete="off" type="text" placeholder="아이디를 입력해주세요"
								name="loginId" />
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>
							<input class="input input-bordered w-full max-w-xs" autocomplete="off" type="text" placeholder="이메일을 입력해주세요"
								name="email" />
						</td>
					</tr>
					<tr>
						<th></th>
						<td>
							<button type="submit">비밀번호 찾기</button>
						</td>
					</tr>
					<tr>
						<th></th>
						<td>
							<a class="btn btn-active btn-ghost" href="../member/login">로그인</a>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<div class="btns">
			<button class="btn btn-outline" type="button" onclick="history.back();">뒤로가기</button>
		</div>
>>>>>>> 8f242d98f3bcc1fcd0da491d9c273e8f42a27bf9
	</div>
</section>

<%@ include file="../common/foot.jspf"%>