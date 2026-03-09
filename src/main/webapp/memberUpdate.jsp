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
    String id     = request.getParameter("id");
    String pass   = request.getParameter("pass");
    String name   = request.getParameter("name");
    String addr   = request.getParameter("addr");
    String phone  = request.getParameter("phone");
    String gender = request.getParameter("gender");
    String email  = request.getParameter("email");
    String ageStr = request.getParameter("age");
    int age = (ageStr != null && !ageStr.isEmpty()) ? Integer.parseInt(ageStr) : 0;

    // 관리자 여부 확인
    boolean isAdmin = "admin".equals(authUser);

    if (isAdmin) {
        // 관리자는 즉시 DB 업데이트 실행
        updateMember(id, pass, name, addr, phone, gender, age, email, out);
        response.sendRedirect("memberList.do");
    } else {
        // 일반 사용자는 세션에 수정 데이터 저장 및 인증 코드 생성
        session.setAttribute("update_id", id);
        session.setAttribute("update_pass", pass);
        session.setAttribute("update_name", name);
        session.setAttribute("update_addr", addr);
        session.setAttribute("update_phone", phone);
        session.setAttribute("update_gender", gender);
        session.setAttribute("update_age", age);
        session.setAttribute("update_email", email);

        // 6자리 인증코드 생성
        String authCode = String.format("%06d", new Random().nextInt(1000000));
        session.setAttribute("authCode", authCode);

        // 메일 발송 로직 호출 (기존에 사용하시던 MailUtil 등을 활용하세요)
        MailUtil.sendMail(email, "정보 수정 인증 코드", "코드: " + authCode);

        response.sendRedirect("verifyCode_Update.jsp");
    }
%>

<%! 
    // DB 업데이트 공통 메서드
    private void updateMember(String id, String pass, String name, String addr, String phone, String gender, int age, String email, JspWriter out) {
        try {
            Connection conn = DBCPUtil.getConnection();
            String sql = "UPDATE ACCOUNTS SET pass=?, name=?, addr=?, phone=?, gender=?, age=?, email=? WHERE id=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, pass);
            pstmt.setString(2, name);
            pstmt.setString(3, addr);
            pstmt.setString(4, phone);
            pstmt.setString(5, gender);
            pstmt.setInt(6, age);
            pstmt.setString(7, email);
            pstmt.setString(8, id);
            pstmt.executeUpdate();
            DBCPUtil.close(pstmt, conn);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
%>