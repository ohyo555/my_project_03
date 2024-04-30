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
	max-width: 1000px;
	margin: 10px auto 0 auto;
	padding: 0 10px;
}

.backbutton {
	width: 60px;
	height: 30px;
	text-align: center;
	padding: 0 3px;
	font-size: 12px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.writebutton:hover {
	color:white;
	background-color: black;
}

.option {
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.post-container {
	max-width: 1000px;
	margin: 0 auto;
	background-color: #fff;
	padding: 10px;
}

/* 파일업로드 */
.filebox .upload-name {
    display: inline-block;
    height: 40px;
    padding: 0 10px;
    vertical-align: middle;
    border: 1px solid #ccc;
	border-radius: 10px;
    width: 30%;
    color: #999999;
}

.filebox label {
    display: inline-block;
    padding: 10px 15px;
    color: black;
    vertical-align: middle;
    background-color: rgb(251,243,238);
    border-radius: 10px;
    cursor: pointer;
    height: 40px;
    margin-left: 5px;
}

.filebox input[type="file"] {
    position: absolute;
    width: 0;
    height: 0;
    padding: 0;
    overflow: hidden;
    border: 0;
}

</style>

<!-- Article write 관련 -->
<script>
$(document).ready(function() { //DOM이 준비되지 않음 -> 해결!
	$("#file").on('change',function(){
		 var fileName = $("#file").val();
		  $(".upload-name").val(fileName);
		});
});
	 
</script>

<script type="text/javascript">
	let ArticleWrite__submitFormDone = false;
	function ArticleWrite__submit(form) {
		
		if (ArticleWrite__submitFormDone) {
			return;
		}
		
		console.log('title: '+form.title.value);
		
		form.title.value = form.title.value.trim();
		if (form.title.value.length == 0) {
			alert('제목을 입력해주세요');
			return;
		}
		const editor = $(form).find('.toast-ui-editor').data(
				'data-toast-editor');
		const markdown = editor.getMarkdown().trim();
		if (markdown.length == 0) {
			alert('내용 써라');
			editor.focus();
			return;
		}
		$('#fileInput').attr('name', 'file__article__' + ${currentId} + '__extra__Img__1');
		
		form.body.value = markdown;
		ArticleWrite__submitFormDone = true;
		form.submit();
	}
</script>
</head>
<body>
	<div class="backbutton_div">
		<button class="backbutton btn-outline" onclick="history.back();">뒤로가기</button>
	</div>
		<form action="../article/doWrite" method="POST" onsubmit="ArticleWrite__submit(this); return false;"
			enctype="multipart/form-data">
			<input type="hidden" name=">${currentId }">
		<input type="hidden" name="body">
		<div class="post-container">
			<div style="display: flex; justify-content: space-between;">
				<div class="mb-5">
					<div class="option">
						<select class="text-base h-8" name="boardId">
							<option value="1">공지사항</option>
							<option value="2">자유게시판</option>
							<option value="3">질의응답</option>
						</select>
					<button class="backbutton writebutton btn-outline" type="submit" value="작성">작성</button>
					</div>
					<div class = "ml-1 mt-2">제목:  
						<input class="input input-bordered w-full max-w-xs mb-3" autocomplete="off" type="text"
								placeholder="제목을 입력해주세요" name="title" style="height:40px"/>
					</div>
					<div class = "filebox ml-1 mb-1">첨부 이미지:
						    <input class="upload-name" value="첨부파일" placeholder="첨부파일">
						    <label for="file" class="text-sm">파일찾기</label> 
						    <input type="file" id="file">
					</div>
					<div class="toast-ui-editor">
						<script type="text/x-template">
      </script>
					</div>
				</div>
			</div>
		</div>
	</form>

</body>
</html>

<%@ include file="../common/foot.jspf"%>