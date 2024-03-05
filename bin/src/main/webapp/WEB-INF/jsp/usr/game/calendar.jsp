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
      background-color: white;
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

  <script>
    function displayCalendar(date) {
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

          if (currentDay.getMonth() !== currentDate.getMonth()) {
            dayCell.classList.add("other-month");
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

    function prevMonth() {
      const currentDate = new Date();
      currentDate.setMonth(currentDate.getMonth() - 1);
      displayCalendar(currentDate);
    }

    function nextMonth() {
      const currentDate = new Date();
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

    // 최초 로딩 시 달력 표시
    displayCalendar();
  </script>

</body>
</html>

<%@ include file="../common/foot.jspf"%>