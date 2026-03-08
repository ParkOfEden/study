<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:oracle:thin:@localhost:1521:xe";
    String user = "DEVELOP_JSP";
    String pass = "12345";
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(url, user, pass);

        String sql = "SELECT * FROM INQUIRY ORDER BY ID DESC";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head><title>1:1 문의 내역</title></head>
<body>
    <h2>1:1 문의 내역</h2>
    <table border="1" style="width:100%; border-collapse:collapse; text-align:center;">
        <tr style="background-color:#eee;">
            <th>번호</th><th>카테고리</th><th>제목</th><th>등록일</th><th>상태</th>
        </tr>
        <% while(rs.next()) { %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("category") %></td>
            <td style="text-align:left; padding-left:10px;">
                <a href="inquiryDetail.jsp?id=<%= rs.getInt("id") %>" style="text-decoration:none; color:blue; font-weight:bold;">
                    <%= (rs.getString("title") == null || rs.getString("title").equals("null")) ? "제목 없음" : rs.getString("title") %>
                </a>
            </td>
            <td><%= rs.getTimestamp("regdate") %></td>
            <td>
                <span style="color: <%= rs.getInt("status") == 1 ? "green" : "red" %>;">
                    <%= rs.getInt("status") == 0 ? "답변대기" : "답변완료" %>
                </span>
            </td>
        </tr>
        <% } %>
    </table>
</body>
</html>
<%
    } catch(Exception e) { e.printStackTrace(); } 
    finally { if(rs != null) rs.close(); if(pstmt != null) pstmt.close(); if(conn != null) conn.close(); }
%>