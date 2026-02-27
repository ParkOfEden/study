package utils;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.PasswordAuthentication;

/**
 * Gmail SMTP 서버 인증 정보 제공 class
 * 
 * Jakarta Mail 에서 SMTP 서버에 접속할때 
 * 인증정보(ID/PASS) 를 제공하는 역할
 * 
 * 
 */
public class GmailAuthenticator extends Authenticator{
	
	private final String user;		// 발신 메일 계정
	private final String password;	// 발신 메일 계정 앱 비밀번호
	
	// 메일 서버 계정 정보 초기화
	public GmailAuthenticator() {
		Properties prop = new Properties();
		
		try {
			String path = GmailAuthenticator.class.getResource("../gmail.properties").getPath();
			System.out.println(path);
			path = path.replace("%20", " ");
			prop.load(new FileReader(path));
			System.out.println(prop);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		this.user = prop.getProperty("user"); 			// 본인 계정
		this.password = prop.getProperty("password");	// 본인 계정 앱 비밀번호
	} // end constructor

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication(this.user, this.password);
	}
	
	
	/**
	 * mail server 설정 정보를 Properties type 으로 반환
	 */
	public Properties getInfo() {
		// 인증을 받아 메일을 발신할 메일 서버 정보
		// SMTP 메일 서버 설정
		Properties prop = new Properties();
		// SMTP 메일 서버 주소
		prop.setProperty("mail.smtp.host", "smtp.gmail.com");
		// TLS 보안 포트로 연결
		prop.setProperty("mail.smtp.port", "587");
		// SMTP 서버 인증 필요 여부 : true
		prop.setProperty("mail.smtp.auth", "true");
		// STARTTLS 명령을 사용하여 TLS 암호화 연결 사용 여부 지정
		prop.setProperty("mail.smtp.starttls.enable", "true");
		return prop;
	}	

} // end GmailAuthenticator














