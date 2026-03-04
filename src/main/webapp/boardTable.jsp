<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ include file="common/header.jsp" %>
<%
String type = request.getParameter("type");
String keywordParam = request.getParameter("keyword");

if (type == null || type.trim().isEmpty()) { type = "all"; }
if (keywordParam == null) { keywordParam = ""; }

/* DAO 호출 (기존 DAO의 리턴 타입이 ProductVO로 바뀌었다고 가정) */
dao.BoardDAO dao = new dao.BoardDAO();
java.util.List<vo.BoardVO> list; // BoardVO -> ProductVO

if (!keywordParam.trim().isEmpty()) {
    list = dao.getSearchBoardListPaging(type, keywordParam, 0, 10);
} else {
    list = dao.getBoardListPaging(0, 10);
}

request.setAttribute("boardList", list);
%>

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
                            <c:if test="${not empty b.systemFilename}">
                                <img src="${pageContext.request.contextPath}/upload/${b.systemFilename}" 
                                     style="width: 50px; height: 50px; object-fit: cover;">
                            </c:if>
                        </td>

			            <td>[${b.category}]</td>
            
            			<td style="text-align:left;">
            				<a href="${pageContext.request.contextPath}/boardDetail.jsp?num=${b.num}">
            					${b.p_name} </a>
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