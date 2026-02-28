<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/privacy.css">

<!--
<!DOCTYPE html>
<html> => html태그를 header.jsp에서 열기때문에 필요없습니다.
<head> => head태그를 header.jsp에서 열기때문에 필요없습니다.
<meta charset="UTF-8">
-->
<title>privacy</title>
<!--
<style>
※ 제발 여기에다가 전역 설정 하지마세요. ※ 
</style>
-->

<!-- 이 부분도 header.jsp에서 작업했기때문에 중복되는태그.
</head>

<body>
 -->
 
<div class="pv-section container">
<h1>개인정보처리방침</h1>

<p><strong>WOL♥CL</strong>은(는) 고객님의 개인정보를 중요시하며, 
「개인정보 보호법」을 준수하고 있습니다.</p>

<div class="pv-section policy-box">

<h3>제1조 (개인정보의 수집 항목)</h3>
<p>회사는 회원가입, 주문, 상담을 위해 다음과 같은 정보를 수집합니다.</p>
<p>- 이름, 아이디, 비밀번호</p>
<p>- 이메일, 휴대전화번호</p>
<p>- 배송지 주소</p>

<h3>제2조 (개인정보의 이용 목적)</h3>
<p>- 회원 관리 및 본인 확인</p>
<p>- 상품 배송 및 결제 처리</p>
<p>- 고객 문의 응대</p>

<h3>제3조 (보유 및 이용 기간)</h3>
<p>회원 탈퇴 시까지 보관하며, 전자상거래 관련 법령에 따라 일정 기간 보관할 수 있습니다.</p>

<h3>제4조 (개인정보의 제3자 제공)</h3>
<p>회사는 고객의 동의 없이 개인정보를 외부에 제공하지 않습니다.</p>

<h3>제5조 (개인정보 보호 조치)</h3>
<p>회사는 개인정보 보호를 위해 보안 시스템을 운영하고 있습니다.</p>

<h3>부칙</h3>
<p>본 방침은 2026년 2월 27일부터 시행됩니다.</p>

</div>

</div>

<%@ include file="common/footer.jsp" %>