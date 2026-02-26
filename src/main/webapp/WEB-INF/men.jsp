<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div>
		<ul>
			<li><a href="index.jsp">홈으로</a></li>
			<li>네이버</li>
			<li>|</li>
			<li>다음</li>

			<!-- 비 로그인 사용자 -->
			<li><a href="login.jsp">로그인</a></li>
			<li><a href="join.jsp">회원가입</a></li>

			<!-- 카테고리 목록 -->
			<li>티셔츠</li>
			<li>니트/스웨터</li>
			<li>가디건</li>
			<li>셔츠</li>
			<li>아우터</li>
			<li>제킷</li>
			<li>팬츠</li>
			<li>데님</li>
			

			<!-- 로그인 된 사용자 -->
			<li><a href="info.jsp"></a>님 안녕하세요.</li>
			<li><a href="logout.jsp">로그아웃</a></li>

			<!-- 관리자 로그인일 경우 -->
			<li><a href="memberList.jsp">회원관리</a></li>
		</ul>


</body>
</html>