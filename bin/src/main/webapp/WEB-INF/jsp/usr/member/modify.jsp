<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MEMBER MODIFY"></c:set>
<%@ include file="../common/head.jspf"%>
<link rel="stylesheet" href="/resource/background.css" />

<section class="mt-8 text-xl px-4">
	<div class="mx-auto">
		<form action="../member/doModify" method="POST">
			<table class="modify-box table-box-1" border="1">
				<tbody>
					<tr>
						<th>아이디</th>
						<td>${member.loginId }</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input class="input input-bordered input-primary w-full max-w-xs" autocomplete="off" type="text" name="loginPw" value="${member.loginPw }"/></td>
					</tr>
					<tr>
						<th>이름</th>
						<td><input class="input input-bordered input-primary w-full max-w-xs" autocomplete="off" type="text" name="mname" value="${member.mname }"/></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td><input class="input input-bordered input-primary w-full max-w-xs" autocomplete="off" type="text" name="cellphoneNum" value="${member.cellphoneNum }" /></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td><input class="input input-bordered input-primary w-full max-w-xs" autocomplete="off" type="text" name="email" value="${member.email }" /></td>
					</tr>
					<tr>
						<th>주소</th>
						<td><input class="input input-bordered input-primary w-full max-w-xs" autocomplete="off" type="text" name="address" value="${member.address }" /></td>
					</tr>

					<tr>
						<th></th>
						<td><input class="btn btn-info" type="submit" value="수정" /></td>
					</tr>
				</tbody>
			</table>
		</form>
		<div class="btns mt-5">
			<button class="btn btn-outline" type="button" onclick="history.back();">뒤로가기</button>
		</div>
	</div>
</section>



<%@ include file="../common/foot.jspf"%>