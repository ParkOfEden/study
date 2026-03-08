<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
    // [1번 위치] 테스트를 위해 관리자 권한을 강제로 부여하는 곳입니다.
    // 답변 작성이 모두 끝나면 이 줄만 지우면 일반 사용자 모드가 됩니다.
    session.setAttribute("loginId", "admin"); 
%>
<%@ page import="java.sql.*" %>
<%
    // [2번 위치] URL에서 전달된 글 번호를 가져옵니다. [cite: 2]
    String idParam = request.getParameter("id");
    if(idParam == null) { 
        response.sendRedirect("inquiryList.jsp"); 
        return; 
    }
    int id = Integer.parseInt(idParam);

    // 세션에 저장된 아이디를 가져와서 관리자인지 확인합니다.
    String loginId = (String)session.getAttribute("loginId");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // [3번 위치] 데이터베이스 연결 (Oracle 사용) [cite: 4]
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "DEVELOP_JSP", "12345");

        // [4번 위치] 해당 ID의 글 상세 정보와 답변(answer)을 조회합니다. [cite: 5]
        String sql = "SELECT * FROM INQUIRY WHERE ID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        rs = pstmt.executeQuery();

        if(rs.next()) { // 데이터가 존재하면 화면을 그립니다. [cite: 6]
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>1:1 문의 상세 내역</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; padding: 20px; line-height: 1.6; }
        .detail-table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        .detail-table th { width: 150px; background-color: #f4f4f4; padding: 10px; border: 1px solid #ddd; text-align: left; }
        .detail-table td { padding: 10px; border: 1px solid #ddd; }
        .answer-view { padding: 20px; background-color: #f9f9f9; border: 1px solid #ddd; margin: 20px 0; }
        .admin-form { background-color: #fff9e6; padding: 20px; border: 1px dashed #ffcc00; margin-top: 20px; }
        textarea { width: 100%; padding: 10px; box-sizing: border-box; margin-top: 10px; }
        .btn { padding: 10px 20px; background-color: #333; color: #fff; text-decoration: none; border: none; cursor: pointer; display: inline-block; }
        .btn-submit { background-color: #4CAF50; }
    </style>
</head>
<body>
    <h2>1:1 문의 상세 내역</h2>
    <hr>
    
    <table class="detail-table">
        <tr><th>번호</th><td><%= rs.getInt("id") %></td></tr>
        <tr><th>카테고리</th><td><%= rs.getString("category") %></td></tr>
        <tr><th>제목</th><td><%= rs.getString("title") %></td></tr>
        <tr><th>이메일</th><td><%= rs.getString("email") %></td></tr>
        <tr><th>내용</th><td><%= rs.getString("content") %></td></tr>
        <tr><th>등록일</th><td><%= rs.getTimestamp("regdate") %></td></tr>
    </table>

    <hr>

    <h4>관리자 답변 확인</h4>
    <div class="answer-view">
    <% 
        String reply = rs.getString("answer"); 
        if(reply == null || reply.trim().equals("")) {
    %>
        <p style="color: #999;">아직 등록된 답변이 없습니다.</p>
    <% } else { %>
        <p><strong>A:</strong> <%= reply %></p>
    <% } %>
    </div>

    <% if("admin".equals(loginId)) { %>
    <div class="admin-form">
        <form action="inquiryAdminReply_pro.jsp" method="post">
            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
            <label><strong>[관리자 전용 답변 작성란]</strong></label><br>
            <textarea name="answer" rows="5" placeholder="답변 내용을 입력하세요" required></textarea>
            <br>
            <input type="submit" value="답변 등록하기" class="btn btn-submit">
        </form>
    </div>
    <% } %>

    <br>
    <a href="inquiryList.jsp" class="btn">목록으로 돌아가기</a>
</body>
</html>
<%
        }
    } catch(Exception e) { 
        e.printStackTrace(); 
    } finally { 
        // [7번 위치] 사용한 DB 자원을 반납합니다. [cite: 8]
        if(rs != null) rs.close(); 
        if(pstmt != null) pstmt.close(); 
        if(conn != null) conn.close(); 
    }
%>