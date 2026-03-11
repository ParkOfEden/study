<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- inquiryMail.jsp -->
<!-- 메일 발신 테스트 -->
<%@ page import="utils.GmailAuthenticator" %>
<%@ page import="jakarta.mail.*"%>
<%@ page import="jakarta.mail.internet.*"%>
<%@ page import="java.util.Properties"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String category = request.getParameter("category");
	String email = request.getParameter("email");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	GmailAuthenticator auth = new GmailAuthenticator();

	String processMessage = "메일 발신 실패";
	String contextPath = request.getContextPath();
	
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
	
	
	try{
		// 인증 정보를 포함하는 메일 발신 Session 생성
		Session mailSession = Session.getInstance(prop, auth);
		MimeMessage message = new MimeMessage(mailSession);
		
		// 받는 사람
		// TO : 수신자
		// CC : 참조
		// BCC : 숨은 참조
		message.setRecipient(Message.RecipientType.TO, new InternetAddress("parkofeden446@gmail.com"));
		
		// 발신자 설정
		message.setFrom(new InternetAddress("chlrlms@gmail.com"));
		
		message.setReplyTo(new Address[]{new InternetAddress(email)});
		
		// 제목 설정 (제목, 인코딩)
		message.setSubject(title, "utf-8");
		
		// 본문 텍스트 설정
		

		String body = "문의 유형 : " + category + "\n"
            + "작성자 이메일 : " + email + "\n\n"
            + "문의 내용\n"
            + content;

		message.setText(body, "UTF-8");
		
		// 메일 발신 요청
		Transport.send(message); // 메일 발신 실패 시 예외 발생
		// Mail Server 에서 메일 발신을 처리할 때 까지 blocking(대기) 
		processMessage = "메일 발신 성공";
		System.out.println(processMessage);
	}catch(MessagingException e){
		e.printStackTrace();
		System.out.println("메일 발신 실패");
	}

%>

<script>
	alert('<%=processMessage%>');
	location.href='<%=contextPath%>';
</script>