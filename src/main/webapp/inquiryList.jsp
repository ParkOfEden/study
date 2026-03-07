<!--  inquiry_view.jsp  -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String id = request.getParameter("id");

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String url = "jdbc:oracle:thin:@localhost:1521:xe";
String user = "develop_jsp";
String password = "12345";

Class.forName("oracle.jdbc.driver.OracleDriver");
conn = DriverManager.getConnection(url,user,password);

String sql = "select * from inquiry where id=?";
pstmt = conn.prepareStatement(sql);
pstmt.setString(1,id);

rs = pstmt.executeQuery();
%>

<h2>문의 상세보기</h2>

<%
if(rs.next()){
%>

<p>문의유형 : <%=rs.getString("category") %></p>
<p>제목 : <%=rs.getString("title") %></p>
<p>작성자 : <%=rs.getString("writer") %></p>
<p>문의내용 : <%=rs.getString("content") %></p>

<hr>

<form action="answer_save.jsp" method="post">

<input type="hidden" name="id" value="<%=id%>">

<h3>답변 작성</h3>

<textarea name="answer" rows="5" cols="50">
<%=rs.getString("answer")==null?"":rs.getString("answer")%>
</textarea>

<br><br>

<input type="submit" value="답변 저장">

</form>

<%
}
%>