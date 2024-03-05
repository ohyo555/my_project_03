<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN"></c:set>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<link rel="stylesheet" href="/resource/background.css" />
<%@ include file="../common/head.jspf"%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사진 업로드</title>
</head>
<body>
    <form action="../member/upload" method="post" enctype="multipart/form-data">
        <input type="file" name="photo" accept="image/*">
        <input type="submit" value="사진 업로드">
    </form>
    
    <canvas id="myCanvas" width="100" height="100"></canvas>
</body>
<%@ include file="../common/foot.jspf"%>