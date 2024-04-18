<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAP"></c:set>
<%@ include file="../common/head.jspf"%>
<link rel="stylesheet" href="/resource/background.css" />

<html lang='en'>
<head>
<meta charset='utf-8' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js'></script>
<!-- tippy 사용을 위한 연결 -->
<script src='https://unpkg.com/@popperjs/core@2'></script>
<script src='https://unpkg.com/tippy@6'></script>

<style>
/* 달력 */
#calendar {
	height: 80%;
	margin: 3% 10%;
}

/* 헤더 버튼 */
.fc .fc-button-primary {
	background-color: #800808;
	border-style: none;
	padding: 3px;
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

/*  .fc-event-title-container {
  	border-style: none;
  	} */

.fc-event {
	margin-bottom: 5px;
}
/* 
.fc-event-main {
	padding-bottom: 10px;
}

.fc-event-main-frame {
	margin-bottom: 5px;
}

.fc-event-title-container {
	margin-bottom: 5px;
}
 */

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
</style>

<script>  
	
	//경기날짜 담은 배열
	const gameDates = [ 
	    // gamedate 배열의 각 요소를 JavaScript 배열에 추가
	    <c:forEach var="date" items="${gamedate}">
	    	"${date.substring(0, 5)}", // 각 날짜를 따옴표로 묶어서 배열에 추가
	    </c:forEach>
	];
	
	// 년도 포함한 경기날짜 배열(2023-10-17)
	const modifiedGameDates = gameDates.map(date => {
	    const [month, day] = date.split(".");
	    const year = (month === "01" || month === "02" || month === "03") ? "2024" : "2023";
	    const modifiedGameDate = year + "-" + month + "-" + day;
	    return modifiedGameDate;
	});
	
	const gamelist = []; // game Date형 배열
	const gameMinuslist = []; // game5일전 Date형 배열
	
	// 년도 포함한 경기 5일전 날짜 배열(2023-10-13)
	const modifiedGameMinusDates = modifiedGameDates.map(date => {
		const [yearStr, monthStr, dayStr] = date.split('-'); 
	     
		const year = parseInt(yearStr, 10); //parseInt(string, radix(진수)) 문자열 분석하고 정수로 변환
	    const month = parseInt(monthStr, 10);
	    const day = parseInt(dayStr, 10);

		  for(let i = 0; i < modifiedGameDates.length; i++){
			  
	          const [yearStr, monthStr, dayStr] = modifiedGameDates[i].split('-');
	          
	          const year = parseInt(yearStr, 10);
	          const month = parseInt(monthStr, 10);
	          const day = parseInt(dayStr, 10);
	          //console.log("year: " + year);
	          const gamelistDate = new Date(year, month - 1, day);
	          gamelist.push(gamelistDate);
	          console.log("gamelistDate: " + gamelistDate);
	          
	          const gameMinusDate = new Date(gamelistDate.getFullYear(), gamelistDate.getMonth(), (gamelistDate.getDate()-3));     
		  
	          const formattedDate = gameMinusDate.toISOString().split('T')[0]; //날짜 개체를 ISO 문자열로 변환한 다음 "YYYY-MM-DD 형식의 날짜 부분을 추출
	          gameMinuslist.push(formattedDate);
		  }
		
		  return gameMinuslist;	  
	});
	
	
    document.addEventListener('DOMContentLoaded', function() { 
    	
      const calendarEl = document.getElementById('calendar');

        const events = [];

        // Loop through modifiedDates and gameMinuslist arrays to populate events
        for (let i = 0; i < modifiedGameDates.length; i++) {
            const event = {
                id: `event${i}`,
                title: '예매하기',
                start: gameMinuslist[i],
                end: modifiedGameDates[i],
                allDay: true,
                backgroundColor: 'pink',
                textColor: 'black',
                extendedProps: {
                    comment: '골드회원 예매일'
                }
            };

            events.push(event);
        }
    	
        const calendar = new FullCalendar.Calendar(calendarEl, {  
        	headerToolbar: { // 헤더 설정
        		left: 'prev',
          		center: 'title',
          		right: 'today next'
        	},
            initialView: 'dayGridMonth',
            fixedWeekCount: false,
            events: events     
	      });  
	      calendar.render();  
	    });  
	  
</script>
</head>

<body>
	<div id='calendar'></div>
</body>

</html>