<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String id = request.getParameter("id");
    String answer = request.getParameter("answer");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "1234");

        // answer 업데이트 및 status를 1(완료)로 변경
        String sql = "UPDATE inquiry SET answer = ?, status = 1 WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, answer);
        pstmt.setString(2, id);
        pstmt.executeUpdate();
%>
        <script>
            alert("답변이 등록되었습니다.");
            location.href = "inquiryList.jsp";
        </script>
<%
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>