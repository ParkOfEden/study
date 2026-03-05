<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="common/header.jsp" %>
<section class="section-center" style="display: block;"> <table class="pd-table member-table list" style="margin: 0 auto; min-width: 800px;"> <thead>
            <tr>
                <th colspan="8"><h1>회원목록</h1></th>
            </tr>
            <tr>
                <th>번호</th>
                <th>아이디</th>
                <th>이름</th>
                <th>주소</th>
                <th>전화번호</th>
                <th>이메일</th>
                <th>성별</th>
                <th>나이</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty memberList}">
                    <tr>
                        <td colspan="8" style="text-align:center;">등록된 회원이 없습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="m" items="${memberList}">
                        <tr>
                            <td>${m.num}</td>
                            <td>${m.id}</td>
                            <td>
    <a href="memberUpdateForm.jsp?id=${m.id}" style="text-decoration: none; color: blue; font-weight: bold;">
        ${m.name}
    </a>
</td>
                            <td>${m.addr}</td>
                            <td>${m.phone}</td>
                            <td>${m.email}</td>
                            <td>${m.gender}</td>
                            <td>${m.age}</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <div class="paging-area" style="text-align: center; margin: 20px auto; width: 100%; clear: both;">
        <c:if test="${pi.currentPage > 1}">
            <a href="memberList.do?page=${pi.currentPage - 1}">[이전]</a>
        </c:if>

        <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
            <c:choose>
                <c:when test="${p eq pi.currentPage}">
                    <b style="color:red; font-size:1.2em; margin: 0 5px;">${p}</b>
                </c:when>
                <c:otherwise>
                    <a href="memberList.do?page=${p}" style="margin: 0 5px;">${p}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${pi.currentPage < pi.maxPage}">
            <a href="memberList.do?page=${pi.currentPage + 1}">[다음]</a>
        </c:if>
    </div>
</section>

<%@ include file="common/footer.jsp" %>