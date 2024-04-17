<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAP"></c:set>
<%@ include file="../common/head.jspf"%>
<link rel="stylesheet" href="/resource/background.css" />

<html lang='en'>  
<head>  
  <meta charset='utf-8' />  
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js'></script>  
  
  <style>
  /* 달력 */
  	#calendar {
  		height: 80%;
  		margin: 5% 10%;
  	}
  	
  	
  	.fc-button {
  		background-color: rgb(251, 243, 238);
  	}
  	
	.fc-scroller::-webkit-scrollbar-track {
	   -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
	   border-radius: 10px;
	   background-color: rgb(255, 255, 255);
	}
	
	.fc-scroller::-webkit-scrollbar {
	    width: 12px;
	    background-color: #f2ede2;
	}
	
	.fc-scroller::-webkit-scrollbar-thumb {
	    border-radius: 10px;
	    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
	    background-color: rgb(251, 243, 238);
	}
  </style>

  <script>  
  
    document.addEventListener('DOMContentLoaded', function() { 
    	
      const calendarEl = document.getElementById('calendar');
  
      const calendar = new FullCalendar.Calendar(calendarEl, {  
    	headerToolbar: { // 헤더 설정
    		left: 'prev',
      		center: 'title',
      		right: 'next today'
    	},
        initialView: 'dayGridMonth',  
        events:[  
          {  
            "id": "common001",  
            "title": "휴가",  
            "start": "2024-01-02",  
            "end": "2024-01-05",  
            "allDay": true,  
            "backgroundColor":"pink",  
            "textColor":"black",  
            "extendedProps": {  
              "comment": "쉼"  
            }  
          },  
          {  
            "id": "common001",  
            "title": "글라스",  
            "start": "2024-01-26",  
            "end": "2024-01-26",  
            "allDay": true,  
            "backgroundColor":"lightblue",  
            "textColor":"black",  
            "extendedProps": {  
              "comment": "쉼"  
            }  
          },  
          {  
            "id": "common001",  
            "title": "산책가기",  
            "start": "2024-01-27",  
            "end": "2024-01-27",  
            "allDay": true,  
            "backgroundColor":"lightyellow",  
            "textColor":"black",  
            "extendedProps": {  
              "comment": "쉼"  
            }  
          },
          {  
              "id": "common001",  
              "title": "산책가기", 
              "start": "2024-04-02",  
              "end": "2024-04-17",  
              "allDay": true,  
              "backgroundColor":"lightpink",  
              "textColor":"black",  
              "extendedProps": {  
                "comment": "쉼"  
              }  
            },
            {  
                "id": "common001",  
                "title": "공부하기",  
                "start": "2024-04-02",  
                "end": "2024-04-05",  
                "allDay": true,  
                "backgroundColor":"lightblue",  
                "textColor":"black",  
                "extendedProps": {  
                  "comment": "쉼"  
                }  
              }
        ]  
      });  
      calendar.render();  
    });  
  
  </script>  
</head>  
<body>  
<div id='calendar'></div>  
</body>  
</html>