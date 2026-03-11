<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.Cookie" %>
<%
    // 1. 일반 로그인 세션 (DB 기반)
    String authUser = (String)session.getAttribute("authUser"); // DB의 id
    String userName = (String)session.getAttribute("userName"); // DB의 name 또는 nickname

    // 2. 카카오 로그인 세션 (카카오 기반)
    String kakaoName = (String)session.getAttribute("userName"); 
    // ※ 주의: 만약 일반 로그인과 카카오 로그인 모두 'userName'이라는 키를 쓴다면 
    // 하나만 체크해도 됩니다.

    String path = request.getContextPath();

    // [자동 로그인 처리] 쿠키 로직 (기존 유지)
    if (authUser == null && kakaoName == null) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("rememberMe")) {
                    String cookieId = c.getValue();
                    session.setAttribute("authUser", cookieId);
                    session.setAttribute("userName", cookieId); 
                    authUser = cookieId;
                    userName = cookieId;
                    break;
                }
            }
        }
    }

    // 최종 로그인 여부 판단 (일반 DB 로그인 유저 OR 카카오 로그인 유저)
    boolean isLoggedIn = (authUser != null || kakaoName != null);
    
    // 표시할 이름 결정 (카카오 닉네임이 있으면 그것을, 없으면 DB 유저명을 사용)
    String displayName = (kakaoName != null) ? kakaoName : userName;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${not empty pageTitle ? pageTitle : '월클의류 (주)'}</title>
    <link rel="icon" href="<%=path%>/css/img/wolcl.ico" type="image/x-icon">
    <link rel="stylesheet" href="<%=path%>/css/common.css">
	<link rel="stylesheet" href="<%=path%>/css/header.css">     
    <link rel="stylesheet" href="<%=path%>/css/footer.css">
    <link rel="stylesheet" href="<%=path%>/css/boardList.css">




</head>
<body>

<header>

<%-- 상단 메뉴 바 섹션 --%>
<ul class="top-menu">
    <li><a href="<%= request.getContextPath() %>/index.jsp">홈</a></li>
    
    <% if(authUser == null){ %>
        <%-- 비회원 상태 --%>
        <li><a href="<%=path%>/login.jsp">로그인</a></li>
        <li><a href="<%=path%>/join.jsp">회원가입</a></li>
        <li><a href="<%=path%>/customerSerHvice.jsp">고객센터</a></li>
        <li><a href="<%=path%>/cartView.jsp">장바구니</a></li> <%-- 비회원 노출 추가 --%>
    <% } else { %>
        <%-- 로그인 상태 (일반회원/관리자 공통) --%>
        <li><a href="<%=path%>/memberUpdateForm.jsp"><strong><%= displayName %></strong>님 환영합니다</a></li>
        <li><a href="<%=path%>/logout.jsp">로그아웃</a></li>
        <li><a href="<%=path%>/cuscen.jsp">고객센터</a></li>
        
        <%-- 관리자 전용 메뉴 --%>
        <% if ("admin".equals(authUser)) { %>
            <li><a href="<%=path%>/memberList.do">회원관리</a></li>
            <li><a href="<%=path%>/boardWrite.jsp">글쓰기</a></li>
        <% } %>
        
        <li><a href="<%=path%>/cartView.jsp">장바구니</a></li>
    <% } %>

    <li class="top-search">
        <input type="checkbox" id="searchToggle" class="search-checkbox">
        <label for="searchToggle" class="search-toggle">상품조회</label>
        <div class="search-box">
            <form action="<%=path%>/boardList.do" method="get">
                <input type="hidden" name="type" value="all">
                <input type="text" name="keyword" placeholder="상품 검색">
                <button type="submit">검색</button>
            </form>
        </div>
    </li>
</ul>

    <ul class="category-menu">
        <li class="has-submenu">
            NEW &amp; BEST
            <ul class="submenu">
                <li><a href="<%=path%>/boardList.do?category=신상품">신상품 (New)</a></li>
                <li><a href="<%=path%>/boardList.do?category=베스트">베스트 (Best)</a></li>
                <li><a href="<%=path%>/boardList.do?category=MD">MD 추천</a></li>
            </ul>
        </li>

        <li class="has-submenu">
            TOP
            <ul class="submenu">
                <li><a href="<%=path%>/boardList.do?category=티셔츠">티셔츠</a></li>
                <li><a href="<%=path%>/boardList.do?category=블라우스">블라우스</a></li>
                <li><a href="<%=path%>/boardList.do?category=셔츠">셔츠</a></li>
                <li><a href="<%=path%>/boardList.do?category=니트">니트/스웨터</a></li>
                <li><a href="<%=path%>/boardList.do?category=카디건">카디건</a></li>
                <li><a href="<%=path%>/boardList.do?category=후드">후드/맨투맨</a></li>
            </ul>
        </li>

        <li class="has-submenu">
            OUTER
            <ul class="submenu">
                <li><a href="<%=path%>/boardList.do?category=자켓">자켓</a></li>
                <li><a href="<%=path%>/boardList.do?category=코트">코트</a></li>
                <li><a href="<%=path%>/boardList.do?category=패딩">패딩/경량</a></li>
                <li><a href="<%=path%>/boardList.do?category=조끼">조끼</a></li>
                <li><a href="<%=path%>/boardList.do?category=가디건">가디건</a></li>
            </ul>
        </li>

        <li class="has-submenu">
            BOTTOM
            <ul class="submenu">
                <li><a href="<%=path%>/boardList.do?category=데님">데님 (Jeans)</a></li>
                <li><a href="<%=path%>/boardList.do?category=슬랙스">슬랙스</a></li>
                <li><a href="<%=path%>/boardList.do?category=와이드 팬츠">와이드 팬츠</a></li>
                <li><a href="<%=path%>/boardList.do?category=스커트">스커트</a></li>
                <li><a href="<%=path%>/boardList.do?category=쇼츠">쇼츠</a></li>
                <li><a href="<%=path%>/boardList.do?category=트레이닝">트레이닝</a></li>
            </ul>
        </li>


        <li class="has-submenu">
            ONE-PIECE
            <ul class="submenu">
                <li><a href="<%=path%>/boardList.do?category=원피스">원피스</a></li>
                <li><a href="<%=path%>/boardList.do?category=점프수트">점프수트</a></li>
                <li><a href="<%=path%>/boardList.do?category=롬퍼">롬퍼</a></li>
            </ul>
        </li>
<%-- 신규 추가: 이너웨어 메뉴 --%>
        <li class="has-submenu">
            INNERWEAR
            <ul class="submenu">
                <li><a href="<%=path%>/boardList.do?category=속옷">속옷</a></li>
                <li><a href="<%=path%>/boardList.do?category=이지웨어">이지웨어</a></li>
                <li><a href="<%=path%>/boardList.do?category=잠옷">홈웨어/잠옷</a></li>
            </ul>
        </li>
        <li class="has-submenu">
            SHOES &amp; BAG
            <ul class="submenu">
                <li><a href="<%=path%>/boardList.do?category=스니커즈">스니커즈</a></li>
                <li><a href="<%=path%>/boardList.do?category=구두">구두/힐</a></li>
                <li><a href="<%=path%>/boardList.do?category=부츠">부츠</a></li>
                <li><a href="<%=path%>/boardList.do?category=가방">가방</a></li>
                <li><a href="<%=path%>/boardList.do?category=모자">모자/액세서리</a></li>
            </ul>
        </li>

        <li class="has-submenu sale-text">
            SALE
            <ul class="submenu">
                <li><a href="<%=path%>/boardList.do?category=할인">전상품 할인</a></li>
                <li><a href="<%=path%>/boardList.do?category=시즌">시즌 오프</a></li>
                <li><a href="<%=path%>/boardList.do?category=특가">특가 존</a></li>
            </ul>
        </li>
    </ul>
</header>