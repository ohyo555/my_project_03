<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Reservation"></c:set>
<%@ include file="../common/head.jspf"%>
<link rel="stylesheet" href="/resource/background.css" />

<html lang='en'>
<head>
<meta charset='utf-8' />
<!-- fullcalendar 사용 -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js'></script>
<!-- <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script> -->


<style>
/* 달력 */
#calendar {
	margin: 30px auto; /* 가운데 정렬 */
	max-width: 900px; /* 최대 너비 지정 */
	height: auto;
}

/* member */
#calendar > span {
	width: 20px;
	height: 20px;
	padding-bottom: 3px;
}
/* 
#calendar > span > .gold{
	background-color: #fbf3ee;
}

#calendar > span > .silver{
	background-color:fad8d7;
}
 */
 
#calendar > div.fc-view-harness.fc-view-harness-active > div > table > thead > tr {
 	overflow-y: hidden; 
 }
/* 헤더 버튼 */
.fc .fc-button-primary {
	background-color: #800808;
	border-style: none;
	padding: 3px;
}

.fc .fc-button:focus {
    outline: none; /* 포커스 시 테두리 제거 */
}

/* today를 표시할 수 없을 때 */
.fc .fc-button-primary:disabled {
	background-color: rgb(251, 243, 238);
	color: #2c3e50;
	padding: 3px 5px;
	border-style: none;
}

.fc .fc-button-primary:hover {
	background-color: #c76161; /* 색 더 찾아바 */
	border-style: none;
	padding: 3px;
}

h2 {
	font-weight: 600;
}

.fc-event {
	border-style: none;
}
.fc-event-main-frame {
	margin-bottom: 5px;
}

.fc .fc-col-header-cell {
	background-color: #f2f2f2;
}

.fc .fc-col-header-cell-cushion {
	padding: 6px;
	font-size: 14px;
}

.fc .fc-daygrid-day-top a{
	width: 100%;
	text-align: center;
    font-size: 13px;
}

/* 주말 */
.fc-day-sun {
    color: red;
    }

.fc-day-sat {
    color: blue;
}

/* 스크롤바 */
.fc-scroller::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 10px;
	background-color: rgb(255, 255, 255);
}

.fc-scroller::-webkit-scrollbar {
	width: 12px;
	background-color: #f2ede2;
}

.fc-scroller::-webkit-scrollbar-thumb {
	border-radius: 10px;
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
	background-color: rgb(251, 243, 238);
}

/* 모달 */
#Modal {
    position: fixed;
    width: 100%;
    height: 100%;
    background-color: rgba(255, 255, 255, 0.5);
    display: none;
    z-index: 1000;
}

#cont {
    margin: 50px auto;
    width: 300px;
    height: 208px;
    color: black;
   	background-color: #fefefe;
	border: 1px solid #888;
	border-radius: 10px;
	font-size: 1rem;
	text-align: right;
}

#modalform {
	margin: 12px;
	text-align: left;
	
}

</style>

<script>  
	
	//경기날짜 담은 배열
	const gameDates = [ 
	    // gamedate 배열의 각 요소를 JavaScript 배열에 추가
	    <c:forEach var="date" items="${gamedate}">
	    	"${date.substring(0, 5)}", // 각 날짜를 따옴표로 묶어서 배열에 추가
	    </c:forEach>
	];
	
	const start_modifiedGameDates = [];
	const end_modifiedGameDates = [];
	
	// 년도 포함한 경기날짜 배열(2023-10-17)
	gameDates.forEach(date => {
    const [month, day] = date.split(".");
    const year = (month === "01" || month === "02" || month === "03") ? "2024" : "2023";
    const modifiedGameDate = year + "-" + month + "-" + day;
    
    start_modifiedGameDates.push(modifiedGameDate);     
    
    const [yearStr, monthStr, dayStr] = modifiedGameDate.split('-');
    const newyear = parseInt(yearStr, 10);
    const newmonth = parseInt(monthStr, 10);
    const newday = parseInt(dayStr, 10);

    const newmodifiedGameDate = new Date(newyear, newmonth - 1, newday);
    
    newmodifiedGameDate.setDate(newmodifiedGameDate.getDate() + 2);
    
    const formattednewmodifiedGameDate = newmodifiedGameDate.toISOString().split('T')[0]; //날짜 개체를 ISO 문자열로 변환한 다음 "YYYY-MM-DD 형식의 날짜 부분을 추출

    end_modifiedGameDates.push(formattednewmodifiedGameDate);     
	});

	console.log(start_modifiedGameDates);
	console.log(end_modifiedGameDates);
	
	const gamelist = []; // game Date형 배열
	const game5Minuslist = []; // game5일전 Date형 배열
	const game3Minuslist = []; // game5일전 Date형 배열
	
	// 년도 포함한 경기 5일전 날짜 배열(2023-10-13)
	const modifiedgameMinusDates = start_modifiedGameDates.map(date => {
		const [yearStr, monthStr, dayStr] = date.split('-'); 
	     
		const year = parseInt(yearStr, 10); //parseInt(string, radix(진수)) 문자열 분석하고 정수로 변환
	    const month = parseInt(monthStr, 10);
	    const day = parseInt(dayStr, 10);

		  for(let i = 0; i < start_modifiedGameDates.length; i++){
			  
	          const [yearStr, monthStr, dayStr] = start_modifiedGameDates[i].split('-');
	          
	          const year = parseInt(yearStr, 10);
	          const month = parseInt(monthStr, 10);
	          const day = parseInt(dayStr, 10);

	          const gamelistDate = new Date(year, month - 1, day);
	          gamelist.push(gamelistDate);
	          
	          const game3MinusDate = new Date(gamelistDate.getFullYear(), gamelistDate.getMonth(), (gamelistDate.getDate()-1));  
	          const formattedDate3 = game3MinusDate.toISOString().split('T')[0]; //날짜 개체를 ISO 문자열로 변환한 다음 "YYYY-MM-DD 형식의 날짜 부분을 추출
	          game3Minuslist.push(formattedDate3)
	          
	          const game5MinusDate = new Date(gamelistDate.getFullYear(), gamelistDate.getMonth(), (gamelistDate.getDate()-3));      
	          const formattedDate5 = game5MinusDate.toISOString().split('T')[0]; //날짜 개체를 ISO 문자열로 변환한 다음 "YYYY-MM-DD 형식의 날짜 부분을 추출
	          game5Minuslist.push(formattedDate5);
		  }  
	});
	
	
    document.addEventListener('DOMContentLoaded', function() { 
    	
      const calendarEl = document.getElementById('calendar');
      
   	  // 일정 그려주기
      const events = [];

      for (let i = 0; i < start_modifiedGameDates.length; i++) {
          const goldmember = {
              id: `event${i}`,
              title: start_modifiedGameDates[i].substring(5,start_modifiedGameDates[i].length) + ' 경기 예매',
              start: game5Minuslist[i],
              end: end_modifiedGameDates[i], // end의 날짜 전날까지 입력 일정이 들어가!
              allDay: true, // event가 하루 종일인지 여부
              backgroundColor: "#fbf3ee",
              textColor: 'black',
              extendedProps: {
                  comment: ''
              }
          };

          events.push(goldmember);
          
          const silvermember = {
                  id: `event${i}`,
                  title: start_modifiedGameDates[i].substring(5,start_modifiedGameDates[i].lengthS) + ' 경기 예매',
                  start: game3Minuslist[i],
                  end: end_modifiedGameDates[i],
                  allDay: true,
                  backgroundColor: "#fad8d7",
                  textColor: 'black',
                  extendedProps: {
                      comment: ''
                  }
              };

          events.push(silvermember);
      }
      const Modal = document.querySelector("#Modal");
      
      const calendar = new FullCalendar.Calendar(calendarEl, {  

      	headerToolbar: { // 헤더 설정
      		left: 'prev',
        		center: 'title',
        		right: 'today next'
      	},
      	// locale: 'ko',
        initialView: 'dayGridMonth',
        fixedWeekCount: false,
        events: events,
       	eventClick : function(eventInfo) { // 이벤트 클릭
       		Modal.style.display = "block";
       	
       		// 클릭한 이벤트의 정보 가져오기
            const eventTitle = eventInfo.event.title.substring(0,6);
       		
       		console.log(eventTitle);

            // 모달에 정보 넣기
            document.getElementById('eventTitle').textContent = eventTitle;
	  	}
     });  
     calendar.render();  
   });  
    
    // 모달 닫기
    function fMClose() {
        Modal.style.display = "none";
    }
    
</script>
</head>

<body>
	<div id="Modal">
        <div id="cont">
    	   <button onclick="fMClose()" class="mt-3 mr-5">X</button><br>	        	
	       <div id="modalform">
	            <label for="date">경기일</label><div id="eventTitle"></div><br>
	            <a href="https://kovo.co.kr/KOVO/ticket/ticket-buy?ticket=%EC%97%AC%EC%9E%90%EB%B6%80" target="_blank">예매하기</a><br>
	            <!-- 하루종일 <input type="checkbox" id="allDay"><br> -->
	            <!-- 배경색<input type="color" id="schBColor" value=""> -->
        	</div>
        </div>
    </div>
	<div id='calendar'></div>
<!--     <div><span class="gold"></span>gold 회원</div>
	<div><span class="silver"></span>silver 회원</div>   --> 
</body>

</html>