package utils;

/*import java.io.FileNotFoundException;*/
import java.io.FileReader;
/*import java.io.IOException;*/
import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.PasswordAuthentication;

public class GmailAuthenticator extends Authenticator {
    
    private String user;        // 발신 메일 계정
    private String password;    // 발신 메일 계정 앱 비밀번호
    private String receiver;    // 수신 메일 계정 (추가)
    
    public GmailAuthenticator() {
        Properties prop = new Properties();
        try {
            String path = GmailAuthenticator.class.getResource("../gmail.properties").getPath();
            path = path.replace("%20", " ");
            prop.load(new FileReader(path));
            
            this.user = prop.getProperty("user");
            this.password = prop.getProperty("password");
            this.receiver = prop.getProperty("receiver"); // 파일에서 receiver 읽기
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(this.user, this.password);
    }
    
    // 발신자 주소 반환
    public String getUser() {
        return this.user;
    }

    // 수신자 주소 반환 (추가)
    public String getReceiver() {
        return this.receiver;
    }

    public Properties getInfo() {
        Properties prop = new Properties();
        prop.setProperty("mail.smtp.host", "smtp.gmail.com");
        prop.setProperty("mail.smtp.port", "587");
        prop.setProperty("mail.smtp.auth", "true");
        prop.setProperty("mail.smtp.starttls.enable", "true");
        return prop;
    }
}