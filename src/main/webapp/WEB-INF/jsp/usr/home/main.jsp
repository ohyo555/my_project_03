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
    width: calc(100% / 6 - 30px);/* 한줄로 나오게 */
    height: 40rem;
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
        width: 15%;
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
            <h2>Membership</h2>
            <p>멤버쉽 가입</p>
            <a class="show-more" href="../member/membership" target="_self"><svg fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" d="M17.25 8.25L21 12m0 0l-3.75 3.75M21 12H3"></path>
              </svg></a>
          </div>
        </div>
      </div>
      <div class="swiper-slide">
        <div class="swiper-slide-img">
          <img src="https://cdn.epnc.co.kr/news/photo/202002/94150_85778_1430.jpg" alt="">
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
          <img src="data:image/png;base64,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" alt="">
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
            <a class="show-more" href="../game/news" target="_self"><svg fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" d="M17.25 8.25L21 12m0 0l-3.75 3.75M21 12H3"></path>
              </svg></a>
          </div>
        </div>
      </div>
    </div>
  </div>

</main>



<%@ include file="../common/foot.jspf"%>