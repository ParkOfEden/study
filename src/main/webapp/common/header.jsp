<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
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
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    </head>
<body>
<!-- 
<style>
	앞으로는 여기에 css 작업 하지 마시고 header.css 에서 작업해주세요 :-)
	(여기 작성된 코드를 지운 것이 아니고 header.css 에 옮겨놓음)
	이유 1 : index.jsp(등) 에 css 효과 include 처리 되어서 그대로 영향
	이유 2 : 만약 <html> 태그를 사용해서 </html>처리를 해버리면 include 한 index.jsp 등에서 닫힌 <html>태그에 이어서 태그를 작성하는 꼴이 나버림..
		   이 이유때문에 남아서 작업해도 해결못하고 있다가 집에 가서 전수조사해서 밝혀냄..
    결론 : header.jsp 에서는 style 태그에 작업 금지 (index, footer 전역 효과 또는 충돌되어 안먹힘), <html> 열고 </html> 닫기 금지 (치명적, 스파게티 코드 발생 가능)
</style>
 -->


<!-- header.jsp 에는 <header></header>태그 안에서만 작성하되, css 효과는 header.css에서 처리할 것 
	 변경사항 : html 선언 & css 링크 선언 (절대 링크로 요청) & body 선언을 헤더에서 작업 후 일괄 include 처리
-->	 

<header>

  <!-- 🔹 1 줄 상단 메뉴 -->
  <ul class="top-menu">
    <li><a href="index.jsp">홈</a></li>
	<li><a href="<%=path%>/sendMail.jsp">SEND MAIL</a></li>
<% if(authUser == null){ %>
    <li><a href="login.jsp">로그인</a></li>
    <li><a href="join.jsp">회원가입</a></li>
    <li><a href="cuscen.jsp">고객센터</a></li>
<% } else { %>
    <!-- 수정된 부분: 아이디 클릭 시 memberUpdateForm.jsp 로 이동 -->
    <li><a href="memberUpdateForm.jsp"><%= userName %></a>님 환영합니다</li>
    
    <li><a href="<%=path%>/logout.jsp">로그아웃</a></li>
    <li><a href="<%=path%>/memberList.jsp">회원관리</a></li>
    <li><a href="<%=path%>/orin.jsp">주문조회</a></li>
    
    <%-- admin 일 때만 보이는 글쓰기 버튼 --%>
    <% if ("admin".equals(authUser)) { %>
        <li><a href="<%=path%>/write.jsp">글쓰기</a></li>
    <% } %>
    
<% } %>
  </ul>

  <!-- 🔹 2 줄 카테고리 메뉴 -->
  <!-- onclick 제거, CSS hover 로 작동 -->
  <ul class="category-menu">
    
    <li class="has-submenu">

        NEW &amp; BEST <!-- & 보다 &amp; 가 안전 -->
        <ul class="submenu">
            <li><a href="Headerjump/new.jsp">신상품 (New)</a></li>
            <li><a href="Headerjump/best.jsp">베스트 (Best)</a></li>
            <li><a href="Headerjump/mdre.jsp">MD 추천</a></li>
        </ul>
    </li>

    <li class="has-submenu">
        TOP
        <ul class="submenu">
            <li><a href="Headerjump/Tshirt.jsp">티셔츠</a></li>
            <li><a href="Headerjump/blouse.jsp">블라우스</a></li>
            <li><a href="Headerjump/Shirt.jsp">셔츠</a></li>
            <li><a href="Headerjump/knsw.jsp">니트/스웨터</a></li>
            <li><a href="Headerjump/card.jsp">카디건</a></li>
            <li><a href="Headerjump/hosw.jsp">후드/맨투맨</a></li>
        </ul>
    </li>

    <li class="has-submenu">
        OUTER
        <ul class="submenu">
            <li><a href="Headerjump/jacket.jsp">자켓</a></li>
            <li><a href="Headerjump/coat.jsp">코트</a></li>
            <li><a href="Headerjump/pacoat.jsp">패딩/경량</a></li>
            <li><a href="Headerjump/vest.jsp">조끼</a></li>
            <li><a href="Headerjump/cardigan.jsp">가디건</a></li>
        </ul>
    </li>

    <li class="has-submenu">
        BOTTOM
        <ul class="submenu">
            <li><a href="Headerjump/demin.jsp">데님 (Jeans)</a></li>
            <li><a href="Headerjump/slacks.jsp">슬랙스</a></li>
            <li><a href="Headerjump/widep.jsp">와이드 팬츠</a></li>
            <li><a href="Headerjump/skirt.jsp">스커트</a></li>
            <li><a href="Headerjump/shorts.jsp">쇼츠</a></li>
            <li><a href="Headerjump/train.jsp">트레이닝</a></li>
        </ul>
    </li>

    <li class="has-submenu">
        ONE-PIECE
        <ul class="submenu">
            <li><a href="Headerjump/onepiece.jsp">원피스</a></li>
            <li><a href="Headerjump/jumps.jsp">점프수트</a></li>
            <li><a href="Headerjump/Romper.jsp">롬퍼</a></li>
        </ul>
    </li>

    <li class="has-submenu">
        SHOES &amp; BAG
        <ul class="submenu">
            <li><a href="Headerjump/sneak.jsp">스니커즈</a></li>
            <li><a href="Headerjump/shoesheel.jsp">구두/힐</a></li>
            <li><a href="Headerjump/boots.jsp">부츠</a></li>
            <li><a href="Headerjump/bag.jsp">가방</a></li>
            <li><a href="Headerjump/capacc.jsp">모자/액세서리</a></li>
        </ul>
    </li>

    <li class="has-submenu sale-text">
        SALE
        <ul class="submenu">
            <li><a href="Headerjump/alldis.jsp">전상품 할인</a></li>
            <li><a href="Headerjump/seoff.jsp">시즌 오프</a></li>
            <li><a href="Headerjump/Spzone.jsp">특가 존</a></li>
        </ul>
    </li>

  </ul>

</header>