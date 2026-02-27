<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, utils.*, vo.*" %>
<%
	// 1. 페이지 번호 파라미터 안전하게 받기
	String paramPage = request.getParameter("page");
	int pageNum = 1; 
	if (paramPage != null && !paramPage.trim().isEmpty()) {
		try {
			pageNum = Integer.parseInt(paramPage);
		} catch (NumberFormatException e) {
			pageNum = 1; 
		}
	}
	
	// 2. 페이징 및 리스트 준비
	Criteria cri = new Criteria(pageNum, 10);
	List<BoardVO> list = new ArrayList<>();
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	int totalCount = 0;

	try {
		conn = DBCPUtil.getConnection();
		
		// 3. 전체 게시글 개수 조회 (페이징용)
		String countSql = "SELECT count(*) FROM board_test";
		pstmt = conn.prepareStatement(countSql);
		rs = pstmt.executeQuery();
		if(rs.next()) totalCount = rs.getInt(1);
		DBCPUtil.close(rs, pstmt); // 개수 조회 후 자원 일시 반납

		// 4. 게시글 목록 조회 (번호가 안 찍힌다면 컬럼명을 명시하는게 안전함)
		String sql = "SELECT num, title, author, created_at, view_count FROM board_test ORDER BY num DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, cri.offset());
		pstmt.setInt(2, cri.getPerPageNum());
		
		rs = pstmt.executeQuery();
		
		while(rs.next()){
			BoardVO board = new BoardVO();
			// 중요: 여기서 num을 반드시 세팅해야 함
			board.setNum(rs.getInt("num"));
			board.setTitle(rs.getString("title"));
			board.setAuthor(rs.getString("author"));
			board.setCreatedAt(rs.getTimestamp("created_at"));
			board.setViewCount(rs.getInt("view_count"));
			list.add(board);
		}
	} catch(Exception e) {
		e.printStackTrace();	
	} finally {
		DBCPUtil.close(rs, pstmt, conn);
	}
	
	PageMaker pm = new PageMaker(cri, totalCount, 10);
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 관리 목록</title>
<style>
	table { width: 100%; border-collapse: collapse; margin-top: 20px; }
	th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
	th { background-color: #f4f4f4; }
	.paging { text-align: center; margin-top: 20px; }
	.paging a { text-decoration: none; color: black; margin: 0 5px; }
	.current-page { font-weight: bold; color: red; text-decoration: underline; }
</style>
</head>
<body>

	<h2>전체 게시글 목록 (Admin)</h2>
	<div style="text-align: right;">
		<a href="write.jsp">[새 상품 등록]</a>
	</div>

	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
		<% if(list.isEmpty()){ %>
			<tr><td colspan="5">등록된 게시글이 없습니다.</td></tr>
		<% } else { %>
			<% for(BoardVO b : list) { %>
			<tr>
				<%-- 5. 여기서 b.getNum()이 0이거나 안 나온다면 VO의 setNum 문제임 --%>
				<td><%= b.getNum() %></td>
				<td style="text-align: left;">
					<%-- 상세페이지로 이동할 때 num 파라미터가 정확히 붙는지 확인 --%>
					<a href="boardDetail.jsp?num=<%= b.getNum() %>"><%= b.getTitle() %></a>
				</td>
				<td><%= b.getAuthor() %></td>
				<td><%= b.getCreatedAt() %></td>
				<td><%= b.getViewCount() %></td>
			</tr>		
			<% } %>
		<% } %>
		</tbody>
	</table>

	<div class="paging">
		<% if(pm.isPrev()){ %>
			<a href="?page=<%=pm.getStartPage()-1%>">[이전]</a>
		<% } %>
		
		<% for(int i=pm.getStartPage(); i<=pm.getEndPage(); i++){ %>
			<a href="?page=<%=i%>" class="<%= (pageNum == i) ? "current-page" : "" %>"><%= i %></a>
		<% } %>
		
		<% if(pm.isNext()){ %>
			<a href="?page=<%=pm.getEndPage()+1%>">[다음]</a>
		<% } %>
	</div>

</body>
</html>
</html>
<%@ include file="common/footer.jsp"%>