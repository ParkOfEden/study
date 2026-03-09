<%-- 파일명: verifyCheck_Update.jsp --%>
<%-- 기능: 이메일 인증코드 일치 확인 및 회원 정보 DB 업데이트 처리 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.*" %>
<%
    // 1. 요청 및 세션 데이터 유효성 검사
    request.setCharacterEncoding("utf-8");
    String inputCode = request.getParameter("inputCode");
    String sessionCode = (String)session.getAttribute("authCode");

    if (sessionCode == null || !sessionCode.equals(inputCode)) {
        out.println("<script>alert('인증코드가 일치하지 않습니다.'); history.back();</script>");
        return;
    }

    // 2. 인증 성공 시 DB 업데이트 실행
    Connection conn = null;
    PreparedStatement pstmt = null;
    String msg = "";

    try {
        conn = DBCPUtil.getConnection();
        String sql = "UPDATE ACCOUNTS SET pass=?, name=?, addr=?, phone=?, gender=?, age=?, email=? WHERE id=?";
        pstmt = conn.prepareStatement(sql);

        // 세션에 임시 저장된 수정 데이터 바인딩
        pstmt.setString(1, (String)session.getAttribute("update_pass"));
        pstmt.setString(2, (String)session.getAttribute("update_name"));
        pstmt.setString(3, (String)session.getAttribute("update_addr"));
        pstmt.setString(4, (String)session.getAttribute("update_phone"));
        pstmt.setString(5, (String)session.getAttribute("update_gender"));
        pstmt.setInt(6, (Integer)session.getAttribute("update_age"));
        pstmt.setString(7, (String)session.getAttribute("update_email"));
        pstmt.setString(8, (String)session.getAttribute("update_id"));

        int result = pstmt.executeUpdate();
        if (result > 0) {
            msg = "정보가 성공적으로 수정되었습니다.";
            // 세션 정보 동기화 (헤더 등 UI 반영용)
            session.setAttribute("userName", (String)session.getAttribute("update_name"));
        }
    } catch (Exception e) {
        e.printStackTrace();
        msg = "수정 중 오류가 발생했습니다. 관리자에게 문의하세요.";
    } finally {
        // 3. 보안 및 자원 정리
        session.removeAttribute("authCode"); // 사용 완료된 인증코드 즉시 제거
        DBCPUtil.close(pstmt, conn);
    }
%>
<script>
    alert("<%= msg %>");
    location.href = "memberUpdateForm.jsp"; 
</script>