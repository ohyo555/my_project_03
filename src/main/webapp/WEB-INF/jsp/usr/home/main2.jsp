<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN"></c:set>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<link rel="stylesheet" href="/resource/background.css" />
<%@ include file="../common/head.jspf"%>

<style>

/* :root {
  --clr-text: hsl(0, 0%, 100%);
}
 */
/* * {
  box-sizing: border-box;
  padding: 0;
  margin: 0;
  font-family: "Quicksand", sans-serif;
}
 */
/* body {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
} */

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
  height: 80%;
  
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
  color: var(--clr-text);
  background: rgba(236, 149, 200, 0.2);
  border-radius: 10px;
  padding: 16px 16px 0;
  margin-bottom: 16px;
}

.post-img {
  width: 100%;
  max-width: 400px;
  object-fit: cover;
  overflow: hidden;
  aspect-ratio: 4/3;
  border-radius: 6px;
  user-select: none;
  pointer-events: none;
}

.post-body {
  display: grid;
  grid-template-columns: 15% 60% 20%;
  align-items: center;
  gap: 8px;
  padding: 15px 0;
  cursor: default;
}

.post-name {
  font-size: 0.9rem;
  font-weight: 600;
  margin-bottom: 2px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.post-author {
  width: fit-content;
  font-size: 0.8rem;
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

  <body>
    <section>
        <div class="swiper">
          <div class="swiper-wrapper">
            <div class="swiper-slide post">
              <img
                class="post-img"
                src="https://github.com/ecemgo/mini-samples-great-tricks/assets/13468728/defebc72-ea17-41c7-9bb6-70b3974a93b7"
                alt="recipe" />

              <div class="post-body">
                <img
                  class="post-avatar"
                  src="https://github.com/ecemgo/mini-samples-great-tricks/assets/13468728/f9d29d0e-f03b-4990-9bc5-ade57a276b41"
                  alt="avatar" />
                <div class="post-detail">
                  <h2 class="post-name">Homemade Ice Cream</h2>
                  <p class="post-author">Evelyn Taylor</p>
                </div>

                <div class="post-actions">
                  <a class="post-like" href="javascript:void(0)"
                    ><i class="fas fa-heart"></i
                  ></a>
                  <button
                    class="post-actions-controller"
                    data-target="post1"
                    aria-controls="post-actions-content"
                    aria-expanded="false">
                    <i class="fa-solid fa-ellipsis fa-2xl"></i>
                  </button>
                  <div
                    class="post-actions-content"
                    id="post1"
                    data-visible="false"
                    aria-hidden="true">
                    <ul role="list" class="grid-flow" data-spacing="small">
                      <li>
                        <a class="post-actions-link" href="javascript:void(0)">
                          <i class="fa-solid fa-folder-open"></i>
                          <span>Add to Collection</span>
                        </a>
                      </li>
                      <li>
                        <a class="post-actions-link" href="javascript:void(0)">
                          <i class="fa-solid fa-eye"></i>
                          <span>Show the Recipe</span>
                        </a>
                      </li>
                      <li>
                        <a class="post-actions-link" href="javascript:void(0)">
                          <i class="fa-solid fa-user-plus"></i>
                          <span>Follow the User</span>
                        </a>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>

            <div class="swiper-slide post">
              <img class="post-img" src="https://github.com/ecemgo/mini-samples-great-tricks/assets/13468728/7443d18f-26b6-47eb-bfca-541fb72cee65" alt="recipe" />

              <div class="post-body">
                <img
                  class="post-avatar"
                  src="https://github.com/ecemgo/mini-samples-great-tricks/assets/13468728/3c7b6ef9-cd2d-4d70-819a-2aa9c2309083"
                  alt="avatar" />
                <div class="post-detail">
                  <h2 class="post-name">Pancake</h2>
                  <p class="post-author">Ethan Wilson</p>
                </div>

                <div class="post-actions">
                  <a class="post-like" href="javascript:void(0)"
                    ><i class="fas fa-heart"></i
                  ></a>
                  <button
                    class="post-actions-controller"
                    data-target="post2"
                    aria-controls="post-actions-content"
                    aria-expanded="false">
                    <i class="fa-solid fa-ellipsis fa-2xl"></i>
                  </button>
                  <div
                    class="post-actions-content"
                    id="post2"
                    data-visible="false"
                    aria-hidden="true">
                    <ul role="list" class="grid-flow" data-spacing="small">
                      <li>
                        <a class="post-actions-link" href="javascript:void(0)">
                          <i class="fa-solid fa-folder-open"></i>
                          <span>Add to Collection</span>
                        </a>
                      </li>
                      <li>
                        <a class="post-actions-link" href="javascript:void(0)">
                          <i class="fa-solid fa-eye"></i>
                          <span>Show the Recipe</span>
                        </a>
                      </li>
                      <li>
                        <a class="post-actions-link" href="javascript:void(0)">
                          <i class="fa-solid fa-user-plus"></i>
                          <span>Follow the User</span>
                        </a>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>

            <div class="swiper-slide post">
              <img class="post-img" src="https://github.com/ecemgo/mini-samples-great-tricks/assets/13468728/24566dbf-61a2-4bd0-bb29-ef1773364eba" alt="recipe" />

              <div class="post-body">
                <img
                  class="post-avatar"
                  src="https://github.com/ecemgo/mini-samples-great-tricks/assets/13468728/01332597-5aeb-483b-b682-9379c6ed8f14"
                  alt="avatar" />
                <div class="post-detail">
                  <h2 class="post-name">Macaron</h2>
                  <p class="post-author">Bella Smith</p>
                </div>

                <div class="post-actions">
                  <a class="post-like" href="javascript:void(0)"
                    ><i class="fas fa-heart"></i
                  ></a>
                  <button
                    class="post-actions-controller"
                    data-target="post3"
                    aria-controls="post-actions-content"
                    aria-expanded="false">
                    <i class="fa-solid fa-ellipsis fa-2xl"></i>
                  </button>
                  <div
                    class="post-actions-content"
                    id="post3"
                    data-visible="false"
                    aria-hidden="true">
                    <ul role="list" class="grid-flow" data-spacing="small">
                      <li>
                        <a class="post-actions-link" href="javascript:void(0)">
                          <i class="fa-solid fa-folder-open"></i>
                          <span>Add to Collection</span>
                        </a>
                      </li>
                      <li>
                        <a class="post-actions-link" href="javascript:void(0)">
                          <i class="fa-solid fa-eye"></i>
                          <span>Show the Recipe</span>
                        </a>
                      </li>
                      <li>
                        <a class="post-actions-link" href="javascript:void(0)">
                          <i class="fa-solid fa-user-plus"></i>
                          <span>Follow the User</span>
                        </a>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>

            <div class="swiper-slide post">
              <img
                class="post-img"
                src="https://github.com/ecemgo/mini-samples-great-tricks/assets/13468728/a208eb17-a847-4e04-be2c-d7ec2071ae45"
                alt="recipe" />

              <div class="post-body">
                <img class="post-avatar" src="https://github.com/ecemgo/mini-samples-great-tricks/assets/13468728/b9f5ef94-c2c9-4792-b7a3-593d393f2c84" alt="avatar" />
                <div class="post-detail">
                  <h2 class="post-name">Cheesecake</h2>
                  <p class="post-author">Mia Dixon</p>
                </div>

                <div class="post-actions">
                  <a class="post-like" href="javascript:void(0)"
                    ><i class="fas fa-heart"></i
                  ></a>
                  <button
                    class="post-actions-controller"
                    data-target="post4"
                    aria-controls="post-actions-content"
                    aria-expanded="false">
                    <i class="fa-solid fa-ellipsis fa-2xl"></i>
                  </button>
                  <div
                    class="post-actions-content"
                    id="post4"
                    data-visible="false"
                    aria-hidden="true">
                    <ul role="list" class="grid-flow" data-spacing="small">
                      <li>
                        <a class="post-actions-link" href="javascript:void(0)">
                          <i class="fa-solid fa-folder-open"></i>
                          <span>Add to Collection</span>
                        </a>
                      </li>
                      <li>
                        <a class="post-actions-link" href="javascript:void(0)">
                          <i class="fa-solid fa-eye"></i>
                          <span>Show the Recipe</span>
                        </a>
                      </li>
                      <li>
                        <a class="post-actions-link" href="javascript:void(0)">
                          <i class="fa-solid fa-user-plus"></i>
                          <span>Follow the User</span>
                        </a>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>

            <div class="swiper-slide post">
              <img class="post-img" src="https://github.com/ecemgo/mini-samples-great-tricks/assets/13468728/208fe8f5-9d7f-4b83-9249-43601bb4c500" alt="recipe" />

              <div class="post-body">
                <img
                  class="post-avatar"
                  src="https://github.com/ecemgo/mini-samples-great-tricks/assets/13468728/58f9319c-78cf-444b-ba71-701c506c2dd3"
                  alt="avatar" />
                <div class="post-detail">
                  <h2 class="post-name">Donuts</h2>
                  <p class="post-author">Olivia Martinez</p>
                </div>

                <div class="post-actions">
                  <a class="post-like" href="javascript:void(0)"
                    ><i class="fas fa-heart"></i
                  ></a>
                  <button
                    class="post-actions-controller"
                    data-target="post5"
                    aria-controls="post-actions-content"
                    aria-expanded="false">
                    <i class="fa-solid fa-ellipsis fa-2xl"></i>
                  </button>
                  <div
                    class="post-actions-content"
                    id="post5"
                    data-visible="false"
                    aria-hidden="true">
                    <ul role="list" class="grid-flow" data-spacing="small">
                      <li>
                        <a class="post-actions-link" href="javascript:void(0)">
                          <i class="fa-solid fa-folder-open"></i>
                          <span>Add to Collection</span>
                        </a>
                      </li>
                      <li>
                        <a class="post-actions-link" href="javascript:void(0)">
                          <i class="fa-solid fa-eye"></i>
                          <span>Show the Recipe</span>
                        </a>
                      </li>
                      <li>
                        <a class="post-actions-link" href="javascript:void(0)">
                          <i class="fa-solid fa-user-plus"></i>
                          <span>Follow the User</span>
                        </a>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>

            <div class="swiper-slide post">
              <img
                class="post-img"
                src="https://github.com/ecemgo/mini-samples-great-tricks/assets/13468728/e4f91d6d-ee11-4ff7-9e6f-0fb3f9a78598"
                alt="recipe" />

              <div class="post-body">
                <img
                  class="post-avatar"
                  src="https://github.com/ecemgo/mini-samples-great-tricks/assets/13468728/24ca2eec-a5ba-4c32-907c-ffffca203e1c"
                  alt="avatar" />
                <div class="post-detail">
                  <h2 class="post-name">Rolo Cheesecake</h2>
                  <p class="post-author">Benjamin Clark</p>
                </div>

                <div class="post-actions">
                  <a class="post-like" href="javascript:void(0)"
                    ><i class="fas fa-heart"></i
                  ></a>
                  <button
                    class="post-actions-controller"
                    data-target="post6"
                    aria-controls="post-actions-content"
                    aria-expanded="false">
                    <i class="fa-solid fa-ellipsis fa-2xl"></i>
                  </button>
                  <div
                    class="post-actions-content"
                    id="post6"
                    data-visible="false"
                    aria-hidden="true">
                    <ul role="list" class="grid-flow" data-spacing="small">
                      <li>
                        <a class="post-actions-link" href="javascript:void(0)">
                          <i class="fa-solid fa-folder-open"></i>
                          <span>Add to Collection</span>
                        </a>
                      </li>
                      <li>
                        <a class="post-actions-link" href="javascript:void(0)">
                          <i class="fa-solid fa-eye"></i>
                          <span>Show the Recipe</span>
                        </a>
                      </li>
                      <li>
                        <a class="post-actions-link" href="javascript:void(0)">
                          <i class="fa-solid fa-user-plus"></i>
                          <span>Follow the User</span>
                        </a>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="swiper-scrollbar"></div>
        </div>
    </section>
  </body>



<%@ include file="../common/foot.jspf"%>