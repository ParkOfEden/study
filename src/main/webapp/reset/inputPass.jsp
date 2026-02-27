<!-- webapp/reset/inputPass.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp" %>
<%
	// 발신 코드와 사용자가 입력한 코드가 일치하는지 확인
	String sendCode=request.getParameter("sendCode");
	String code=request.getParameter("code");
	String id=request.getParameter("id");
	
	System.out.println("발신 코드 :"+sendCode);
	System.out.println("입력 코드 :"+code);
	
	if(!sendCode.equals(code)){
		//발신 코드와 입력 코드가 일치하지않음.
%>
	<script>
		alert("인증 실패, 다시 확인후 요청해 주세요.");
		history.back();
	</script>
<%
	return;//요청 처리 종료
	}

%>
<%	
		//발신 코드와 입력 코드가 일치함.
 %>	
<section>
	<form action="updatePass.jsp" method="POST">
		<input type="hidden" name="id" value="<%=id%>">
		<table>
			<tr>
				<th colspan="2">
					<h2>새 비밀번호</h2>
					<h3>새롭게 사용할 비밀번호를 입력해 주세요.</h3>
				</th>
			</tr>
			<tr>
				<td>새 비밀번호</td>
				<td>
					<input type="password" name="password" placeholder="새 비밀번호">
				</td>
			</tr>
			<tr>
				<td>비밀번호 확인</td>
				<td>
					<input type="password" name="rePassword" placeholder="새 비밀번호">
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<button>확인</button>
				</th>
			</tr>
		</table>
	</form>
</section>	



<%@ include file="/common/footer.jsp" %>