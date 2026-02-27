<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- memberUpdate.jsp -->
<!-- 회원 정보 수정 요청 처리 -->
<%@ page import="java.sql.*, utils.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	// 1. 파라미터 받기
	String id     = request.getParameter("id");
	String pass   = request.getParameter("pass");
	String name   = request.getParameter("name");
	String addr   = request.getParameter("addr");
	String phone  = request.getParameter("phone");
	String gender = request.getParameter("gender");
	String email  = request.getParameter("email");
	int age       = Integer.parseInt(request.getParameter("age"));

	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String msg = "";

	try {
	    conn = DBCPUtil.getConnection();

    	// 2. UPDATE 문 작성
    	String sql = "UPDATE test_member SET "
               + "pass=?, name=?, addr=?, phone=?, gender=?, age=?, email=? "
               + "WHERE id=?";

    	pstmt = conn.prepareStatement(sql);

    	// 3. ? 채우기
	    pstmt.setString(1, pass);
	    pstmt.setString(2, name);
	    pstmt.setString(3, addr);
	    pstmt.setString(4, phone);
	    pstmt.setString(5, gender);
	    pstmt.setInt(6, age);
	    pstmt.setString(7, email);
	    pstmt.setString(8, id);

	    int result = pstmt.executeUpdate();
	
	    if(result == 1){
	        msg = "수정 성공";
	    } else {
	        msg = "수정 실패";
	    }
	
	} catch(Exception e){
		    msg = "오류: " + e.getMessage();
	} finally {
	    DBCPUtil.close(pstmt, conn);
	}
%>

<script>
alert('<%=msg%>');
location.href='index.jsp';
</script>








