<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="utils.DBCPUtil" %> <%-- 패키지명 확인 필수 --%>
<%
    request.setCharacterEncoding("UTF-8");

    // 1. 파라미터 수집 및 가공
    String category = request.getParameter("category");
    String p_name = request.getParameter("p_name");
    String author = request.getParameter("author");
    String p_desc = request.getParameter("p_desc");
    String priceStr = request.getParameter("price");
    String imgUrl = request.getParameter("imgUrl");

    int price = 0;
    if(priceStr != null && !priceStr.isEmpty()){
        try {
            price = Integer.parseInt(priceStr);
        } catch(NumberFormatException e) {
            price = 0; // 예외 처리
        }
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // 2. DBCP를 통한 커넥션 획득 (ID/PW 불필요)
        conn = DBCPUtil.getConnection();

        String sql = "INSERT INTO products (category, p_name, author, p_desc, price, img_url) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, category);
        pstmt.setString(2, p_name);
        pstmt.setString(3, author);
        pstmt.setString(4, p_desc);
        pstmt.setInt(5, price);
        pstmt.setString(6, imgUrl);

        pstmt.executeUpdate();
        
        response.sendRedirect("boardList.do");

    } catch (Exception e) {
        out.println("<script>alert('등록 실패: " + e.getMessage() + "'); history.back();</script>");
        e.printStackTrace();
    } finally {
        // 3. DBCPUtil.close()를 활용한 간결한 자원 해제
        DBCPUtil.close(pstmt, conn);
    }
%>