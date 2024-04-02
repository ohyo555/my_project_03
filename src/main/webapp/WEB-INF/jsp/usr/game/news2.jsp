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
	height: 100%;
	display: flex;
	align-items: center;
	justify-content: center;
}

.form {
	width: 700px;
	height: 830px;
	margin-bottom: 100px;
	padding: 10px;
	padding-bottom: 20px;
	background-color: rgb(251, 243, 238);
}

.newstitle {
	height: 30px;
	width: 100%;
	display: flex;
	align-items: center;
	justify-content: center;
}

.navernews {
	height: 88%;
	width: 100%;
}

.navernews > div{
	background-color: rgba(255, 255, 255, 0.8);
	margin-bottom:10px;
}

.navernews > div > div {
	height: 10%;
	width: 100%;
	display: flex;
}

.navernews .title {
	height: 5%;
	width: 30%;
}

.navernews .title > div {
	padding: 5px;
}

.navernews .title>div:first-child {
	width: 30px;
}

.navernews .body a {
	width: 100%;
	display: flex;
}

.navernews .body .main {
	width: 100%;
	display: block;
}

.navernews .body .main div:first-child {
	height: 25%;
	padding: 5px;
}

.navernews .body .main div:nth-child(2) {
	height: 75%;
	padding: 5px;
}

.navernews .mainimg {
	width: 170px;
	padding: 5px;
}

.sns {
	height: 40px;
	width: 100%;
	margin-top: 17px;
	display: flex;
	align-items: center;
	justify-content: space-around;
}

.all{
	color: #800808;
} 

.all:hover {
	background-color: #800808;
	color: white;
} 
</style>
</head>

<body>
	<div class="news">
		<div class="form">
			<div class="newstitle font-bold">NEWS</div>
			<a class="all text-xs font-bold" href="https://search.naver.com/search.naver?where=news&ie=utf8&sm=nws_hty&query=%EC%A0%95%EA%B4%80%EC%9E%A5+%EB%A0%88%EB%93%9C%EC%8A%A4%ED%8C%8C%ED%81%AC%EC%8A%A4" target="_blank">전체 뉴스 보기</a>
			<div class="navernews">
				<c:forEach items="${News}" var="News" varStatus="loop">
        		<c:if test="${loop.index < 4}">
				<div>
					<div class="title">
						<div><img src="${News.company_img }" alt="Company Image"></div>
						<div>${News.company_name }</div>
						<div>${News.date }</div>						
					</div>
					<div class="body">
					 <a href="${News.news_url }" target="_blank">
						<div class="main">
							<div class="font-bold">${News.title }</div>
							<div class="text-sm">${News.content }</div>
						</div>
						<div class="mainimg"><img src="${News.title_img }"></div>
					</a>
					</div>
				</div>
				</c:if>
				</c:forEach>
			</div>
			<div class="sns">
				<a href="https://www.youtube.com/channel/UCd6B93FlFmBAd9w6Aa_rsvA" target="_blank"><img
					src="https://github.com/ohyo555/my_project_03/assets/153146836/93e64b07-ae31-4099-b28a-84281b25f48f"
					style="height: 25px; width: 25px"></a> <a href="https://www.instagram.com/red__sparks/" target="_blank"><img
					src="https://github.com/ohyo555/my_project_03/assets/153146836/edf03484-af1a-4272-a0a1-e3c02406b8d1"
					style="height: 25px; width: 25px"></a> <a href="https://www.facebook.com/jkjredsparks/" target="_blank"><img
					src="https://github.com/ohyo555/my_project_03/assets/153146836/8a6a44b5-c429-44aa-a0e4-dc20305ab90d"
					style="height: 25px; width: 25px"></a> <a
					href="https://m.post.naver.com/my.nhn?memberNo=44010406&navigationType=push" target="_blank"><img
					src="https://github.com/ohyo555/my_project_03/assets/153146836/763b7e3d-e546-4678-8871-d7c1e7373389"
					style="height: 25px; width: 25px"></a>
			</div>
		</div>
	</div>
</body>
</html>
<%@ include file="../common/foot.jspf"%>