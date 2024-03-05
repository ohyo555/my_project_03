<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="API TEST4"></c:set>
<%@ include file="../common/head.jspf"%>
<link rel="stylesheet" href="/resource/background.css" />


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>지도 이동시키기</title>
<style>
	.map_wrap {
	position:relative;
	overflow:hidden;
	width:100%;
	height:350px;
	}

    #map {
        position: fixed;
      	top: 80px; /* 헤더의 높이 */
        right: 0;
        width: 80%;
        margin: 30px;
        height: 80% /* 화면 아래 끝까지 나오도록 조정 */
    }

    .button-container {
        display: flex;
        flex-direction: column;
        position: fixed;
        top: 50%;
        left: 50px;
        transform: translateY(-50%);
        padding: 10px;
    }

    .button-container button {
        margin-bottom: 10px;
    }
    
    /* 확대/축소 스타일 */
    .custom_zoomcontrol {
    position:absolute;
    top:50px;
    right:10px;
    width:30px;
    height:60px;
    overflow:hidden;
    z-index:1;
    background-color:#f5f5f5;
    } 
    
	.custom_zoomcontrol span {
	display:block;
	width:30px;
	height:30px;
	text-align:center;
	cursor:pointer;
	}     
	
	.custom_zoomcontrol span img {
	width:30px;
	height:30px;
	padding:5px;
	border:none;
	z-index:99;
	}           
	  
	.custom_zoomcontrol span:first-child{
	border-bottom:1px solid #bfbfbf;
	}      

	/* 팀 이미지 스타일 */
	.team {
		display: flex;
	}
	
	.team span {
		 width: 40px;
    	height: auto; /* 이미지 비율을 유지하면서 크기 조절 */
	}
</style>
</head>
<body>
<div class="map_wrap" >
    <div class="button-container">
        <button onclick="Daejeon()">충무체육관</button>
    </div>
    
    <div id="map"></div>
    
    <div class="team">
    	<span onclick="goheungkuk()"><img src="/resource/흥국.png" alt="heungkuk"></span>  
        <span onclick="gohyundai()"><img src="/resource/현대.png" alt="hyundai"></span>
        <span onclick="goibk()"><img src="/resource/IBK.png" alt="ibk"></span>  
        <span onclick="gohipass()"><img src="/resource/한국도로공사.png" alt="hipass"></span>
        <span onclick="gopepper()"><img src="/resource/페퍼.png" alt="pepper"></span>  
        <span onclick="gogs()"><img src="/resource/GS.png" alt="gs"></span>
    </div>
    
    <!-- 지도 확대, 축소 컨트롤 div 입니다 -->
    <div class="custom_zoomcontrol radius_border"> 
         <span onclick="zoomIn()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png" alt="확대"></span>  
         <span onclick="zoomOut()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png" alt="축소"></span>
    </div>
    <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=19cf78438548356f5de2f18b79f43362"></script>
   <script>
        var lat = ${team.latitude};
        var lon = ${team.longitude};

        // 카카오지도
        var mapContainer = document.getElementById('map');
        var mapOption = {
            center: new kakao.maps.LatLng(lat, lon),
            level: 3
        };
        var map = new kakao.maps.Map(mapContainer, mapOption);
        
        var positions = [
		    {
		        title: '체육관', 
		        latlng: new kakao.maps.LatLng(lat, lon)
		    }];
		var imageSrc = "/resource/KakaoTalk_20240305_140207461.png"; 
	    
		for (var i = 0; i < positions.length; i ++) {
		    
		    // 마커 이미지의 이미지 크기 입니다
		    var imageSize = new kakao.maps.Size(40, 50); 
		    
		    // 마커 이미지를 생성합니다    
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		    
		    // 마커를 생성합니다
		    var marker = new kakao.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: positions[i].latlng, // 마커를 표시할 위치
		        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
		        image : markerImage // 마커 이미지 
		    });
		}
		
		// 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
		function zoomIn() {
		    map.setLevel(map.getLevel() - 1);
		}

		// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
		function zoomOut() {
		    map.setLevel(map.getLevel() + 1);
		}
		
    </script>
    
    </div>
</body>
</html>
<%@ include file="../common/foot.jspf"%>