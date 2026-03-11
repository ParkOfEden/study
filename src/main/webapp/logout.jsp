<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 브라우저 캐시 방지 설정
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies

    // 세션 삭제 로직
    session.invalidate();
    
    // 쿠키 삭제 (기존 코드)
    Cookie cookie = new Cookie("rememberMe", "");
    cookie.setMaxAge(0);
    cookie.setPath("/");
    response.addCookie(cookie);
%>
<%-- 기존 세션 삭제 로직은 그대로 유지 --%>
<script>
    alert("로그아웃 되었습니다.");
    // 우리 사이트의 인덱스로 가는 것이 아니라, 카카오 계정 로그아웃 URL로 보냅니다.
    // client_id: 본인의 REST API 키
    // logout_redirect_uri: 로그아웃 후 돌아올 주소 (카카오 설정에 등록되어 있어야 함)
    var logoutUrl = "https://kauth.kakao.com/oauth/logout"
                  + "?client_id=412803eee2a93e9ee787821e916e63d4"
                  + "&logout_redirect_uri=" + encodeURIComponent("http://localhost:8080/14_db_member_practice/index.jsp");
    
    location.replace(logoutUrl);
</script>