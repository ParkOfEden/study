<!-- Tshirt.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>  
<%-- <%@ include file="/common/header.jsp"%> --%>
<!-- ✅ Tomcat 버전에 맞는 URI 선택 -->
<!-- Tomcat 9 이하라면: uri="http://java.sun.com/jsp/jstl/core" -->

<section class="main2 section-base">
	<div class="main2-inner">
	<h3>여기는 티셔츠 상품 페이지입니다.</h3>
	
	<!-- ✅ jsp:include 시작 태그와 닫는 태그 정확히 작성 -->
	
	<jsp:include page="/boardTableNew.jsp">
	    <jsp:param name="type" value="category"/>
	    <jsp:param name="keyword" value="티셔츠"/>
	    <jsp:param name="include" value="table"/>
	</jsp:include>
	<!-- ✅ jsp:include 닫는 태그 필수 -->
	</div>
</section>

<%-- <%@ include file="/common/footer.jsp"%> --%>