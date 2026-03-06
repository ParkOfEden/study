<!-- gridTable.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
    
<%-- boardList : ${boardList}
<br>
size : ${boardList.size()} --%>    
    


<c:if test="${empty boardList}">
    <div class="grid-empty">
        등록된 게시글이 없습니다.
    </div>
</c:if>

<c:if test="${not empty boardList}">
<table class="grid-table">
<tbody>
   	<c:forEach var="b" items="${boardList}" varStatus="status">
   	
   		<c:if test="${status.index % 4 == 0}">
       		<tr>
        </c:if>
           
        <td class="grid-item">
        
        	<img src="${pageContext.request.contextPath}/css/img/upload/${b.system_filename}"
			     style="width:120px;height:120px;object-fit:cover;"
			     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/css/img/no_image.jpg';">
           	
           	<div class="grid-category">
           		[${b.category}]
           	</div>
           	
           	<div class="grid-title">
    	        <a href="${pageContext.request.contextPath}/boardDetail.jsp?num=${b.num}">
                    ${b.title}
                </a>
           	</div>
           	
            <div class="grid-meta">
                조회 ${b.viewCount}
            </div>       
                    
		</td>     	
   
        <c:if test="${status.index % 4 == 3}">
        	</tr>
        </c:if>	
        		            
      	</c:forEach>
      	 	
		<c:if test="${not empty boardList and boardList.size() % 4 != 0}">		
    	</tr>
        </c:if>				
	</c:if>    	
</tbody>
</table>

