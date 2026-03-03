<!-- src/main/webapp/writeSubmit.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.*" %>

<%
	//게시글 등록을 위해 작성한 요청 파라미터
	request.setCharacterEncoding("utf-8");
String category = request.getParameter("category");
String title = request.getParameter("title");
String author = request.getParameter("author");
String content = request.getParameter("content");
String imgUrl = request.getParameter("imgUrl");

	Connection conn=DBCPUtil.getConnection();
	PreparedStatement pstmt= null;
	
	String msg="게시글 등록에 실패하였습니다.";
	
	try{
		
		String sql = "INSERT INTO board_test(category, title, author, content, img_url) VALUES(?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, category);
		pstmt.setString(2, title);
		pstmt.setString(3, author);
		pstmt.setString(4, content);
		pstmt.setString(5, imgUrl);

		int result = pstmt.executeUpdate();
		if(result==1) msg="1개의 게시글이 등록되었습니다.";
		
	}catch(Exception e){
		e.printStackTrace();
		msg="게시글 등록 실패 오류: "+e.getMessage();
	}finally{
		DBCPUtil.close(pstmt,conn);
		out.println("<script>");
		//msg에 등록된 메시지 알림창 출력
		out.println("alert('"+msg+"')");
		//게시글 목록 페이지로 이동
		out.println("location.href='boardList.do';");
		out.println("</script>");
	}
%>