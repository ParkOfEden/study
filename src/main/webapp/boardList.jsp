<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ include file="common/header.jsp" %>

<div class="search-area">
    <form action="boardList.do" method="get">
        
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

<c:choose>

    <c:when test="${param.include == 'grid'}">
        <jsp:include page="gridTable.jsp"/>
    </c:when>

    <c:otherwise>
        <jsp:include page="boardTableNew.jsp"/>
    </c:otherwise>

</c:choose>

<!-- 페이징 -->
<div class="paging">

    <c:if test="${pageMaker.prev}">
        <a href="?page=${pageMaker.startPage - 1}">[이전]</a>
    </c:if>

    <c:forEach var="i"
               begin="${pageMaker.startPage}"
               end="${pageMaker.endPage}">
        <a href="?page=${i}"
           class="${pageMaker.criteria.page == i ? 'current-page' : ''}">
            ${i}
        </a>
    </c:forEach>

    <c:if test="${pageMaker.next}">
        <a href="?page=${pageMaker.endPage + 1}">[다음]</a>
    </c:if>

</div>
</section>
<%@ include file="common/footer.jsp"%>

