<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- sendMail.jsp  -->
<!-- 메일 발신 테스트  -->
<%@ page import="utils.GmailAuthenticator" %>
<%@ page import="jakarta.mail.*" %>
<%@ page import="jakarta.mail.internet.*"%>
<%@ page import="java.util.Properties" %>
<% 
    GmailAuthenticator auth = new GmailAuthenticator();
    
    // Properties에서 읽어온 값 변수 할당
    String senderEmail = auth.getUser();
    String receiverEmail = auth.getReceiver();

    String processMessage = "메일 발신 실패";
    String contextPath = request.getContextPath();
    
    Properties prop = new Properties();
    prop.setProperty("mail.smtp.host", "smtp.gmail.com");
    prop.setProperty("mail.smtp.port", "587");
    prop.setProperty("mail.smtp.auth", "true");
    prop.setProperty("mail.smtp.starttls.enable", "true");

    try {
        Session mailSession = Session.getInstance(prop, auth);
        MimeMessage message = new MimeMessage(mailSession);
        
        // [수정] 수신자 설정 (Properties 파일 기반)
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(receiverEmail));
        
        // [수정] 발신자 설정 (Properties 파일 기반)
        message.setFrom(new InternetAddress(senderEmail));
        
        message.setSubject("메일 테스트", "utf-8");
        message.setText("설정 파일에서 불러온 수신자에게 발송된 메일입니다.", "UTF-8");
        
        Transport.send(message);
        processMessage = "메일 발신 성공";
        
    } catch(MessagingException e) {
        e.printStackTrace();
    }
%>
<script>
	alert('<%=processMessage%>');
	location.href='<%=contextPath%>';
</script>