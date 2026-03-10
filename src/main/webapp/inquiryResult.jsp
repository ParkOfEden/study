<!--  inquiryResult.jsp  -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    // 폼 데이터 받기
    String category = request.getParameter("category");
    String email = request.getParameter("email");
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "DEVELOP_JSP", "12345");

        // status는 0(대기), id는 시퀀스 사용
        String sql = "INSERT INTO INQUIRY (ID, CATEGORY, EMAIL, TITLE, CONTENT, STATUS, REGDATE) "
                     + "VALUES (INQUIRY_SEQ.NEXTVAL, ?, ?, ?, ?, 0, SYSDATE)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, category);
        pstmt.setString(2, email);
        pstmt.setString(3, title);
        pstmt.setString(4, content);
        
        pstmt.executeUpdate();
%>
        <script>
            alert("정상 접수되었습니다.");
            window.close();
        </script>
<%
    } catch (Exception e) {
        e.printStackTrace();
        out.println("데이터 저장 오류: " + e.getMessage());
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>문의 접수 완료</title>
</head>
<body>

    <div style="margin-top: 20px;">
        <button type="button" onclick="location.href='inquiry.jsp'">
            다시 작성하기
        </button>

        <button type="button" onclick="location.href='inquiryList.jsp'" style="background-color: #e0e0e0;">
            문의 목록 확인하기
        </button>
    </div>

</body>
</html>