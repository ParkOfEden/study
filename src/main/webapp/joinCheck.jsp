<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, utils.*" %>
<!-- 회원가입 요청 처리 - joinCheck.jsp -->



<%
	//한글 인코딩 처리
	request.setCharacterEncoding("utf-8");

	//중복 아이디 체크 및 회원가입 요청처리
	
	//요청 파라미터로 전달된 사용자 등록 요청 ID
	String id=request.getParameter("id");

	//요청 처리 결과 메세지
	String msg="";
	
	//처리 결과에 따른 이동 페이지
	String nextPage="";
	
	Connection conn=DBCPUtil.getConnection();
	
	PreparedStatement pstmt=null;
	
	ResultSet rs=null;
	
	try{
		pstmt=conn.prepareStatement("SELECT * FROM test_member where id=?");
		pstmt.setString(1,id);
		
		rs=pstmt.executeQuery();
		
		if(rs.next()){
			//사용자가 요청하나 아이디와 일치하는 아이디를 사용중인 사용자가 이미 존재
			//중복아이디
			msg="이미 존재하는 아이디 입니다.";
			nextPage="join.jsp";
		}else{
			//사용 가능한  아이디
			//id | pass | name | addr | phone | gender |age (number-int)
			String pass= request.getParameter("pass");
			String name= request.getParameter("name");
			String addr= request.getParameter("addr");
			String phone= request.getParameter("phone");
			String gender= request.getParameter("gender");
			String paramAge= request.getParameter("age");
			int age=Integer.parseInt(paramAge);
			
			//요청 파라미터로 전달된 회원 정보 등록
			String sql="INSERT INTO test_member VALUES(null, ?, ?, ?, ?, ?, ?, ?)";
			//기존에 생성 사용된 자원 해제후 새로운 preparedStatement 할당
			DBCPUtil.close(rs,pstmt);
			
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			pstmt.setString(3, name);
			pstmt.setString(4, addr);
			pstmt.setString(5, phone);
			pstmt.setString(6, gender);
			pstmt.setInt(7, age);
			
			int result=pstmt.executeUpdate();
			if(result==1){
				msg="회원가입 성공";
				nextPage= "login.jsp";
				
			}else{
				msg="회원가입 실패";
				nextPage="join.jsp";
			}			
		}//end else
			
	}catch(Exception e){
		msg = "회원가입 요청 처리 실패 : " + e.getMessage();
		nextPage = "join.jsp";
	}finally{
		DBCPUtil.close(rs, pstmt, conn);
	}
	

%>
