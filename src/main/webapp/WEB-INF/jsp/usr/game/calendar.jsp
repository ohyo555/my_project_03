<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN"></c:set>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

<link rel="stylesheet" href="/resource/background.css" />
<%@ include file="../common/head.jspf"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>간단한 달력</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0; /* Body의 기본 margin 제거 */
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

th, td {
	border: 1px solid #dddddd;
	text-align: center;
	padding: 24px; /* 날짜 부분의 패딩을 3배로 크게 설정 */
	font-size: 15px; /* 날짜 부분의 글꼴 크기 조절 */
}

th {
	background-color: #f2f2f2;
	padding: 7px; /* 날짜 부분의 패딩을 3배로 크게 설정 */
}

button {
	margin: 10px;
	padding: 5px 10px;
	font-size: 16px;
	cursor: pointer;
}

.sunday {
	color: red; /* 일요일은 빨간색으로 설정 */
}

.saturday {
	color: blue; /* 토요일은 파란색으로 설정 */
}

#currentMonth {
	text-align: center; /* 월과 년도 중앙 정렬 */
	margin-top: 10px; /* 월과 년도 상단 마진 추가 */
}

#calendar {
	margin: 30 auto; /* 가운데 정렬 */
	max-width: 800px; /* 최대 너비 지정 */
}

.other-month {
	color: rgba(0, 0, 0, 0.3); /* 현재 월이 아닌 경우 투명도 추가 */
}

.highlight {
	background-color: blue; /* 특정 날짜에 대한 배경색으로 지정 */
	color: white; /* 글자색을 흰색 또는 다른 색상으로 지정 (필요에 따라) */
}

.highlight2 {
	background-color: red; /* 특정 날짜에 대한 배경색으로 지정 */
	color: white; /* 글자색을 흰색 또는 다른 색상으로 지정 (필요에 따라) */
}

.modal {
    display: none;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 350px;
    padding: 30px;
/*     border: 1px solid #888;
    border-radius: 10px;
    font-size: 1rem;
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19); */
}

.modal-content {
    position: relative;
}

.close {
    position: absolute;
    top: 10px;
    right: 10px;
    font-size: 20px;
    cursor: pointer;
}

.modal_btn {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-top: 20px;
}

.modal_button {
	margin: 0px 10px;
	font-size: 12px;
}

#my_modal .modal_close_btn {
	position: absolute;
	top: 5px;
	right: 20px;
	cursor: pointer; /* 추가: 마우스 포인터 모양 변경 */
}


</style>
</head>
<body>

	<h2 id="currentMonth">간단한 달력</h2>

	<div id="myModal" class="modal">
		<div id="modal-content">
			<span class="modal_close_btn" onclick="closeModal()">&times;</span>
			<p id="selectedDate"></p>
			<!-- 필요에 따라 모달에 더 많은 내용을 추가하세요 -->
		</div>
	</div>

	<table id="calendar">
		<thead>
			<tr>
				<th class="sunday">일</th>
				<th>월</th>
				<th>화</th>
				<th>수</th>
				<th>목</th>
				<th>금</th>
				<th class="saturday">토</th>
			</tr>
		</thead>
		<tbody id="calendarBody"></tbody>

	</table>

	<button onclick="prevMonth()">이전 달</button>
	<button onclick="nextMonth()">다음 달</button>
	
	<a href="../game/gamelist">list</a>

	<script>
  	let currentDate = new Date(); // 블록 범위 변수를 선언하는 데 사용되는 키워드
/*   	
   	const gamedate = ${gamedate};
	console.log(gamedate);
   */
    function displayCalendar(date, schedules) {
      const currentDate = date || new Date(); // currentDate 선언
      const calendarBody = document.querySelector("#calendarBody");
      const currentMonthElement = document.getElementById("currentMonth");
      calendarBody.innerHTML = "";

      const firstDayOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
      const lastDayOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0);
  	
      let currentDay = new Date(firstDayOfMonth);
      currentDay.setDate(1 - firstDayOfMonth.getDay());

      currentMonthElement.textContent = getMonthName(currentDate.getMonth()) + " " + currentDate.getFullYear();

      while (currentDay <= lastDayOfMonth) {
        const weekRow = document.createElement("tr");

        for (let i = 0; i < 7; i++) {
          const dayCell = document.createElement("td");
          dayCell.textContent = currentDay.getDate();

       	  // 날짜를 클릭하면 모달을 표시하기 위한 이벤트 리스너 추가
          dayCell.addEventListener("click", function () {
        	  openModal('myModal'); // 복제된 날짜 객체를 전달
          });
       
          if (currentDay.getMonth() !== currentDate.getMonth()) {
            dayCell.classList.add("other-month"); // 현재 월의 날짜인지 여부를 체크
          }
          
          if (isToday(currentDay)) { // 오늘 날짜에 대한 표시
              dayCell.classList.add("highlight");
          }
          
         /*  if(isGameToday(schedules)) {
        	  dayCell.classList.add("highlight2");
          }
           */
          // 일요일은 빨간색, 토요일은 파란색
          if (i === 0) {
            dayCell.classList.add("sunday");
          } else if (i === 6) {
            dayCell.classList.add("saturday");
          }

          weekRow.appendChild(dayCell);
          currentDay.setDate(currentDay.getDate() + 1);
        }

        calendarBody.appendChild(weekRow);
      }
    }

    function prevMonth() { // 이전달에 대한 달력 나오도록
      currentDate.setMonth(currentDate.getMonth() - 1);
      displayCalendar(currentDate);
    }

    function nextMonth() { // 다음달에 대한 달력 나오도록
      currentDate.setMonth(currentDate.getMonth() + 1);
      displayCalendar(currentDate);
    }
    
    function getMonthName(month) {
        const monthNames = [
          "1월", "2월", "3월", "4월", "5월", "6월",
          "7월", "8월", "9월", "10월", "11월", "12월"
        ];
        return monthNames[month];
     }
    
    function isToday(date) {
    	
        const today = new Date();
        return (
            date.getDate() === today.getDate() &&
            date.getMonth() === today.getMonth() &&
            date.getFullYear() === today.getFullYear()
        );
    }
    
    /* function highlightDates() {
	    const cells = document.querySelectorAll("#calendarBody td");

	    cells.forEach(cell => {
	        const date = cell.textContent;
	        if (${gamedate}.includes(date)) {
	            cell.classList.add("highlight2"); // 날짜가 배열에 포함되어 있으면 배경색을 변경
	        }
	    });
	} */

    	// function isGameToday(schedules) {
    	 // String[] gamedateArray = ${gamedate};
    	/* // 포맷된 날짜를 저장할 StringBuilder
        StringBuilder formattedDates = new StringBuilder();

        // 배열을 반복하고 각 날짜를 포맷합니다.
        for (String date : gamedateArray) {
            // 날짜를 날짜 부분과 요일 부분으로 분할합니다.
            String[] parts = date.split(" ");
            // 월과 일을 추출합니다.
            String[] dateParts = parts[0].split("\\.");
            String month = dateParts[0];
            String day = dateParts[1];
            // 요일을 추출합니다.
            String dayName = parts[1].substring(1, parts[1].length() - 1); // 괄호 제거
            // 포맷하고 StringBuilder에 추가합니다.
            formattedDates.append(month).append(".").append(day).append(" (").append(dayName).append("), ");
        } */

        // 마지막 쉼표와 공백을 제거합니다.
        // String result = formattedDates.substring(0, formattedDates.length() - 2);
        
    	//const gamedateArray = '${gamedate}'.split(',');
        
    	/* for(int i = 0; i < ${gamedate}.size(); i++) {
    		
    	}
    	const array[] = ${gamedate}.split(',');
    	console.log(array[0]); */
    	// 받은 일정 반복
       /*  ${schedules}.forEach(schedule => {
            // Schedule 클래스로부터 날짜 값을 가져와서 JavaScript Date 객체로 변환
            const date = new Date(schedule.date);

            // 해당 날짜의 셀을 가져오기
            const dayCell = document.getElementById("cell_" + date.getDate()); 

            // 날짜에 해당하는 셀이 있으면 색상 변경
            if (dayCell) {
                dayCell.classList.add("highlight2");
            }
        }); */

    // }

/* 모달 기능 */
    function openModal(id) {
	
    	var zIndex = 999;
        const modal = document.getElementById("myModal");
        const selectedDateElement = document.getElementById("modal-content");
        
     // 모달 div 뒤에 희끄무레한 레이어
        var bg = document.createElement('div');
        bg.className = 'modal_bg'; // 클래스 추가
        bg.setStyle({
            position: 'fixed',
            zIndex: zIndex,
            left: '0px',
            top: '0px',
            width: '100%',
            height: '100%',
            overflow: 'auto',
            // 레이어 색갈은 여기서 바꾸면 됨
            backgroundColor: 'rgba(0,0,0,0.3)'
        });
        document.body.append(bg); // 배경 레이어를 body에 추가

        // 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
       modal.querySelector('.modal_close_btn').addEventListener('click', function() {
		    bg.remove();
		    modal.style.display = 'none';
		});
        
       modal.setStyle({
           position: 'fixed',
           display: 'block',
           boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',
           // 시꺼먼 레이어 보다 한칸 위에 보이기
           zIndex: zIndex + 1,

           // div center 정렬
           top: '50%',
           left: '50%',
           transform: 'translate(-50%, -50%)',
           msTransform: 'translate(-50%, -50%)',
           webkitTransform: 'translate(-50%, -50%)'
       });
    }
    
    // Element 에 style 한번에 오브젝트로 설정하는 함수 추가
    Element.prototype.setStyle = function(styles) {
        for (var k in styles) this.style[k] = styles[k];
        return this;
    };

      function closeModal() {
        const modal = document.getElementById("myModal");
        modal.style.display = "none";
      }

      function getFormattedDate(date) {
        const options = { year: "numeric", month: "long", day: "numeric" };
        return date.toLocaleDateString("en-US", options);
      }
      

    // 최초 로딩 시 달력 표시
    displayCalendar();
    // highlightDates();
  </script>

</body>
</html>


<%@ include file="../common/foot.jspf"%>