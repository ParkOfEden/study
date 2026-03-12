<%-- 파일명: verifyCheck_Update.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.*, java.util.*" %>

<%
    request.setCharacterEncoding("utf-8");

    // 1. 인증 코드 검증
    String inputCode = request.getParameter("inputCode");
    String sessionCode = (String)session.getAttribute("authCode");

    if (sessionCode == null || !sessionCode.equals(inputCode)) {
        out.println("<script>alert('인증코드가 일치하지 않습니다.'); history.back();</script>");
        return;
    }

    // 2. DB 업데이트 준비
    Connection conn = null;
    PreparedStatement pstmt = null;
    String msg = "";

    try {
        conn = DBCPUtil.getConnection();

        // 세션에서 수정 대기 중인 데이터 추출
        String id       = (String)session.getAttribute("update_id");
        String pass     = (String)session.getAttribute("update_pass");
        String name     = (String)session.getAttribute("update_name");
        String nickname = (String)session.getAttribute("update_nickname");
        String addr     = (String)session.getAttribute("update_addr");
        String phone    = (String)session.getAttribute("update_phone");
        String gender   = (String)session.getAttribute("update_gender");
        String email    = (String)session.getAttribute("update_email");
        
        // age 타입 안전 처리
        Object ageObj = session.getAttribute("update_age");
        int age = (ageObj instanceof Integer) ? (Integer)ageObj : Integer.parseInt(String.valueOf(ageObj));
        
        // 이미지 데이터 추출
        byte[] profileBytes = (byte[])session.getAttribute("update_profile_blob");

        // 3. SQL 동적 구성 (이미지가 있을 때만 업데이트 목록에 추가)
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE ACCOUNTS SET pass=?, name=?, nickname=?, addr=?, phone=?, gender=?, age=?, email=?");
        
        if (profileBytes != null && profileBytes.length > 0) {
            sql.append(", profile_blob=?");
        }
        sql.append(" WHERE id=?");

        pstmt = conn.prepareStatement(sql.toString());
        
        // 바인딩
        pstmt.setString(1, pass);
        pstmt.setString(2, name);
        pstmt.setString(3, nickname);
        pstmt.setString(4, addr);
        pstmt.setString(5, phone);
        pstmt.setString(6, gender);
        pstmt.setInt(7, age);
        pstmt.setString(8, email);
        
        if (profileBytes != null && profileBytes.length > 0) {
            pstmt.setBytes(9, profileBytes);
            pstmt.setString(10, id);
        } else {
            pstmt.setString(9, id);
        }

        int result = pstmt.executeUpdate();

        if (result > 0) {
            msg = "정보가 성공적으로 수정되었습니다.";
            // 세션 정보 동기화
            session.setAttribute("userName", name);
            session.setAttribute("userNickname", nickname);
            
            // 4. 보안 및 자원 정리 (수정 완료 후 세션 데이터 일괄 삭제)
            Enumeration<String> attrNames = session.getAttributeNames();
            while (attrNames.hasMoreElements()) {
                String attr = attrNames.nextElement();
                if (attr.startsWith("update_") || attr.equals("authCode")) {
                    session.removeAttribute(attr);
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        msg = "수정 중 오류가 발생했습니다: " + e.getMessage();
    } finally {
        DBCPUtil.close(pstmt, conn);
    }
%>

<script>
    alert("<%= msg %>");
    location.href = "memberUpdateForm.jsp"; 
</script>