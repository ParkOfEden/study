<!-- Tshirt.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>  
<%@ include file="/common/header.jsp"%>
<!-- ✅ Tomcat 버전에 맞는 URI 선택 -->
<!-- Tomcat 9 이하라면: uri="http://java.sun.com/jsp/jstl/core" -->

<%
String keyword = "티셔츠";
request.setAttribute("keyword", keyword);
%>

<section class="product-page">
	<div class="product-inner">
	<h3 class="product-title fade-message">"${keyword}" 검색 결과입니다.</h3>
	
	<!-- ✅ jsp:include 시작 태그와 닫는 태그 정확히 작성 -->
	
	<jsp:include page="/gridTable.jsp">
	    <jsp:param name="type" value="category"/>
	    <jsp:param name="keyword" value="티셔츠"/>
	    <jsp:param name="include" value="table"/>
	</jsp:include>
	<!-- ✅ jsp:include 닫는 태그 필수 -->
	</div>
</section>

<%@ include file="/common/footer.jsp"%>