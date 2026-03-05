<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ include file="common/header.jsp" %>
<!-- boardTableNew.jsp -->
<div style="color:red">
boardList size : ${boardList.size()}
</div>
<section>
<table class="board-table">
    <thead>
        <tr>
            <th>상품번호</th>
            <th>이미지</th>
            <th>카테고리</th> 
            <th>상품명</th>
            <th>판매가</th>
            <th>조회수</th>
            <c:if test="${sessionScope.authUser == 'admin'}">
                <th>관리</th>
            </c:if>
        </tr>
    </thead>
    <tbody>
        <c:choose>
            <%-- 서블릿에서 넘겨준 이름인 'boardList'를 사용합니다 --%>
            <c:when test="${empty boardList}">
                <tr>
                    <td colspan="7">등록된 상품이 없습니다.</td>
                </tr>
            </c:when>
            
            <c:otherwise>
                <c:forEach var="b" items="${boardList}">
                    <tr>
                        <%-- BoardVO의 필드명에 맞춰서 작성 (num인지 p_id인지 확인 필요) --%>
                        <td>${b.num}</td> 
                        <td>
							<%-- 이미지의 경로가 null 이거나 틀렸을때 엑박 대체이미지 출력되도록 설정 --%>
					        <img src="${pageContext.request.contextPath}/css/img/upload/product/${b.systemFilename}"
					             style="width:50px;height:50px;object-fit:cover;"
					             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/css/img/no_image.jpg';">
                        </td>
                        <td>[${b.category}]</td>
                        <td style="text-align:left;">
                            <a href="${pageContext.request.contextPath}/boardDetail.jsp?num=${b.num}">
                                ${b.title} 
                            </a>
                        </td>
                        <td style="color: #e74c3c; font-weight: bold;">
                            ${b.price}원
                        </td>
                        <td>${b.viewCount}</td>
                        <c:if test="${sessionScope.authUser == 'admin'}">
                            <td>
                                <a href="boardUpdateForm.do?num=${b.num}">수정</a> |
                                <a href="boardDelete.do?num=${b.num}" onclick="return confirm('삭제하시겠습니까?');">삭제</a>
                            </td>                   
                        </c:if>     
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </tbody>
</table>
<%-- 디버깅용 코드 --%>
<div style="color:red; background:#eee; padding:10px;">
    현재 넘어온 데이터 개수: ${empty boardList ? 0 : boardList.size()} <br>
    AuthUser 세션 상태: ${sessionScope.authUser}
</div>

<!-- 페이징 (중복 확인 후 주석 제거 요망)
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
-->
</section>
<%@ include file="common/footer.jsp"%>