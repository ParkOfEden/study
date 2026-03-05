<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, utils.*, java.util.*" %>
<%@ page import="jakarta.mail.*, jakarta.mail.internet.*" %>

<%
    request.setCharacterEncoding("utf-8");

    String id = request.getParameter("id");
    String pass = request.getParameter("pass");
    String name = request.getParameter("name");
    String addr = request.getParameter("addr");
    String phone = request.getParameter("phone");
    String gender = request.getParameter("gender");
    String email = request.getParameter("email");
    int age = Integer.parseInt(request.getParameter("age"));
    
    Connection conn = DBCPUtil.getConnection();
    PreparedStatement pstmt = null;
    ResultSet rs = null;    
    
    String msg = "";
    String nextPage = "";

    try {
        // 1. 중복 체크
        String sql = "SELECT id FROM ACCOUNTS WHERE id=? OR email=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, email);
        rs = pstmt.executeQuery();
        
        if (rs.next()) {
            msg = "아이디 또는 이메일이 이미 존재합니다.";
            nextPage = "join.jsp";
        } else {
            // 2. 인증코드 생성
            String authCode = String.valueOf((int)(Math.random() * 900000) + 100000);
            
            // 3. 세션에 정보 저장
            session.setAttribute("join_id", id);
            session.setAttribute("join_pass", pass);
            session.setAttribute("join_name", name);
            session.setAttribute("join_addr", addr);
            session.setAttribute("join_phone", phone);
            session.setAttribute("join_gender", gender);
            session.setAttribute("join_age", age);
            session.setAttribute("join_email", email);
            session.setAttribute("authCode", authCode);
            
            // 4. 메일 발송 설정
            Properties prop = new Properties();
            prop.setProperty("mail.smtp.host", "smtp.gmail.com");
            prop.setProperty("mail.smtp.port", "587");
            prop.setProperty("mail.smtp.auth", "true");
            prop.setProperty("mail.smtp.starttls.enable", "true");
            
            GmailAuthenticator auth = new GmailAuthenticator();
            Session mailSession = Session.getInstance(prop, auth);
            
            MimeMessage message = new MimeMessage(mailSession);
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setFrom(new InternetAddress("pshyun9063@gmail.com", "월클의류"));
            message.setSubject("[월클의류] 회원가입 인증번호입니다.", "UTF-8");
            
            // HTML 본문 구성
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
        } // end else
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