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
        
        // 1. 조회수 증가
        String sql = "UPDATE board_test SET view_count = view_count + 1 WHERE num = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, num);
        pstmt.executeUpdate();
        DBCPUtil.close(pstmt);
        
        // 2. 게시글 정보 검색 (컬럼명으로 가져오기 위해 * 대신 명시하거나 rs.getXX("이름") 사용)
        sql = "SELECT * FROM board_test WHERE num = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, num);
        rs = pstmt.executeQuery();
        
        if(rs.next()){
            board = new BoardVO();
            // DB 컬럼명과 정확히 일치해야 합니다.
            board.setNum(rs.getInt("num"));
            board.setCategory(rs.getString("category")); 
            board.setTitle(rs.getString("title"));
            board.setAuthor(rs.getString("author"));
            
            // CLOB 타입은 getString으로 읽어올 수 있습니다.
            board.setContent(rs.getString("content"));
            
            board.setImgUrl(rs.getString("img_url"));
            
            // TIMESTAMP 타입 대응
            board.setCreatedAt(rs.getTimestamp("created_at"));
            board.setUpdatedAt(rs.getTimestamp("updated_at"));
            board.setViewCount(rs.getInt("view_count"));
            
            System.out.println("데이터 로드 성공: " + board.getTitle()); // 이클립스 콘솔 확인용
        }
        
        conn.commit();
    } catch(Exception e) {
        if(conn != null) try { conn.rollback(); } catch(SQLException ex) {}
        e.printStackTrace();
    } finally {
        if(conn != null) try { conn.setAutoCommit(true); } catch(SQLException ex) {}
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
        <% if(board.getImgUrl() != null && !board.getImgUrl().isEmpty()) { %>
        <tr>
            <td colspan="2" align="center">
                <img src="<%= board.getImgUrl() %>" class="prod-img" alt="상품이미지">
            </td>
        </tr>
        <% } %>
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
            <%--
            <%= new SimpleDateFormat("yyyy-MM-dd HH:mm").format(board.getCreatedAt()) %>
            --%>
                    <%= board.getCreatedAt() == null ? "-" :
            new SimpleDateFormat("yyyy-MM-dd HH:mm")
                .format(board.getCreatedAt()) %>
            
            </td>
        </tr>
        <tr>
            <th colspan="2">
                <button onclick="location.href='boardList.do'">목록</button>
            <%
            String loginUser = (String)session.getAttribute("authUser");
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