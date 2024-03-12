<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAP"></c:set>
<%@ include file="../common/head.jspf"%>
<link rel="stylesheet" href="/resource/background.css" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>지도 이동시키기</title>
<style>
*, *::before, *::after {
	box-sizing: border-box;
	padding: 0;
	margin: 0;
}

nav {
	user-select: none;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	-o-user-select: none;
}

nav ul, nav ul li {
	outline: 0;
}

nav ul li a {
	text-decoration: none;
}

/* MAIN MENU */
body {
	overflow: hidden;
}

.container {
	display: flex;
	align-items: center;
	justify-content: center;
	height: 90%;
}

main {
	display: grid;
	grid-template-columns: 13% 87%;
	width: 90%;
	height: 80%;
	margin: 20px;
	background-color: rgb(251, 243, 238);
	border-radius: 15px;
	z-index: 10;
	text-align: center;
}

.main-menu {
	overflow: hidden;
	background: rgb(73, 57, 113);
	padding-top: 10px;
	border-radius: 15px 0 0 15px;
	font-family: "Roboto", sans-serif;
}

.main-menu h1 {
	display: block;
	font-size: 1.5rem;
	font-weight: 500;
	text-align: center;
	margin: 20px 0 30px;
	color: #fff;
	font-family: "Nunito", sans-serif;
}

.logo {
	display: none;
}

.nav-item {
	position: relative;
	display: block;
}

.nav-item a {
	position: relative;
	display: flex;
	flex-direction: row;
	align-items: center;
	justify-content: center;
	color: #fff;
	font-size: 1rem;
	padding: 15px 0;
	margin-left: 10px;
	border-top-left-radius: 20px;
	border-bottom-left-radius: 20px;
}

.nav-item b:nth-child(1) {
	position: absolute;
	top: -15px;
	height: 15px;
	width: 100%;
	background: #fff;
	display: none;
}

.nav-item b:nth-child(1)::before {
	content: "";
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	border-bottom-right-radius: 20px;
	background: rgb(73, 57, 113);
}

.nav-item b:nth-child(2) {
	position: absolute;
	bottom: -15px;
	height: 15px;
	width: 100%;
	background: #fff;
	display: none;
}

.nav-item b:nth-child(2)::before {
	content: "";
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	border-top-right-radius: 20px;
	background: rgb(73, 57, 113);
}

.nav-item.active b:nth-child(1), .nav-item.active b:nth-child(2) {
	display: block;
}

.nav-item.active a {
	text-decoration: none;
	color: #000;
	background: rgb(251, 243, 238);
}

.nav-icon {
	width: 60px;
	height: 20px;
	font-size: 20px;
	text-align: center;
}

.nav-text {
	display: block;
	width: 120px;
	height: 20px;
}
</style>

<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
    const nav = document.querySelector(".main-menu ul");

    nav.addEventListener("click", (event) => {
        const clickedItem = event.target.closest(".nav-item");
        console.log(clickedItem);
        if (clickedItem && nav.contains(clickedItem)) {
            // 클릭된 nav-item에 active 클래스 추가
            clickedItem.classList.add("active");

            // 다른 모든 nav-item에서 active 클래스 제거
            const navItems = document.querySelectorAll(".nav-item");
            navItems.forEach((item) => {
                if (item !== clickedItem) {
                    item.classList.remove("active");
                }
            });
        }
    });
});
</script>

</head>
<body>
	<div class="container">
		<main>
			<nav class="main-menu">
				<h1>MAP</h1>
				<img class="logo"
					src="https://github.com/ecemgo/mini-samples-great-tricks/assets/13468728/4cfdcb5a-0137-4457-8be1-6e7bd1f29ebb"
					alt="" />
				<ul>
					<li class="nav-item active"><b></b> <b></b> <a href="?menu=home"> <span class="nav-text">Home</span>
					</a></li>

					<li class="nav-item"><b></b> <b></b> <a href="?menu=profile"> <span class="nav-text">Profile</span>
					</a></li>
				</ul>
			</nav>

			<section class="content">
				<c:choose>
					<c:when test="${empty param.menu or param.menu eq 'home'}">
						<!-- Content for the Home menu -->
						<h2>Welcome to the Home Page</h2>
						<p>This is the home content.</p>
					</c:when>
					<c:when test="${param.menu eq 'profile'}">
						<!-- Content for the Profile menu -->
						<h2>User Profile</h2>
						<p>This is the profile content.</p>
					</c:when>
				</c:choose>
			</section>
		</main>
	</div>
</body>
</html>


<%@ include file="../common/foot.jspf"%>