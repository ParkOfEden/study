<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="utils.GmailAuthenticator" %>
<%@ page import="jakarta.mail.*, jakarta.mail.internet.*" %>
<%@ page import="java.io.File" %>
<%
    // 1. Authenticator 객체 생성 (생성자에서 properties 로드됨)
    GmailAuthenticator auth = new GmailAuthenticator();

    String processMessage = ""; 
    
    // 2. 세션 생성 (설정 정보와 인증 정보 전달)
    Session mailSession = Session.getInstance(auth.getInfo(), auth);
    
    try {
        MimeMessage message = new MimeMessage(mailSession);
        
        // 3. 발신자 설정 (properties의 user 값 사용)
        message.setFrom(new InternetAddress(auth.getUser()));
        
        // 4. 수신자 설정 (properties의 receiver 값 사용)
        message.setRecipient(
            Message.RecipientType.TO, 
            new InternetAddress(auth.getReceiver())
        );
        
        message.setSubject("첨부파일 테스트 (동적 설정 적용)");

        // 5. 메일 본문 및 첨부파일 구성 (Multipart)
        Multipart multipart = new MimeMultipart();
        
        // 텍스트 파트
        MimeBodyPart textPart = new MimeBodyPart();
        textPart.setContent("<h2 style='color:green;'>설정 파일로부터 읽어온 메일입니다.</h2>", "text/html;charset=utf-8");
        multipart.addBodyPart(textPart);
        
        // 첨부파일 파트
        File file = new File("C:\\Temp\\cat1.jpg");
        if (file.exists()) {
            MimeBodyPart filePart = new MimeBodyPart();
            filePart.attachFile(file);
            multipart.addBodyPart(filePart);
        }
        
        // 최종 메시지에 multipart 설정
        message.setContent(multipart);
        
        // 6. 메일 발송
        Transport.send(message);
        processMessage = "메일 발신 성공 (수신: " + auth.getReceiver() + ")";
        
    } catch (Exception e) {
        processMessage = "메일 발신 실패: " + e.getMessage();
        e.printStackTrace();
    }
%>
<script>
    alert('<%=processMessage%>');
    location.href='<%=request.getContextPath()%>';
</script>