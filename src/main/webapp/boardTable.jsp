<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

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

