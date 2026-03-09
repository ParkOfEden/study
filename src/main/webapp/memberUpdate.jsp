<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.*, java.util.Random" %>
<%
    request.setCharacterEncoding("UTF-8");
    String authUser = (String)session.getAttribute("authUser");
    
    if(authUser == null){
        response.sendRedirect("login.jsp");
        return;
    }

    // 폼 파라미터 수집
    String id       = request.getParameter("id");
    String nickname = request.getParameter("nickname"); // [추가] 닉네임 수집
    String pass     = request.getParameter("pass");
    String name     = request.getParameter("name");
    String addr     = request.getParameter("addr");
    String phone    = request.getParameter("phone");
    String gender   = request.getParameter("gender");
    String email    = request.getParameter("email");
    String ageStr   = request.getParameter("age");
    int age = (ageStr != null && !ageStr.isEmpty()) ? Integer.parseInt(ageStr) : 0;

    // [추가] 닉네임 기본값 처리 (아이디로 설정)
    if (nickname == null || nickname.trim().isEmpty()) {
        nickname = id;
    }

    // 관리자 여부 확인
    boolean isAdmin = "admin".equals(authUser);

    if (isAdmin) {
        // [수정] 메서드 호출 시 nickname 추가
        updateMember(id, nickname, pass, name, addr, phone, gender, age, email);
        response.sendRedirect("memberList.do");
    } else {
        // 일반 사용자는 세션에 수정 데이터 저장
        session.setAttribute("update_id", id);
        session.setAttribute("update_nickname", nickname); // [추가] 닉네임 세션 저장
        session.setAttribute("update_pass", pass);
        session.setAttribute("update_name", name);
        session.setAttribute("update_addr", addr);
        session.setAttribute("update_phone", phone);
        session.setAttribute("update_gender", gender);
        session.setAttribute("update_age", age);
        session.setAttribute("update_email", email);

        // 인증코드 생성 및 발송 로직 (기존 동일)
        String authCode = String.format("%06d", new java.util.Random().nextInt(1000000));
        session.setAttribute("authCode", authCode);
        // MailUtil.sendMail(...) 호출 생략
        response.sendRedirect("verifyCode_Update.jsp");
    }
%>

<%! 
    // [수정] DB 업데이트 메서드 (nickname 매개변수 및 쿼리 수정)
    private void updateMember(String id, String nickname, String pass, String name, String addr, String phone, String gender, int age, String email) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBCPUtil.getConnection();
            // 쿼리에 nickname=?, 추가
            String sql = "UPDATE ACCOUNTS SET pass=?, name=?, nickname=?, addr=?, phone=?, gender=?, age=?, email=? WHERE id=?";
            pstmt = conn.prepareStatement(sql);
            
            // 바인딩 순서 주의!
            pstmt.setString(1, pass);
            pstmt.setString(2, name);
            pstmt.setString(3, nickname); // [추가]
            pstmt.setString(4, addr);
            pstmt.setString(5, phone);
            pstmt.setString(6, gender);
            pstmt.setInt(7, age);
            pstmt.setString(8, email);
            pstmt.setString(9, id);
            
            pstmt.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            DBCPUtil.close(pstmt, conn);
        }
    }
%>