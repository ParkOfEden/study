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
.detail-table{
width:650px;
margin:40px auto;
border-collapse:collapse;
background:white;

box-shadow:0 5px 20px rgba(0,0,0,0.08);
border-radius:8px;
overflow:hidden;
}

.detail-table td{
padding:12px;
border-bottom:1px solid #eee;
}

.detail-table td:first-child{
width:120px;
font-weight:bold;
background:#fafafa;
}

.detail-image{
text-align:center;
padding:30px 0;
background:#fafafa;
}

.prod-img{
max-width:350px;
border-radius:6px;
}

.detail-btn-area{
text-align:center;
padding:25px 0;
}

/* 장바구니 버튼 */
.btn-cart{
background:#ff8a00;
color:#fff;
border:none;
padding:10px 18px;
border-radius:4px;
cursor:pointer;
font-weight:600;
transition:0.2s;
}

.btn-cart:hover{
background:#ff7300;
}

/* 목록 버튼 */
.btn-list{
background:#fff;
color:#555;
border:1px solid #ccc;
padding:10px 18px;
border-radius:4px;
cursor:pointer;
margin-left:8px;
transition:0.2s;
}

.btn-list:hover{
background:#f2f2f2;
color:#333;
border-color:#bbb;
}

.debug-file{
font-size:11px;
color:#3b82f6;
margin-top:8px;

animation: debugFade 3s forwards;
}

@keyframes debugFade{

0%{
opacity:1;
}

70%{
opacity:1;
}

100%{
opacity:0;
}
}
</style>
</head>
<body>
    <table class="detail-table">
    <tr>
        <th colspan="2">
            <h4>[<%= board.getCategory() %>] <%= board.getNum() %>번 상품 상세 정보</h4>
        </th>
    </tr>

    <tr>
    <td colspan="2" class="detail-image">
        <% 
	        // DB에서 가져온 파일명 확인
		    String system_file = board.getSystem_filename();
		    String imgUrl = board.getImgUrl();
		    String ctx = request.getContextPath();
        %>
        
		<%
		if(system_file != null && !system_file.trim().isEmpty()){
		%>
        
            <img class="prod-img"
             	 src="<%= ctx %>/css/img/upload/product/<%= system_file %>" 
             	 onerror="this.src='<%= ctx %>/css/img/no_image.jpg'"
                 style="max-width: 450px; height: auto; border: 2px solid #eee;" 
                 alt="상품이미지">
                 
            <p class="debug-file">(server에) 저장된 파일명: <%= system_file %></p>
                    
        <%
        } else if(imgUrl != null && !imgUrl.isEmpty()) { 
        %>
        
		    <img class="prod-img" src="<%= imgUrl %>">
		    
		    <p style="color: green; font-size: 11px;">
		        외부URL: <%= imgUrl %>
		    </p>
	    
	    <% } else { %>    
	        
        	<img class="prod-img"
			 src="<%= ctx %>/css/img/no_image.jpg">
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
        <th colspan="2" class="detail-btn-area">
        <%
        // 1. 여기서 먼저 세션 정보를 가져옵니다 (변수 선언)
        String loginUser = (String)session.getAttribute("authUser");
        %>

            <form action="cart" method="post" style="display: inline;">
    <input type="hidden" name="p_id" value="<%= board.getNum() %>">
    <button type="submit" class="btn-cart">
        장바구니 담기
    </button>
</form>

            <button class="btn-list" onclick="location.href='boardList.do'">목록</button>
            
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