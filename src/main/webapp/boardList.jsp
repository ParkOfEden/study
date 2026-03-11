<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ include file="common/header.jsp" %>

<section>
<div class="search-area">
    <form action="boardList.do" method="get">
        
        <select name="type">
            <option value="title"
            	${param.type == 'title' ? 'selected' : ''}>제목</option>
            <option value="category"
            	${param.type == 'category' ? 'selected' : ''}>카테고리</option>
            <option value="all"
            	${param.type == 'all' ? 'selected' : ''}>제목+카테고리</option>
         	<option value="author"
         		${param.type == 'author' ? 'selected' : ''}>저자</option>
    		<option value="content"
    			${param.type == 'content' ? 'selected' : ''}>내용</option>
        </select>
		<!-- 검색 후에도 값 유지 -->
        <input type="text" name="keyword" 
               value="${param.keyword}" 
               placeholder="검색어 입력">

        <button type="submit">검색</button>
    </form>
</div>

<c:choose>

    <c:when test="${param.include eq 'grid'}">
        <jsp:include page="gridTable.jsp"/>
    </c:when>

    <c:otherwise>
        <jsp:include page="boardTableNew.jsp"/>
    </c:otherwise>

</c:choose>

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
<br><br><br>
<<<<<<< HEAD
<!-- 확인용
<span style="color:red;">
pageMaker.startPage : ${pageMaker.startPage}	<br>
pageMaker.endPage : ${pageMaker.endPage}		<br>
pageMaker.total : ${pageMaker.totalCount}	<br>
=======

>>>>>>> branch 'master' of https://github.com/ParkOfEden/study.git
</span>
 -->
</div>
</section>
<%@ include file="common/footer.jsp"%>

