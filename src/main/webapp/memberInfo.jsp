<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!-- memberInfo.jsp -->
<%@ include file="common/header.jsp" %>
<%
    
    String authUser = (String)session.getAttribute("authUser");
    String userName = (String)session.getAttribute("userName");
    
    
    if(authUser == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
        return;
    }
%>
<section>
<table>
	<tr>
		<th colspan="2">
		</th>
	</tr>
	<tr>
		<td>아이디</td>
		<td></td>
	</tr>
	<tr>
		<td>이름</td>
		<td></td>
	</tr>
	<tr>
		<td>주소</td>
		<td></td>
	</tr>
	<tr>
		<th colspan="2">
			<a href="">수정</a> | <a href="">삭제</a>
		</th>
	</tr>
</table>
</section>
<%@ include file="common/footer.jsp" %>











