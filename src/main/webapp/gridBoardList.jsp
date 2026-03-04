<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!-- 타이틀은 여기서 작업하면 반영됩니다. -->
<c:set var="pageTitle" value="상품 관리 목록" />
  

<%@ include file="common/header.jsp" %>

<section class="section-container">


     
<h2 class="board-title">전체 게시글 목록 
<c:if test="${sessionScope.authUser eq 'admin'}">
<span style="color: gray;
			 font-weight: bold;">
(Admin)
</span>
</c:if>
</h2>

<div class="write-area">
<c:if test="${sessionScope.authUser eq 'admin'}">
	<a href="boardWrite.jsp">[새 상품 등록]</a>
</c:if>
</div>

<div class="search-area">
    <form action="${pageContext.request.contextPath}/boardList.do" method="get">
        
        <select name="type">
            <option value="title"
            	${param.type == 'title' ? 'selected' : ''}>제목</option>
            <option value="category"
            	${param.type == 'category' ? 'selected' : ''}>카테고리</option>
            <option value="all"
            	${param.type == 'all' ? 'selected' : ''}>제목+카테고리</option>
        </select>
		<!-- 검색 후에도 값 유지 -->
        <input type="text" name="keyword" 
               value="${param.keyword}" 
               placeholder="검색어 입력">

        <button type="submit">검색</button>
    </form>
</div>

<jsp:include page="gridTable.jsp" />

<!-- 페이징 -->
<div class="paging">

    <c:if test="${pageMaker.prev}">
        <a href="?page=${pageMaker.startPage - 1}&type=${param.type}&keyword=${param.keyword}">[이전]</a>
    </c:if>

    <c:forEach var="i"
               begin="${pageMaker.startPage}"
               end="${pageMaker.endPage}">
        <a href="?page=${i}&type=${param.type}&keyword=${param.keyword}"
           class="${pageMaker.criteria.page == i ? 'current-page' : ''}">
            ${i}
        </a>
    </c:forEach>

    <c:if test="${pageMaker.next}">
        <a href="?page=${pageMaker.endPage + 1}&type=${param.type}&keyword=${param.keyword}">[다음]</a>
    </c:if>

</div>
</section>
<%@ include file="common/footer.jsp"%>