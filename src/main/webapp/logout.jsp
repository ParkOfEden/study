<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- logout.jsp -->
<!-- 로그아웃 요청 처리 -->
<% //session에 저장된 속성값들 중에 로그인 정보용으로 저장한 속성(login) 삭제
session.removeAttribute("authUser");
session.removeAttribute("authNum");
// session.invalidate(); => 세션 전체 삭제 (안전)

//사용자 브라우저에 등록된 쿠키 정보제거
Cookie cookie = new Cookie("rememberMe","");
cookie.setMaxAge(0); // 기본값은 session
//name이 같더라도 path가 틀리면 다른 쿠키
cookie.setPath("/");
response.addCookie(cookie);

%>
<script>
alert("로그아웃 되었습니다.");
location.replace("login.jsp"); //속성 제거후 로그인 페이지로 이동
</script>
