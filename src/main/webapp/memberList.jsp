<!-- JSP는 View이고, 데이터는 Servlet에서 전달받기 때문에 JSP를 직접 호출하면 데이터가 없습니다. 그래서 memberList.do로 접근해야 합니다. -->
<!-- JSTL = JSP Standard Tag Library : JSP에서 자바 코드(scriptlet) 대신 쓰는 태그 모음 -->
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!-- memberList.jsp -->
<%@ include file="common/header.jsp" %>

			<section class="section-base">
			<table class="pd-table">
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
				<!-- 회원 목록 출력 -->
				
				<!-- 등록된 회원이 없을 시 출력 -->
			<c:choose>
   				<c:when test="${empty memberList}">
					<tr>
						<th colspan="7">등록된 회원이 없습니다.</th>
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
			</section>
<%@ include file="common/footer.jsp" %>











