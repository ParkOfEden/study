<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!-- 타이틀은 여기서 작업하면 반영됩니다. -->
<%
request.setAttribute("pageTitle", "상품 관리 목록");
%>  

<%@ include file="common/header.jsp" %>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/boardList.css">
      
<h2>전체 게시글 목록 
<c:if test="${sessionScope.authUser == 'admin'}">
<span style="color: gray;
			 font-weight: bold;">
(Admin)
</span>
</c:if>
</h2>

<div style="text-align: right;">
<c:if test="${sessionScope.authUser == 'admin'}">
	<a href="boardWrite.jsp">[새 상품 등록]</a>
</c:if>
</div>

<table class="board-table">
    <thead>
        <tr>
            <th>번호</th>
            <th>카테고리</th> <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>조회수</th>
        <c:if test="${sessionScope.authUser == 'admin'}">
            <th>관리</th>
        </c:if>
        </tr>
    </thead>
    <tbody>
    	<c:choose>
    		<c:when test="${empty boardList}">
	        	<tr>
	            	<td colspan="7">등록된 게시글이 없습니다.</td>
	            </tr>
            </c:when>
            
            <c:otherwise>
            	<c:forEach var="b" items="${boardList}">
            		<tr>
			            <td>${b.num}</td>
			            
			            <td>[${b.category}]</td>
            
            			<td style="text-align:left;">
            				<a href="boardDetail.jsp?num=${b.num}">
            					${b.title}
            				</a>
            			</td>
            			
			            <td>${b.author}</td>
			            
			            <td>${b.createdAt}</td>
			            
			            <td>${b.viewCount}</td>
		            
		            <c:if test="${sessionScope.authUser == 'admin'}">
                        <td>
                            <a href="boardUpdateForm.do?num=${b.num}">수정</a>
                            |
                            <a href="boardDelete.do?num=${b.num}"
                               onclick="return confirm('삭제하시겠습니까?');">
                                삭제
                            </a>
                        </td>			            
    				</c:if>		
    				
   				</tr>
        	</c:forEach>
    	</c:otherwise>
   	</c:choose>
    </tbody>
</table>

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

<%@ include file="common/footer.jsp"%>