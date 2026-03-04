<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%
String type = request.getParameter("type");
String keywordParam = request.getParameter("keyword");

/* 기본값 처리 */
if (type == null || type.trim().isEmpty()) {
    type = "all";
}

if (keywordParam == null) {
    keywordParam = "";
}

/* DAO 호출 */
dao.BoardDAO dao = new dao.BoardDAO();

java.util.List<vo.BoardVO> list;

/* 검색어가 있을 때만 검색 메서드 호출 */
if (!keywordParam.trim().isEmpty()) {
    list = dao.getSearchBoardListPaging(type, keywordParam, 0, 12);
} else {
    list = dao.getBoardListPaging(0, 10);
}

/* request 영역에 저장 */
request.setAttribute("boardList", list);
%>

<table class="grid-table">
 
<tbody>
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
            
           </div>
           
		</td>     	
   
        <c:if test="${status.index mod 4 == 3}">
        	</tr>		            
		</c:if>		
    					
      	</c:forEach>
</tbody>
</table>

