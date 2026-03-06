<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 1. 폼 파라미터 받기 (보내준 boardWrite.jsp의 name값과 일치해야 함)
    String category = request.getParameter("category");
    String p_name = request.getParameter("p_name"); // title -> p_name
    String author = request.getParameter("author");
    String p_desc = request.getParameter("p_desc"); // content -> p_desc
    String priceStr = request.getParameter("price"); // 가격 추가
    String imgUrl = request.getParameter("imgUrl"); // 파일명 대용 (임시)

    // 가격 숫자 변환
    int price = 0;
	if(priceStr != null && !priceStr.isEmpty()){
	    price = Integer.parseInt(priceStr);
	}

/*     // 파일명과 확장자 분리 로직 (유지)
    String fileName = "product";
    String fileExt = ".jpg";
    if(imgUrl != null && imgUrl.contains(".")) {
        fileName = imgUrl.substring(0, imgUrl.lastIndexOf("."));
        fileExt = imgUrl.substring(imgUrl.lastIndexOf("."));
    } */

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "1234");

        // 2. SQL문 수정: 테이블명(products), 컬럼명(p_name, p_desc, price 등) 반영
        // p_id는 IDENTITY이므로 생략 가능
        /* String sql = "INSERT INTO products (category, p_name, author, p_desc, price, system_filename) "
                   + "VALUES (?, ?, ?, ?, ?, ? || '_' || (SELECT COUNT(*) FROM products) || ?)"; */
        String sql = "INSERT INTO products (category, p_name, author, p_desc, price, system_filename) "
        + "VALUES (?, ?, ?, ?, ?, ?)";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, category);
        pstmt.setString(2, p_name);
        pstmt.setString(3, author);
        pstmt.setString(4, p_desc);
        pstmt.setInt(5, price);      // 가격 설정
        pstmt.setString(6, imgUrl); 
        /* pstmt.setString(7, fileExt); */

        pstmt.executeUpdate();
        
        // 목록 페이지로 이동 (서블릿 매핑 주소 확인)
        response.sendRedirect("boardList.do");

    } catch (Exception e) {
        out.println("<script>alert('등록 실패: " + e.getMessage() + "'); history.back();</script>");
        e.printStackTrace();
    } finally {
        if(pstmt != null) try { pstmt.close(); } catch(Exception e) {}
        if(conn != null) try { conn.close(); } catch(Exception e) {}
    }
%>