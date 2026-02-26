<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title>
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

<ul class="category">
  <li>티셔츠</li>
  <li>니트/스웨터</li>
  <li>블라우스/셔츠</li>
  <li>스커트</li>
  <li>팬츠</li>
  <li>데님</li>
  <li>아우터</li>
  <li>원피스</li>
</ul>

			<!-- 로그인 된 사용자 -->
			<li><a href="info.jsp"></a>님 안녕하세요.</li>
			<li><a href="logout.jsp">로그아웃</a></li>

			<!-- 관리자 로그인일 경우 -->
			<li><a href="memberList.jsp">회원관리</a></li>
		</ul>
	</div>
</body>
</html>
<style>
.category {
  display: flex;      /* 가로 정렬 */
  list-style: none;   /* 점 제거 */
  padding: 0;
  gap: 20px;          /* 사이 간격 */
}
</style>