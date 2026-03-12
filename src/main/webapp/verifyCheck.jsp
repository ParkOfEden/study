<!-- verifyCheck.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- java.util.* 또는 java.util.Enumeration 추가 --%>
<%@ page import="java.sql.*, utils.*, java.util.*" %>

<%
    request.setCharacterEncoding("utf-8");

    String inputCode = request.getParameter("inputCode");
    String sessionCode = (String)session.getAttribute("authCode");

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
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBCPUtil.getConnection();

            // 1. SQL 수정: profile_blob 컬럼 추가
            String sql = "INSERT INTO ACCOUNTS "
                       + "(id, nickname, pass, name, addr, phone, gender, age, email, profile_blob) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);

            // 2. 세션 데이터 바인딩
            pstmt.setString(1, (String)session.getAttribute("join_id"));
            pstmt.setString(2, (String)session.getAttribute("join_nickname"));
            pstmt.setString(3, (String)session.getAttribute("join_pass"));
            pstmt.setString(4, (String)session.getAttribute("join_name"));
            pstmt.setString(5, (String)session.getAttribute("join_addr"));
            pstmt.setString(6, (String)session.getAttribute("join_phone"));
            pstmt.setString(7, (String)session.getAttribute("join_gender"));
            
            // age 처리
            Object ageObj = session.getAttribute("join_age");
            int age = 0;
            if (ageObj instanceof Integer) {
                age = (Integer)ageObj;
            } else if (ageObj instanceof String) {
                age = Integer.parseInt((String)ageObj);
            }
            pstmt.setInt(8, age);
            
            pstmt.setString(9, (String)session.getAttribute("join_email"));

            // 3. BLOB 데이터 바인딩 (이미지 바이너리)
            byte[] profileBytes = (byte[])session.getAttribute("join_profile_blob");
            if (profileBytes != null && profileBytes.length > 0) {
                pstmt.setBytes(10, profileBytes);
            } else {
                pstmt.setNull(10, java.sql.Types.BLOB);
            }

            int result = pstmt.executeUpdate();

            if (result == 1) {
                msg = "회원가입 성공 🎉";
                nextPage = "login.jsp";
                
                // 가입 완료 후 세션 데이터 일괄 제거
                Enumeration<String> attributes = session.getAttributeNames();
                while (attributes.hasMoreElements()) {
                    String attr = attributes.nextElement();
                    if (attr.startsWith("join_") || attr.equals("authCode")) {
                        session.removeAttribute(attr);
                    }
                }
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
    }
%>

<script>
    alert("<%= msg %>");
    location.href = "<%= nextPage %>";
</script>