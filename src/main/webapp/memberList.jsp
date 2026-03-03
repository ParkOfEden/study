<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="common/header.jsp" %>

<section class="section-center">
    <table class="pd-table member-table list">
        <tr>
            <th colspan="7"><h1>회원목록</h1></th>
        </tr>
        <tr>
            <th>번호</th>
            <th>아이디</th>
            <th>이름</th>
            <th>주소</th>
            <th>전화번호</th>
            <th>성별</th>
            <th>나이</th>
        </tr>
        
        <c:choose>
            <c:when test="${empty memberList}">
                <tr>
                    <td colspan="7" style="text-align:center;">등록된 회원이 없습니다.</td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="m" items="${memberList}">
                    <tr>
                        <td>${m.num}</td>
                        <td>${m.id}</td>
                        <td>${m.name}</td>
                        <td>${m.addr}</td>
                        <td>${m.phone}</td>
                        <td>${m.gender}</td>
                        <td>${m.age}</td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </table>

    <div class="paging-area" align="center" style="margin-top:20px;">
        <%-- [이전] 버튼 --%>
        <c:if test="${pi.currentPage > 1}">
            <a href="memberList.do?page=${pi.currentPage - 1}">[이전]</a>
        </c:if>

        <%-- 숫자 페이지 버튼 (예: 1 2 3 4 5) --%>
        <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
            <c:choose>
                <c:when test="${p eq pi.currentPage}">
                    <b style="color:red; font-size:1.2em;">${p}</b>
                </c:when>
                <c:otherwise>
                    <a href="memberList.do?page=${p}">${p}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <%-- [다음] 버튼 --%>
        <c:if test="${pi.currentPage < pi.maxPage}">
            <a href="memberList.do?page=${pi.currentPage + 1}">[다음]</a>
        </c:if>
    </div>
</section>

<%@ include file="common/footer.jsp" %>