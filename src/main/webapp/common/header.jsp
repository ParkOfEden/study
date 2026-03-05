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
    <%-- <link rel="stylesheet" href="<%=path%>/css/header.css"> header.css 비활성화(필요시 header.css 열람) --%>
    <link rel="stylesheet" href="<%=path%>/css/footer.css">
    <link rel="stylesheet" href="<%=path%>/css/boardList.css">


<style>

	/* ============================= */
	/* 공통 초기화 */
	/* ============================= */
	
	* {
	    box-sizing: border-box;
	    margin: 0;
	    padding: 0;
	}
	
	body {
	    margin: 0;
	    font-family: 'Noto Sans KR', sans-serif;
	}
	
	a {
	    text-decoration: none;
	    color: #333;
	    /* [Action Tag] 링크 클릭 시 기본 동작 */
	    cursor: pointer; 
	}
	
	ul {
	    list-style: none;
	}

	/* ============================= */
	/* 헤더 기본 구조 */
	/* ============================= */
	
	header {
	    height: auto;
	    /* border-bottom: 1px solid #ccc; */
	    border-bottom: none;
	    padding: 15px 20px;
	    background-color: #fff;
	    position: relative;
	    /* [Action Tag] 스크롤 시 헤더 고정용 클래스 hook: .header-fixed */
	}

	/* ============================= */
	/* 상단 메뉴 (로그인 등) */
	/* ============================= */
	
	.top-menu {
	    display: flex;
	    justify-content: flex-end;
	    gap: 20px;
	    margin-bottom: 15px;
	    font-size: 13px;
	    color: #666;
	}
	
	/* [Action Tag] 마우스 오버 시 색상 변화 */
	.top-menu a:hover {
	    color: #ff6600;
	    text-decoration: underline;
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
    	
	/* ============================= */
	/* 🔍 상단 검색창 */
	/* ============================= */
	
	.top-search {
	    
	    position: relative;   /* 검색창 absolute 기준 */
	}
	
	.top-search form {
	    display: flex;
	    align-items: center;
	    gap: 6px;
	}
	
	.top-search input {
	    height: 28px;
	    padding: 0 8px;
	    border: 1px solid #ccc;
	    border-radius: 3px;
	    font-size: 13px;
	    outline: none;
	    transition: 0.2s ease;
	}
	
	.top-search input:focus {
	    border-color: #000;
	}
	
	.top-search button {
	    height: 28px;
	    padding: 0 10px;
	    border: 1px solid #000;
	    background-color: #000;
	    color: #fff;
	    font-size: 13px;
	    cursor: pointer;
	    border-radius: 3px;
	    transition: 0.2s ease;
	}
	
	.top-search button:hover {
	    background-color: #333;
	}
	
	/* 체크박스 숨기기 */
	.search-checkbox {
	    display: none;
	}
	
	/* 기본은 숨김 */
	.search-box {
	    display: none;
	    position: absolute;
	    top: 30px;
	    right: 0;
	    background: #fff;
	    padding: 8px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    white-space: nowrap;    
	}
	
	.search-box input {
	    padding: 4px 6px;
	    border: 1px solid #ccc;
	}
	
	.search-box button {
	    padding: 4px 8px;
	    background: #CD5C5C;
	    color: white;
	    border: none;
	    cursor: pointer;
	}
	
	/* 체크되면 보이기 */
	.search-checkbox:checked + .search-toggle + .search-box {
	    display: block;
	}
	
	/* ============================= */
	/* 커서 효과 (맨 아래 위치!) */
	/* ============================= */
	
	.category-menu > li:hover,
	.submenu a:hover,
	.top-menu a:hover {
	    cursor: url("link-w.cur"), pointer;
	}	    
</style>

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
                <form action="<%=path%>/boardList.jsp" method="get">
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