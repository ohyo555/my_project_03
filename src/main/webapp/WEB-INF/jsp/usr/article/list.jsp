<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="#{board.code } ARTICLE LIST"></c:set>
<link rel="stylesheet" href="/resource/background.css" />
<%@ include file="../common/head.jspf"%>

<!-- flaticon 불러오기 -->
<link rel='stylesheet'
	href='https://cdn-uicons.flaticon.com/2.1.0/uicons-regular-rounded/css/uicons-regular-rounded.css'>

<style>
.board-container {
	max-width: 800px;
	margin: 0px auto;
	background-color: white;
	position: relative; /* relative position 설정 */
	margin-top: -20px;
}

section {
	justify-content: center;
	height:95%;
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
	padding: 10px;
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

.boardname {
	font-size: 1rem;
	font-weight: 600;
}

.articlecnt {
	margin-right: 320px;
}

form > button {
	border: 1.5px solid rgba(102, 100, 100);
	border-radius: 5px;
	font-size: 12px;
	padding: 0 15px;
	
}
form > button:hover {
	color: #800808;
	font-weight: 600;
}

/* 목록 바 스타일 */
.list-bar {
	width: 800px;
	margin: 0px auto;
	display: flex;
	justify-content: space-between;
	align-items: center;
	background-color: white;
	height: 30px;
	background-color: rgb(251, 243, 238);
	border-radius: 10px;
}

.article {
	width: 80px;
	height: 30px;
	margin: 0px auto;
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-size: 1rem;
	text-align: center;
}

.list {
	margin-top: 40px;
	height: 700px;
}
.myModal {
    display: none;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 350px;
    padding: 35px;
    border: 1px solid #888;
    border-radius: 10px;
    background-color: #fff;
    z-index: 10000;
}

.modal-content {
    position: relative;
}

.modal_close_btn {
    position: absolute;
    top: 5px;
    right: 20px;
    cursor: pointer;
}

.pw_modal {
	display: flex;
    align-items: center;
}

.pw_modal > input {
	font-size: 12px;
	height: 30px;
	margin-right: 5px;
	width: 60%;
}

.password_btn {
	border: 1.5px solid rgba(102, 100, 100);
	border-radius: 5px;
	font-size: 12px;
	padding: 5px 10px;
}
	
</style>

<script>
    function openModal(articleId) {
        var modal = document.getElementById('myModal');
        var inputPassword = document.getElementById('loginPw');
        inputPassword.value = ''; // 초기화
        inputPassword.dataset.articleId = articleId; // articleId 설정
        modal.style.display = 'block';

     	// 모달 열릴 때 articleId를 form의 hidden input에 설정
        var a = document.getElementById('id');
        a.value = articleId;
    }

    function closeModal() {
        var modal = document.getElementById('myModal');
        var inputPassword = document.getElementById('loginPw');
        inputPassword.value = ''; // 초기화
        
        modal.style.display = 'none';
    }
    
    document.addEventListener('DOMContentLoaded', function() {
        var links = document.querySelectorAll('a[href^="detail?id="]');
        links.forEach(function(link) {
            link.addEventListener('click', function(event) {
            	var articleId = this.getAttribute('href').match(/\d+$/)[0];
                var boardId = this.getAttribute('data-boardId');
                
                var inputPassword = document.getElementById('loginPw');
                //inputPassword.dataset.articleId = articleId;
                
                if (boardId === '3') {
                    event.preventDefault(); 
                    openModal(articleId); 
                }
            });
        });
    });
    
    function togglePasswordVisibility() {
        var passwordField = document.getElementById("loginPw");
        var toggleIcon = document.getElementById("toggleIcon");

        if (passwordField.type === "password") {
            passwordField.type = "text";
            toggleIcon.src = "https://github.com/ohyo555/my_project_03/assets/153146836/025eaaf9-aee2-483f-925a-bc884a7fe688";
        } else {
            passwordField.type = "password";
            toggleIcon.src = "https://github.com/ohyo555/my_project_03/assets/153146836/665f7e05-f73f-4491-a7df-c1f9f8ff74c4";
        }
    }
</script>


<form action="../article/doAction" method="POST">
	<div id="myModal" class="myModal">
		<input id ="id" type="hidden" name="id" value="" />
	      <span class="modal_close_btn" onclick="closeModal()">&times;</span>
	      <div class="pw_modal">
	      	  <img class="w-5 h-5 mr-1" src="https://github.com/ohyo555/my_project_03/assets/153146836/6ee187e0-bdeb-4920-96e6-1800fd12fe8b">
		      <input id="loginPw" name="loginPw" type="password" placeholder="비밀번호를 입력해주세요." class="input input-bordered w-full max-w-xs" style=""/>
		      <button class="password_btn mr-3" type="submit">입력</button>
		      <button type="button" id="passwordToggleBtn" onclick="togglePasswordVisibility()">
              <img id="toggleIcon" class="w-4 h-4" src="https://github.com/ohyo555/my_project_03/assets/153146836/025eaaf9-aee2-483f-925a-bc884a7fe688">
              </button>
	      </div>
	</div>
</form>

<section class="text-xl px-4">
	<input type="hidden" name="id" value="${article.id }" />
	<div class="list mx-auto overflow-x-auto">
	
		<c:set var="article1" value=""/>
		<c:set var="article2" value=""/>
		<c:set var="article3" value=""/>
		<c:set var="article4" value=""/>

		<c:choose>
		    <c:when test="${board.id == 1}">
		        <c:set var="article1" value="font-weight: bold; color:#800808;"/>
		    </c:when>
		    <c:when test="${board.id == 2}">
		        <c:set var="article2" value="font-weight: bold; color:#800808;"/>
		    </c:when>
		    <c:when test="${board.id == 3}">
		        <c:set var="article3" value="font-weight: bold; color:#800808;"/>
		    </c:when>
		    <c:when test="${board.id == 4}">
		        <c:set var="article4" value="font-weight: bold; color:#800808;"/>
		    </c:when>
		</c:choose>
		
		<div class="list-bar">
			<a class="article article1" href="../article/list?boardId=1&page=1" style="${article1}">자유게시판</a>
			<a class="article article2" href="../article/list?boardId=2&page=1" style="${article2}">공지사항</a>
			<a class="article article3" href="../article/list?boardId=3&page=1" style="${article3}">질의응답</a>
			<a class="article article4" href="../article/list?boardId=4&page=1" style="${article4}">나의게시판</a>
			<a class="article" href="../article/write">글쓰기</a>
		</div>
		
		<div class="search-bar">
			<%-- <div class="boardname">${board.name}</div> --%>
			<div class="articlecnt badge badge-outline">${articlesCount }개</div>
			<form action="">
				<input type="hidden" name="boardId" value="${param.boardId }" /> <select class="text-sm mr-3"
					name="searchKeywordTypeCode">
					<option value="title" ${searchKeywordTypeCode.equals("title") ? 'selected="selected"' : '' }>제목</option>
					<option value="body" ${searchKeywordTypeCode.equals("body") ? 'selected="selected"' : '' }>내용</option>
					<option value="memberId" ${searchKeywordTypeCode.equals("memberId") ? 'selected="selected"' : '' }>작성자</option>
				</select> <input value="${param.searchKeyword }" type="text" placeholder="검색어를 입력하세요" class="input input-bordered mr-3"
					style="font-size: 12px; height: 30px;" name="searchKeyword" />
				<button type="submit" style="background-color: rgba(255, 255, 255, 0.5)">검색</button>
			</form>
		</div>
		<div class="board-container">
			<table>
				<colgroup>
					<col style="width: 10%" />
					<c:if test="${board.id == 4}">
						<col style="width: 10%" />
					</c:if>
					<col style="width: 20%" />
					<col style="width: 40%" />
					<col style="width: 10%" />
					<col style="width: 10%" />
					<c:if test="${board.id == 3}">
						<col style="width: 10%" />
					</c:if>
				</colgroup>

				<thead>
					<tr>
						<th>번호</th>
						<c:if test="${board.id == 4}">
							<th>구분</th>
						</c:if>
						<th>날짜</th>
						<th>제목</th>
						<th>작성자</th>
						<th>조회수</th>
						<c:if test="${board.id == 3}">
							<th>답변</th>
						</c:if>
					</tr>
				</thead>
				<tbody>

					<c:if test="${articles.size() == 0 }">
						<tr>
							<td colspan="7">게시글 없습니다.</td>
						</tr>
					</c:if>

					<c:forEach var="article" items="${articles }">
						<tr >
							<td>${article.id }</td>
							<c:if test="${board.id == 4}">
								<td>${article.type }</td>
							</c:if>							
							<td>${article.regDate.substring(0,10) }</td>
							<c:if test="${article.cnt == 0}">
								<td><a href="detail?id=${article.id }" data-boardId="${article.boardId }">${article.title }</a></td>
							</c:if>
							<c:if test="${article.cnt != 0}">
								<td><a href="detail?id=${article.id }" data-boardId="${article.boardId }">${article.title }</a>
									<div class="inline-block" style="color: #e0316e">[${article.cnt }]</div></td>
							</c:if>
							<td>${article.loginId }</td>
							<td class="article-detail__hit-count">${article.hitCount }</td>
							<c:choose>
								<c:when test="${board.id == 3 && article.cnt != 0}">
									<td>완료</td>
								</c:when>
								<c:when test="${board.id == 3 && article.cnt == 0}">
									<td>대기</td>
								</c:when>
							</c:choose>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<div class="pagination flex justify-center mt-3">
		<c:set var="paginationLen" value="2" />
		<c:set var="startPage" value="${page -  paginationLen  >= 1 ? page - paginationLen : 1}" />
		<c:set var="endPage" value="${page +  paginationLen  <= pagesCount ? page + paginationLen : pagesCount}" />

		<c:set var="baseUri" value="?boardId=${boardId }" />
		<c:set var="baseUri" value="${baseUri }&searchKeywordTypeCode=${searchKeywordTypeCode}" />
		<c:set var="baseUri" value="${baseUri }&searchKeyword=${searchKeyword}" />

		<c:if test="${startPage > 1 }">
			<a class="btn btn-sm" href="${baseUri }&page=1">1</a>
			<button class="btn btn-sm btn-disabled">...</button>
		</c:if>

		<c:forEach begin="${startPage }" end="${endPage }" var="i">
			<a class="btn btn-sm ${param.page == i ? 'btn-active' : '' }" href="${baseUri }&page=${i }">${i }</a>
		</c:forEach>

		<c:if test="${endPage < pagesCount }">
			<button class="btn btn-sm btn-disabled">...</button>
			<a class="btn btn-sm" href="${baseUri }&page=${pagesCount }">${pagesCount }</a>
		</c:if>
	</div>

	</form>
</section>



<%@ include file="../common/foot.jspf"%>