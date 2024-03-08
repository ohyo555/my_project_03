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

.post-container {
	max-width: 800px;
	margin: 20px auto;
	background-color: #fff;
	padding: 20px;
}

.post-header {
	border-bottom: 1px solid #ccc;
	padding-bottom: 10px;
	margin-bottom: 20px;
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

.post-actions {
	margin-top: 10px;
}

.like-btn, .dislike-btn {
	background-color: #3498db;
	color: #fff;
	padding: 8px 12px;
	border: none;
	cursor: pointer;
	margin-right: 10px;
}

.content {
	line-height: 5; /* 글꼴 크기의 배수 */
	height: 40%;
}


/* 댓글 */
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
			$('#likeButton').toggleClass('btn-outline');
		}else if(isAlreadyAddBadRp == true){
			$('#DislikeButton').toggleClass('btn-outline');
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
					var DislikeButton = $('#DislikeButton');
					var DislikeCount = $('#DislikeCount');
					
					if(data.resultCode == 'S-1'){
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
					}else if(data.resultCode == 'S-2'){
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
					}else {
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
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
	
	
	
	function doBadReaction(articleId) {
		
	 $.ajax({
			url: '/usr/reactionPoint/doBadReaction',
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
					var DislikeButton = $('#DislikeButton');
					var DislikeCount = $('#DislikeCount');
					
					if(data.resultCode == 'S-1'){
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
					}else if(data.resultCode == 'S-2'){
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
		
					}else {
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
					}
			
				}else {
					alert(data.msg);
				}
			},
			error: function(jqXHR,textStatus,errorThrown) {
				alert('싫어요 오류 발생 : ' + textStatus);
			}
			
		});
	}
	
	$(function() {
		checkRP();
	});
	
	/* 댓글 좋아요 */
		function doGoodCommentReaction(articleId, commentId) {
		
		$.ajax({
			url: '/usr/reactionPoint/doGoodCommentReaction',
			type: 'POST',
			data: {relTypeCode: 'comment', relId: articleId, Id: commentId},
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
					
					if(data.resultCode == 'S-1'){
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
					}else if(data.resultCode == 'S-2'){
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
					}else {
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
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
	function toggleModifybtn(commentId) {
		$('#modify-btn-'+commentId).hide();
		$('#save-btn-'+commentId).show();
		$('#comment-'+commentId).hide();
		$('#modify-form-'+commentId).show();
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

	<div class="post-container">
		<div class="post-header">
<%-- 			<h1>${article.type }</h1> --%>
			<div class="post-meta">
				<div style="display: flex; justify-content: space-between;">
				<!-- ${article.id }${goodRP}${badRP} 글번호 -->
					<p class = "p-1">${article.type }</p>
					<p class = "p-1" >조회 ${article.hitCount } / ${article.formattedUpdateDate }</p>
				</div>
				<div style="display: flex; justify-content: space-between; align-items: center;">
					<p class = "p-1 text-4xl" style = "font-weight: bold;">${article.title }</p>
					<p class = "p-1 h-7" >${article.loginId }(${article.userLevel })</p>
				</div>
			</div>
		</div>

		<div class="post-actions">
			<button id="likeButton" class="btn btn-outline btn-success" onclick="doGoodReaction(${param.id})">▲</button>
			<button id="DislikeButton" class="btn btn-outline btn-error" onclick="doBadReaction(${param.id})">▼</button>
			<span>Likes: ${article.goodReactionPoint }</span> <span>Dislikes: ${article.badReactionPoint }</span>
		</div>

		<div class="content">
			<p>${article.body }</p>
			<!-- Add more content here -->
		</div>

		<div class="comment">
			<c:forEach var="comments" items="${comments }">
				<div class="chat chat-start">
					<div class="chat-image avatar">
						<div class="w-10 rounded-full">
							<img alt="Tailwind CSS Navbar component"
								src="https://health.chosun.com/site/data/img_dir/2023/07/17/2023071701753_0.jpg" />
						</div>
					</div>
					<div class="chat-header font-semibold">
						${comments.loginId }
						<time class="text-xs opacity-50">${comments.updateDate.substring(0,10) }</time>
					</div>
					<div class="commentbar">
						<span class="chat-bubble" id="comment-${comments.id }">${comments.comment }</span>
						<form method="POST" id="modify-form-${comments.id }" style="display: none;" action="/usr/comment/doModify">
							<input class="chat-bubble" type="text" value="${comments.comment }" name="comment-text-${comments.id }" />
						</form>
						<button id="likeButton" onclick="doCommentGoodReaction(${param.id},)" style="color: #e0316e"
							class="reaction text-xl">♡</button>
						<c:if test="${comments.goodReactionPoint > 0}">
							<div class="reaction" style="color: #e0316e">[${comments.sum }]</div>
						</c:if>
						<div>${CommentGoodCnt }</div>
						<c:if test="${comments.memberId == rq.loginedMemberId }">
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
			</c:forEach>
		</div>
	</div>



</body>
</html>

<%@ include file="../common/foot.jspf"%>