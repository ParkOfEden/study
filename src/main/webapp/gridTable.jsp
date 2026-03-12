<!-- gridTable.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
    
<%@ page import="dao.BoardDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="vo.BoardVO"%>  

<!-- 전체 상품 조회(구버전) -->
<%--
BoardDAO dao = new BoardDAO();
List<BoardVO> boardList = dao.getBoardListPaging(0, 20);
request.setAttribute("boardList", boardList);
--%>

<!-- 카테고리별 상품 조회(개정판) -->
<%
String keyword = request.getParameter("keyword");

if(keyword == null) {
    keyword = "";
}

BoardDAO dao = new BoardDAO();
List<BoardVO> boardList = dao.getBoardListByCategory(keyword);

request.setAttribute("boardList", boardList);
%>

<!-- 디버깅용 확인 코드 -->  
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
        <div class="grid-card">
        	<div class="grid-img-box">
			<%-- 이미지의 경로가 null 이거나 틀렸을때 엑박 대체이미지 출력되도록 설정 --%>
			<c:choose>
			    <c:when test="${empty b.system_filename}">
			        <img src="${pageContext.request.contextPath}/css/img/no_image.jpg"
			             class="grid-noimg">
			    </c:when>
			    <c:otherwise>
			    	<a href="${pageContext.request.contextPath}/boardDetail.jsp?num=${b.num}">
			        <img src="${pageContext.request.contextPath}/css/img/upload/${b.system_filename}"
			             class="grid-img"
			             onerror="this.onerror=null;
			                      this.src='${pageContext.request.contextPath}/css/img/upload/product/${b.system_filename}';">
                    </a>
			    </c:otherwise>
			</c:choose>	
           	</div>
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
        
        </div>
                    
		</td>     	
   
        <c:if test="${status.index % 4 == 3}">
        	</tr>
        </c:if>	
        		            
      	</c:forEach>
      	 	
		<c:if test="${not empty boardList and boardList.size() % 4 != 0}">		
    		</tr>
        </c:if>				
	   	
</tbody>
</table>

</c:if> 

