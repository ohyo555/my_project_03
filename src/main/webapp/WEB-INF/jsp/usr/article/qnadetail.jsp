<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="ARTICLE WRITE"></c:set>
<link rel="stylesheet" href="/resource/background.css" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Post Detail</title>
<style>
body {
	font-family: 'Arial', sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f4f4f4;
}

.backbutton_div {
	max-width: 800px;
	margin: 10px auto 0 auto;
	padding: 0 10px;
}

.backbutton {
	width: 60px;
	height: 30px;
	text-align:center;
	padding:0 3px;
	font-size: 12px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.loginbutton {
	width: 60px;
	height: 30px;
	text-align:center;
	padding:5px;
	font-size: 12px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.post-container {
	max-width: 800px;
	margin: 0 auto;
	background-color: #fff;
	padding: 20px;
}

.post-header {
	border-bottom: 1px solid #ccc;
	padding-bottom: 5px;
	margin-bottom: 10px;
}

.post-header h1 {
	margin: 0;
	font-size: 24px;
	color: #333;
}

.post-meta {
	font-size: 14px;
	color: #777;
}

/* 좋아요 */
.post-actions {
	height: 30px;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.post-actions a:hover {
	color:red;
}

.like-btn {
	color: #fff;
	padding: 8px 12px;
	border: none;
	cursor: pointer;
	margin-right: 10px;
}

/* 내용 */
.content {
	margin: 10px;
	padding: 0 0 30px 0;
	border-bottom: 1px solid #ccc;
}

.content p {
	background-color: rgb(251, 243, 238);
	line-height: 5; /* 글꼴 크기의 배수 */
	padding: 0 30px;
	height: 40%;
}

/* 댓글 */
.comment {
	margin: 20px 10px 10px 10px;
}

.commentbar {
	width: 100%;
}

.commentbar ul {
	z-index: 2;
}

.commentbar>ul>li {
	margin-right: 0px;
	margin-left: auto;
	position: relative;
}

.chat {
	padding: 0px;
}

#member_img {
	display: inline-block;
	width: 50px; /* 원하는 너비로 설정 */
	height: 50px; /* 원하는 높이로 설정 */
	border-radius: 50%; /* 동그란 모양으로 설정 */
	background-image: url('${rq.loginedMember.image }'); /* 이미지 경로 설정 */
	background-size: cover; /* 배경 이미지를 커버로 설정 */
	background-position: center; /* 배경 이미지를 가운데 정렬 */
	background-repeat: no-repeat; /* 배경 이미지 반복 없음 */
	border: none; /* 테두리 없음 */
	cursor: pointer; /* 마우스 포인터 모양 변경 */
	margin: 3px 12px;
}

.c_option {
	display: flex;
	align-items: center;
	padding-right: 13px;
}
/* 댓글 수정/삭제 */
.option {
	margin-left: auto;

	/* position: absolute;
	right: 0; */
}

.option ul {
	margin-left: auto; /* 가장 오른쪽으로 이동하게 함 */

	/* position: absolute;
	right: 0;
	top: 0; */
}

.option ul>li:hover>ul>li>a {
	background-color: white;
	white-space: nowrap;
	padding: 5px;
	font-size: 1rem;
}

.option>ul ul {
	display: none;
	position: absolute;
}

.option ul>li:hover ul {
	display: block;
	cursor: pointer;
}

.option ul>li>ul>li:hover>a {
	color:red;
}
</style>

<!-- 변수 -->
<script>
	const params = {};
	params.id = parseInt('${param.id}');
	
	var isAlreadyAddGoodRp = ${isAlreadyAddGoodRp};
	var isAlreadyAddBadRp = ${isAlreadyAddBadRp};
</script>

<!-- 조회수 -->
<script>
	function ArticleDetail__doIncreaseHitCount() {
		const localStorageKey = 'article__' + params.id + '__alreadyView';

		if (localStorage.getItem(localStorageKey)) {
			return;
		}

		localStorage.setItem(localStorageKey, true);

		$.get('../article/doIncreaseHitCountRd', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json');
	}

	$(function() {
		// 		ArticleDetail__doIncreaseHitCount();
		setTimeout(ArticleDetail__doIncreaseHitCount, 2000);
	});
</script>

<!-- 좋아요 싫어요  -->
<script>
	<!-- 좋아요 싫어요 버튼	-->
	function checkRP() {
		if(isAlreadyAddGoodRp == true){
			$('#likeButton').html('♥');
		}else {
			return;
		}
	}


	function doGoodReaction(articleId) {
		
		$.ajax({
			url: '/usr/reactionPoint/doGoodReaction',
			type: 'POST',
			data: {relTypeCode: 'article', relId: articleId},
			dataType: 'json',
			success: function(data){
				console.log(data);
				console.log('data.data1Name : ' + data.data1Name);
				console.log('data.data1 : ' + data.data1);
				console.log('data.data2Name : ' + data.data2Name);
				console.log('data.data2 : ' + data.data2);
				if(data.resultCode.startsWith('S-')){
					var likeButton = $('#likeButton');
					var likeCount = $('#likeCount');
					/* var DislikeButton = $('#DislikeButton');
					var DislikeCount = $('#DislikeCount');
					 */
					if(data.resultCode == 'S-1'){
						if(data.msg == '좋아요!'){
							likeButton.html('♥');
							likeCount.text(data.data1);
						} else {
							likeButton.html('♡');
							likeCount.text(data.data1);
						}
					}
					
				}else {
					alert(data.msg);
				}
		
			},
			error: function(jqXHR,textStatus,errorThrown) {
				alert('좋아요 오류 발생 : ' + textStatus);

			}
			
		});
	}
	
	$(function() {
		checkRP();
	});
	
	/* 댓글 좋아요 */
	function doGoodCommentReaction(articleId) {
	
	$.ajax({
		url: '/usr/reactionPoint/doGoodReaction',
		type: 'POST',
		data: {relTypeCode: 'comment', relId: articleId},
		dataType: 'json',
		success: function(data){
			console.log(data);
			console.log('data.data1Name : ' + data.data1Name);
			console.log('data.data1 : ' + data.data1);
			console.log('data.data2Name : ' + data.data2Name);
			console.log('data.data2 : ' + data.data2);
			if(data.resultCode.startsWith('S-')){
				var clikeButton = $('#clikeButton');
				var clikeCount = $('#clikeCount');
				/* var DislikeButton = $('#DislikeButton');
				var DislikeCount = $('#DislikeCount');
				 */
				if(data.resultCode == 'S-1'){
					if(data.msg == '좋아요!'){
						clikeButton.html('♥');
						clikeCount.text(data.data1);
					} else {
						clikeButton.html('♡');
						clikeCount.text(data.data1);
					}
				}
				
			}else {
				alert(data.msg);
			}
	
		},
		error: function(jqXHR,textStatus,errorThrown) {
			alert('좋아요 오류 발생 : ' + textStatus);

		}
		
	});
}

</script>

<!-- 댓글 -->
<script>
		var CommentWrite__submitDone = false;
		function CommentWrite__submit(form) {
			if (CommentWrite__submitDone) {
				alert('이미 처리중입니다');
				return;
			}
			console.log(123);
			
			console.log(form.body.value);
			
			if (form.body.value.length < 3) {
				alert('댓글은 3글자 이상 입력해');
				form.body.focus();
				return;
			}
			CommentWrite__submitDone = true;
			form.submit();
		}
	</script>


<!-- 댓글 수정, 삭제 -->
<script>
	//댓글 수정 시 창 조정
	function resizeCommentInput(commentId) {
		// 너비와 높이를 설정할 input 요소의 ID
	    var widthInputId = 'comment-width-input-' + commentId;
	    // var heightInputId = 'comment-height-input-' + commentId;

	    // 입력된 값을 가져옵니다
	    var newWidth = $('#' + widthInputId).val() || '100%'; // 값이 입력되지 않은 경우 기본값은 '100%'
	    // var newHeight = $('#' + heightInputId).val() || '100%';

	    // 댓글 편집 입력 창의 ID를 선택합니다
	    var inputElement = $('#modify-form-' + commentId).find('input[name="comment-text-' + commentId + '"]');

	    // 댓글 편집 입력 창의 너비와 높이를 설정합니다
	    inputElement.width(newWidth);
	    // inputElement.height(newHeight);
	    
	 	// 입력 창의 텍스트가 너비를 초과하면 다음 줄로 줄바꿈되도록 설정
	    inputElement.css('white-space', 'normal');
	}

	function toggleModifybtn(commentId) {
		$('#modify-btn-'+commentId).hide();
		$('#save-btn-'+commentId).show();
		$('#comment-'+commentId).hide();
		$('#modify-form-'+commentId).show();
		
		// 크기 조절
	    resizeCommentInput(commentId);
	}

	
	function doModifyComment(commentId) {
		 console.log(commentId); // 디버깅을 위해 replyId를 콘솔에 출력
		    
		    // form 요소를 정확하게 선택
		    var form = $('#modify-form-' + commentId);
		    console.log(form); // 디버깅을 위해 form을 콘솔에 출력

		    // form 내의 input 요소의 값을 가져옵니다
		    var text = form.find('input[name="comment-text-' + commentId + '"]').val();
		    console.log(text); // 디버깅을 위해 text를 콘솔에 출력

		    // form의 action 속성 값을 가져옵니다
		    var action = form.attr('action');
		    console.log(action); // 디버깅을 위해 action을 콘솔에 출력
		
	    $.post({
	    	url: '/usr/comment/doModify', // 수정된 URL
	        type: 'POST', // GET에서 POST로 변경
	        data: { id: commentId, comment: text }, // 서버에 전송할 데이터
	        success: function(data) {
	        	$('#modify-form-'+commentId).hide();
	        	$('#comment-'+commentId).text(data);
	        	$('#comment-'+commentId).show();
	        	$('#save-btn-'+commentId).hide();
	        	$('#modify-btn-'+commentId).show();
	        },
	        error: function(xhr, status, error) {
	            alert('댓글 수정에 실패했습니다: ' + error);
	        }
		})
	}
</script>


</head>
<body>
	<div class="backbutton_div">
	<button class="backbutton btn-outline"  onclick="history.back();">뒤로가기</button>
	</div>
	<div class="post-container">
		<div class="post-header">
			<%-- 			<h1>${article.type }</h1> --%>
			<div class="post-meta">
				<div style="display: flex; justify-content: space-between;">
					<!-- ${article.id }${goodRP}${badRP} 글번호 -->
					<p class="p-1">${article.type }</p>
					<p class="p-1">조회 <span class = "article-detail__hit-count"> ${article.hitCount } / ${article.regDate.substring(0,10) }</p>
				</div>
				<div style="display: flex; justify-content: space-between; align-items: center;">
					<p class="p-1 text-4xl" style="font-weight: bold;">${article.title }</p>
					<p class="p-1 h-7">${article.loginId }(${article.userLevel })</p>
				</div>
			</div>
		</div>
		<!-- 좋아요, 수정, 삭제 -->
		<div class="post-actions">
		<div style="display: flex; align-items: center;">
			<button id="likeButton" class="btn btn-outline btn-error text-xl"
					style="border: none; background-color: transparent;" onclick="doGoodReaction(${param.id})">♡</button>			
			<div id="likeCount" class="text-xs">${article.goodReactionPoint }</div>
		</div>
			
			<div>
				<c:if test="${article.userCanModify }">
					<a class="btn btn-outline text-xs" style="border: none; background-color: transparent;" href="../article/modify?id=${article.id }">수정</a>
				</c:if>
				<c:if test="${article.userCanDelete }">
					<a class="btn btn-outline text-xs" style="border: none; background-color: transparent;" onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;"
						href="../article/doDelete?id=${article.id }">삭제</a>
				</c:if>
			</div>
		</div>

		<div class="content">
			<p>${article.body }</p>
			<!-- Add more content here -->
		</div>

		<!-- 등록된 댓글 -->
		<div class="comment">
			<div class="button mb-2">
				<button id = "asc" class="mr-2" onclick="asc();">등록순</button>
				<button id = "desc" onclick="desc();">최신순</button>
			</div>
			<c:forEach var="comments" items="${comments }">
				<!-- 각 댓글을 나타내는 부분 -->
				<div class="chat chat-start">
					<!-- 댓글 작성자의 이미지와 정보 -->
					<div class="chat-image avatar">
						<div class="w-10 rounded-full">
							<img alt="Tailwind CSS Navbar component" src="${comments.image }" />
						</div>
					</div>
					<!-- 댓글 작성자 정보와 작성 날짜 -->
					<div class="chat-header font-semibold">
						${comments.loginId }
						<time class="text-xs opacity-50">${comments.updateDate.substring(0,10) }</time>
					</div>
					<!-- 댓글 내용과 수정 폼, 리액션 옵션 -->
					<div class="commentbar">
						<span style="background-color: #777" class="chat-bubble" id="comment-${comments.id }">${comments.comment }</span>
						<form method="POST" id="modify-form-${comments.id }" style="display: none;" action="/usr/comment/doModify">
							<input class="chat-bubble" type="text" value="${comments.comment }" name="comment-text-${comments.id }" />
						</form>
						<!-- 좋아요 버튼과 리액션 정보 -->
						<div class="c_option">
							<button id="clickButton" onclick="doCommentGoodReaction(${param.id},)" style="color: #e0316e"
								class="reaction text-xl">♡</button>
							<c:if test="${comments.goodReactionPoint > 0}">
								<div class="reaction" style="color: #e0316e">[${comments.sum }]</div>
								<div id="clickCount" class="text-xs">${CommentGoodCnt }</div>
							</c:if>
							<c:if test="${comments.memberId == rq.loginedMemberId }">
								<!-- 수정 및 삭제 옵션 -->
								<nav class="option">
									<ul>
										<li><a class="hover:underline" href="#">···</a>
											<ul>
												<c:if test="${comments.userCanModify }">
													<li><a onclick="toggleModifybtn('${comments.id}');" style="white-space: nowrap;"
														id="modify-btn-${comments.id }">수정</a></li>
													<li><a onclick="doModifyComment('${comments.id}');" style="white-space: nowrap; display: none;"
														id="save-btn-${comments.id }">저장</a></li>
												</c:if>
												<c:if test="${comments.userCanDelete }">
													<li><a onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;"
														href="../comment/doDelete?id=${comments.id }">삭제</a></li>
												</c:if>
											</ul></li>
									</ul>
								</nav>
							</c:if>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>

		<!-- 댓글 등록 -->
		<c:choose>
            <c:when test="${rq.loginedMember.authLevel == 7}">
                <form action="../comment/doWrite" method="POST" onsubmit="ReplyWrite__submit(this); return false;">
				<input type="hidden" name="relTypeCode" value="article" /> <input type="hidden" name="relId" value="${article.id }" />
				<label class="form-control"> <!-- 회원정보 버튼 -->
					<div class="flex-none gap-2 m-3 ">
						<div class="form-control">
							<textarea name="comment" placeholder="댓글을 입력해주세요" class="textarea textarea-bordered h-24"></textarea>
						</div>
					</div>
					<button class="btn btn-outline m-3"  type="submit">댓글등록</button>
				</label>
			</form>
            </c:when>
            <c:when test="${!rq.isLogined() }">
                <div class = "backbutton_div">
				<a class="loginbutton btn-outline"  href="${rq.loginUri }">LOGIN</a> 후 이용해주세요.
				</div>
            </c:when>
            <c:when test="${rq.loginedMember.authLevel != 7}">
                &nbsp;&nbsp;&nbsp;관리자만 답변 가능합니다.
            </c:when>
         </c:choose>
	</div>



</body>
</html>

<%@ include file="../common/foot.jspf"%>