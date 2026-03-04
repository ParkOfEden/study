<!-- Tshirt.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<!-- ✅ Tomcat 버전에 맞는 URI 선택 -->
<%@ taglib prefix="c" uri="jakarta.tags.core" %>  
<!-- Tomcat 9 이하라면: uri="http://java.sun.com/jsp/jstl/core" -->

<%
    String keyword = request.getParameter("keyword");
    if (keyword != null) {
        keyword = new String(keyword.getBytes("ISO-8859-1"), "UTF-8");
    }
    request.setAttribute("pageTitle", "티셔츠");
%>    




<section class="main2 section-base">
	<h3>여기는 티셔츠 상품 페이지입니다.</h3>
	
	<!-- ✅ c:import 시작 태그와 닫는 태그 정확히 작성 -->
	<c:import url="/boardList.do">
	    <c:param name="type" value="category"/>
	    <c:param name="keyword" value="티셔츠"/>
	    <c:param name="include" value="table"/>
	</c:import>
	<!-- ✅ c:import 닫는 태그 필수 -->
	
<!-- 공백 출력 원인 1 : main2 class 중복 선언. 원인 2 : </section> 없이 <section> 사용. 원인 3 : 서블릿 없이 JSP 직접 호출
<section class="main2">
	<div class="main2-inner">
		<div class="contents-wrapper">
			<h3>여기는 티셔츠 상품 페이지입니다.</h3>
		
			<jsp:include page="/boardTable.jsp">
			    <jsp:param name="type" value="category"/>
			    <jsp:param name="keyword" value="티셔츠"/>  
			</jsp:include>	
			
		</div>
	</div>
 -->
</section>

<%@ include file="/common/footer.jsp"%>