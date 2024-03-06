<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN"></c:set>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<link rel="stylesheet" href="/resource/background.css" />
<%@ include file="../common/head.jspf"%>

<style>
main {
    position: relative;
    width: 100%;
    margin: 0;
    padding: 0;
    display: flex;
    align-items: center;
    min-height: 100vh;
    min-height: 100svh;
    column-gap: 3rem;
    padding-block: min(20vh, 3rem);
}

.swiper {
    width: 100%;
    padding: 1.875rem 0;
}

.swiper-wrapper {
  display: flex;
  flex-direction: row;
}
    
.swiper-slide {
    width: 80%; 
    height: 35rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: self-start;
    box-shadow: 0.063rem 0.5rem 1.25rem hsl(0deg 0% 0% / 12.16%);
    border-bottom-left-radius: 0.5rem;
    border-bottom-right-radius: 0.5rem;
/*     flex-direction: row; */
}


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

@media screen and (min-width: 93.75rem) {
    .swiper {
        width: 85%;
    }
}
/*  html {
    overflow-y: scroll;
  } */
</style>

<div class="swiper">
    <div class="swiper-wrapper">
        <!-- Your slides go here -->
    </div>
    <!-- Add a scrollbar -->
    <div class="swiper-scrollbar"></div>
</div>

<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
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
        });

  
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
});
</script>


<main>
  <div class="swiper">
    <div class="swiper-wrapper"> <!--카드영역부터 옆영역까지-->
      <div class="swiper-slide"> <!--카드역역-->
        <div class="swiper-slide-img">
          <img src="https://www.kgcsports.com/images/volleyball/2324_new/homearena_01.jpg" alt="">
          <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
            <path d="M0,0V46.29c47.79,22.2,103.59,32.17,158,28,70.36-5.37,136.33-33.31,206.8-37.5C438.64,32.43,512.34,53.67,583,72.05c69.27,18,138.3,24.88,209.4,13.08,36.15-6,69.85-17.84,104.45-29.34C989.49,25,1113-14.29,1200,52.47V0Z" opacity=".25" class="shape-fill"></path>
            <path d="M0,0V15.81C13,36.92,27.64,56.86,47.69,72.05,99.41,111.27,165,111,224.58,91.58c31.15-10.15,60.09-26.07,89.67-39.8,40.92-19,84.73-46,130.83-49.67,36.26-2.85,70.9,9.42,98.6,31.56,31.77,25.39,62.32,62,103.63,73,40.44,10.79,81.35-6.69,119.13-24.28s75.16-39,116.92-43.05c59.73-5.85,113.28,22.88,168.9,38.84,30.2,8.66,59,6.17,87.09-7.5,22.43-10.89,48-26.93,60.65-49.24V0Z" opacity=".5" class="shape-fill"></path>
            <path d="M0,0V5.63C149.93,59,314.09,71.32,475.83,42.57c43-7.64,84.23-20.12,127.61-26.46,59-8.63,112.48,12.24,165.56,35.4C827.93,77.22,886,95.24,951.2,90c86.53-7,172.46-45.71,248.8-84.81V0Z" class="shape-fill"></path>
          </svg>
        </div>
        <div class="swiper-slide-content">
          <div>
            <h2>Schedule</h2>
            <p>National art museum in Paris, France. It is located on the Right Bank of the Seine in the city's 1st arrondissement (district or ward) and home to some of the most canonical works of Western art, including the Mona Lisa and the Venus de Milo.</p>
            <a class="show-more" href="../game/calendar" target="_self"><svg fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" d="M17.25 8.25L21 12m0 0l-3.75 3.75M21 12H3"></path>
              </svg></a>
          </div>
        </div>
      </div>
      <div class="swiper-slide">
        <div class="swiper-slide-img">
          <img src="https://images.unsplash.com/photo-1618822461310-da1be362e30c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80" alt="">
          <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
            <path d="M0,0V46.29c47.79,22.2,103.59,32.17,158,28,70.36-5.37,136.33-33.31,206.8-37.5C438.64,32.43,512.34,53.67,583,72.05c69.27,18,138.3,24.88,209.4,13.08,36.15-6,69.85-17.84,104.45-29.34C989.49,25,1113-14.29,1200,52.47V0Z" opacity=".25" class="shape-fill"></path>
            <path d="M0,0V15.81C13,36.92,27.64,56.86,47.69,72.05,99.41,111.27,165,111,224.58,91.58c31.15-10.15,60.09-26.07,89.67-39.8,40.92-19,84.73-46,130.83-49.67,36.26-2.85,70.9,9.42,98.6,31.56,31.77,25.39,62.32,62,103.63,73,40.44,10.79,81.35-6.69,119.13-24.28s75.16-39,116.92-43.05c59.73-5.85,113.28,22.88,168.9,38.84,30.2,8.66,59,6.17,87.09-7.5,22.43-10.89,48-26.93,60.65-49.24V0Z" opacity=".5" class="shape-fill"></path>
            <path d="M0,0V5.63C149.93,59,314.09,71.32,475.83,42.57c43-7.64,84.23-20.12,127.61-26.46,59-8.63,112.48,12.24,165.56,35.4C827.93,77.22,886,95.24,951.2,90c86.53-7,172.46-45.71,248.8-84.81V0Z" class="shape-fill"></path>
          </svg>
        </div>
        <div class="swiper-slide-content">
          <div>
            <h2>seychelles</h2>
            <p>Officially the Republic of Seychelles is an island country and archipelagic state consisting of 155 islands in the Indian Ocean.</p>
            <a class="show-more" href="https://en.wikipedia.org/wiki/Seychelles" target="_blank"><svg fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
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
            <h2>london</h2>
            <p>The capital and largest city of England and the United Kingdom, with a population of around 8.8 million. It stands on the River Thames in south-east England at the head of a 50-mile (80 km) estuary down to the North Sea and has been a major settlement for nearly two millennia.</p>
            <a class="show-more" href="https://en.wikipedia.org/wiki/London" target="_blank"><svg fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
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
            <h2>maldives</h2>
            <p>Officially the Republic of Maldives is an archipelagic state and country in South Asia, situated in the Indian Ocean.</p>
            <a class="show-more" href="https://en.wikipedia.org/wiki/Maldives" target="_blank"><svg fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" d="M17.25 8.25L21 12m0 0l-3.75 3.75M21 12H3"></path>
              </svg></a>
          </div>
        </div>
      </div>
      <div class="swiper-slide">
        <div class="swiper-slide-img">
          <img src="https://images.unsplash.com/photo-1516483638261-f4dbaf036963?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1886&q=80" alt="">
          <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
            <path d="M0,0V46.29c47.79,22.2,103.59,32.17,158,28,70.36-5.37,136.33-33.31,206.8-37.5C438.64,32.43,512.34,53.67,583,72.05c69.27,18,138.3,24.88,209.4,13.08,36.15-6,69.85-17.84,104.45-29.34C989.49,25,1113-14.29,1200,52.47V0Z" opacity=".25" class="shape-fill"></path>
            <path d="M0,0V15.81C13,36.92,27.64,56.86,47.69,72.05,99.41,111.27,165,111,224.58,91.58c31.15-10.15,60.09-26.07,89.67-39.8,40.92-19,84.73-46,130.83-49.67,36.26-2.85,70.9,9.42,98.6,31.56,31.77,25.39,62.32,62,103.63,73,40.44,10.79,81.35-6.69,119.13-24.28s75.16-39,116.92-43.05c59.73-5.85,113.28,22.88,168.9,38.84,30.2,8.66,59,6.17,87.09-7.5,22.43-10.89,48-26.93,60.65-49.24V0Z" opacity=".5" class="shape-fill"></path>
            <path d="M0,0V5.63C149.93,59,314.09,71.32,475.83,42.57c43-7.64,84.23-20.12,127.61-26.46,59-8.63,112.48,12.24,165.56,35.4C827.93,77.22,886,95.24,951.2,90c86.53-7,172.46-45.71,248.8-84.81V0Z" class="shape-fill"></path>
          </svg>
        </div>
        <div class="swiper-slide-content">
          <div>
            <h2>Italy</h2>
            <p>Located in the middle of the Mediterranean Sea, it consists of a peninsula delimited by the Alps and surrounded by several islands. Italy shares land borders with France, Switzerland, Austria, Slovenia and the enclaved microstates of Vatican City and San Marino.</p>
            <a class="show-more" href="https://en.wikipedia.org/wiki/Italy" target="_blank"><svg fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" d="M17.25 8.25L21 12m0 0l-3.75 3.75M21 12H3"></path>
              </svg></a>
          </div>
        </div>
      </div>
    </div>
  </div>
</main>



<%@ include file="../common/foot.jspf"%>