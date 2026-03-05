<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.*, vo.BoardVO" %>
<%
    String paramNum = request.getParameter("num");

    Connection conn = DBCPUtil.getConnection();
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    BoardVO board = null;
    
    try {
        conn.setAutoCommit(false);
        int num = Integer.parseInt(paramNum);
        
        // 1. 조회수 증가 (num -> p_id로 변경)
        String sql = "UPDATE products SET view_count = view_count + 1 WHERE p_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, num);
        pstmt.executeUpdate();
        DBCPUtil.close(pstmt);
        
        // 2. 게시글 정보 검색 (num -> p_id로 변경)
        sql = "SELECT * FROM products WHERE p_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, num);
        rs = pstmt.executeQuery();
        
        if(rs.next()){
            board = new BoardVO();
            // DB 컬럼명과 정확히 매핑
            board.setNum(rs.getInt("p_id")); 
            board.setCategory(rs.getString("category")); 
            board.setTitle(rs.getString("p_name")); 
            board.setPrice(rs.getInt("price")); 
            board.setAuthor(rs.getString("author"));
            board.setSystem_filename(rs.getString("system_filename")); 
            
            // p_desc 컬럼을 content로 매핑
            board.setContent(rs.getString("p_desc")); 
            
            // created_at, updated_at, view_count는 컬럼명 동일하므로 유지
            board.setCreatedAt(rs.getTimestamp("created_at"));
            board.setUpdatedAt(rs.getTimestamp("updated_at"));
            board.setViewCount(rs.getInt("view_count"));
            
            System.out.println("데이터 로드 성공: " + board.getTitle());
        }
        
        conn.commit();
    } catch(Exception e) {
        if(conn != null) try { conn.rollback(); } catch(SQLException ex) {}
        e.printStackTrace();
    } { if(conn != null) try { conn.setAutoCommit(true); } catch(SQLException ex) {}
        DBCPUtil.close(rs, pstmt, conn);    
    }
%>

<% if(board == null){
   out.print("<script>");
   out.print("alert('해당 게시글이 존재하지 않습니다.');");
   out.print("location.href='boardList.do';");
   out.print("</script>");
   return; } %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= board.getTitle() %></title>
<style>
    .prod-img { max-width: 400px; display: block; margin-bottom: 10px; border: 1px solid #eee; }
    table { width: 500px; border-collapse: collapse; }
    td, th { padding: 10px; }
</style>
</head>
<body>
    <table border="1">
    <tr>
        <th colspan="2">
            <h4>[<%= board.getCategory() %>] <%= board.getNum() %>번 상품 상세 정보</h4>
        </th>
    </tr>

    <tr>
    <td colspan="2" align="center" style="padding: 20px; background-color: #f9f9f9;">
        <% 
	        // DB에서 가져온 파일명 확인
		    String system_file = board.getSystem_filename();
		    String imgUrl = board.getImgUrl();
        %>
        
        <% if(system_file != null && !system_file.isEmpty()) { %>
        
            <img src="<%= request.getContextPath() %>/upload/<%= system_file %>" 
                 style="max-width: 450px; height: auto; border: 2px solid #eee;" 
                 alt="상품이미지">
            <p style="color: blue; font-size: 11px;">(server에) 저장된 파일명: <%= system_file %></p>
        <% } else if(imgUrl != null && !imgUrl.isEmpty()) { %>
	    <img src="<%= imgUrl %>"
	         style="max-width: 450px; height: auto; border: 2px solid #eee;">
	    <p style="color: green; font-size: 11px;">
	        외부URL: <%= imgUrl %>
	    </p>
	    <% } else { %>        
            <p style="color: #ccc;">등록된 이미지가 없습니다.</p>
        <% } %>
    </td>
</tr>
    <tr>
        <td>제목</td>
        <td><%= board.getTitle() %></td>
    </tr>
    <tr>
        <td>작성자</td>
        <td><%= board.getAuthor() %></td>
    </tr>
    <tr>
        <td>내용</td>
        <td>
            <div style="min-height: 150px; white-space: pre-wrap;"><%= board.getContent() %></div>
        </td>
    </tr>
    <tr>
        <td>조회수</td>
        <td><%= board.getViewCount() %></td>
    </tr>
    <tr>
        <td>등록 시간</td>
        <td>
            <%= board.getCreatedAt() == null ? "-" :
            new SimpleDateFormat("yyyy-MM-dd HH:mm").format(board.getCreatedAt()) %>
        </td>
        
    </tr>
    <tr>
        <th colspan="2">
        <%
        // 1. 여기서 먼저 세션 정보를 가져옵니다 (변수 선언)
        String loginUser = (String)session.getAttribute("authUser");
        %>

            <form action="cart" method="post" style="display: inline;">
    <input type="hidden" name="p_name" value="<%= board.getTitle() %>">
    <input type="hidden" name="price" value="<%= board.getPrice() %>">
    
    <button type="submit" style="background-color: orange; color: white; border: none; padding: 7px 15px; cursor: pointer;">
        장바구니 담기
    </button>
</form>

            <button onclick="location.href='boardList.do'">목록</button>
            
        <%
        // 3. 관리자일 때만 수정/삭제 버튼 노출
        if ("admin".equals(loginUser)) { 
        %>
            <button onclick="location.href='boardUpdateForm.do?num=<%= board.getNum() %>'">수정</button>
            <button onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='boardDelete.do?num=<%= board.getNum() %>'">삭제</button>
        <% } %>
        </th>
    </tr>
    
</table>
</body>
</html>