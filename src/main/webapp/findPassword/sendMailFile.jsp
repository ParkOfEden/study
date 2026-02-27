<!-- sendMailFile.jsp  -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 첨부파일 메일 발신 테스트  -->
<%@ page import="utils.GmailAuthenticator" %>
<%@ page import="jakarta.mail.*, jakarta.mail.internet.*" %>
<!-- 첨부파일 정보 저장  -->
<%@ page import="java.io.File" %>
<%
GmailAuthenticator auth=new GmailAuthenticator();

//메일 발신 요청 처리 결과를 저장할 변수 선언
	String processMessage =""; 
	

Session mailSession=Session.getInstance(auth.getInfo(),auth);
try{
	//연결된 session 정보로 메일 발신 정보를 저장하는 class
	MimeMessage message=new MimeMessage(mailSession);
	
	//보내는 사람 이메일 계정 지정
	message.setFrom(new InternetAddress("studylsy@gmail.com"));
	
	//수신자 설정
	message.setRecipient(
		Message.RecipientType.TO,				//수신자 타입 설정
		new InternetAddress("studylsy@gmail.com") //수산자 이메일 설정
	);
	
	//메일 제목
	message.setSubject("첨부파일 테스트");
	
	//본문
	//message.setText("본문내용");// text/plain=>일반 텍스트 평문
	message.setContent("<h1>메일 본문</h1>","text/html;charset=utf-8");
	
	//첨부파일 추가
	//대용량 데이터를 포함한 메세지 본문 생성 객체
	Multipart multipart = new MimeMultipart();
	//텍스트 본문 추가
	MimeBodyPart textPart=new MimeBodyPart();
	textPart.setContent(
			"<h2 style='color:red;'>첨부파일 이메일</h2>",//본문 텍스트 내용
			"text/html;charset=utf-8"//본문 형식
			
			
	);
	//멀티 파트 본문에 textPart 추가
	multipart.addBodyPart(textPart);
	
	//첨부파일 추가
	File file=new File("C:\\Temp\\cat1.jpg");//첨부할 파일 지정
	//첨부파일 메세지 본문 객체
	MimeBodyPart filePart=new MimeBodyPart();
	filePart.attachFile(file);// 첨부할 파일 등록
	multipart.addBodyPart(filePart);// 메세지 본문에 첨부파일 추가
	
	//메세지 객체에 본문 메세지 content로 Multipart에 등록한 content 저장(textPart, filePart)
	message.setContent(multipart);
	
	//메일 전송 요청
	Transport.send(message);
	processMessage="메일 발신 성공";
	
}catch(Exception e){
	processMessage="메일 발신 실패";
	e.printStackTrace();
}
%>
<script>
	alert('<%=processMessage%>');
	location.href='<%=request.getContextPath()%>';
</script>
