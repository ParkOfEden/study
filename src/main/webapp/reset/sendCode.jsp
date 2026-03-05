<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.*, jakarta.mail.*, jakarta.mail.internet.*" %>
<% 
/* id로 이메일 검색후 검색된 이메일 code 발송
   code 발송이 정상적으로 처리되었으면 code(acceptCode.jsp) 출력
   */
   //비밀번호 찾기 요청한 사용자 id
   String id=request.getParameter("id");

   Connection conn = DBCPUtil.getConnection();
   PreparedStatement pstmt=null;
   ResultSet rs=null;
   
   // 사용자가 입력한 id 로 검색된 email정보 저장
   String email=null;
   try{
	   String sql="SELECT email From ACCOUNTS WHERE id=?";
	   pstmt = conn.prepareStatement(sql);
	   pstmt.setString(1, id);
	   rs=pstmt.executeQuery();
	   
	   if(rs.next()){
		  //일치하는 회원정보 검색
		  email=rs.getString(1);
		   
	   }
   }catch(Exception e){
	   e.printStackTrace();
   }finally{
	   DBCPUtil.close(rs,pstmt,conn);
   }
   if(email!=null){
	   //사용자가 입력한 id로 검색된 email 정보가 존재
	   //인증코드 발송
	   
	   // 숫자 5개 조합으로 랜덤한 인증코드 생성
	   String code="";//00012, 08946
	   for(int i=0;i<5;i++){
		   code += (int)(Math.random()*10);//0~9까지 한자리 랜덤한 정수
		   
	   }//end generate code
	   System.out.println("생성 코드: "+ code);
	   //code email 전송
	   GmailAuthenticator auth=new GmailAuthenticator();
	   try{
		   Session mailSession = Session.getInstance(auth.getInfo(),auth);
		   MimeMessage message= new MimeMessage(mailSession);
		   //수신자 지정
		   message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
		   //제목지정
		   message.setSubject("[월클의류] 비밀번호 찾기 인증번호", "UTF-8");
		   //발신 본문 내용 생성
		   String content = "<div style='font-family: sans-serif; padding: 20px; border: 1px solid #eee;'>";
content += "<h2 style='color: #d16464;'>비밀번호 재설정 인증번호</h2>";
content += "<p>안녕하세요. 요청하신 비밀번호 찾기 인증번호를 안내해 드립니다.</p>";
content += "<div style='background: #f9f9f9; padding: 15px; text-align: center; font-size: 1.5rem; font-weight: bold;'>";
content += "[" + code + "]"; // 랜덤하게 생성된 5자리 코드
content += "</div>";
content += "<p>해당 코드를 인증번호 입력창에 입력해 주세요.</p>";
content += "</div>";
		   
		   //본문 내용등록
		   message.setContent(content, "text/html;charset=utf-8");
		   
		   //메일 전송
		   Transport.send(message);
		   
		   //메일 발신 성공
		   request.setAttribute("id", id);
		   request.setAttribute("code",code);
		   //forward 방식으로 코드 입력 페이지 출력
		   RequestDispatcher rd =request.getRequestDispatcher("acceptCode.jsp");
		   rd.forward(request,response);
		   
	   }catch(Exception e){
		   //메일 발신 실패
		   e.printStackTrace();
%>
	<script>
		alert("메일 발송에 문제가 발생하였습니다.");
		history.go(-1);
	</script>

<%
	   }
   }else{
	   //사용자가 입력한 id로 검색된 email 정보가 존재하지 않음
%>
<script>
alert("id를 확인하신후 다시 요청 바랍니다.");
history.go(-1);
</script>
<%
   }
%>