<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/customerService.css">

<title>customerService.jsp</title>

<!-- 
<style>
[CSS 규칙]

1. <style> 태그 사용 금지
2. 전역 선택자 사용 금지 (table, section, ul)
3. header.css / index.css / footer.css 에서만 관리
4. 클래스 prefix 사용

</style>
 
      
</head> => header.jsp 에서 head 닫으므로 불필요 => 쓰기 금지

<body> => header.jsp 에서 body 선언하므로 중복 => 쓰기 금지
-->

  	<h1>고객센터</h1>
    <p>WOL♥CL을 이용해주셔서 감사합니다 😊</p>
   
    <h3>📞 고객 상담 안내</h3>
    <p><strong>전화번호 :</strong> 051-1234-5678</p>
    <p><strong>운영시간 :</strong> 평일 09:00 ~ 18:00</p>
    <p><strong>점심시간 :</strong> 12:00 ~ 13:00</p>
    <p>※ 주말/공휴일 휴무</p>
    
    <h3>❓ 자주 묻는 질문</h3>

    <p><strong>Q. 배송 기간은 얼마나 걸리나요?</strong></p>
    <p>A. 결제 완료 후 평균 2~3일 소요됩니다.</p>

    <p><strong>Q. 교환/환불은 어떻게 하나요?</strong></p>
    <p>A. 상품 수령 후 7일 이내 고객센터로 문의해주세요.</p>

    <p><strong>Q. 배송비는 얼마인가요?</strong></p>
    <p>A. 3만원 이상 구매 시 무료배송입니다.</p>
    
    <br>
    <button id = "inquiryBtn">1:1 문의하기</button>
    
	<script>
	
	document.getElementById("inquiryBtn")
    .addEventListener("click", function() {
        location.href = "inquiry.jsp";
    });
	
	</script>    

<%@ include file="common/footer.jsp" %>