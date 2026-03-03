<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
    String authUser = (String)session.getAttribute("authUser");
    String userName = (String)session.getAttribute("userName");
    String path = request.getContextPath();
 // [자동 로그인 핵심] 세션은 없는데 쿠키가 있는 경우 처리
    if (authUser == null) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("rememberMe")) {
                    String cookieId = c.getValue();
                    
                    // 쿠키가 발견되면 세션을 강제로 생성 (로그인 시킴)
                    session.setAttribute("authUser", cookieId);
                    
                    // 실제 이름을 가져오고 싶다면 여기서 DB 조회가 필요하지만,
                    // 일단 아이디를 이름으로 세팅합니다.
                    session.setAttribute("userName", cookieId); 
                    
                    // 변수 업데이트
                    authUser = cookieId;
                    userName = cookieId;
                    break;
                }
            }
        }
    }
%><!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= request.getAttribute("pageTitle") != null ? request.getAttribute("pageTitle") : "월클의류(주)" %></title>
    <link rel="icon" href="${pageContext.request.contextPath}/css/img/wolcl.ico" type="image/x-icon">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    
    <!-- 아래는 요청받아 추가한 css 링크입니다. -->
    <link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/boardList.css">
      
    </head>
<body><%-- 
<style>
	<style>
    /* 🔹 상단 메뉴 (오른쪽 정렬) */
    .top-menu {
        display: flex;             /* flexbox 활성화 */
        justify-content: flex-end; /* 항목들을 오른쪽으로 밀어냄 */
        align-items: center;       /* 수직 중앙 정렬 */
        list-style: none;          /* 불릿점 제거 */
        margin: 0;
        padding: 10px 20px;        /* 상단 여백 */
        background-color: #f5f5f5; /* 배경색 (선택사항) */
        font-size: 13px;
    }

    .top-menu li {
        margin-left: 15px;         /* 메뉴 항목 간 간격 */
    }

    .top-menu a {
        text-decoration: none;     /* 밑줄 제거 */
        color: #333;               /* 글자색 */
    }

    .top-menu a:hover {
        color: #000;               /* 마우스 올렸을 때 색상 */
        text-decoration: underline;
    }

    /* 🔹 카테고리 메뉴 (가로 정렬 기본 스타일) */
    .category-menu {
        display: flex;             /* 가로 나열 */
        justify-content: center;   /* 중앙 정렬 (원하시면 flex-start 로 변경) */
        list-style: none;
        margin: 0;
        padding: 15px 0;
        background-color: #fff;
        border-bottom: 1px solid #ddd;
    }

    .category-menu > li {
        position: relative;        /* 서브메뉴 위치 기준 */
        margin: 0 15px;
        padding: 10px 0;
        cursor: pointer;
        font-weight: bold;
    }

    /* 서브메뉴 숨김 */
    .category-menu .submenu {
        display: none;
        position: absolute;
        top: 100%;
        left: 0;
        background: #fff;
        border: 1px solid #ddd;
        list-style: none;
        padding: 10px;
        min-width: 150px;
        z-index: 100;
    }

    /* 마우스 올렸을 때 서브메뉴 보임 */
    .category-menu > li:hover .submenu {
        display: block;
    }

    .category-menu .submenu li {
        padding: 5px 0;
        border-bottom: 1px solid #eee;
    }
    
    .category-menu .submenu li a {
        text-decoration: none;
        color: #555;
        display: block;
    }
</style>
<<<<<<< HEAD

<!-- 🔹 상단 메뉴 (수정됨: </ul> 태그 추가 및 클래스 적용) -->
<ul class="top-menu">
    <li><a href="<%= request.getContextPath() %>/index.jsp">홈</a></li>
    <li><a href="<%= request.getContextPath() %>/sendMail.jsp">SEND MAIL</a></li>
=======
 --%><%-- header.jsp 에는 <header></header>태그 안에서만 작성하되, css 효과는 header.css에서 처리할 것 
	 변경사항 : html 선언 & css 링크 선언 (절대 링크로 요청) & body 선언을 헤더에서 작업 후 일괄 include 처리
--%>
<header>


  <!-- 🔹 1 줄 상단 메뉴 -->
  <ul class="top-menu">
    <li><a href="<%=path%>/index.jsp">홈</a></li>
    <li><a href="<%=path%>/boardList.do">PRODUCTS</a></li>
	<li><a href="<%=path%>/sendMail.jsp">SEND MAIL</a></li>
>>>>>>> branch 'master' of https://github.com/ParkOfEden/study.git
<% if(authUser == null){ %>
<<<<<<< HEAD
    <li><a href="<%= request.getContextPath() %>/login.jsp">로그인</a></li>
    <li><a href="<%= request.getContextPath() %>/join.jsp">회원가입</a></li>
    <li><a href="<%= request.getContextPath() %>/join.jsp">고객센터</a></li>
=======
    <li><a href="<%=path%>/login.jsp">로그인</a></li>
    <li><a href="<%=path%>/join.jsp">회원가입</a></li>
    <li><a href="<%=path%>/cuscen.jsp">고객센터</a></li>
>>>>>>> branch 'master' of https://github.com/ParkOfEden/study.git
<% } else { %>
    <!-- 수정된 부분: 아이디 클릭 시 memberUpdateForm.jsp 로 이동 -->
    <li><a href="<%=path%>/memberUpdateForm.jsp"><%= userName %></a>님 환영합니다</li>
    
    <li><a href="<%=path%>/logout.jsp">로그아웃</a></li>
    <li><a href="<%=path%>/memberList.do">회원관리</a></li> <%-- <li><a href="<%=path%>/memberList.jsp">회원관리</a></li> --%>
    <li><a href="<%=path%>/orin.jsp">주문조회</a></li>
    
    <%-- admin 일 때만 보이는 글쓰기 버튼 --%>
    <% if ("admin".equals(authUser)) { %>
        <li><a href="<%=path%>/boardWrite.jsp">글쓰기</a></li>
    <% } %>
<% } %>
<<<<<<< HEAD
</ul> <!-- 👈 이 닫는 태그가 원래 코드에 없었습니다. 추가 필요합니다. -->
=======

	<li class="top-search">

	    <!-- 1. 숨겨진 체크박스 -->
	    <input type="checkbox" id="searchToggle" class="search-checkbox">
	
	    <!-- 2. 상품조회 라벨 (클릭용) -->
	    <label for="searchToggle" class="search-toggle">
	        상품조회
	    </label>
	
	    <!-- 3. 검색창 -->
	    <div class="search-box">
	        <form action="<%=path%>/boardList.do" method="get">
	            <input type="hidden" name="type" value="all">
	            <input type="text" name="keyword" placeholder="상품 검색">
	            <button type="submit">검색</button>
	        </form>
	    </div>

	</li>

  </ul>
>>>>>>> branch 'master' of https://github.com/ParkOfEden/study.git

<!-- 🔹 2 줄 카테고리 메뉴 -->
<ul class="category-menu">
    <li class="has-submenu">
        NEW &amp; BEST
        <ul class="submenu">
            <li><a href="<%=path%>/Headerjump/new.jsp">신상품 (New)</a></li>
            <li><a href="<%=path%>/Headerjump/best.jsp">베스트 (Best)</a></li>
            <li><a href="<%=path%>/Headerjump/mdre.jsp">MD 추천</a></li>
        </ul>
    </li>

    <li class="has-submenu">
        TOP
        <ul class="submenu">
            <li><a href="<%=path%>/Headerjump/Tshirt.jsp">티셔츠</a></li>
            <li><a href="<%=path%>/Headerjump/blouse.jsp">블라우스</a></li>
            <li><a href="<%=path%>/Headerjump/Shirt.jsp">셔츠</a></li>
            <li><a href="<%=path%>/Headerjump/knsw.jsp">니트/스웨터</a></li>
            <li><a href="<%=path%>/Headerjump/card.jsp">카디건</a></li>
            <li><a href="<%=path%>/Headerjump/hosw.jsp">후드/맨투맨</a></li>
        </ul>
    </li>

    <li class="has-submenu">
        OUTER
        <ul class="submenu">
            <li><a href="<%=path%>/Headerjump/jacket.jsp">자켓</a></li>
            <li><a href="<%=path%>/Headerjump/coat.jsp">코트</a></li>
            <li><a href="<%=path%>/Headerjump/pacoat.jsp">패딩/경량</a></li>
            <li><a href="<%=path%>/Headerjump/vest.jsp">조끼</a></li>
            <li><a href="<%=path%>/Headerjump/cardigan.jsp">가디건</a></li>
        </ul>
    </li>

    <li class="has-submenu">
        BOTTOM
        <ul class="submenu">
            <li><a href="<%=path%>/Headerjump/demin.jsp">데님 (Jeans)</a></li>
            <li><a href="<%=path%>/Headerjump/slacks.jsp">슬랙스</a></li>
            <li><a href="<%=path%>/Headerjump/widep.jsp">와이드 팬츠</a></li>
            <li><a href="<%=path%>/Headerjump/skirt.jsp">스커트</a></li>
            <li><a href="<%=path%>/Headerjump/shorts.jsp">쇼츠</a></li>
            <li><a href="<%=path%>/Headerjump/train.jsp">트레이닝</a></li>
        </ul>
    </li>

    <li class="has-submenu">
        ONE-PIECE
        <ul class="submenu">
            <li><a href="<%=path%>/Headerjump/onepiece.jsp">원피스</a></li>
            <li><a href="<%=path%>/Headerjump/jumps.jsp">점프수트</a></li>
            <li><a href="<%=path%>/Headerjump/Romper.jsp">롬퍼</a></li>
        </ul>
    </li>

    <li class="has-submenu">
        SHOES &amp; BAG
        <ul class="submenu">
            <li><a href="<%=path%>/Headerjump/sneak.jsp">스니커즈</a></li>
            <li><a href="<%=path%>/Headerjump/shoesheel.jsp">구두/힐</a></li>
            <li><a href="<%=path%>/Headerjump/boots.jsp">부츠</a></li>
            <li><a href="<%=path%>/Headerjump/bag.jsp">가방</a></li>
            <li><a href="<%=path%>/Headerjump/capacc.jsp">모자/액세서리</a></li>
        </ul>
    </li>

    <li class="has-submenu sale-text">
        SALE
        <ul class="submenu">
            <li><a href="<%=path%>/Headerjump/alldis.jsp">전상품 할인</a></li>
            <li><a href="<%=path%>/Headerjump/seoff.jsp">시즌 오프</a></li>
            <li><a href="<%=path%>/Headerjump/Spzone.jsp">특가 존</a></li>
        </ul>
    </li>
</ul>

</header>