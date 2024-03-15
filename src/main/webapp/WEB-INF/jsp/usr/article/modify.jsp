<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="ARTICLE MODIFY"></c:set>
<link rel="stylesheet" href="/resource/background.css" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>

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

.option {
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.writebutton:hover {
	color: white;
	background-color: black;
}

.writebutton {
    margin-left: auto; /* 수정 버튼을 왼쪽 여백을 최대화하여 오른쪽으로 이동시킵니다. */
}

.post-container {
	max-width: 1000px;
	margin: 0 auto;
	background-color: #fff;
	padding: 10px;
}
</style>

<!-- Article modify 관련 -->
<script type="text/javascript">
	let ArticleModify__submitFormDone = false;
	function ArticleModify__submit(form) {
		if (ArticleModify__submitFormDone) {
			return;
		}
		form.title.value = form.title.value.trim();
		if (form.title.value == 0) {
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
		form.body.value = markdown;
		ArticleModify__submitFormDone = true;
		form.submit();
	}
</script>

<body>
	<div class="backbutton_div">
		<button class="backbutton btn-outline" onclick="history.back();">뒤로가기</button>
	</div>
	<form action="../article/doWrite" method="POST" onsubmit="ArticleWrite__submit(this); return false;">
		<input type="hidden" name="body">
		<div class="post-container">
			<div style="display: flex; justify-content: space-between;">
				<!-- ${article.id }${goodRP}${badRP} 글번호 -->
				<div class="mb-5">
					<div class="option">
						<div class="ml-1 mt-2 mb-1 flex">
							제목: <input class="input input-bordered w-full max-w-xs mb-3" autocomplete="off" type="text" value="${article.title}" name="title" style="height: 40px" />
    </div>
						<button class="backbutton writebutton btn-outline" type="submit" value="수정">수정</button>
					</div>
					<div class="ml-1 mt-2 mb-1">작성일: ${article.regDate.substring(0,10) }</div>
					<div class="ml-1 mt-2 mb-1">수정일: ${article.updateDate.substring(0,10) }</div>
				</div>
			</div>
			<div class="toast-ui-editor">
				<script type="text/x-template">${article.body } </script>
			</div>
		</div>
	</form>

</body>
</html>



<%@ include file="../common/foot.jspf"%>