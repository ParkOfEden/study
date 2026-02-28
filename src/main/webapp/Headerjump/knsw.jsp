<!-- knsw.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 타이틀은 여기서 작업하면 반영됩니다. -->
<%
request.setAttribute("pageTitle", "니트 &amp; 스웨터");
%>       
<%@ include file="/common/header.jsp"%>
<!-- header.jsp에서 처리합니다.(중복코드)
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>
<body>
 -->

<!-- section 태그 내에서 관리하세요. (골격 구조 통일 - common.css 참조) -->

<section class="main2 section-base">
	<h3>여기는 니트 &amp; 스웨터 상품 페이지입니다.</h3>
</section>


<!-- footer.jsp에서 처리합니다.(중복코드)
</body>
</html>
 -->
<%@ include file="/common/footer.jsp"%>