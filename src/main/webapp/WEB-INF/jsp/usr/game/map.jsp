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
body, html {
	height: 100%;
	overflow: hidden;
	margin: 0;
}

.map_wrap {
	position: relative;
	width: 100%;
	height: 100vh; /* 뷰포트 높이에 따라 조절 */
	display: flex;
	align-items: center;
	justify-content: center;
}

.form {
	position: relative; /* 부모 요소를 상대 위치로 설정 .findmap때매*/
	width: 80%;
	height: 80vh;
	margin-bottom: 100px;
	padding: 20px;
	background-color: rgb(251, 243, 238);
}

#map {
	width: 98%; /* 원하는 가로 크기로 조절 */
	height: 75vh; /* 원하는 세로 크기로 조절 */
}

/* 주변 지도 버튼 */
.findmap {
	position: absolute; /* 자식 요소를 절대 위치로 설정 */
	height: 100px;
	width: 20px;
	bottom: 10px; /* 원하는 바닥 여백 값으로 조절 */
	right: 10px; /* 원하는 우측 여백 값으로 조절 */
	top: 20px;
	right: 20px;
	z-index: 99;
	background-color: rgb(251, 243, 238);
	cursor: pointer;
	border: 1px solid lightgray;
	border-radius: 5px;
}

/* 구단 */
.team {
	position: absolute;
	bottom: 20px;
	right: 20px;
	width: 30px;
	height: 213px;
	overflow: hidden;
	padding: 3px 0;
	z-index: 99;
	background-color: rgb(251, 243, 238);
	box-sizing: border-box; /* 테두리 밖으로 그리기 */
	border-radius: 5px;
	display: flex; /* Flex 컨테이너로 설정 */
	flex-direction: column; /* 수직 방향으로 아이템 정렬 */
}

.team span {
	display: block;
	height: 20px; /* 이미지 비율을 유지하면서 크기 조절 */
	margin-bottom: 10px;
}

.team span img {
	width: 30px;
}

/* 커스텀 라벨 */
.label {
	margin-bottom: 120px;
}

.label * {
	display: inline-block;
	vertical-align: top;
}

.label .left {
	background:
		url("https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_l.png")
		no-repeat;
	display: inline-block;
	height: 24px;
	overflow: hidden;
	vertical-align: top;
	width: 7px;
}

.label .center {
	background:
		url(https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_bg.png)
		repeat-x;
	display: inline-block;
	height: 24px;
	font-size: 12px;
	line-height: 24px;
}

.label .right {
	background:
		url("https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_r.png")
		-1px 0 no-repeat;
	display: inline-block;
	height: 24px;
	overflow: hidden;
	width: 6px;
}

/* 확대/축소 스타일 */
.custom_zoomcontrol {
	position: absolute;
	top: 20px; /* 조절 가능한 상단 여백 값 */
	right: 20px; /* 조절 가능한 우측 여백 값 */
	width: 30px;
	height: 60px;
	overflow: hidden;
	z-index: 99;
	background-color: rgb(251, 243, 238);
	box-sizing: border-box; /* 테두리 밖으로 그리기 */
	border-radius: 5px;
}

.custom_zoomcontrol span {
	display: block;
	width: 30px;
	height: 30px;
	text-align: center;
	cursor: pointer;
}

.custom_zoomcontrol span img {
	width: 100%; /* 이미지를 꽉 차게 표시합니다. */
	height: 100%; /* 이미지를 꽉 차게 표시합니다. */
	padding: 3px;
	border: none;
	z-index: 99;
}

.custom_zoomcontrol span:first-child {
	border-bottom: 1px solid #bfbfbf;
}
</style>
</head>
<body>
	<div class="map_wrap">
		<div class="form">
			<div id="map">
				<!-- 지도 확대, 축소 컨트롤 div 입니다 -->
				<div class="custom_zoomcontrol radius_border">
					<span onclick="zoomIn()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png"
						alt="확대"></span> <span onclick="zoomOut()"><img
						src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png" alt="축소"></span>
				</div>

				<!-- 구단 이동 -->
				<div class="team">
					<span onclick="gokgc()"><img src="/resource/정관장.png" alt="kgc"></span> <span onclick="gohk()"><img
						src="/resource/흥국.png" alt="heungkuk"></span> <span onclick="gohd()"><img src="/resource/현대.png"
						alt="hyundai"></span> <span onclick="goibk()"><img src="/resource/IBK.png" alt="ibk"></span> <span
						onclick="gohp()"><img src="/resource/한국도로공사.png" alt="hipass"></span> <span onclick="gopp()"><img
						src="/resource/페퍼.png" alt="pepper"></span> <span onclick="gogs()"><img src="/resource/GS.png" alt="gs"></span>
				</div>
			</div>
			<button class="findmap" onclick="findNearbyAmenities()">편의시설</button>
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
        
        var content = '<div class ="label"><span class="left"></span><span class="center">대전충무체육관</span><span class="right"></span></div>';
     	// 커스텀 오버레이가 표시될 위치입니다 
        var position = new kakao.maps.LatLng(lat, lon);  

        // 커스텀 오버레이를 생성합니다
        var customOverlay = new kakao.maps.CustomOverlay({
            position: position,
            content: content   
        });

        // 커스텀 오버레이를 지도에 표시합니다
        customOverlay.setMap(map);
        
        // 기존에 마커를 추가하던 부분을 함수로 묶어 호출
        addMarker(map, '배구장', lat, lon);
        
        function addMarker(map, title, lat, lon) {
            var positions = [{
                title: title,
                latlng: new kakao.maps.LatLng(lat, lon)
            }];

            var imageSrc = "/resource/KakaoTalk_20240305_140207461.png";
            var imageSize = new kakao.maps.Size(40, 50);
            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

            for (var i = 0; i < positions.length; i++) {
                var marker = new kakao.maps.Marker({
                    map: map, // 마커를 표시할 지도
                    position: positions[i].latlng, // 마커를 표시할 위치
                    title: positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                    image: markerImage // 마커 이미지  
                });
            }
        }

     	// 커스텀 오버레이를 표시하는 함수
        function showCustomOverlay(map, title, lat, lon) {
        	
        	var content = '<div class ="label"><span class="left"></span><span class="center">' + title + '</span><span class="right"></span></div>';

            // 커스텀 오버레이를 생성합니다
            var customOverlay = new kakao.maps.CustomOverlay({
            	position: new kakao.maps.LatLng(lat, lon),
                content: content
            });

            // 커스텀 오버레이를 지도에 표시합니다
            customOverlay.setMap(map);
        }
     
        // 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
        function zoomIn() {
            map.setLevel(map.getLevel() - 1);
        }

        // 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
        function zoomOut() {
            map.setLevel(map.getLevel() + 1);
        }

        // 타 구단 이동
        function gokgc() {
            var moveLatLon = new kakao.maps.LatLng(36.3179809, 127.4304347);
            map.panTo(moveLatLon);
            showCustomOverlay(map, "대전충무체육관", 36.3179809, 127.4304347);
            addMarker(map, '배구장', 36.3179809, 127.4304347);
        }
        function gohd() {
            var moveLatLon = new kakao.maps.LatLng(37.2983182, 127.0090137);
            map.panTo(moveLatLon);
            showCustomOverlay(map, "수원실내체육관", 37.2983182, 127.0090137);
            addMarker(map, '배구장', 37.2983182, 127.0090137);
        }
		function goibk() { 
		    var moveLatLon = new kakao.maps.LatLng(37.1382754, 126.9227018);
		    map.panTo(moveLatLon);   
		    showCustomOverlay(map, "화성종합경기타운 실내체육관", 37.1382754, 126.9227018);
		    addMarker(map, '배구장', 37.1382754, 126.9227018);
		}  
		function gohp() { 
		    var moveLatLon = new kakao.maps.LatLng(36.1430267, 128.0868359);
		    map.panTo(moveLatLon);
		    showCustomOverlay(map, "김천실내체육관", 36.1430267, 128.0868359);
		    addMarker(map, '배구장', 36.1430267, 128.0868359);
		}  
		function gogs() { 
		    var moveLatLon = new kakao.maps.LatLng(37.5581571, 127.0068191);
		    map.panTo(moveLatLon); 
		    showCustomOverlay(map, "수원실내체육관", 37.5581571, 127.0068191);
		    addMarker(map, '배구장', 37.5581571, 127.0068191);
		}  
		function gohk() { 
		    var moveLatLon = new kakao.maps.LatLng(37.5076162, 126.7376084);
		    map.panTo(moveLatLon);
		    showCustomOverlay(map, "인천산삼월드체육관", 37.5076162, 126.7376084);
		    addMarker(map, '배구장', 37.5076162, 126.7376084);
		} 
		function gopp() { 
		    var moveLatLon = new kakao.maps.LatLng(35.1352826, 126.8789211);
		    map.panTo(moveLatLon);
		    showCustomOverlay(map, "페퍼스타디움", 35.1352826, 126.8789211);
		    addMarker(map, '배구장', 35.1352826, 126.8789211);
		} 
		
	    function findNearbyAmenities() {
	        window.location.href = '/usr/game/findmap';
	    }
    </script>

	</div>
</body>
</html>
<%@ include file="../common/foot.jspf"%>