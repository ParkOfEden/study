<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>customerService.jsp</title>

<style>
body { padding:40px; font-family: Arial; }
h1 { border-bottom:2px solid black; padding-bottom:10px; }
button {
    padding:10px 20px;
    background-color:black;
    color:white;
    border:none;
    cursor:pointer;
}
button:hover { background-color:red; }
</style>
     
</head>

<body>

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
    <button onclick="location.href='inquiry.jsp'">1:1 문의하기</button>

</body>
</html>