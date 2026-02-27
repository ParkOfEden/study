<!-- 회원가입 요청 처리 - joinCheck.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, utils.*, java.util.*" %>
<%@ page import="jakarta.mail.*, jakarta.mail.internet.*" %>

<%
	//한글 인코딩 처리
	request.setCharacterEncoding("utf-8");

	//중복 아이디 체크 및 회원가입 요청처리
	
	//요청 파라미터로 전달된 사용자 등록 요청 회원 정보
	String id=request.getParameter("id");
	String pass = request.getParameter("pass");
	String name = request.getParameter("name");
	String addr = request.getParameter("addr");
	String phone = request.getParameter("phone");
	String gender = request.getParameter("gender");
	String email = request.getParameter("email"); // 이메일 파라미터
	int age = Integer.parseInt(request.getParameter("age"));
	
	Connection conn=DBCPUtil.getConnection();
	
	PreparedStatement pstmt=null;
	
	ResultSet rs=null;	
	
	//요청 처리 결과 메세지
	String msg="";
	
	//처리 결과에 따른 이동 페이지
	String nextPage="";
	

	try{
		
		// 1. 중복 체크
	    String sql = "SELECT id FROM ACCOUNTS WHERE id=? OR email=?";
	    pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1, id);
	    pstmt.setString(2, email);
	    rs = pstmt.executeQuery();
		
		if(rs.next()){
			//사용자가 요청하나 아이디와 일치하는 아이디를 사용중인 사용자가 이미 존재
	        msg = "아이디 또는 이메일이 이미 존재합니다.";
	        nextPage = "join.jsp";
	        
		}else{
			// 2. 인증코드 생성
			String authCode = String.valueOf((int)(Math.random()*900000)+100000);
			
			// 3. 세션에 회원정보 + 인증코드 저장
	        session.setAttribute("join_id", id);
	        session.setAttribute("join_pass", pass);
	        session.setAttribute("join_name", name);
	        session.setAttribute("join_addr", addr);
	        session.setAttribute("join_phone", phone);
	        session.setAttribute("join_gender", gender);
	        session.setAttribute("join_age", age);
	        session.setAttribute("join_email", email);
	        session.setAttribute("authCode", authCode);
	        
	        // 4. 메일 발송
	        Properties prop = new Properties();
	        prop.setProperty("mail.smtp.host","smtp.gmail.com");
	        prop.setProperty("mail.smtp.port","587");
	        prop.setProperty("mail.smtp.auth","true");
	        prop.setProperty("mail.smtp.starttls.enable","true");
	        
	        GmailAuthenticator auth = new GmailAuthenticator();
	        Session mailSession = Session.getInstance(prop, auth);
	        
	        MimeMessage message = new MimeMessage(mailSession);
	        message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
	        message.setFrom(new InternetAddress("pshyun9063@gmail.com"));
	        message.setSubject("회원가입 인증코드");
	        message.setText("인증코드 : " + authCode);
	        
	        Transport.send(message);
	        
	        msg = "인증코드가 이메일로 발송되었습니다.";
	        nextPage = "verifyCode.jsp";	        
					
		}//end else
			
	}catch(Exception e){
		e.printStackTrace(); // 콘솔에 에러 원인 출력

		msg = "회원가입 요청 처리 실패 : " + e.getMessage();
		nextPage = "join.jsp";
	}finally{
		DBCPUtil.close(rs, pstmt, conn);
	}
	

%>

<script type="text/javascript">
	alert("<%= msg %>");
	location.replace("<%= nextPage %>");
</script>