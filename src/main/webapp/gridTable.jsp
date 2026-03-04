<!-- gridTable.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>



<table class="grid-table">
 
<tbody>

<c:if test="${empty boardList}">
    <tr>
        <td colspan="4">등록된 게시글이 없습니다.</td>
    </tr>
</c:if>

<c:if test="${not empty boardList}">
   	<c:forEach var="b" items="${boardList}" varStatus="status">
   	
   		<c:if test="${status.index mod 4 == 0}">
       		<tr>
        </c:if>
           
        <td class="grid-item">
           	
           	<div class="grid-category">
           		[${b.category}]
           	</div>
           	
           	<div class="grid-title">
    	        <a href="${pageContext.request.contextPath}/boardDetail.jsp?num=${b.num}">
                    ${b.title}
                </a>
           	</div>
           	
            <div class="grid-info">
                ${b.author}
            </div>

            <div class="grid-meta">
                조회 ${b.viewCount}
            </div>       
            
           
		</td>     	
   
        <c:if test="${status.index mod 4 == 3}">
        	</tr>		            
		</c:if>		
    					
      	</c:forEach>
	</c:if>    	
</tbody>
</table>

