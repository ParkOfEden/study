<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, utils.*" %>
<!-- 로그인 요청 처리 페이지 - loginCheck.jsp -->

<%
    // 1. 한글 인코딩 및 파라미터 수집
    request.setCharacterEncoding("utf-8");
    String id = request.getParameter("id");
    String pass = request.getParameter("pass");
    String rememberMe = request.getParameter("rememberMe"); // 체크박스 값 수집
    
    // 2. DB 연결 준비
    Connection conn = DBCPUtil.getConnection();
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String msg = "";
    String nextPage = "";

    try {
        // 3. 아이디와 비밀번호가 일치하는 사용자 조회
        String sql = "SELECT num, name FROM ACCOUNTS WHERE id=? AND pass=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, pass);
        
        rs = pstmt.executeQuery();

        if(rs.next()) {
            // [성공] 일치하는 회원 있음
            int userNum = rs.getInt("num");   // 회원탈퇴 로직 처리용
            String userName = rs.getString("name");
            
            // 세션에 로그인 정보 저장 (이게 핵심!)
            session.setAttribute("authUser", id);
            session.setAttribute("authNum", userNum);   // 회원탈퇴 로직 처리용
            session.setAttribute("userName", userName);
            //자동 로그인 쿠키 처리 (추가된 부분)
            if(rememberMe != null && rememberMe.equals("login")) {
                // "rememberMe"라는 이름으로 아이디를 1일간 저장하는 쿠키 생성
                Cookie cookie = new Cookie("rememberMe", id);
                cookie.setMaxAge(60 * 60 * 24 * 1); // 1일
                cookie.setPath("/"); // 프로젝트 전역에서 사용
                response.addCookie(cookie);
            }
            msg = userName + "님, 환영합니다!";
            if ("admin".equals(id)) {
                nextPage = "boardWrite.jsp"; // 관리자면 글쓰기로
            } else {
                nextPage = "index.jsp"; // 일반 유저는 메인으로
            }
        } else {
            // [실패] 아이디 또는 비밀번호 불일치
            msg = "아이디 또는 비밀번호가 일치하지 않습니다.";
            nextPage = "login.jsp"; // 다시 로그인 페이지로
        }
    } catch(Exception e) {
        e.printStackTrace();
        msg = "로그인 처리 중 오류가 발생했습니다.";
        nextPage = "login.jsp";
    } finally {
        DBCPUtil.close(rs, pstmt, conn);
    }
%>

<script>
    alert('<%= msg %>');
    location.replace('<%= nextPage %>');
</script>




