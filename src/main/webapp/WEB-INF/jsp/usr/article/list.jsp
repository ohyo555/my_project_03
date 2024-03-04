<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="#{board.code } ARTICLE LIST"></c:set>
<link rel="stylesheet" href="/resource/background.css" />
<%@ include file="../common/head.jspf"%>

 <style>

        .board-container {
            max-width: 800px;
            margin: 0px auto;
            background-color: white;
			position: relative; /* relative position 설정 */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd; 
        }

        th {
            background-color: #f2f2f2;
        }
        
      /* 검색창 스타일 */
		form {
		    margin: 10px;
		    display: flex;
		    align-items: center;
		}

		.search-bar {
            width: 800px;
            margin: 0px auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

</style>

<section class="mt-3 text-xl px-4">
	<input type="hidden" name="id" value="${article.id }" />
	<div class="mx-auto overflow-x-auto">
		<div class="search-bar">
		    <div class="badge badge-outline">${articlesCount }개</div>
	        <form action="">
	            <input type="hidden" name="boardId" value="${param.boardId }" /> 
	            <select class="text-sm mr-3" name="searchKeywordTypeCode">
	                <option value="title" ${searchKeywordTypeCode.equals("title") ? 'selected="selected"' : '' }>제목</option>
	                <option value="body" ${searchKeywordTypeCode.equals("body") ? 'selected="selected"' : '' }>내용</option>
	                <option value="extra__writer" ${searchKeywordTypeCode.equals("extra__writer") ? 'selected="selected"' : '' }>작성자</option>
	            </select> 
	            <input value="${param.searchKeyword }" type="text" placeholder="검색어를 입력하세요" class="input input-bordered mr-3" style="font-size: 12px; height: 30px;" name="searchKeyword" />
	            <button class="btn btn-sm btn-outline" type="submit">검색</button>
	        </form>
		</div>
		<div class="board-container">
		<table>
			<thead>
				<tr>
					<th>번호</th>
	                <th>날짜</th>
	                <th>제목</th>
	                <th>작성자</th>
	                <th>조회수</th>
				</tr>
			</thead>
			<tbody>

				<c:if test="${articles.size() == 0 }">
					<tr>
						<td colspan="7">게시글 없어</td>
					</tr>
				</c:if>

				<c:forEach var="article" items="${articles }">
					<tr class="hover">
						<td>${article.id }</td>
						
						<c:if test="${article.cnt == 0}">
							<td><a href="detail?id=${article.id }">${article.title }</a></td>
						</c:if>
						<td>${article.regDate.substring(0,10) }</td>
						<c:if test="${article.cnt != 0}">
							<td><a href="detail?id=${article.id }">${article.title }</a>
							<div class="inline-block" style="color: #e0316e">[${article.cnt }]</div></td>
						</c:if>
						<td>${article.memberId }</td>
						<td>${article.hitCount }</td>
					</tr>
				</c:forEach>
			</tbody>
			</table>
		</div>
	</div>
	<div class="pagination flex justify-center mt-3">
		<c:set var="paginationLen" value="3" />
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