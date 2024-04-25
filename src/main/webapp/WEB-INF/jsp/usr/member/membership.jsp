<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MEMBERSHIP"></c:set>
<%@ include file="../common/head.jspf"%>

<!-- 주소 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 결제 api -->
<script src="https://js.tosspayments.com/v1/payment"></script>

<link rel="stylesheet" href="/resource/background.css" />
<style>

.signup-form {
	width: 350px; 
	background-color: rgba(255, 255, 255, 0.4);
	margin: 100px auto;
	padding: 20px;
	border-radius: 8px;
	}

form {
	text-align: center;
}

.signup-form .text{
	font-size: 0.7rem;
	margin-left: 13rem;
	color: #a32222;
}

.signup-form div {
	display: inline-block;
	width: 100%;
	font-size: 1rem;
	text-align: left;
}

.signup-form div:last-child {
	text-align: center;
	padding-right: 40px;
}

.signup-form label {
	width: 22%;
	display: inline-block;
}

.signup-form div .msg {
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
	padding-left: 70px;
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

function makePayment() {
    var clientKey = "test_ck_GjLJoQ1aVZbJQKJRZAAlVw6KYe2R";
    var tossPayments = TossPayments(clientKey);

    var amount = 0;
    var level = document.querySelector('input[name="level"]:checked').value;

    var orderName = null;
    var customerName = document.getElementById('mname').value;
    
    if (level === "1") { // Gold membership
        amount = 100000;
        orderName = "Gold membership";
    } else if (level === "2") { // Silver membership
        amount = 70000;
        orderName = "Silver membership";
    }
    
    tossPayments.requestPayment("카드", {
        amount: amount,
        orderId: "CtaMgVA6Dxw9X7hanNsLY",
        orderName: orderName,
        customerName: customerName
    }).then(function () {
    	 document.getElementById("membershipForm").submit();
    }).catch(function (error) {
        // Handle payment error
        console.error("Payment error:", error);
        // Optionally, display an error message to the user
        alert("결제가 실패했습니다. 잠시 후 다시 시도해주세요.");
    });
}

</script>

<script>
/* 라디오 버튼 */
document.addEventListener("DOMContentLoaded", function () {
	var membershipLevel = ${member.authLevel};

    function setMembershipCheckbox() {
        // 해당 등급에 맞는 라디오 버튼 찾기
        var radioButtons = document.getElementsByName('level');
        for (var i = 0; i < radioButtons.length; i++) {
            if (radioButtons[i].value == membershipLevel) {
                radioButtons[i].checked = true;
            }
        }
	    document.getElementById("membershipForm").addEventListener("submit", function (event) {
	        // Prevent default form submission behavior
	        event.preventDefault();
	        // Initiate payment process
	        makePayment();
	    });
	}
    
 // 페이지 로딩 시 실행 (예시)
    window.onload = setMembershipCheckbox;
});

/* 이름 클릭 */
 document.addEventListener("DOMContentLoaded", function() {
	 
        var goldlabel = document.getElementById("goldlabel");
        var goldradio = document.getElementById("gold");
        var silverlabel = document.getElementById("silverlabel");
        var silverradio  = document.getElementById("silver");

        goldlabel.addEventListener('click', function() {
        	goldradio.checked = true;
        });
        silverlabel.addEventListener('click', function() {
        	silverradio.checked = true;
        });
        
    });
</script>

<!-- <script>

	var clientKey = "test_ck_GjLJoQ1aVZbJQKJRZAAlVw6KYe2R";
	var tossPayments = TossPayments(clientKey);
	document.addEventListener("DOMContentLoaded", function () {
	const button = document.getElementById("membershipjoin");
	button.addEventListener("click", function () {
	  // ------ 결제창 띄우기 ------
	  console.log("!!!!!!!!!!!!!!!!!!!!!!!!");
	  tossPayments
	    .requestPayment("카드", {
	      // 결제수단 파라미터 (카드, 계좌이체, 가상계좌, 휴대폰 등)
	      // 결제 정보 파라미터
	      // 더 많은 결제 정보 파라미터는 결제창 Javascript SDK에서 확인하세요.
	      // https://docs.tosspayments.com/reference/js-sdk
	      amount: 100, // 결제 금액
	      orderId: "CtaMgVA6Dxw9X7hanNsLY", // 주문번호(주문번호는 상점에서 직접 만들어주세요.)
	      orderName: "테스트 결제", // 구매상품
	      customerName: "김토스", // 구매자 이름
	      successUrl: "https://docs.tosspayments.com/guides/payment/test-success", // 결제 성공 시 이동할 페이지(이 주소는 예시입니다. 상점에서 직접 만들어주세요.)
	      failUrl: "https://docs.tosspayments.com/guides/payment/test-fail" // 결제 실패 시 이동할 페이지(이 주소는 예시입니다. 상점에서 직접 만들어주세요.)
	    })
	    .then(function () {
        // If payment is successful, manually submit the form
        document.form1.submit();
      	})
	    // ------결제창을 띄울 수 없는 에러 처리 ------
	    // 메서드 실행에 실패해서 reject 된 에러를 처리하는 블록입니다.
	    // 결제창에서 발생할 수 있는 에러를 확인하세요.
	    // https://docs.tosspayments.com/reference/error-codes#결제창공통-sdk-에러
	    .catch(function (error) {
	      if (error.code === "USER_CANCEL") {
	        // 결제 고객이 결제창을 닫았을 때 에러 처리
	      } else if (error.code === "INVALID_CARD_COMPANY") {
	        // 유효하지 않은 카드 코드에 대한 에러 처리
	      }
	    });
	});
	});

</script>
 -->
<body>
	

<section class="mt-8 text-xl px-4">
	<div class="signup-form">
		<form class="form" id="membershipForm" name="form1" action="../member/doMembership" method="POST">
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
				<label for="address">*주소:</label> <input type="text" class="w-20" id="postcode" name="postcode" placeholder="우편번호">
				<input type="button" onclick="execDaumPostcode()" value="찾기"><br> <label for="address"></label> <input
					type="text" id="address" name="address" placeholder="주소"><br> <label for="address"></label> <input
					type="text" class="w-25" id="detailAddress" name="detailAddress" placeholder="상세주소"><br> <label
					for="address"></label> <input type="text" class="w-20" id="extraAddress" name="extraAddress" placeholder="참고항목">

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
		        <label for="open" class="form-check-label mr-5 text-base" id="goldlabel">골드</label>
		        <input type="radio" id="silver" name="level" class="form-check-input" value="2" required>
		        <label for="open" class="form-check-label text-base mr-5" id="silverlabel">실버</label>
			</div>
			<div class="center-text mt-5">
				<button type="submit" id="membershipjoin">멤버쉽 가입</button>
				<button type="button" onclick="history.back();">뒤로가기</button>
			</div>
		</form>

	</div>
</section>

</body>

<%@ include file="../common/foot.jspf"%>