<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="common/header.jsp" %>
<%-- 관리자 체크 로직 --%>
<c:if test="${sessionScope.authUser ne 'admin' and sessionScope.authUser ne 'ADMIN'}">
    <script>
        alert("관리자 전용 페이지입니다.");
        location.href = "${pageContext.request.contextPath}/index.jsp";
    </script>
    <% if(true) return; // JSP 실행 중단 %>
</c:if>

<section class="section-center" style="display: block;"> 
    <table class="pd-table member-table list" style="margin: 0 auto; min-width: 900px;"> <thead>
            <tr>
                <th colspan="9"><h1>회원목록</h1></th>
            </tr>
            <tr>
                <th>번호</th>
                <th>아이디</th>
                <th>닉네임</th> <th>이름</th>
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
                        <td colspan="9" style="text-align:center;">등록된 회원이 없습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="m" items="${memberList}">
                        <tr>
                            <td>${m.num}</td>
                            <td>${m.id}</td>
                            <td style="font-weight: bold; color: #555;">${m.nickname}</td>
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
    </section>

<%@ include file="common/footer.jsp" %>