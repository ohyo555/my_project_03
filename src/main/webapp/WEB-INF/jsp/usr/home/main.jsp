<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN"></c:set>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<link rel="stylesheet" href="/resource/background.css" />
<%@ include file="../common/head.jspf"%>

<style>
section {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	width: 100%;
	height: 90%;
	padding: 60px;
}

.swiper {
	display: flex; /* 슬라이드를 한 줄로 표시 */
	overflow-x: auto; /* 가로 스크롤 가능하도록 설정 */
	overflow-y: hidden; /* 세로 스크롤 숨기기 */
	width: 100%; /* 전체 너비 차지 */
	height: 70%;
}

.swiper-wrapper {
	display: flex;
}

.swiper-slide {
	flex: 0 0 auto; /* 슬라이드가 축소되거나 확대되지 않도록 설정 */
}

/* 목록 */
.post {
	max-width: 450px;
	font-size: 1rem;
	font-weight: 500;
	max-height: 450px;
	color: var(--clr-text);
	background: rgba(251, 243, 238, 0.8);
	border-radius: 10px;
	padding: 16px 16px 0;
	margin-bottom: 16px;
}

.post-main {
	width: 100%;
	height: 60%;
	position: relative;
}

.post-img {
	position: absolute;
	width: 100%;
	height: 100%;
	object-fit: cover;
	overflow: hidden;
	aspect-ratio: 4/3;
	border-radius: 6px;
	user-select: none;
	pointer-events: none;
}

.post-body {
	width: 100%;
	height: 30%;
	align-items: center;
	gap: 8px;
	padding: 15px 0;
	cursor: default;
}

.post-name {
	font-size: 1.3rem;
	font-weight: 600;
	margin-bottom: 2px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.post-subname {
	width: fit-content;
	font-size: 1rem;
	font-weight: 500;
	opacity: 0.6;
	color: var(--clr-text);
}

/* MEDIA QUERIES */
@media ( max-width : 1200px) {
	.swiper {
		width: 80%;
	}
}

@media ( max-width : 900px) {
	#recipes {
		padding: 60px 80px;
	}
	.swiper {
		width: 50%;
	}
}

@media ( max-width : 765px) {
	.swiper {
		width: 70%;
	}
}

@media ( max-width : 550px) {
	#recipes {
		padding: 40px 40px;
	}
	.swiper {
		width: 80%;
	}
}

/* 스크롤바 */
.swiper::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 10px;
	background-color: rgb(255, 255, 255);
}

.swiper::-webkit-scrollbar {
	width: 12px;
	background-color: #f2ede2;
}

.swiper::-webkit-scrollbar-thumb {
	border-radius: 10px;
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
	background-color: rgb(251, 243, 238);
}
</style>

<script>
document.addEventListener('DOMContentLoaded', function () {
    var swiper = new Swiper(".swiper", {
        direction: "horizontal",
        // 다른 슬라이더 설정
    });

    // 스크롤 이벤트 감지
    window.addEventListener('scroll', function () {
        var scrollPos = window.scrollX || window.pageXOffset;
        var scrollWidth = document.documentElement.scrollWidth - document.documentElement.clientWidth;
        var scrollPercentage = (scrollPos / scrollWidth) * 100;

        // 스크롤바 위치 업데이트
        var scrollbar = document.querySelector('.swiper-scrollbar');
        scrollbar.style.left = scrollPercentage + '%';
    });

    // swiper 슬라이더의 스크롤 이벤트 감지
    swiper.on('scroll', function () {
        var scrollPos = swiper.translate;
        var maxTranslate = swiper.snapGrid[swiper.snapGrid.length - 1];

        // 스크롤 위치 백분율 계산
        var scrollPercentage = (scrollPos / maxTranslate) * 100;

        // 스크롤바 위치 업데이트
        var scrollbar = document.querySelector('.swiper-scrollbar');
        scrollbar.style.left = scrollPercentage + '%';
    });
});
</script>

<script>

	document.addEventListener('scroll', function () {
	    var scrollPos = window.scrollX || window.pageXOffset;
	    var activeIndex = Math.round(scrollPos / window.innerWidth);
	
	    if (activeIndex === swiper.slides.length - 1) {
	        swiper.allowSlideNext = false;
	    } else {
	        swiper.allowSlideNext = true;
	    }
	
	    swiper.slideTo(activeIndex, 0, false);
	
	    // 스크롤바 위치 업데이트
	    var scrollPercentage = (scrollPos / document.documentElement.scrollWidth) * 100;
	    document.querySelector('.swiper-scrollbar').style.left = scrollPercentage + '%';
	});

    document.addEventListener('DOMContentLoaded', function () {
        var swiper = new Swiper(".swiper", {
            direction: "horizontal", // 수평 방향으로 설정
            effect: "coverflow",
            grabCursor: true,
            centeredSlides: true,
            coverflowEffect: {
                rotate: 0,
                stretch: 0,
                depth: 100,
                modifier: 2.5
            },
            keyboard: {
                enabled: true
            },
            mousewheel: {
                thresholdDelta: 70
            },
            spaceBetween: 30,
            loop: false,
            slidesPerView: 'auto', // 화면 크기에 따라 자동으로 조절
            scrollbar: {
                el: '.swiper-scrollbar',
                draggable: true,
            },
            breakpoints: {
                640: {
                    slidesPerView: 2
                },
                1024: {
                    slidesPerView: 3
                }
            },
        });
        
        function setMaxWidth() {
            var windowWidth = window.innerWidth;
            var maxWidth = 200; // 카드의 최대 너비 (또는 다른 값으로 조절)
            
            if (windowWidth >= 640) {
                maxWidth = windowWidth / 3; // 화면 크기에 따라 동적으로 조절
            }

            document.querySelectorAll('.swiper-slide').forEach(function (slide) {
                slide.style.maxWidth = maxWidth + 'px';
            });
        }

        // 초기 호출
        setMaxWidth();

        // 화면 크기 변경 시 호출
        window.addEventListener('resize', setMaxWidth);
  
		//Update the active slide on scroll
		  window.addEventListener('scroll', function () {
		      var scrollPos = window.scrollX || window.pageXOffset;
		      var activeIndex = Math.round(scrollPos / window.innerWidth);
		      
		      if (activeIndex === swiper.slides.length - 1) {
		          swiper.allowSlideNext = false; //  마지막 슬라이드가 화면 중간에 오면 swiper.allowSlideNext를 false로 설정하여 더 이상 오른쪽으로 슬라이더가 움직이지 않도록 합니다.
		      } else {
		          swiper.allowSlideNext = true;
		      }
		
		      swiper.slideTo(activeIndex, 0, false);
		  });
		
		// 마우스 오버 및 아웃을 위한 이벤트 리스너 추가
		    document.querySelectorAll('.swiper-slide-content').forEach(function (content) {
		        content.addEventListener('mouseover', handleMouseover);
		        content.addEventListener('mouseout', handleMouseout);
		    });
});
</script>

<script>
	document.addEventListener('DOMContentLoaded', function () {
	    document.querySelectorAll('.swiper').forEach(function(swiperElement) {
	        swiperElement.addEventListener('click', function(event) {
	            // 클릭된 .swiper의 post-name 요소의 텍스트 내용 가져오기
	            var postName = event.target.querySelector('.post-name').textContent.trim();
	            
	            // postName에 기반한 URL 매핑 정의
	            var urlMappings = {
	                "경기일정 및 경기정보": "../game/calendar",
	                "등급별 예매일정": "../game/reservation3",
	                "멤버쉽 가입": "../member/membership",
	                "경기장 및 편의시설": "../game/map",
	                "게시판": "../article/list",
	                "뉴스 & SNS": "../game/news"
	                // 필요에 따라 추가적인 매핑 추가
	            };

	            // 클릭된 .swiper에 해당하는 URL로 이동
	            if (urlMappings.hasOwnProperty(postName)) {
 	
	            	if(postName == "멤버쉽 가입") {
	            		memberCheck();
	            	}
	            	else {
	            		window.location.href = urlMappings[postName];
	            	}

	            } else {
	                console.error("포스트에 대한 URL 매핑이 없습니다:", postName);
	            }
	        });
	    });
	});
</script>

<script>
	// 멤버쉽 체크
	function memberCheck(){
		if(${rq.loginedMember.type != null}){
			alert("이미 멤버쉽이 등록되었습니다.");
			window.location.href = "../home/main";
		} else {
		      // 여기에 원하는 페이지 이동 로직 추가
		      window.location.href = "../member/membership";
		    }
	}
</script>

<body>
	<section>
		<div class="swiper">
			<div class="swiper-wrapper">
				<div class="swiper-slide post">
					<div class="post-main">
						<img class="post-img" src="/resource/calendar.gif" alt="recipe" />
					</div>
					<div class="post-body">
						<div class="post-detail">
							<h2 class="post-name">경기일정 및 경기정보</h2>
							<p class="post-subname">정관장 V리그 경기일정 및 경기정보</p>
						</div>
					</div>
				</div>

				<div class="swiper-slide post">
					<div class="post-main">
						<img class="post-img" src="/resource/ticket.png" alt="reservation" />
					</div>
					<div class="post-body">
						<div class="post-detail">
							<h2 class="post-name">등급별 예매일정</h2>
							<p class="post-subname">등급별 경기 예매 일정</p>
						</div>
					</div>
				</div>

				<div class="swiper-slide post">
					<div class="post-main">
						<img class="post-img" src="/resource/membership.png" alt="membership" />
					</div>
					<div class="post-body">
						<div class="post-detail">
							<h2 class="post-name">멤버쉽 가입</h2>
							<p class="post-subname">골드, 실버 멤버쉽 가입</p>
						</div>
					</div>
				</div>

				<div class="swiper-slide post">
					<div class="post-main">
						<img class="post-img" src="/resource/map.png" alt="map" />
					</div>
					<div class="post-body">
						<div class="post-detail">
							<h2 class="post-name">경기장 및 편의시설</h2>
							<p class="post-subname">구단 및 주변 시설 지도</p>
						</div>
					</div>
				</div>

				<div class="swiper-slide post">
					<div class="post-main">
						<img class="post-img" src="/resource/ball.gif" alt="article" />
					</div>
					<div class="post-body">
						<div class="post-detail">
							<h2 class="post-name">게시판</h2>
							<p class="post-subname">자유게시판, 공지사항, 문의사항, 나의 게시판</p>
						</div>
					</div>
				</div>

				<div class="swiper-slide post">
					<div class="post-main">
						<img class="post-img" src="/resource/news3.png" alt="news" />
					</div>
					<div class="post-body">
						<div class="post-detail">
							<h2 class="post-name">뉴스 & SNS</h2>
							<p class="post-subname">네이버 뉴스, Youtube, Instagram 등</p>
						</div>
					</div>
				</div>
				<div class="swiper-scrollbar"></div>
			</div>
	</section>
</body>



<%@ include file="../common/foot.jspf"%>