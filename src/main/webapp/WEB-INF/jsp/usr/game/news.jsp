<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="API TEST4"></c:set>
<%@ include file="../common/head.jspf"%>
<link rel="stylesheet" href="/resource/background.css" />


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
body, html {
	height: 100%;
	overflow: hidden;
	margin: 0;
}

.news {
	width: 100%;
	height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
}

.form {
	width: 80%;
	height: 80vh;
	margin-bottom: 100px;
	padding: 15px;
	background-color: rgb(251, 243, 238);
}

.newstitle {
	height: 30px;
	width: 100%;
	background-color: white;
	margin-bottom: 10px;
	display: flex;
	align-items: center;
	justify-content: center; 
}

.navernews {
	height: 88%;
	width: 100%;
	background-color: black;
}

.sns {
	height: 40px;
	width: 100%;
	margin-top: 10px;
	display: flex;
	align-items: center;
	justify-content: space-around;
}

</style>
</head>

<body>
	<div class="news">
		<div class="form">
			<div class="newstitle">News</div>
			<div class="navernews"></div>
			<div class="sns">
				<a href="https://www.youtube.com/channel/UCd6B93FlFmBAd9w6Aa_rsvA" target="_blank"><img
					src="https://github.com/ohyo555/my_project_03/assets/153146836/a3d4b16c-329c-4c14-9af5-ecac4a78c729"
					style="height: 30px; width: 30px"></a> <a href="https://www.instagram.com/red__sparks/" target="_blank"><img
					src="https://github.com/ohyo555/my_project_03/assets/153146836/55151c70-a6ff-41b9-865a-5225d78a400e"
					style="height: 30px; width: 30px"></a> <a href="https://www.facebook.com/jkjredsparks/" target="_blank"><img
					src="https://github.com/ohyo555/my_project_03/assets/153146836/c80d943f-5d65-4136-9c19-fddeebad8c63"
					style="height: 30px; width: 30px"></a> <a
					href="https://m.post.naver.com/my.nhn?memberNo=44010406&navigationType=push" target="_blank"><img
					src="https://github.com/ohyo555/my_project_03/assets/153146836/b6abdae4-1417-4532-8dfd-4733a3d683b6"
					style="height: 15px; width: 60px"></a>
			</div>
		</div>
	</div>
</body>
</html>
<%@ include file="../common/foot.jspf"%>