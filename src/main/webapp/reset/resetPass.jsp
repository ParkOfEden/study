<!-- resetPass -->
<!-- 비밀번호 재설정을 위한 사용자 id입력 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp" %>
<section>
	<form class="form-card" action="sendCode.jsp" method="POST">
		<table class="pd-table">
			<tr>
				<th colspan="2">
					<h2>비밀번호 찾기</h2>
				</th>
			</tr>
			<tr>
				<td>아이디</td>
				<td>
					<input type="text" name="id" required placeholder="아이디 입력">
				</td>				
			</tr>
			<tr>
				<td colspan="2">
					<h3>회원가입시 등록한 이메일로 인증코드를 보내드립니다.</h3>
					<h4>아이디 입력후 확인 버튼을 눌러주세요.</h4>
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