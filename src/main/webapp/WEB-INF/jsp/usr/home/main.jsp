<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN"></c:set>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<link rel="stylesheet" href="/resource/background.css" />
<%@ include file="../common/head.jspf"%>

<style>
body {
    overflow-y: hidden; 
}

main {
    position: relative;
    width: 100%;
    display: flex;
    align-items: center;
    min-height: 100vh;
    min-height: 100svh;
    /* 스크롤 */
    overflow-y: auto;
    scrollbar-width: thin;
    scrollbar-color: #888 #f1f1f1; 
}

.swiper {
    width: 100%;
    padding-bottom: 100px;
    display: block;
}

.swiper-wrapper {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap; /* 기본이 nowrap > wrapper 넓이에 맞춰서 요소 크기 자동 조정 */
  margin-left: -50px; /* 화면에서 좀 더 왼쪽에 보이고 싶어서 */
}
    
.swiper-slide {
    width: calc(100% / 5 - 30px);/* 한줄로 나오게 */
    height: 35rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: self-start;
    box-shadow: 0.063rem 0.5rem 1.25rem hsl(0deg 0% 0% / 12.16%);
    border-bottom-left-radius: 0.5rem;
    border-bottom-right-radius: 0.5rem;
    max-width: none !important;
}

/* 사용하신 슬라이드 script에 기본적으로 max-width가 설정되어있는데 
이게 우선순위가 가장 높아서
직접 적은 css로 위 설정을 덮어야하는데
저는 그럴때 !important를 씀 */

.swiper-slide-img {
    position: relative;
    width: 100%;
    height: 100%;
    overflow: hidden;
    transform: rotate(180deg);
    line-height: 0;
    bottom: -0.063rem;
    border-bottom-left-radius: 0.5rem;
    border-bottom-right-radius: 0.5rem;
}

.swiper-slide-img img {
    width: 100%;
    height: 100%;
    position: absolute;
    inset: 0;
    object-fit: cover;
    z-index: -1;
    transition: 0.3s ease-in-out;
    transform: rotate(-180deg);
    border:none;
}

.swiper-slide-img svg {
    position: relative;
    display: block;
    width: calc(300% + 1.3px);
    height: 5rem;
    transform: rotateY(180deg);
}

.swiper-slide-img .shape-fill {
    fill: #ffffff;
}

.swiper-slide-content {
    background: #fff;
    padding: 0 1.65rem;
    border-bottom-left-radius: 0.5rem;
    border-bottom-right-radius: 0.5rem;
}

.swiper-slide-content>div {
    transform: translateY(-1.25rem);
}

.swiper-slide-content h2 {
    color: #000;
    font-family: "Raleway", sans-serif;
    font-weight: 700;
    font-size: 1.4rem;
    line-height: 1.4;
    margin-bottom: 0.425rem;
    text-transform: capitalize;
    letter-spacing: 0.02rem;
}

.swiper-slide-content p {
    color: #000;
    line-height: 1.6;
    font-size: 0.9rem;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.swiper-slide-content .show-more {
    width: 3.125rem;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #24aad9;
    border-radius: 50%;
    box-shadow: 0px 0.125rem 0.875rem #24aad96b;
    margin-top: 1em;
    margin-bottom: 0.2em;
    height: 0;
    opacity: 0;
    transition: opacity 0.3s ease-in;
    margin-left: auto;
}

.swiper-slide-content .show-more:hover {
    background: #1184ac;
}

.swiper-slide-content .show-more svg {
    width: 1.75rem;
    color: #fff;
}

.swiper-slide-active:hover img {
    transform: scale(1.2) rotate(-185deg);
}

.swiper-slide-active:hover .show-more {
    opacity: 1;
    height: 3.125rem;
}

.swiper-slide-active:hover p {
    display: block;
    overflow: visible;
}

.swiper-3d .swiper-slide-shadow-left,
.swiper-3d .swiper-slide-shadow-right {
    background-image: none;
}

@media screen and (min-width: 100.75rem) {
    .swiper-slide {
        width: 18%;
    }
}

/*  html {
    overflow-y: scroll;
  } */
</style>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        var swiper = new Swiper(".swiper", {
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
            breakpoints: {
                640: {
                    slidesPerView: 2
                },
                1024: {
                    slidesPerView: 3
                }
            },
            scrollbar: {
                el: '.swiper-scrollbar',
                draggable: true,
            },
            breakpoints: {
                640: {
                    slidesPerView: 'auto', // 화면 크기에 따라 자동으로 조절
                },
                1024: {
                    slidesPerView: 'auto', // 화면 크기에 따라 자동으로 조절
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

        // 마우스 오버 이벤트를 처리하는 함수
        function handleMouseover(event) {
            var slideContent = event.target.closest('.swiper-slide-content');
            if (slideContent) {
                var showMoreButton = slideContent.querySelector('.show-more');
                if (showMoreButton) {
                    showMoreButton.style.opacity = 1;
                    showMoreButton.style.height = '3.125rem';
                }
            }
        }

        // 마우스 아웃 이벤트를 처리하는 함수
        function handleMouseout(event) {
            var slideContent = event.target.closest('.swiper-slide-content');
            if (slideContent) {
                var showMoreButton = slideContent.querySelector('.show-more');
                if (showMoreButton) {
                    showMoreButton.style.opacity = 0;
                    showMoreButton.style.height = '0';
                }
            }
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


<main>
  <div class="swiper">
    <div class="swiper-wrapper"> <!--카드 ~ 옆까지-->
      <div class="swiper-slide"> <!--카드-->
        <div class="swiper-slide-img"> <!--카드 이미지-->
          <img src="https://www.kgcsports.com/images/volleyball/2324_new/homearena_01.jpg" alt="">
          <!-- 카드 아래 장식용 -->
          <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
            <!-- SVG에서 사용되는 path 요소들로 구성되어 있습니다. -->
            <path d="M0,0V46.29c47.79,22.2,103.59,32.17,158,28,70.36-5.37,136.33-33.31,206.8-37.5C438.64,32.43,512.34,53.67,583,72.05c69.27,18,138.3,24.88,209.4,13.08,36.15-6,69.85-17.84,104.45-29.34C989.49,25,1113-14.29,1200,52.47V0Z" opacity=".25" class="shape-fill"></path>
            <path d="M0,0V15.81C13,36.92,27.64,56.86,47.69,72.05,99.41,111.27,165,111,224.58,91.58c31.15-10.15,60.09-26.07,89.67-39.8,40.92-19,84.73-46,130.83-49.67,36.26-2.85,70.9,9.42,98.6,31.56,31.77,25.39,62.32,62,103.63,73,40.44,10.79,81.35-6.69,119.13-24.28s75.16-39,116.92-43.05c59.73-5.85,113.28,22.88,168.9,38.84,30.2,8.66,59,6.17,87.09-7.5,22.43-10.89,48-26.93,60.65-49.24V0Z" opacity=".5" class="shape-fill"></path>
            <path d="M0,0V5.63C149.93,59,314.09,71.32,475.83,42.57c43-7.64,84.23-20.12,127.61-26.46,59-8.63,112.48,12.24,165.56,35.4C827.93,77.22,886,95.24,951.2,90c86.53-7,172.46-45.71,248.8-84.81V0Z" class="shape-fill"></path>
          </svg>
        </div>
        <div class="swiper-slide-content"> <!-- 카드 텍스트 -->
          <div>
            <h2>Game Schedule</h2>
            <p>경기일정 및 경기정보</p>
            <a class="show-more" href="../game/calendar" target="_self"><svg fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" d="M17.25 8.25L21 12m0 0l-3.75 3.75M21 12H3"></path>
              </svg></a>
          </div>
        </div>
      </div>
      <div class="swiper-slide">
        <div class="swiper-slide-img">
          <img src="https://kovostoragedev.blob.core.windows.net/kovo-dev/club/14/banner/Frame%2021578.png" alt="">
          <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
            <path d="M0,0V46.29c47.79,22.2,103.59,32.17,158,28,70.36-5.37,136.33-33.31,206.8-37.5C438.64,32.43,512.34,53.67,583,72.05c69.27,18,138.3,24.88,209.4,13.08,36.15-6,69.85-17.84,104.45-29.34C989.49,25,1113-14.29,1200,52.47V0Z" opacity=".25" class="shape-fill"></path>
            <path d="M0,0V15.81C13,36.92,27.64,56.86,47.69,72.05,99.41,111.27,165,111,224.58,91.58c31.15-10.15,60.09-26.07,89.67-39.8,40.92-19,84.73-46,130.83-49.67,36.26-2.85,70.9,9.42,98.6,31.56,31.77,25.39,62.32,62,103.63,73,40.44,10.79,81.35-6.69,119.13-24.28s75.16-39,116.92-43.05c59.73-5.85,113.28,22.88,168.9,38.84,30.2,8.66,59,6.17,87.09-7.5,22.43-10.89,48-26.93,60.65-49.24V0Z" opacity=".5" class="shape-fill"></path>
            <path d="M0,0V5.63C149.93,59,314.09,71.32,475.83,42.57c43-7.64,84.23-20.12,127.61-26.46,59-8.63,112.48,12.24,165.56,35.4C827.93,77.22,886,95.24,951.2,90c86.53-7,172.46-45.71,248.8-84.81V0Z" class="shape-fill"></path>
          </svg>
        </div>
        <div class="swiper-slide-content">
          <div>
            <h2>Reservation Schedule</h2>
            <p>등급별 예매일정</p>
            <a class="show-more" href="../game/reservation" target="_self"><svg fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" d="M17.25 8.25L21 12m0 0l-3.75 3.75M21 12H3"></path>
              </svg></a>
          </div>
        </div>
      </div>
      <div class="swiper-slide">
        <div class="swiper-slide-img">
          <img src="https://images.unsplash.com/photo-1529655683826-aba9b3e77383?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1965&q=80" alt="">
          <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
            <path d="M0,0V46.29c47.79,22.2,103.59,32.17,158,28,70.36-5.37,136.33-33.31,206.8-37.5C438.64,32.43,512.34,53.67,583,72.05c69.27,18,138.3,24.88,209.4,13.08,36.15-6,69.85-17.84,104.45-29.34C989.49,25,1113-14.29,1200,52.47V0Z" opacity=".25" class="shape-fill"></path>
            <path d="M0,0V15.81C13,36.92,27.64,56.86,47.69,72.05,99.41,111.27,165,111,224.58,91.58c31.15-10.15,60.09-26.07,89.67-39.8,40.92-19,84.73-46,130.83-49.67,36.26-2.85,70.9,9.42,98.6,31.56,31.77,25.39,62.32,62,103.63,73,40.44,10.79,81.35-6.69,119.13-24.28s75.16-39,116.92-43.05c59.73-5.85,113.28,22.88,168.9,38.84,30.2,8.66,59,6.17,87.09-7.5,22.43-10.89,48-26.93,60.65-49.24V0Z" opacity=".5" class="shape-fill"></path>
            <path d="M0,0V5.63C149.93,59,314.09,71.32,475.83,42.57c43-7.64,84.23-20.12,127.61-26.46,59-8.63,112.48,12.24,165.56,35.4C827.93,77.22,886,95.24,951.2,90c86.53-7,172.46-45.71,248.8-84.81V0Z" class="shape-fill"></path>
          </svg>
        </div>
        <div class="swiper-slide-content">
          <div>
            <h2>Map</h2>
            <p>경기장 및 주변시설</p>
            <a class="show-more" href="../game/map" target="_self"><svg fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" d="M17.25 8.25L21 12m0 0l-3.75 3.75M21 12H3"></path>
              </svg></a>
          </div>
        </div>
      </div>
      <div class="swiper-slide">
        <div class="swiper-slide-img">
          <img src="https://images.unsplash.com/photo-1512100356356-de1b84283e18?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1975&q=80" alt="">
          <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
            <path d="M0,0V46.29c47.79,22.2,103.59,32.17,158,28,70.36-5.37,136.33-33.31,206.8-37.5C438.64,32.43,512.34,53.67,583,72.05c69.27,18,138.3,24.88,209.4,13.08,36.15-6,69.85-17.84,104.45-29.34C989.49,25,1113-14.29,1200,52.47V0Z" opacity=".25" class="shape-fill"></path>
            <path d="M0,0V15.81C13,36.92,27.64,56.86,47.69,72.05,99.41,111.27,165,111,224.58,91.58c31.15-10.15,60.09-26.07,89.67-39.8,40.92-19,84.73-46,130.83-49.67,36.26-2.85,70.9,9.42,98.6,31.56,31.77,25.39,62.32,62,103.63,73,40.44,10.79,81.35-6.69,119.13-24.28s75.16-39,116.92-43.05c59.73-5.85,113.28,22.88,168.9,38.84,30.2,8.66,59,6.17,87.09-7.5,22.43-10.89,48-26.93,60.65-49.24V0Z" opacity=".5" class="shape-fill"></path>
            <path d="M0,0V5.63C149.93,59,314.09,71.32,475.83,42.57c43-7.64,84.23-20.12,127.61-26.46,59-8.63,112.48,12.24,165.56,35.4C827.93,77.22,886,95.24,951.2,90c86.53-7,172.46-45.71,248.8-84.81V0Z" class="shape-fill"></path>
          </svg>
        </div>
        <div class="swiper-slide-content">
          <div>
            <h2>게시판</h2>
            <p>자유게시판, 공지사항, Q&A, My</p>
            <a class="show-more" href="../article/list" target="_self"><svg fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" d="M17.25 8.25L21 12m0 0l-3.75 3.75M21 12H3"></path>
              </svg></a>
          </div>
        </div>
      </div>
      <div class="swiper-slide">
        <div class="swiper-slide-img">
          <img src="https://images.unsplash.com/photo-1529655683826-aba9b3e77383?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1965&q=80" alt="">
          <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
            <path d="M0,0V46.29c47.79,22.2,103.59,32.17,158,28,70.36-5.37,136.33-33.31,206.8-37.5C438.64,32.43,512.34,53.67,583,72.05c69.27,18,138.3,24.88,209.4,13.08,36.15-6,69.85-17.84,104.45-29.34C989.49,25,1113-14.29,1200,52.47V0Z" opacity=".25" class="shape-fill"></path>
            <path d="M0,0V15.81C13,36.92,27.64,56.86,47.69,72.05,99.41,111.27,165,111,224.58,91.58c31.15-10.15,60.09-26.07,89.67-39.8,40.92-19,84.73-46,130.83-49.67,36.26-2.85,70.9,9.42,98.6,31.56,31.77,25.39,62.32,62,103.63,73,40.44,10.79,81.35-6.69,119.13-24.28s75.16-39,116.92-43.05c59.73-5.85,113.28,22.88,168.9,38.84,30.2,8.66,59,6.17,87.09-7.5,22.43-10.89,48-26.93,60.65-49.24V0Z" opacity=".5" class="shape-fill"></path>
            <path d="M0,0V5.63C149.93,59,314.09,71.32,475.83,42.57c43-7.64,84.23-20.12,127.61-26.46,59-8.63,112.48,12.24,165.56,35.4C827.93,77.22,886,95.24,951.2,90c86.53-7,172.46-45.71,248.8-84.81V0Z" class="shape-fill"></path>
          </svg>
        </div>
        <div class="swiper-slide-content">
          <div>
            <h2>뉴스 & SNS</h2>
            <p>네이버 스포츠, 인스타그램, 유튜브 등</p>
            <a class="show-more" href="../game/map" target="_self"><svg fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" d="M17.25 8.25L21 12m0 0l-3.75 3.75M21 12H3"></path>
              </svg></a>
          </div>
        </div>
      </div>
    </div>
  </div>

</main>



<%@ include file="../common/foot.jspf"%>