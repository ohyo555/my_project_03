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

tbody tr {
	height: 100px;
}

th {
	border: 1px solid #dddddd;
	text-align: center;
	padding: 24px; /* 날짜 부분의 패딩을 3배로 크게 설정 */
	font-size: 14px; /* 날짜 부분의 글꼴 크기 조절 */
	background-color: #f2f2f2;
	padding: 7px; /* 날짜 부분의 패딩을 3배로 크게 설정 */
}

td {
	border: 1px solid #dddddd;
	width: calc(800px/ 7);
	text-align: center;
	font-size: 13px;
	vertical-align: top; /* 셀 안의 텍스트를 상단에 정렬합니다. */
	padding: 0;
}

button {
	margin: 10px;
	padding: 5px 10px;
	font-size: 16px;
	cursor: pointer;
}

.scoreresult {
	letter-spacing: 10px; /* 글자 간격 조절 */
	padding-left: 8px;
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
	height: 600px;
}

.other-month {
	color: rgba(0, 0, 0, 0.3); /* 현재 월이 아닌 경우 투명도 추가 */
}

.highlight {
	background-color: rgb(251, 243, 238);
	color: black;
}

.highlight2 {
	background-color: rgb(179, 11, 27);
	color: white;
}

.highlight3 {
	background-color: rgb(15, 1, 0);
	color: white;
}

.reservationdate {
	display: flex;
	align-items: center;
	height: 20px;
	font-size: 8px;
}

.reservationdate2 {
	background-color: rgba(255, 192, 203, 0.5);
	border: rgba(255, 192, 203, 0.5); 
}

@keyframes shake {
  0% { transform: translateX(0); }
  25% { transform: translateX(-2px) rotate(5deg); }
  50% { transform: translateX(2px) rotate(-5deg); }
  75% { transform: translateX(-2px) rotate(5deg); }
  100% { transform: translateX(0); }
}

.shake-effect {
  animation: shake 0.5s ease-in-out infinite;
}
</style>
</head>
<body>

	<h2 id="currentMonth">간단한 달력</h2>

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
    
    function getAllDatesOfMonth(month, year) {
	    const numDays = new Date(year, month + 1, 0).getDate();
	    const datesArray = [];
	    for (let day = 1; day <= numDays; day++) {
	        datesArray.push(new Date(year, month, day));
	    }
	    return datesArray;
	}
   
  	// 달력 보여주기!!!!!!!!!!!!!!!!!!!!!!!!!
    function displayCalendar(date, schedules) {
      const currentDate = date || new Date(); // currentDate 선언
      const calendarBody = document.querySelector("#calendarBody");
      const currentMonthElement = document.getElementById("currentMonth");
      
      calendarBody.innerHTML = "";

      const firstDayOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
	  const lastDayOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0);
  	
   	  // 경기날짜 담은 배열
      const gameDates = [ 
          // gamedate 배열의 각 요소를 JavaScript 배열에 추가
          <c:forEach var="date" items="${gamedate}">
          	"${date.substring(0, 5)}", // 각 날짜를 따옴표로 묶어서 배열에 추가
          </c:forEach>
      ];
      
   	  // 경기 5일전 날짜 배열
      const gameDates5DaysBefore = [];

      gameDates.forEach(date => {
    	  
          const [monthStr, dayStr] = date.split('.'); 
          
          const month = parseInt(monthStr, 10);
          const day = parseInt(dayStr, 10);

          const originalDate = new Date();
          originalDate.setMonth(month - 1);
          originalDate.setDate(day);
          
          const fiveDaysBefore = new Date(originalDate);
          fiveDaysBefore.setDate(originalDate.getDate() - 5);

          const formattedMonth = String(fiveDaysBefore.getMonth() + 1).padStart(2, '0');
          const formattedDay = String(fiveDaysBefore.getDate()).padStart(2, '0');

          const a = new Date(currentDate.getFullYear(), formattedMonth - 1, formattedDay);

          gameDates5DaysBefore.push(getFormattedDate(a));
      });
      
      console.log(gameDates5DaysBefore);
      // scheduleData 스케줄과 경기장을 담은 배열 + 경기번호
      var scheduleData = [];
	    <c:forEach var="item" items="${schedule}">
	        var date = "${item.date.substring(0, 5)}";
	        var stadium = "${item.stadium}";
	        var game = "${item.game}";
	        var num = "${item.num}";
	        var round = "${item.round}";
	        scheduleData.push({ date: date, stadium: stadium, game: game, num: num, round: round});
	    </c:forEach>
    
      let currentDay = new Date(firstDayOfMonth);
      currentDay.setDate(1 - firstDayOfMonth.getDay());

      currentMonthElement.textContent = getMonthName(currentDate.getMonth()) + " " + currentDate.getFullYear();
      
      while (currentDay <= lastDayOfMonth) {9
        const weekRow = document.createElement("tr");
        //const formatcurrentDay = getFormattedDate(currentDay);
        
        /* 현재 월의 모든 날짜 */ 
        const allDatesOfMonth = getAllDatesOfMonth(currentDate.getMonth(), currentDate.getFullYear());
     
        for (let i = 0; i < 7; i++) {
          const dayCell = document.createElement("td");
          const formatcurrentDay = getFormattedDate(currentDay);
          const formatcurrentDayYear = getFormattedDateYear(currentDay); //2024-03-01
          dayCell.textContent = currentDay.getDate();
          
          const reservationdate = document.createElement("div");
          reservationdate.classList.add("reservationdate");
		  reservationdate.classList.add(formatcurrentDay); // div의 클래스명을 지정해줘
		  dayCell.appendChild(reservationdate);
		  
		// 현재 날짜가 예약 가능한 날짜 범위에 있는지 확인
		    const isReservationDayResult = isReservationDay(currentDay, allDatesOfMonth, gameDates5DaysBefore, gameDates);
		    if (isReservationDayResult.isInGameDates5DaysBefore || isReservationDayResult.isInGameDates) {
		        reservationdate.classList.add("reservationdate2");
		    }

		    dayCell.appendChild(reservationdate);
		  
          if (currentDay.getMonth() !== currentDate.getMonth()) {
            dayCell.classList.add("other-month"); // 현재 월의 날짜인지 여부를 체크
          }
          
          if (isToday(currentDay)) { // 오늘 날짜에 대한 표시
              dayCell.classList.add("highlight");
          }
          
          //isReservationDay(currentDay, gameDates5DaysBefore, gameDates);
          /* if (isReservationDay(currentDay, allDatesOfMonth, gameDates5DaysBefore, gameDates)) {

        	  console.log("###" + formatcurrentDay);
        	  for(let i = 0; i < gameDates5DaysBefore.length; i++){
        		  if(isInGameDates5DaysBefore >= formatcurrentDay && isInGameDates <= formatcurrentDay){
        			  reservationdate.classList.add("reservationdate2");
        		  } */
              		/*   
              		$(".reservationdate").each(
              				function() {
              					if(gameDates5DaysBefore[i] < formatcurrentDay && gameDates[i] > formatcurrentDay){
              					$(this).css("background-color", "skyblue");
              					}
              				}
              		); */
              		
              		// 현재 날짜의 클래스명을 가져옵니다.
                      //const currentDateClass = gameDates[i]; // 클래스명에서 날짜 부분만 추출합니다.
                      //console.log("Current date class: " + currentDateClass);

                      // 해당 클래스명을 가진 요소들의 배경색을 분홍색으로 변경합니다.
                      // const elements = document.querySelectorAll(currentDateClass);
			           //for (let j = 0; j < elements.length; j++) {
			               // console.log(j);
			              //  console.log("elements[j] " + elements[j]);
			                //elements[j].style.backgroundColor = "pink";
			          // } 
         /*          }
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
    
    function getFormattedDate(date) { // 날짜 형식 바꿔주는거
    	
        const month = (date.getMonth() + 1).toString().padStart(2, '0'); // Extract month with leading zero if necessary
        const day = date.getDate().toString().padStart(2, '0'); // Extract day with leading zero if necessary
        var Date = month + "." + day;
        return Date;
    }
    
	function getFormattedDateYear(date) { // 날짜 형식 바꿔주는거(+년도 포함)
    	
        const year = date.getFullYear().toString();
        const month = (date.getMonth() + 1).toString().padStart(2, '0');
        const day = date.getDate().toString().padStart(2, '0');
        var Date = year + "-" + month + "-" + day;
        return Date;
    }
    
    function isReservationDay(currentDate, allDatesOfMonth, gameDates5DaysBefore, gameDates) {
        const formattedCurrentDate = getFormattedDate(currentDate);

        const isInGameDates5DaysBefore = gameDates5DaysBefore.includes(formattedCurrentDate);
        const isInGameDates = gameDates.includes(formattedCurrentDate);
        
  /*       console.log("isInGameDates5DaysBefore: " + isInGameDates5DaysBefore);
        console.log("isInGameDates: " + isInGameDates); */
        
        return {
            isInGameDates5DaysBefore: isInGameDates5DaysBefore,
            isInGameDates: isInGameDates 
        };
    }
    
    function isGameToday(currentDate, allDatesOfMonth, gameDates) { // 경기 있는 날
        const formattedCurrentDate = getFormattedDate(currentDate);
        //console.log("gameDates:" + gameDates);
        return gameDates.includes(formattedCurrentDate);
    }

    function GameTeamInfo(team) {
    	
    	// Team 정보를 담은 배열(이미지)
       	var TeamData = [];
	     	<c:forEach var="item" items="${teamlist}">
	        	var tname = "${item.tname}";
	        	var timg = "${item.timg}";
	        	TeamData.push({tname: tname, timg: timg});
	     	</c:forEach>
  
     	for (var i = 0; i < TeamData.length; i++) {
     		if(team == TeamData[i].tname) {
     			return TeamData[i].timg
     		}
        } 
    }
  
    // 최초 로딩 시 달력 표시
    displayCalendar();
  </script>

</body>
</html>


<%@ include file="../common/foot.jspf"%>