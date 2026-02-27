<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    String authUser = (String)session.getAttribute("authUser");
    String userName = (String)session.getAttribute("userName");
%>

<!-- 
<style>
	앞으로는 여기에 css 작업 하지 마시고 header.css에서 작업해주세요 :-)
	(여기 작성된 코드를 지운 것이 아니고 header.css에 옮겨놓음)
	이유1 : index.jsp(등)에 css 효과 include 처리 되어서 그대로 영향
	이유2 : 만약 <html> 태그를 사용해서 </html>처리를 해버리면 include 한 index.jsp 등에서 닫힌 <html>태그에 이어서 태그를 작성하는 꼴이 나버림..
		   이 이유때문에 남아서 작업해도 해결못하고 있다가 집에 가서 전수조사해서 밝혀냄..
    결론 : header.jsp에서는 style 태그에 작업 금지(index, footer 전역 효과 또는 충돌되어 안먹힘), <html> 열고 </html> 닫기 금지 (치명적, 스파게티 코드 발생 가능)
</style>
 -->

<!-- header.jsp 에는 <header></header>태그 안에서만 작성하되, css 효과는 header.css에서 처리할 것 
	 변경사항 : html 선언 & css 링크 선언 (절대 링크로 요청) & body 선언을 헤더에서 작업 후 일괄 include 처리
	 
<!-- 확인 후 주석 해제 요청
 	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>CHOI HOUSE</title>
		
		<link rel="stylesheet" href="css/common.css">
		<link rel="stylesheet" href="css/header.css">		
		<link rel="stylesheet" href="css/footer.css">
		<link rel="stylesheet" href="css/product.css">
	</head>
		<body>
-->
<header>

  <!-- 🔹 1 줄 상단 메뉴 -->
  <ul class="top-menu">
    <li><a href="index.jsp">홈</a></li>

<% if(authUser == null){ %>
    <li><a href="login.jsp">로그인</a></li>
    <li><a href="join.jsp">회원가입</a></li>
    <li><a href="#">고객센터</a></li>
<% } else { %>
    <!-- 수정된 부분: 아이디 클릭 시 memberUpdateForm.jsp 로 이동 -->
    <li><a href="memberUpdateForm.jsp"><%= userName %></a>님 환영합니다</li>
    
    <li><a href="logout.jsp">로그아웃</a></li>
    <li><a href="memberList.jsp">회원관리</a></li>
    <li><a href="orin.jsp">주문조회</a></li>
    
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

        NEW &amp; BEST <!-- & 보다 &amp; 가 안전 -->
        <ul class="submenu">
            <li><a href="new.jsp">신상품 (New)</a></li>
            <li><a href="best.jsp">베스트 (Best)</a></li>
            <li><a href="mdre.jsp">MD 추천</a></li>
        </ul>
    </li>

    <li class="has-submenu">
        TOP
        <ul class="submenu">
            <li><a href="Tshirt.jsp">티셔츠</a></li>
            <li><a href="blouse.jsp">블라우스</a></li>
            <li><a href="Shirt.jsp">셔츠</a></li>
            <li><a href="knsw.jsp">니트/스웨터</a></li>
            <li><a href="card.jsp">카디건</a></li>
            <li><a href="hosw.jsp">후드/맨투맨</a></li>
        </ul>
    </li>

    <li class="has-submenu">
        OUTER
        <ul class="submenu">
            <li><a href="jacket.jsp">자켓</a></li>
            <li><a href="coat.jsp">코트</a></li>
            <li><a href="pacoat.jsp">패딩/경량</a></li>
            <li><a href="vest.jsp">조끼</a></li>
            <li><a href="cardigan.jsp">가디건</a></li>
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
        SHOES &amp; BAG
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

