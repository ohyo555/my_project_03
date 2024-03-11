<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAP"></c:set>
<%@ include file="../common/head.jspf"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>지도 이동시키기</title>
<style>
*,
*::before,
*::after {
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
main {
	display: grid;
	grid-template-columns: 13% 87%;
	width: 90%;
	margin: 10px;
	background: rgb(251,243,238);
	border-radius: 15px;
	z-index: 10;
}

.main-menu {
	overflow: hidden;
	background: rgb(252, 163, 151);
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
	background: rgb(254, 254, 254);
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
}
</style>
</head>

<body>
	<main>
		<nav class="main-menu">
			<h1>Map</h1>
			<ul>
				<li class="nav-item active"><a href="../game/map"> <i class="fa fa-house nav-icon"></i> <span class="nav-text">Home</span>
				</a></li>

				<li class="nav-item"><a href="../game/findmap"> <i class="fa fa-user nav-icon"></i> <span class="nav-text">Profile</span>
				</a></li>

				<li class="nav-item"><a href="#"> <i class="fa fa-calendar-check nav-icon"></i> <span class="nav-text">Schedule</span>
				</a></li>

				<li class="nav-item"><a href="#"> <i class="fa fa-person-running nav-icon"></i> <span class="nav-text">Activities</span>
				</a></li>
			</ul>
		</nav>
	</main>
	<script type="text/javascript">
	const navItems = document.querySelectorAll(".nav-item");

	navItems.forEach((navItem, i) => {
	  navItem.addEventListener("click", () => {
	    navItems.forEach((item, j) => {
	      item.className = "nav-item";
	    });
	    navItem.className = "nav-item active";
	  });
	});

	</script>
</body>
</html>


<%@ include file="../common/foot.jspf"%>