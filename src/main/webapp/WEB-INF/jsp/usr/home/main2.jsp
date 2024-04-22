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
  width: 100%; /* 전체 너비 차지 */
  height: 70%;
}

.swiper-wrapper {
  display: flex; 
}

.swiper-slide {
  flex: 0 0 auto;  /* 슬라이드가 축소되거나 확대되지 않도록 설정 */
}

/* 목록 */
.post {
  max-width: 400px;
  font-size: 1rem;
  font-weight: 500;
  max-height: 450px;
  color: var(--clr-text);
  background: rgba(251,243,238,0.8);
  border-radius: 10px;
  padding: 16px 16px 0;
  margin-bottom: 16px;
}                             

.post-img {
  width: 100%;
  object-fit: cover;
  overflow: hidden;
  aspect-ratio: 4/3;
  border-radius: 6px;
  user-select: none;
  pointer-events: none;
}

.post-body {
  display: grid;
  grid-template-columns: 60% 40%;
  align-items: center;
  gap: 8px;
  padding: 15px 0;
  cursor: default;
}

.post-name {
  font-size: 1.5rem;
  font-weight: 600;
  margin-bottom: 2px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.post-author {
  width: fit-content;
  font-size: 1rem;
  font-weight: 600;
  opacity: 0.6;
  color: var(--clr-text);
}

.post-avatar {
  width: 40px;
  aspect-ratio: 1/1;
  object-fit: cover;
  border-radius: 5px;
  cursor: pointer;
}

.post-actions {
  position: relative;
}

.post-actions-content {
  position: absolute;
  bottom: 130%;
  right: 0;
  padding: 8px;
  border-radius: 8px;
  background: rgba(172, 172, 172, 0.2);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  box-shadow: 2px 2px 10px 2px hsl(0, 0%, 0%, 0.25);
  transition: opacity 0.25s, scale 0.25s;
  transform-origin: bottom right;
}

.post-actions-content[data-visible="false"] {
  pointer-events: none;
  opacity: 0;
  scale: 0;
}

.post-actions-content[data-visible="true"] {
  pointer-events: unset;
  scale: 1;
  opacity: 1;
}

.post-actions-content li {
  padding: 0.5rem 0.65rem;
  border-radius: 0.25rem;
  list-style: none;
}

.post-actions-content li:is(:hover, :focus-within) {
  background-color: rgba(248, 132, 169, 0.7);
}

.post-actions-link {
  width: max-content;
  display: grid;
  grid-template-columns: 1rem 1fr;
  align-items: center;
  gap: 0.6rem;
  color: inherit;
  text-decoration: none;
  cursor: pointer;
}

.post-like {
  text-decoration: none;
  color: var(--clr-text);
  margin-right: 5px;
  font-size: 1.1rem;
  opacity: 0.65;
  border-radius: 50%;
  overflow: hidden;
  transition: all 0.35s ease;
}

.post-actions-controller {
  border: 0;
  background: none;
  color: var(--clr-text);
  cursor: pointer;
  opacity: 0.65;
}

.post-like:hover,
.post-actions-controller:hover {
  opacity: 1;
}

.post-like:focus {
  outline: none;
}

.post-like.active {
  color: rgb(255, 0, 0);
  opacity: 1;
  transform: scale(1.2);
}

/* MEDIA QUERIES */

@media (max-width: 1200px) { 
  .swiper {
      width: 80%;
    }
}

@media (max-width: 900px) {
  #recipes {
    padding: 60px 80px;
  }

  .swiper {
    width: 50%;
  }
}

@media (max-width: 765px) {
  .swiper {
    width: 70%;
  }
}

@media (max-width: 550px) {
  #recipes {
    padding: 40px 40px;
  }

  .swiper {
    width: 80%;
  }
}

/* 스크롤바 */
 .swiper::-webkit-scrollbar-track {
   -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
   border-radius: 10px;
   background-color: rgb(255, 255, 255);
}

.swiper::-webkit-scrollbar {
    width: 12px;
    background-color: #f2ede2;
}

.swiper::-webkit-scrollbar-thumb {
    border-radius: 10px;
    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
    background-color: rgb(251, 243, 238);
}

</style>

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
	                window.location.href = urlMappings[postName];
	            } else {
	                console.error("포스트에 대한 URL 매핑이 없습니다:", postName);
	            }
	        });
	    });
	});
</script>

  <body>
    <section>
        <div class="swiper">
          <div class="swiper-wrapper">
            <div class="swiper-slide post">
              <img
                class="post-img"
                src="https://github.com/ohyo555/my_project_03/assets/153146836/44dbf692-1729-4f7c-af64-b2164540ddfb"
                alt="recipe" />
                
              <div class="post-body">
                <div class="post-detail">
                  <h2 class="post-name">경기일정 및 경기정보</h2>
                  <p class="post-author">Evelyn Taylor</p>
                </div>
              </div>
            </div>

            <div class="swiper-slide post">
              <img class="post-img" src="https://github.com/ohyo555/my_project_03/assets/153146836/8c1cc718-e0b5-4132-a680-7fcfeafcf5c3" alt="recipe" />

              <div class="post-body">
                <div class="post-detail">
                  <h2 class="post-name">등급별 예매일정</h2>
                  <p class="post-author">Ethan Wilson</p>
                </div>
              </div>
            </div>

            <div class="swiper-slide post">
              <img class="post-img" src="https://github.com/ecemgo/mini-samples-great-tricks/assets/13468728/24566dbf-61a2-4bd0-bb29-ef1773364eba" alt="recipe" />

              <div class="post-body">
                <div class="post-detail">
                  <h2 class="post-name">멤버쉽 가입</h2>
                  <p class="post-author">Bella Smith</p>
                </div>
              </div>
            </div>

            <div class="swiper-slide post">
              <img
                class="post-img"
                src="https://github.com/ohyo555/my_project_03/assets/153146836/31c62d3a-2185-4085-b69f-879f861334f7"
                alt="recipe" />

              <div class="post-body">
                <div class="post-detail">
                  <h2 class="post-name">경기장 및 편의시설</h2>
                  <p class="post-author">Mia Dixon</p>
                </div>
              </div>
            </div>

            <div class="swiper-slide post">
              <img class="post-img" src="https://github.com/ohyo555/my_project_03/assets/153146836/8fc31d83-16be-44d0-98d1-fc985fb97cb3" alt="recipe" />

              <div class="post-body">
                <div class="post-detail">
                  <h2 class="post-name">게시판</h2>
                  <p class="post-author">자유게시판, 공지사항, 문의사항, 나의 게시판</p>
                </div>
              </div>
            </div>

            <div class="swiper-slide post">
              <img
                class="post-img"
                src="https://github.com/ohyo555/my_project_03/assets/153146836/68bbb3d4-04d6-4a1a-8814-3039d90a79b8"
                alt="recipe" />

              <div class="post-body">
                <div class="post-detail">
                  <h2 class="post-name">뉴스 & SNS</h2>
                  <p class="post-author">네이버 뉴스, Youtube, Instagram 등</p>
                </div>
            </div>
          </div>
          <div class="swiper-scrollbar"></div>
        </div>
    </section>
  </body>



<%@ include file="../common/foot.jspf"%>