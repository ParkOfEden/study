<!-- best.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<!-- header.jsp에서 처리합니다.(중복코드)
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>
<body>
 -->
 
 <!-- 타이틀은 여기서 작업하면 반영됩니다. -->
 <%
 request.setAttribute("pageTitle", "베스트 상품");
 %>

<!-- section 태그 내에서 관리하세요. (골격 구조 통일 - common.css 참조) -->

<section class="main2 section-base">
	<h3>여기는 베스트 상품 페이지입니다.</h3>
</section>


<!-- footer.jsp에서 처리합니다.(중복코드)
</body>
</html>
 -->
<%@ include file="/common/footer.jsp"%>