<!-- webapp/reset/acceptCode.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/common/header.jsp" %>
    
<%
	String code=(String)request.getAttribute("code");
	String id=(String)request.getAttribute("id");
%>
<section>
	<!-- 메일로 발신된 code를 입력받은후 새로운 비밀번호 입력페이지로 이동
	전송된 코드와 사용자가 입력한 코드를 비교하여 비밀번호 변경작업 수행
	 -->
	<form action="inputPass.jsp" method="POST">
	<input type="hidden" name="sendCode" value="<%=code%>">
	<input type="hidden" name="id" value="<%=id%>">
		<table>
			<tr>
				<th colspan="2">
					<h2>이메일로 코드 전송 완료</h2>
				</th>
			</tr>
			<tr>
				<td colspan="2">
					<h4>회원가입시 등록한 이메일을 확인 후</h4>
					<h4>전송된 코드를 입력해 주세요.</h4>
				</td>
			</tr>
			<tr>
				<td>코드</td>
				<td>
					<input type="text" name="code" placeholder="코드입력">
				</td>
			</tr>
			<tr>
				<th colspan="2"><button>확인</button></th>
			</tr>					
		</table>
	</form>


</section>
