<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    String authUser = (String)session.getAttribute("authUser");
    String userName = (String)session.getAttribute("userName");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHOI HOUSE</title>

<style>
/* 공통 */
header {
  border-bottom: 1px solid #ddd;
  padding: 10px 20px;
}

ul {
  list-style: none;
  margin: 0;
  padding: 0;
}

/* 상단 메뉴 */
.top-menu {
  display: flex;
  justify-content: flex-end;
  gap: 20px;
  margin-bottom: 10px;
}

/* 카테고리 메뉴 */
.category-menu {
  display: flex;
  justify-content: center;
  gap: 30px;
  font-weight: bold;
}

.category-menu li:hover {
  color: #ff6600;
  cursor: pointer;
}
</style>

</head>
<body>

<header>

  <!-- 🔹 1줄 상단 메뉴 -->
  <ul class="top-menu">
    <li><a href="index.jsp">홈</a></li>

    <% if(authUser == null){ %>
        <li><a href="login.jsp">로그인</a></li>
        <li><a href="join.jsp">회원가입</a></li>
    <% } else { %>
        <li><%= userName %>님 환영합니다</li>
        <li><a href="logout.jsp">로그아웃</a></li>
        <li><a href="memberList.jsp">회원관리</a></li>
    <% } %>
  </ul>

  <!-- 🔹 2줄 카테고리 메뉴 -->
  <ul class="category-menu">
    <li>티셔츠</li>
    <li>니트/스웨터</li>
    <li>가디건</li>
    <li>셔츠</li>
    <li>아우터</li>
    <li>자켓</li>
    <li>팬츠</li>
    <li>데님</li>
    <li>원피스</li>
  </ul>

</header>

</body>
</html>