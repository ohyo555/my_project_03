<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="#{board.code } schedule LIST"></c:set>
<link rel="stylesheet" href="/resource/background.css" />
<%@ include file="../common/head.jspf"%>

<!-- flaticon 불러오기 -->
<link rel='stylesheet'
	href='https://cdn-uicons.flaticon.com/2.1.0/uicons-regular-rounded/css/uicons-regular-rounded.css'>

 <style>

		html, body {
		    overflow: hidden; /* 스크롤 비활성화 */
		}
		
        .board-container {
            max-width: 850px;
            margin: 0px auto;
            background-color: white;
			position: relative; /* relative position 설정 */
			margin-top: -20px;
        }
		
		section {
			justify-content:center;
			height: 800px;
		}
		
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

		tr {
		    font-size: 13px; /* tr 안의 글자 크기 조절 */
		}

		/* 테이블 헤더,셀의 스타일 */
        th, td {
            padding: 5px;
            text-align: center;
            border-bottom: 1px solid #ddd; 
        }

		/* 테이블 헤더 스타일 */
        th {
            background-color: #f2f2f2;
        }
        
      	/* 검색창 스타일 */
		form {
		    margin: 10px;
		    display: flex;
		    align-items: center;
		    padding-bottom: 0;
		}

		/* 검색 바 스타일 */
		.search-bar {
            width: 800px;
            margin: 0px auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .list {
        	margin-top: 20px;
        	height: 750px;
        	width: 900px;
        	background-color: white;
        }

</style>

<section class="text-xl px-4">
	<input type="hidden" name="id" value="${schedule.id }" />
	<div class="list mx-auto overflow-x-auto" style="overflow-x: auto;"> <!--  style="overflow-x: auto;" 가로로 오버플로우되면 수평스크롤 생김 -->
		<div class="board-container">
		<table>
			<colgroup>
				<col style="width: 11%" />
				<col style="width: 4%" />
				<col style="width: 10%" />
				<col style="width: 20%" />
				<col style="width: 13%" />
				<col style="width: 13%" />
				<col style="width: 12%" />
				<col style="width: 17%" />
			</colgroup>
			
			<thead>
				<tr>
					<th>날짜</th>
	                <th>경기번호</th>
	                <th>시간</th>
	                <th>경기</th>
	                <th>경기장</th>
	                <th>중계일정</th>
	                <th>라운드</th>
	                <th>정보</th>
				</tr>
			</thead>
			<tbody>

				<c:if test="${schedules.size() == 0 }">
					<tr>
						<td colspan="7">게시글 없습니다.</td>
					</tr>
				</c:if>

				<c:forEach var="schedule" items="${schedules }">
					<tr class="hover">
						<td>${schedule.date }</td>
						<td>${schedule.num }</td>
						<td>${schedule.time }</td>
						<td>${schedule.game }</td>
						<td>${schedule.gym }</td>
						<td>${schedule.broadcasting }</td>
						<td>${schedule.round }</td>
						<td>${schedule.info }</td>
					</tr>
				</c:forEach>
			</tbody>
			</table>
		</div>
	</div>

	</form>
</section>



<%@ include file="../common/foot.jspf"%>