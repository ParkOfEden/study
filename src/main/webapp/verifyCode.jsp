<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 세션에 인증코드가 없으면 잘못된 접근
    String sessionCode = (String)session.getAttribute("authCode");

    if(sessionCode == null){
        out.println("<script>");
        out.println("alert('잘못된 접근입니다.');");
        out.println("location.href='join.jsp';");
        out.println("</script>");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
<title>이메일 인증</title>
</head>
<body>

	<section class="section-base">
		<div class="verify-wrapper">

    		<div class="verify-text">
				<h2>이메일 인증</h2>
				
				<p>입력하신 이메일로 인증코드를 발송했습니다.</p>
				<p>받은 인증코드를 아래에 입력해주세요.</p>
			</div>
		
			<form class="verify-card" action="verifyCheck.jsp" method="post">
			   <input type="text" name="inputCode" placeholder="인증코드 6자리 입력" required>
			   <button type="submit">인증하기</button>
			</form>
		</div>
	</section>
</body>
</html>