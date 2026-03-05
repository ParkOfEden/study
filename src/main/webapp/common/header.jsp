<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.Cookie" %>
<%
    String authUser = (String)session.getAttribute("authUser");
    String userName = (String)session.getAttribute("userName");
    String path = request.getContextPath();

    // [자동 로그인 처리] 세션은 없는데 쿠키가 있는 경우
    if (authUser == null) {
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
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= request.getAttribute("pageTitle") != null ? request.getAttribute("pageTitle") : "월클의류(주)" %></title>
    <link rel="icon" href="<%=path%>/css/img/wolcl.ico" type="image/x-icon">
    <link rel="stylesheet" href="<%=path%>/css/common.css">
     
    <link rel="stylesheet" href="<%=path%>/css/footer.css">
    <link rel="stylesheet" href="<%=path%>/css/boardList.css">
<link rel="stylesheet" href="<%=path%>/css/header.css">



</head>
<body>

<header>

<!-- 🔹 상단 메뉴 (수정됨: </ul> 태그 추가 및 클래스 적용) -->
<ul class="top-menu">
    <li><a href="<%= request.getContextPath() %>/index.jsp">홈</a></li>
    <li><a href="<%= request.getContextPath() %>/sendMail.jsp">SEND MAIL</a></li>

<%-- header.jsp 에는 <header></header>태그 안에서만 작성하되, css 효과는 header.css에서 처리할 것 
	 변경사항 : html 선언 & css 링크 선언 (절대 링크로 요청) & body 선언을 헤더에서 작업 후 일괄 include 처리
--%>

        <% if(authUser == null){ %>
            <li><a href="<%=path%>/login.jsp">로그인</a></li>
            <li><a href="<%=path%>/join.jsp">회원가입</a></li>
            <li><a href="<%=path%>/cuscen.jsp">고객센터</a></li>
        <% } else { %>
            <li><a href="<%=path%>/memberUpdateForm.jsp"><strong><%= userName %></strong>님 환영합니다</a></li>
            <li><a href="<%=path%>/logout.jsp">로그아웃</a></li>
            <li><a href="<%=path%>/memberList.do">회원관리</a></li>
            <li><a href="<%=path%>/cartView.jsp">장바구니</a></li>
            <% if ("admin".equals(authUser)) { %>
                <li><a href="<%=path%>/boardWrite.jsp">글쓰기</a></li>
            <% } %>
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