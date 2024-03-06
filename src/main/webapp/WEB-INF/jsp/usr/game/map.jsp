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
	    overflow: hidden;
	    margin: 0;
	}

	.map_wrap {
	position:relative;
	overflow:hidden;
	width:100%;
	height: 100%;
	}

    #map {
        position: fixed;
      	top: 80px; /* 헤더의 높이 */
        right: 0;
        width: 80%;
        margin: 30px;
        height: 85% /* 화면 아래 끝까지 나오도록 조정 */
    }

    /* 구단 */
    .team {
    position:absolute;
    bottom: 110px;
    right: 40px;
    width:34px;
    height: 217px;
    overflow:hidden;
    z-index:1;
    background-color:#f5f5f5;
    box-sizing: border-box; /* 테두리 밖으로 그리기 */
  	border: 3px solid #bfbfbf;
  	border-radius: 5px;
  	display: flex; /* Flex 컨테이너로 설정 */
    flex-direction: column; /* 수직 방향으로 아이템 정렬 */
    }
    
    .team span {
    display: block;
    height: 20px; /* 이미지 비율을 유지하면서 크기 조절 */
    margin-bottom: 10px;
	}
	
	.team span img{
    	width: 28px; 
	}
	
	/* 커스텀 라벨 */
	
	.label {margin-bottom: 120px;}
	.label * {display: inline-block;vertical-align: top;}
	.label .left {background: url("https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_l.png") no-repeat;display: inline-block;height: 24px;overflow: hidden;vertical-align: top;width: 7px;}
	.label .center {background: url(https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_bg.png) repeat-x;display: inline-block;height: 24px;font-size: 12px;line-height: 24px;}
	.label .right {background: url("https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_r.png") -1px 0  no-repeat;display: inline-block;height: 24px;overflow: hidden;width: 6px;}

    /* 확대/축소 스타일 */
    .custom_zoomcontrol {
    position:absolute;
    top:55px;
    right:40px;
    width:35px;
    height:65px;
    overflow:hidden;
    z-index:1;
    background-color:#f5f5f5;
    box-sizing: border-box; /* 테두리 밖으로 그리기 */
  	border: 3px solid #bfbfbf;
  	border-radius: 5px;
    } 
    
	.custom_zoomcontrol span {
	display:block;
	width:30px;
	height:30px;
	text-align:center;
	cursor:pointer;
	}     
	
	.custom_zoomcontrol span img {
	width: 100%; /* 이미지를 꽉 차게 표시합니다. */
    height: 100%; /* 이미지를 꽉 차게 표시합니다. */
    padding: 3px;
	border:none;
	z-index:99;
	}           
	  
	.custom_zoomcontrol span:first-child{
	border-bottom:1px solid #bfbfbf;
	}      
</style>
</head>
<body>
<div class="map_wrap" >
    
    <div id="map"></div>
    
    <!-- 지도 확대, 축소 컨트롤 div 입니다 -->
    <div class="custom_zoomcontrol radius_border"> 
         <span onclick="zoomIn()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png" alt="확대"></span>  
         <span onclick="zoomOut()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png" alt="축소"></span>
    </div>
    
    <!-- 구단 이동 -->
    <div class="team">
    	<span onclick="gokgc()"><img src="/resource/정관장.png" alt="kgc"></span>
    	<span onclick="gohk()"><img src="/resource/흥국.png" alt="heungkuk"></span>  
        <span onclick="gohd()"><img src="/resource/현대.png" alt="hyundai"></span>
        <span onclick="goibk()"><img src="/resource/IBK.png" alt="ibk"></span>  
        <span onclick="gohp()"><img src="/resource/한국도로공사.png" alt="hipass"></span>
        <span onclick="gopp()"><img src="/resource/페퍼.png" alt="pepper"></span>  
        <span onclick="gogs()"><img src="/resource/GS.png" alt="gs"></span>
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
            addMarker(map, '배구장', 36.3179809, 127.4304347);
        }
        function gohd() {
            var moveLatLon = new kakao.maps.LatLng(37.2983182, 127.0090137);
            map.panTo(moveLatLon);
            addMarker(map, '배구장', 37.2983182, 127.0090137);
        }
		function goibk() { 
		    var moveLatLon = new kakao.maps.LatLng(37.1382754, 126.9227018);
		    map.panTo(moveLatLon);   
		    addMarker(map, '배구장', 37.1382754, 126.9227018);
		}  
		function gohp() { 
		    var moveLatLon = new kakao.maps.LatLng(36.1430267, 128.0868359);
		    map.panTo(moveLatLon);
		    addMarker(map, '배구장', 36.1430267, 128.0868359);
		}  
		function gogs() { 
		    var moveLatLon = new kakao.maps.LatLng(37.5581571, 127.0068191);
		    map.panTo(moveLatLon); 
		    addMarker(map, '배구장', 37.5581571, 127.0068191);
		}  
		function gohk() { 
		    var moveLatLon = new kakao.maps.LatLng(37.5076162, 126.7376084);
		    map.panTo(moveLatLon);    
		    addMarker(map, '배구장', 37.5076162, 126.7376084);
		} 
		function gopp() { 
		    var moveLatLon = new kakao.maps.LatLng(35.1352826, 126.8789211);
		    map.panTo(moveLatLon);
		    addMarker(map, '배구장', 35.1352826, 126.8789211);
		} 
		
    </script>
    
    </div>
</body>
</html>
<%@ include file="../common/foot.jspf"%>