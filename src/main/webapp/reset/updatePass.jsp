<!-- webapp/reset/updatePass -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.*"%>
<%
	//새 비밀번호 요청
	String password =request.getParameter("password");
	String rePassword = request.getParameter("rePassword");
	
	if(!password.equals(rePassword)){
		//입력받은 두 비밀번호가 일치하지않음.
%>
	<script>
		alert("비밀번호가 일치하지 않습니다.");
		history.go(-1);
	
	</script>
<%		
		return;//비밀번호를 변경하지 않고 응답 종료
	}
	// 비밀번호 일치 - 해당 비밀번호로 사용자 비밀번호 수정
	
	// 수정할 사용자의 id 
	String id = request.getParameter("id");
	
	Connection conn=DBCPUtil.getConnection();
	PreparedStatement pstmt =null;
	
	String sql="UPDATE test_member SET pass=? WHERE id=?";
	try{
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1,password);
		pstmt.setString(2,id);
		
		
		int result = pstmt.executeUpdate();
		out.println("<script>");
		if(result==1){
			//비밀번호 변경 성공=>로그인 페이지로 이동
			out.println("alert('비밀번호가 변경되었습니다.');");
			out.println("location.href='"+request.getContextPath()+"/login.jsp';");
			
		}else{
			//비밀번호 변경 실패=>이전 페이지로 이동
			out.println("alert('비밀번호 변경이 실패하였습니다. 정보를 확인해주세요');");
			out.println("history.back();");
		}
		out.println("</script>");
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBCPUtil.close(pstmt,conn);
	}
	
%>