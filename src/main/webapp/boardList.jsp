<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ include file="common/header.jsp" %>

<section>
<div class="search-area">
    <form action="boardList.do" method="get">
        <select name="type">
            <option value="title" ${param.type == 'title' ? 'selected' : ''}>제목</option>
            <option value="category" ${param.type == 'category' ? 'selected' : ''}>카테고리</option>
            <option value="all" ${param.type == 'all' ? 'selected' : ''}>제목+카테고리</option>
            <option value="author" ${param.type == 'author' ? 'selected' : ''}>저자</option>
            <option value="content" ${param.type == 'content' ? 'selected' : ''}>내용</option>
        </select>

        <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어 입력">

<select name="sort" onchange="this.form.submit()">
    <option value="time" ${currentSort == 'time' || empty currentSort ? 'selected' : ''}>최신순</option>
    <option value="view" ${currentSort == 'view' ? 'selected' : ''}>조회수 높은순</option>
    <option value="title" ${currentSort == 'title' ? 'selected' : ''}>상품명순</option>
</select>

        <button type="submit">검색</button>
        <input type="hidden" name="include" value="${param.include}">
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

<c:set var="queryParam" value="type=${param.type}&keyword=${param.keyword}&category=${param.category}&sort=${currentSort}&include=${param.include}" />

<div class="paging">
    <c:if test="${pageMaker.prev}">
        <a href="?page=${pageMaker.startPage - 1}&${queryParam}">[이전]</a>
    </c:if>

    <c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
        <a href="?page=${i}&${queryParam}"
           class="${pageMaker.criteria.page == i ? 'current-page' : ''}">
            ${i}
        </a>
    </c:forEach>

    <c:if test="${pageMaker.next}">
        <a href="?page=${pageMaker.endPage + 1}&${queryParam}">[다음]</a>
    </c:if>
</div>
</section>
<%@ include file="common/footer.jsp"%>