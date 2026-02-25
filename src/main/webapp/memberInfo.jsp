<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, utils.*" %>
    
<!-- memberInfo.jsp -->
<%@ include file="common/header.jsp" %>
<%
	String id = (String)session.getAttribute("authUser");
	if(id == null) {
	    out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
	    return;
	}
	Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    String name = "", addr = "", phone = "", email = "", gender = "";
    int age = 0;

    String msg = "";
    String nextPage = "";
try {
        conn = DBCPUtil.getConnection();
        String sql = "SELECT * FROM test_member WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        if(rs.next()) {
            name = rs.getString("name");
            addr = rs.getString("addr");
            phone = rs.getString("phone");
            gender = rs.getString("gender");
            age = rs.getInt("age");
            email = rs.getString("email");
        }
    } catch(Exception e) {
    	e.printStackTrace();
        msg = "정보표시 처리 중 오류가 발생했습니다.";
        nextPage = "logout.jsp";
    } finally {
        DBCPUtil.close(rs, pstmt, conn);
    }
%>
<section>
<table>
	<tr>
		<th colspan="2">
		</th>
	</tr>
	<tr>
		<td>아이디</td>
		<td></td>
	</tr>
	<tr>
		<td>이름</td>
		<td></td>
	</tr>
	<tr>
		<td>주소</td>
		<td></td>
	</tr>
	<tr>
		<th colspan="2">
			<a href="">수정</a> | <a href="">삭제</a>
		</th>
	</tr>
</table>
</section>
<%@ include file="common/footer.jsp" %>











