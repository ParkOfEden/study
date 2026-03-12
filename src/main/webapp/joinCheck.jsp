<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, utils.*, java.util.*" %>
<%@ page import="jakarta.mail.*, jakarta.mail.internet.*" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="jakarta.servlet.http.Part" %>

<%
    request.setCharacterEncoding("utf-8");

    // 1. Multipart 데이터 처리 (파일 및 텍스트 파라미터 수집)
    // 주의: enctype="multipart/form-data" 설정 시 request.getParameter가 null을 반환할 수 있음
    // 서블릿 버전이나 설정에 따라 getPart를 통해 텍스트도 추출해야 할 수 있습니다.
    
    String id = request.getParameter("id");
    String nickname = request.getParameter("nickname");
    String pass = request.getParameter("pass");
    String name = request.getParameter("name");
    String addr = request.getParameter("addr");
    String phone = request.getParameter("phone");
    String gender = request.getParameter("gender");
    String email = request.getParameter("email");
    
    String ageStr = request.getParameter("age");
    int age = (ageStr != null && !ageStr.isEmpty()) ? Integer.parseInt(ageStr) : 0;

    // 2. 프로필 이미지 바이너리 데이터 추출
    Part filePart = request.getPart("profile_img");
    byte[] profileBytes = null;
    
    if (filePart != null && filePart.getSize() > 0) {
        try (InputStream is = filePart.getInputStream()) {
            profileBytes = is.readAllBytes(); // 이미지 데이터를 byte 배열로 로드
        }
    }

    if (nickname == null || nickname.trim().isEmpty()) {
        nickname = id;
    }
    
    Connection conn = DBCPUtil.getConnection();
    PreparedStatement pstmt = null;
    ResultSet rs = null;    
    
    String msg = "";
    String nextPage = "";

    try {
        // 중복 체크
        String sql = "SELECT id FROM ACCOUNTS WHERE id=? OR email=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, email);
        rs = pstmt.executeQuery();
        
        if (rs.next()) {
            msg = "아이디 또는 이메일이 이미 존재합니다.";
            nextPage = "join.jsp";
        } else {
            // 인증코드 생성
            String authCode = String.valueOf((int)(Math.random() * 900000) + 100000);
            
            // 3. 세션에 모든 정보 저장 (이미지 포함)
            session.setAttribute("join_id", id);
            session.setAttribute("join_nickname", nickname);
            session.setAttribute("join_pass", pass);
            session.setAttribute("join_name", name);
            session.setAttribute("join_addr", addr);
            session.setAttribute("join_phone", phone);
            session.setAttribute("join_gender", gender);
            session.setAttribute("join_age", age);
            session.setAttribute("join_email", email);
            session.setAttribute("join_profile_blob", profileBytes); // 이미지 데이터 저장
            session.setAttribute("authCode", authCode);
            
            // 4. 메일 발송 로직 (기존과 동일)
            GmailAuthenticator auth = new GmailAuthenticator();
            Properties prop = auth.getInfo(); 
            Session mailSession = Session.getInstance(prop, auth);
            MimeMessage message = new MimeMessage(mailSession);
            
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setFrom(new InternetAddress(auth.getUser(), "월클의류"));
            message.setSubject("[월클의류] 회원가입 인증번호입니다.", "UTF-8");
            
            String joinContent = "<div style='font-family: sans-serif; max-width: 500px; margin: 0 auto; border: 1px solid #ddd; border-radius: 10px; overflow: hidden;'>"
                + "  <div style='background-color: #333; color: #fff; padding: 20px; text-align: center;'>"
                + "    <h1 style='margin: 0; font-size: 24px;'>Welcome to 월클의류!</h1>"
                + "  </div>"
                + "  <div style='padding: 30px; line-height: 1.6; color: #333;'>"
                + "    <p style='font-size: 16px;'>안녕하세요! <strong>" + name + "</strong>님, 반갑습니다.</p>"
                + "    <p>회원가입을 완료하기 위해 아래의 인증번호를 입력해 주세요.</p>"
                + "    <div style='margin: 30px 0; padding: 20px; background-color: #f9f9f9; border-radius: 5px; text-align: center;'>"
                + "      <span style='font-size: 32px; font-weight: bold; color: #d16464; letter-spacing: 5px;'>" + authCode + "</span>"
                + "    </div>"
                + "  </div>"
                + "</div>";

            message.setContent(joinContent, "text/html;charset=utf-8");
            Transport.send(message);
            
            msg = "인증코드가 이메일로 발송되었습니다.";
            nextPage = "verifyCode.jsp";
        } 
    } catch (Exception e) {
        e.printStackTrace();
        msg = "처리 실패: " + e.getMessage();
        nextPage = "join.jsp";
    } finally {
        DBCPUtil.close(rs, pstmt, conn);
    }
%>

<script>
    alert("<%= msg %>");
    location.replace("<%= nextPage %>");
</script>