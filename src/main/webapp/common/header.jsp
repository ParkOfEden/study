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
* { box-sizing: border-box; }
body { margin: 0; font-family: 'Noto Sans KR', sans-serif; }
header {
  border-bottom: 1px solid #ddd;
  padding: 15px 20px;
  background-color: #fff;
  position: relative;
}

ul {
  list-style: none;
  margin: 0;
  padding: 0;
}

a {
  text-decoration: none;
  color: #333;
}

/* 상단 메뉴 (로그인 등) */
.top-menu {
  display: flex;
  justify-content: flex-end;
  gap: 20px;
  margin-bottom: 15px;
  font-size: 13px;
  color: #666;
}

.top-menu a:hover {
  color: #ff6600;
  text-decoration: underline;
}

/* 카테고리 메뉴 (메인) */
.category-menu {
  display: flex;
  justify-content: center;
  gap: 25px;
  font-weight: bold;
  font-size: 15px;
  position: relative;
  flex-wrap: wrap;
}

.category-menu > li {
  position: relative;
  cursor: pointer;
  padding: 10px 5px;
  transition: color 0.3s;
}

.category-menu > li:hover {
  color: #ff6600;
}

/* 화살표 표시 */
.category-menu > li.has-submenu::after {
  content: '▼';
  font-size: 10px;
  margin-left: 5px;
  color: #999;
  vertical-align: middle;
  transition: transform 0.3s;
}

/* 메뉴 호버 시 화살표 회전 */
.category-menu > li:hover::after {
  color: #ff6600;
  transform: rotate(180deg);
}

/* 🔹 서브 메뉴 (드롭다운) 스타일 */
.submenu {
  display: none; /* 기본적으로 숨김 */
  position: absolute;
  top: 100%;
  left: 50%;
  transform: translateX(-50%);
  background-color: #fff;
  border: 1px solid #eee;
  box-shadow: 0 4px 10px rgba(0,0,0,0.1);
  min-width: 160px;
  z-index: 1000;
  padding: 15px 0;
  text-align: left;
  border-radius: 4px;
  margin-top: 10px; /* 메인 메뉴와 살짝 띄우기 */
  opacity: 0;
  transition: all 0.3s ease;
  visibility: hidden;
}

.submenu li {
  padding: 8px 20px;
  font-weight: normal;
  font-size: 14px;
  color: #555;
  white-space: nowrap;
}

.submenu li:hover {
  background-color: #f9f9f9;
  color: #ff6600;
  padding-left: 25px;
  transition: all 0.2s;
}

/* 🔹 핵심: 마우스를 올렸을 때 (Hover) 서브 메뉴 표시 */
.category-menu > li:hover .submenu {
  display: block;
  opacity: 1;
  visibility: visible;
  margin-top: 0; /* 올라오는 효과 */
}

/* 특별 메뉴 (세일 등) 색상 */
.sale-text { color: #ff3333 !important; }
</style>

</head>
<body>

<header>

  <!-- 🔹 1 줄 상단 메뉴 -->
  <ul class="top-menu">
    <li><a href="index.jsp">홈</a></li>

<% if(authUser == null){ %>
    <li><a href="login.jsp">로그인</a></li>
    <li><a href="join.jsp">회원가입</a></li>
    <li><a href="#">고객센터</a></li>
<% } else { %>
    <li><%= userName %>님 환영합니다</li>
    <li><a href="logout.jsp">로그아웃</a></li>
    <li><a href="memberList.jsp">회원관리</a></li>
    <li><a href="oi.jsp">주문조회</a></li>
    
    <%-- admin 일 때만 보이는 글쓰기 버튼 --%>
    <% if ("admin".equals(authUser)) { %>
        <li><a href="write.jsp">글쓰기</a></li>
    <% } %>
    
<% } %>
  </ul>

  <!-- 🔹 2 줄 카테고리 메뉴 -->
  <!-- onclick 제거, CSS hover 로 작동 -->
  <ul class="category-menu">
    
    <li class="has-submenu">
        NEW & BEST
        <ul class="submenu">
            <li><a href="new.jsp">신상품 (New)</a></li>
            <li><a href="best.jsp">베스트 (Best)</a></li>
            <li><a href="r.jsp">MD 추천</a></li>
        </ul>
    </li>

    <li class="has-submenu">
        TOP
        <ul class="submenu">
            <li><a href="T.jsp">티셔츠</a></li>
            <li><a href="B.jsp">블라우스</a></li>
            <li><a href="S.jsp">셔츠</a></li>
            <li><a href="N/S.jsp">니트/스웨터</a></li>
            <li><a href="K.jsp">카디건</a></li>
            <li><a href="H.jsp">후드/맨투맨</a></li>
        </ul>
    </li>

    <li class="has-submenu">
        OUTER
        <ul class="submenu">
            <li><a href="#">자켓</a></li>
            <li><a href="#">코트</a></li>
            <li><a href="#">패딩/경량</a></li>
            <li><a href="#">조끼</a></li>
            <li><a href="#">가디건</a></li>
        </ul>
    </li>

    <li class="has-submenu">
        BOTTOM
        <ul class="submenu">
            <li><a href="#">데님 (Jeans)</a></li>
            <li><a href="#">슬랙스</a></li>
            <li><a href="#">와이드 팬츠</a></li>
            <li><a href="#">스커트</a></li>
            <li><a href="#">쇼츠</a></li>
            <li><a href="#">트레이닝</a></li>
        </ul>
    </li>

    <li class="has-submenu">
        ONE-PIECE
        <ul class="submenu">
            <li><a href="#">원피스</a></li>
            <li><a href="#">점프수트</a></li>
            <li><a href="#">롬퍼</a></li>
        </ul>
    </li>

    <li class="has-submenu">
        SHOES & BAG
        <ul class="submenu">
            <li><a href="#">스니커즈</a></li>
            <li><a href="#">구두/힐</a></li>
            <li><a href="#">부츠</a></li>
            <li><a href="#">가방</a></li>
            <li><a href="#">모자/액세서리</a></li>
        </ul>
    </li>

    <li class="has-submenu sale-text">
        SALE
        <ul class="submenu">
            <li><a href="#">전상품 할인</a></li>
            <li><a href="#">시즌 오프</a></li>
            <li><a href="#">특가 존</a></li>
        </ul>
    </li>

  </ul>

</header>

<!-- 🔹 자바스크립트 제거 (CSS Hover 로 대체) -->
<!-- 마우스를 올리기만 하면 CSS 가 자동으로 처리합니다 -->

</body>
</html>