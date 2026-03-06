<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.*" %>

<%
    request.setCharacterEncoding("utf-8");

    String inputCode = request.getParameter("inputCode");
    String sessionCode = (String)session.getAttribute("authCode");

    // 변수 초기화 (기본값 설정)
    String msg = "";
    String nextPage = "";

    if (sessionCode == null) {
        msg = "세션 정보가 만료되었습니다.";
        nextPage = "join.jsp";
    } 
    else if (inputCode == null || !inputCode.equals(sessionCode)) {
        msg = "인증코드가 일치하지 않습니다.";
        nextPage = "verifyCode.jsp";
    } 
    else {
        // 인증 성공 → 회원 DB 저장 로직 시작
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBCPUtil.getConnection();

            String sql = "INSERT INTO ACCOUNTS "
                       + "(id, pass, name, addr, phone, gender, age, email) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, (String)session.getAttribute("join_id"));
            pstmt.setString(2, (String)session.getAttribute("join_pass"));
            pstmt.setString(3, (String)session.getAttribute("join_name"));
            pstmt.setString(4, (String)session.getAttribute("join_addr"));
            pstmt.setString(5, (String)session.getAttribute("join_phone"));
            pstmt.setString(6, (String)session.getAttribute("join_gender"));
            
            // age 처리: Integer 또는 String 대응
            Object ageObj = session.getAttribute("join_age");
            int age = 0;
            if (ageObj instanceof Integer) {
                age = (Integer)ageObj;
            } else if (ageObj instanceof String) {
                age = Integer.parseInt((String)ageObj);
            }
            pstmt.setInt(7, age);
            
            pstmt.setString(8, (String)session.getAttribute("join_email"));

            int result = pstmt.executeUpdate();

            if (result == 1) {
                msg = "회원가입 성공 🎉";
                nextPage = "login.jsp";
                
                // 가입 완료 후 불필요한 세션 데이터 제거
                session.removeAttribute("authCode");
                session.removeAttribute("join_id");
                session.removeAttribute("join_pass");
                session.removeAttribute("join_name");
                session.removeAttribute("join_addr");
                session.removeAttribute("join_phone");
                session.removeAttribute("join_gender");
                session.removeAttribute("join_age");
                session.removeAttribute("join_email");
            } else {
                msg = "회원가입 실패 (데이터 미삽입)";
                nextPage = "join.jsp";
            }
        } catch (Exception e) {
            e.printStackTrace();
            msg = "DB 오류: " + e.getMessage();
            nextPage = "join.jsp";
        } finally {
            DBCPUtil.close(pstmt, conn);
        }
    } // else 블록 닫기 (중요)
%>

<%-- 스크립트는 모든 로직이 끝난 후 한 번만 실행되도록 위치 --%>
<script>
    alert("<%= msg %>");
    location.href = "<%= nextPage %>";
</script>