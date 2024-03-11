<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MEMBER JOIN"></c:set>
<%@ include file="../common/head.jspf"%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="/resource/background.css" />
<style>

.signup-form {
	width: 400px; 
	background-color: rgba(255, 255, 255, 0.4);
	margin: 100px auto;
	padding: 20px;
	border-radius: 8px;
	overflow-x: auto;
	overflow-y: auto;
	}

.signup-form .form{
	text-align: center;
}

.signup-form .text{
	font-size: 0.7rem;
	text-align: right; /* 오른쪽 정렬 추가 */
    margin-left: -5rem;
    color: #a32222;
    position: relative; /* 상대 위치 설정 */
}


.signup-form div {
	display: inline-block;
	width: 100%;
	font-size: 1rem;
}

.signup-form label {
	width: 20%;
	display: inline-block;
}

.signup-form div .msg {
	display: inline;
	color: #800808;
	font-size: 0.75rem;
}

.signup-form input {
	padding: 5px;
	margin-bottom: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}

.signup-form button {
	background-color: #800808;
	color: white;
	padding: 10px 15px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 0.75rem;
}

.signup-form button:hover {
	background-color: #260301;
}

.signup-form .form-check-label {
    width: 90px;
    height: 15px; /* 원하는 크기로 설정하세요 */
    margin: 0; /* 기본 마진 제거 */
}

/* 안내문구 */

.signup-form .info {
	font-size: 0.75rem;
	color: #a32222;
	text-align: left; /* 오른쪽 정렬 추가 */
	padding-left: 42px;
}

.signup-form .cellphoneNum {
	margin-bottom: 0px;
}

/* 주소 */
#extraAddress {
	width: 100px;
}
</style>

<script>
$(function() {
    $("#birthdate").datepicker({
        changeMonth: true,
        changeYear: true,
        yearRange: 'c-100:c+0'
    });
});
</script>

<script>
	function callByAjax(loginId) {
		
		var form = document.form1;
		
		var action = "../member/doAction";
		var loginId = form.loginId.value;
		
		$.get(action, {
			loginId : loginId,
		}, function(data) {
			$('.msg').text(data);
		}, 'html');
		
	}
</script>

<script>
// 골드 등급일 경우 골드 라디오 버튼에 체크 설정
 var membershipLevel = ${member.authLevel};

    // 골드 등급일 경우 골드 라디오 버튼에 체크 설정
    function setMembershipCheckbox() {
        // 해당 등급에 맞는 라디오 버튼 찾기
        var radioButtons = document.getElementsByName('level');
        for (var i = 0; i < radioButtons.length; i++) {
            if (radioButtons[i].value == membershipLevel) {
                radioButtons[i].checked = true;
            }
        }
    }

    var alertMessage = "${alertMessage}";
    if (alertMessage) {
        alert(alertMessage);
    }
    
// 페이지 로딩 시 실행 (예시)
window.onload = setMembershipCheckbox;
</script>
<body>
	

<section class="mt-8 text-xl px-4">
	<div class="signup-form">
		<form class="form" name="form1" action="../member/doMembership" method="POST">
			<div class="text">*는 필수정보</div>
			<div>
				<label for="username">*아이디:</label> <input type="text" id="loginId" name="loginId" autocomplete="off" value="${member.loginId }" readonly>
			</div>
			<div>
				<label for="name">*이름:</label> <input type="text" id="mname" name="mname" autocomplete="off" value="${member.mname }" required>
			</div>
			<div>
				<label for="cellphoneNum">*전화번호:</label> <input class = "cellphoneNum" type="tel" id="cellphoneNum" name="cellphoneNum" autocomplete="off" value="${member.cellphoneNum }" required>
			</div>
			<div class = "info">※ -없이 숫자만 입력가능합니다.</div>
			<div>
				<label for="email">*이메일:</label> <input type="email" id="email" name="email" autocomplete="off" value="${member.email }" required>
			</div>
			<div>
				<label for="address">*주소: </label> 
				<input type="text" class = "w-20" id="postcode" name="postcode" value="${member.postcode }" placeholder="우편번호"> 
				<input type="button" onclick="execDaumPostcode()" value="찾기"><br>
				<label for="address"></label> 
				<input type="text" id="address" name="address" placeholder="주소" value="${member.address }"><br>
				<label for="address"></label> 
				<input type="text" class = "w-25" id="detailAddress" name="detailAddress" placeholder="상세주소"><br>
				<label for="address"></label> 
				<input type="text" class = "w-20" id="extraAddress" name="extraAddress" placeholder="참고항목">

				<script>
				    function execDaumPostcode() {
				        new daum.Postcode({
				            oncomplete: function(data) {
				                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				
				                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
				                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				                var addr = ''; // 주소 변수
				                var extraAddr = ''; // 참고항목 변수
				
				                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				                    addr = data.roadAddress;
				                } else { // 사용자가 지번 주소를 선택했을 경우(J)
				                    addr = data.jibunAddress;
				                }
				
				                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				                if(data.userSelectedType === 'R'){
				                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
				                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
				                        extraAddr += data.bname;
				                    }
				                    // 건물명이 있고, 공동주택일 경우 추가한다.
				                    if(data.buildingName !== '' && data.apartment === 'Y'){
				                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				                    }
				                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				                    if(extraAddr !== ''){
				                        extraAddr = ' (' + extraAddr + ')';
				                    }
				                    // 조합된 참고항목을 해당 필드에 넣는다.
				                    document.getElementById("extraAddress").value = extraAddr;
				                
				                } else {
				                    document.getElementById("extraAddress").value = '';
				                }
				
				                // 우편번호와 주소 정보를 해당 필드에 넣는다.
				                document.getElementById('postcode').value = data.zonecode;
				                document.getElementById("address").value = addr;
				                // 커서를 상세주소 필드로 이동한다.
				                document.getElementById("detailAddress").focus();
				            }
				        }).open();
				    }
				</script>
			</div>
			<div>
				<label for="level">*등급:</label>
		        <input type="radio" id="gold" name="level" class="form-check-input" value="1" required>
		        <label for="open" class="form-check-label mr-5 text-base">골드</label>
		        <input type="radio" id="silver" name="level" class="form-check-input" value="2" required>
		        <label for="open" class="form-check-label text-base mr-5">실버</label>
			</div>
			<div class="center-text mt-5">
				<button type="submit">멤버쉽 가입</button>
				<button type="button" onclick="history.back();">뒤로가기</button>
			</div>
		</form>

	</div>
</section>

</body>

<%@ include file="../common/foot.jspf"%>