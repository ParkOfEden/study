<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 폼 파라미터 받기
    String category = request.getParameter("category");
    String title = request.getParameter("title");
    String author = request.getParameter("author");
    String content = request.getParameter("content");
    String imgUrl = request.getParameter("imgUrl"); // 파일명 대용

    // 파일명과 확장자 분리 (예: test.jpg -> test / .jpg)
    String fileName = "default";
    String fileExt = ".jpg";
    if(imgUrl != null && imgUrl.contains(".")) {
        fileName = imgUrl.substring(0, imgUrl.lastIndexOf("."));
        fileExt = imgUrl.substring(imgUrl.lastIndexOf("."));
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "1234");

        // 요청하신 그대로: 파일명 + _ + 전체개수 + 확장자
        String sql = "INSERT INTO board_test (category, title, author, content, system_filename) "
                   + "VALUES (?, ?, ?, ?, ? || '_' || (SELECT COUNT(*) FROM board_test) || ?)";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, category);
        pstmt.setString(2, title);
        pstmt.setString(3, author);
        pstmt.setString(4, content);
        pstmt.setString(5, fileName); 
        pstmt.setString(6, fileExt);

        pstmt.executeUpdate();
        response.sendRedirect("boardList.jsp");

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if(pstmt != null) pstmt.close();
        if(conn != null) conn.close();
    }
%>