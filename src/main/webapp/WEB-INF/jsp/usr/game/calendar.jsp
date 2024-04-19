<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="CALENDAR"></c:set>

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
	padding: 5px;
	padding-bottom: 10px;
}

.form {
	margin: 30 auto;
	max-width: 900px;
	height: 700px;
}

/* 달력 헤더 */

.calendar-header {
	margin-bottom: 24px;
	display:flex;
	justify-content: space-between;
	align-items: center;
	height: 42px;
}

button {
	width: 30px;
	height: 30px;
	padding: 3px 3px;
	font-size: 13px;
	cursor: pointer;
	background-color: #800808;
	border-radius: 4px;
	color: white;
}

h2 { 
    font-size: 1.75em;
    font-weight: 600;
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
}

#calendar {
	height: 634px;
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

.game {
	width: auto;
	height: 30px;
	margin-top: 10px;
	padding: 10px;
	display: flex;
	align-items: center;
	justify-content: space-around;
	font-size: 0.8rem;
}

.info {
	width: auto;
	height: 50px;
	margin-top: 20px;
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 0 15px;
}

.info a {
	border: 1.5px solid rgba(102, 100, 100);
	border-radius: 10%;
	padding: 0 10px;
	font-size: 13px;
	display: inline-block; /* inline 요소를 block 요소로 변경 */
    text-align: center; /* 가운데 정렬 */
}

#gameresult {
	padding-right: 3px;
}

.info a:hover {
	background-color: rgba(125, 10, 0);
	color: white;
}

.gameimg {
	display: flex;
	align-items: center;
	justify-content: space-around;
	height: 60px;
	color: black;
	padding: 0 3px;
	margin-top: 5px;
	font-size: 8px;
	color: white;
}

.gameimg img {
	background-color: rgb(255, 255, 255, 0.5);
	border-radius: 30%;
	width: 35px;
	height: 35px;
	margin-top: 3px;
}

.myModal {
	display: none;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%); /* 요소를 부모 요소의 정중앙으로 이동 */
	width: 300px;
	padding: 30px;
	border: 1px solid #888;
	border-radius: 10px;
	font-size: 1rem;
	/* background-color: white; */
	/* background-image: url('https://img.freepik.com/premium-vector/woman-volleyball-player-tosses-ball-to-score-goal-for-opposing-team-during-tournament-or-training_160308-6892.jpg'); */
	background-image: linear-gradient(rgba(255,255,255,0.4), rgba(255,255,255,0.4)), url('https://github.com/ohyo555/my_project_03/assets/153146836/c4813f71-d123-43e4-a04a-c1f9fbd17e91');
	/* background-image: url('https://images.unsplash.com/photo-1593115379577-a21ea97d6645?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8JUVCJUIwJUIwJUVBJUI1JUFDJUVBJUIzJUI1fGVufDB8fDB8fHww'); */
	background-size: cover;
    background-position: center;
}

#hometeamscore {
	text-align: center;
	margin-top: 3px;
}

#otherteamscore {
	text-align: center;
	margin-top: 3px;
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

#myModal .modal_close_btn {
	position: absolute;
	top: 5px;
	right: 20px;
	cursor: pointer; /* 추가: 마우스 포인터 모양 변경 */
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

	<div id="myModal" class="myModal">
		<div id="modal-content">
			<span class="modal_close_btn" onclick="closeModal()">&times;</span>
			<div class="game">
				<div>
					<div id="hometeam" class = "text-sm font-bold"></div>
					<div id="hometeamscore" class = "font-bold"></div>
				</div>
				<div class = "text-sm font-extrabold">VS</div>
				<div>
					<div id="otherteam" class = "text-sm font-bold"></div>
					<div id="otherteamscore" class = "font-bold"></div>
				</div>
			</div>
			<div class="info">
				<a href="" target="_blank" id="gameresult" class = "font-bold">경기결과&nbsp;&nbsp;&nbsp;</a> 
				<a href="" target="_blank" id="gamehighlight" class = "font-bold">하이라이트</a>
			</div>
			<!-- 필요에 따라 모달에 더 많은 내용을 추가하세요 -->
		</div>
	</div>

	<div class="form">
		<div class="calendar-header">
		    <button onclick="prevMonth()">◀</button>
		    <h2 id="currentMonth">간단한 달력</h2>
		    <button onclick="nextMonth()">▶</button>
  		</div>
  	
		<table id="calendar">
			<thead>
				<tr>
					<th class="sunday">Sun</th>
					<th>Mon</th>
					<th>Tue</th>
					<th>Wen</th>
					<th>Thu</th>
					<th>Fri</th>
					<th class="saturday">Sat</th>
				</tr>
			</thead>
			<tbody id="calendarBody"></tbody>
	
		</table>

		<a href="../game/gamelist">list</a>
	</div>

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
      
      while (currentDay <= lastDayOfMonth) {
        const weekRow = document.createElement("tr");
        
        /* 현재 월의 모든 날짜 */ 
        const allDatesOfMonth = getAllDatesOfMonth(currentDate.getMonth(), currentDate.getFullYear());
     
        for (let i = 0; i < 7; i++) {
          const dayCell = document.createElement("td");
          dayCell.textContent = currentDay.getDate();
       
          if (currentDay.getMonth() !== currentDate.getMonth()) {
            dayCell.classList.add("other-month"); // 현재 월의 날짜인지 여부를 체크
          }
          
          if (isToday(currentDay)) { // 오늘 날짜에 대한 표시
              dayCell.classList.add("highlight");
          }

          if (isGameToday(currentDay, allDatesOfMonth, gameDates)) {

        	 for(let i = 0; i < scheduleData.length; i++){
        		 // const modalContent = document.getElementById("modal-content");
        		 const formatcurrentDay = getFormattedDate(currentDay);
        		 const formatcurrentDayYear = getFormattedDateYear(currentDay);
        		 if(formatcurrentDay == scheduleData[i].date){
        		  const gameimg = document.createElement("div");
               	  gameimg.classList.add("gameimg"); // div의 클래스명을 지정해줘
               	  dayCell.appendChild(gameimg);

               	  // scheduleData[i].game에서 팀 이름 추출
               	  const gameInfo = scheduleData[i].game.split(" ");
               	  const team1 = gameInfo[0];
               	  const team2 = gameInfo[gameInfo.length - 1];
               	  const score = gameInfo[1] + "   :   " + gameInfo[3];
               	  const num = scheduleData[i].num;
               	  const round = scheduleData[i].round.substring(0,4);
               	 
               	  if (scheduleData[i].stadium === "대전충무체육관") {
              			  dayCell.classList.add("highlight2");
              		  } else {
              			  dayCell.classList.add("highlight3");
              		  }
               	  
               	  // 홈 팀
               	  const firstChildDiv = document.createElement("div");
               	  firstChildDiv.textContent = team1;
               	  firstChildDiv.classList.add("gameteam1");
               	  gameimg.appendChild(firstChildDiv);
               	
              	  const team1Image = document.createElement("img");
              	  team1Image.src = GameTeamInfo(team1); // 팀 1 이미지의 경로를 지정해줘
               	  team1Image.alt = team1; // 대체 텍스트로 팀 1 이름을 설정해줘
               	  firstChildDiv.appendChild(team1Image);
              	    
               	  // VS
               	  const vs = document.createElement("div");
               	  vs.textContent = "VS";
               	  vs.classList.add("vs");
               	  gameimg.appendChild(vs);
               	  
               	  // 원정 팀
               	  const secondChildDiv = document.createElement("div");
               	  secondChildDiv.textContent = team2;
               	  secondChildDiv.classList.add("gameteam2");
               	  gameimg.appendChild(secondChildDiv);

               	  const team2Image = document.createElement("img");
               	  team2Image.src = GameTeamInfo(team2); // 팀 2 이미지의 경로를 지정해줘
               	  team2Image.alt = team2; // 대체 텍스트로 팀 2 이름을 설정해줘
               	  secondChildDiv.appendChild(team2Image);
               	  
               	  // score
               	  const scoreresult = document.createElement("div");
               	  scoreresult.textContent = score;
               	  scoreresult.classList.add("scoreresult");
               	  dayCell.appendChild(scoreresult);

               	  dayCell.addEventListener("click", function () {
  	        	  	openModal('myModal'); // 복제된 날짜 객체를 전달
  	        	  	setmodal(team1, team2, score, num, round, formatcurrentDayYear);
	  	          });
            	 }

        	 }
        	
        	}

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
          "January", "February", "March", "April", "May", "June",
          "July", "August", "September", "October", "November", "December"
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
    
    function isGameToday(currentDate, allDatesOfMonth, gameDates) { // 경기 있는 날
        const formattedCurrentDate = getFormattedDate(currentDate);
        
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
    

/* 모달 기능 */
    function openModal(id) {
	
    	var zIndex = 999;
        const modal = document.getElementById(id);
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
           zIndex: 10000,
	
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
      
      function setmodal(team1, team2, score, num, round, formatcurrentDayYear){
    	 const hometeam = document.getElementById("hometeam");
    	 const otherteam = document.getElementById("otherteam");
    	 const hometeamscore = document.getElementById("hometeamscore");
    	 const otherteamscore = document.getElementById("otherteamscore");
    	 const gameresult = document.getElementById("gameresult");
    	 const gamehighlight = document.getElementById("gamehighlight");
    	 
    	 let gameresultLink = "https://kovo.co.kr/redsparks/game/v-league/" + num + "?season=020&gPart=201&gender=%EC%97%AC%EC%9E%90%EB%B6%80&first=%EC%9D%BC%EC%A0%95+%EB%B0%8F+%EA%B2%B0%EA%B3%BC";

    	 // 경기결과 링크
    	 if(round != "V-리그"){
    		 gameresultLink = "https://kovo.co.kr/redsparks/game/v-league/" + num + "?season=020&gPart=202&gender=%EC%97%AC%EC%9E%90%EB%B6%80&first=%EC%9D%BC%EC%A0%95+%EB%B0%8F+%EA%B2%B0%EA%B3%BC";
    	 }
    	 
    	 // 하이라이트 영상 링크
    	 let gamehighlightLink = "https://kovo.co.kr/redsparks/media/media-video?third=%EA%B2%BD%EA%B8%B0%EB%B3%84&date=" + formatcurrentDayYear;

    	 hometeam.textContent = team1;
    	 otherteam.textContent = team2;
    	 gameresult.href = gameresultLink;
    	 gamehighlight.href = gamehighlightLink;
    	 
    	 const modalscore = score.split("   :   ");

    	// 경기결과
    	 if(modalscore[0] == 3){
    		 hometeamscore.textContent = "승"
        	 hometeamscore.style.color = "red";
        	 otherteamscore.textContent = "패"
        	 otherteamscore.style.color = "black";
    		 const winIcon = document.createElement("i");
    	     winIcon.classList.add("fas", "fa-trophy"); 
    	     winIcon.style.color = "gold";
    	     winIcon.style.paddingLeft = "3px";
    	     hometeamscore.appendChild(winIcon);
    	     otherteamscore.classList.remove("shake-effect");
    	     hometeamscore.classList.add("shake-effect");   
    	 } else if(modalscore[1] == 3){
    		 hometeamscore.textContent = "패"
    		 hometeamscore.style.color = "black";
        	 otherteamscore.textContent = "승"
        	 otherteamscore.style.color = "red";
        	 const winIcon = document.createElement("i");
             winIcon.classList.add("fas", "fa-trophy");
             winIcon.style.color = "gold";
             winIcon.style.paddingLeft = "3px";
             otherteamscore.appendChild(winIcon);
             hometeamscore.classList.remove("shake-effect"); 
             otherteamscore.classList.add("shake-effect"); 
    	 } 
    	
    	 // if()
    	 
      }
    // 최초 로딩 시 달력 표시
    displayCalendar();
  </script>

</body>
</html>


<%@ include file="../common/foot.jspf"%>