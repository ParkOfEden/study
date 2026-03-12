<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.*, java.util.Random, java.io.*" %>
<%@ page import="jakarta.servlet.http.Part" %>

<%
    request.setCharacterEncoding("UTF-8");
    String authUser = (String)session.getAttribute("authUser");
    
    if(authUser == null){
        response.sendRedirect("login.jsp");
        return;
    }

    // [중요] MultipartConfig 설정이 되어있어야 getPart()가 작동합니다.
    String id       = request.getParameter("id");
    String nickname = request.getParameter("nickname");
    String pass     = request.getParameter("pass");
    String name     = request.getParameter("name");
    String addr     = request.getParameter("addr");
    String phone    = request.getParameter("phone");
    String gender   = request.getParameter("gender");
    String email    = request.getParameter("email");
    String ageStr   = request.getParameter("age");
    int age = (ageStr != null && !ageStr.isEmpty()) ? Integer.parseInt(ageStr) : 0;

    // 프로필 이미지 수집
    Part filePart = request.getPart("profile_img");
    byte[] profileBytes = null;
    if (filePart != null && filePart.getSize() > 0) {
        try (InputStream is = filePart.getInputStream()) {
            profileBytes = is.readAllBytes();
        }
    }

    if (nickname == null || nickname.trim().isEmpty()) {
        nickname = id;
    }

    boolean isAdmin = "admin".equals(authUser);

    if (isAdmin) {
        // 관리자는 즉시 업데이트 (이미지 포함)
        updateMember(id, nickname, pass, name, addr, phone, gender, age, email, profileBytes);
        response.sendRedirect("memberList.do");
    } else {
        // 일반 사용자는 세션에 임시 저장 (이미지 byte[] 포함)
        session.setAttribute("update_id", id);
        session.setAttribute("update_nickname", nickname);
        session.setAttribute("update_pass", pass);
        session.setAttribute("update_name", name);
        session.setAttribute("update_addr", addr);
        session.setAttribute("update_phone", phone);
        session.setAttribute("update_gender", gender);
        session.setAttribute("update_age", age);
        session.setAttribute("update_email", email);
        session.setAttribute("update_profile_blob", profileBytes); // 이미지 세션 저장

        String authCode = String.format("%06d", new java.util.Random().nextInt(1000000));
        session.setAttribute("authCode", authCode);

        try {
            String subject = "[내 사이트] 회원정보 수정을 위한 인증번호입니다.";
            String content = "<h2>안녕하세요, " + name + "님!</h2>"
                           + "<p>정보 수정을 완료하려면 아래 인증번호를 입력해 주세요.</p>"
                           + "<h3>인증번호: <span style='color:blue;'>" + authCode + "</span></h3>";
            
            MailUtil.sendMail(email, subject, content); 
            response.sendRedirect("verifyCode_Update.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('메일 발송에 실패했습니다.'); history.back();</script>");
        }
    }
%>

<%! 
    private void updateMember(String id, String nickname, String pass, String name, String addr, String phone, String gender, int age, String email, byte[] profileBlob) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBCPUtil.getConnection();
            
            // 이미지가 넘어왔을 때와 아닐 때를 구분하여 쿼리 작성 (이미지 없으면 기존 값 유지)
            String sql;
            if (profileBlob != null) {
                sql = "UPDATE ACCOUNTS SET pass=?, name=?, nickname=?, addr=?, phone=?, gender=?, age=?, email=?, profile_blob=? WHERE id=?";
            } else {
                sql = "UPDATE ACCOUNTS SET pass=?, name=?, nickname=?, addr=?, phone=?, gender=?, age=?, email=? WHERE id=?";
            }

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, pass);
            pstmt.setString(2, name);
            pstmt.setString(3, nickname);
            pstmt.setString(4, addr);
            pstmt.setString(5, phone);
            pstmt.setString(6, gender);
            pstmt.setInt(7, age);
            pstmt.setString(8, email);
            
            if (profileBlob != null) {
                pstmt.setBytes(9, profileBlob);
                pstmt.setString(10, id);
            } else {
                pstmt.setString(9, id);
            }
            
            pstmt.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            DBCPUtil.close(pstmt, conn);
        }
    }
%>