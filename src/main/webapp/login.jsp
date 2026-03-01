<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- login.jsp -->
<%@ include file="common/header.jsp" %>

		<script type="text/javascript" src="js/inputCheck.js"></script>
		<section>
		<form class="form-card" action="loginCheck.jsp" method="POST">
			<table class="pd-table">
				<tr>
					<th colspan="2"><h1>로그인</h1></th>
				</tr>
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" name="id" placeholder="INSERT ID HERE" data-msg="아이디" autofocus/>
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td>
						<input type="password" name="pass" placeholder="INSERT PW HERE" data-msg="비밀번호"/>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<label>
						<input type="checkbox" name="rememberMe" value="login"/>
							로그인 상태 유지
						</label>
					</td>
				</tr>
				
				<tr>
			<th colspan="2">
				<button>로그인</button>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="reset/resetPass.jsp">비밀번호 찾기</a>
			</th>
		</tr>
			</table>
		</form>
		</section>
		
<%@ include file="common/footer.jsp" %>
















