package utils;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class MailUtil {
    public static void sendMail(String to, String subject, String content) {
        // 1. 인증 정보 및 설정 로드
        GmailAuthenticator auth = new GmailAuthenticator();
        Properties prop = auth.getInfo();

        // 2. 세션 생성
        Session session = Session.getInstance(prop, auth);

        try {
            // 3. 메시지 구성
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(auth.getUser())); // 발신자
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(to)); // 수신자
            message.setSubject(subject); // 제목
            message.setContent(content, "text/html; charset=utf-8"); // 내용 (HTML 형식)

            // 4. 메일 전송
            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
            throw new RuntimeException("메일 발송 중 오류 발생: " + e.getMessage());
        }
    }
}