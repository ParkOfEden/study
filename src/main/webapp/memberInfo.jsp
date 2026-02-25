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
    
    String name = "", addr = "", phone = "", email = "", gender = "", pass = "";
    int age = 0;
    int num = 0;

    String msg = "";
    String nextPage = "";
try {
        conn = DBCPUtil.getConnection();
        String sql = "SELECT * FROM test_member WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        if(rs.next()) {
        	num = rs.getInt("num");
        	pass   = rs.getString("pass");
            name   = rs.getString("name");
            addr   = rs.getString("addr");
            phone  = rs.getString("phone");
            gender = rs.getString("gender");
            age    = rs.getInt("age");
            email  = rs.getString("email");
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
		<th colspan="2"><h3><%= name %>님의 회원정보</h3></th>
	</tr>
	<tr>
            <td style="width:150px; padding:8px;">아이디</td>
            <td style="padding:8px;"><%= id %></td>
        </tr>
        <tr>
            <td style="padding:8px;">비밀번호</td>
            <td style="padding:8px;"><%= pass %></td>
        </tr>
        <tr>
            <td style="padding:8px;">이름</td>
            <td style="padding:8px;"><%= name %></td>
        </tr>
        <tr>
            <td style="padding:8px;">주소</td>
            <td style="padding:8px;"><%= addr %></td>
        </tr>
        <tr>
            <td style="padding:8px;">전화번호</td>
            <td style="padding:8px;"><%= phone %></td>
        </tr>
        <tr>
            <td style="padding:8px;">성별</td>
            <td style="padding:8px;"><%= gender %></td>
        </tr>
        <tr>
            <td style="padding:8px;">나이</td>
            <td style="padding:8px;"><%= age %> 세</td>
        </tr>
        <tr>
            <td style="padding:8px;">이메일</td>
            <td style="padding:8px;"><%= email %></td>
        </tr>
        <tr>
            <th colspan="2" style="padding:15px;">
                <a href="memberUpdateForm.jsp">수정하기</a> | 
                <a href="#" onclick="deleteMember(<%= num %>)" style="color:red;">탈퇴하기</a>
            </th>
        </tr>
    </table>
</section>

<script type="text/javascript">
function deleteMember(memberNum) {
    if (confirm("정말 탈퇴하시겠습니까?")) {
        // [네] 클릭 시: 삭제 페이지로 이동
        location.href = "memberDelete.jsp?num=" + memberNum;
    } else {
        // [아니오] 클릭 시: 메인 페이지로 이동
        alert("취소되었습니다.");
        location.href = "index.jsp";
    }
}
</script>

<%@ include file="common/footer.jsp" %>









