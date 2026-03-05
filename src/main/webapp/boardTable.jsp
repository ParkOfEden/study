<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ include file="common/header.jsp" %>

boardList size : ${boardList.size()}
<br>
boardList : ${boardList}

<table class="board-table">
    <thead>
        <tr>
            <th>상품번호</th>
            <th>이미지</th> <th>카테고리</th> 
            <th>상품명</th>
            <th>판매가</th> <th>조회수</th>
        <c:if test="${sessionScope.authUser == 'admin'}">
            <th>관리</th>
        </c:if>
        </tr>
    </thead>
    <tbody>
    	<c:choose>
    		<c:when test="${empty boardList}">
	        	<tr>
	            	<td colspan="7">등록된 상품이 없습니다.</td>
	            </tr>
            </c:when>
            
            <c:otherwise>
            	<c:forEach var="b" items="${boardList}">
            		<tr>
			            <td>${b.num}</td> <td>
                            <c:if test="${not empty b.system_filename}">
                                <img src="${pageContext.request.contextPath}/upload/${b.system_filename}" 
                                     style="width: 50px; height: 50px; object-fit: cover;"
                                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/css/img/no_image.jpg';">
                            </c:if>
                        </td>

			            <td>[${b.category}]</td>
            
            			<td style="text-align:left;">
            				<a href="${pageContext.request.contextPath}/boardDetail.jsp?num=${b.num}">
            					${b.title} </a>
            			</td>
            			
                        <td style="color: #e74c3c; font-weight: bold;">
                            ${b.price}원
                        </td>
			            
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
<%@ include file="common/footer.jsp" %>