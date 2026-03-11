package dao;

import java.sql.*;
import java.util.*;
import vo.BoardVO;
import utils.DBCPUtil;

public class BoardDAO {
	
    Connection conn;
    PreparedStatement pstmt;
    ResultSet rs;	

	
	// 전체 목록 조회
	
	public List<BoardVO> getAllBoards() {
	    List<BoardVO> list = new ArrayList<>();
        return list;
    }


	// 1. 검색 결과의 전체 개수 조회
	public int getSearchBoardCount(String type, String keyword) throws Exception {
	    int count = 0;
	    String columnName = "p_name";
	    if ("category".equals(type)) {
	        columnName = "category";
	    }

	    String sql = "SELECT COUNT(*) FROM products WHERE ";
	    if ("all".equals(type)) {
	        sql += "p_name LIKE ? OR category LIKE ?";
	    } else {
	        sql += columnName + " LIKE ?";
	    }

	    try (Connection conn = DBCPUtil.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {

	        if ("all".equals(type)) {
	            ps.setString(1, "%" + keyword + "%");
	            ps.setString(2, "%" + keyword + "%");
	        } else {
	            ps.setString(1, "%" + keyword + "%");
	        }

	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) count = rs.getInt(1);
	        }
	    } 
	    // catch 블록을 제거하여 호출부(Servlet)에서 예외를 처리하도록 합니다.
	    return count;
	}
	

 // 2. 검색 결과 페이징 목록 조회
    public List<BoardVO> getSearchBoardListPaging(String type, String keyword, int offset, int limit) throws Exception {
        List<BoardVO> list = new ArrayList<>();
        String condition = "";

        if ("title".equals(type)) {
            condition = "p_name LIKE ?";
        } else if ("category".equals(type)) {
            condition = "category LIKE ?";
        } else if ("author".equals(type)) {
            condition = "author LIKE ?";
        } else if ("content".equals(type)) {
            condition = "p_desc LIKE ?";    
        } else if ("num".equals(type)) {
            condition = "p_id = ?";
        } else {
            condition = "p_name LIKE ? OR category LIKE ? OR author LIKE ?";
        }

        String sql = "SELECT p_id as num, category, p_name as title, author, price, created_at, view_count, system_filename "
                   + "FROM products "
                   + "WHERE " + condition + " "
                   + "ORDER BY p_id DESC "
                   + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = DBCPUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            int idx = 1;
            
            if ("num".equals(type)) {
                try {
                    ps.setInt(idx++, Integer.parseInt(keyword));
                } catch (NumberFormatException e) {
                    ps.setInt(idx++, -1);  // 존재하지 않는 번호
                }
            } else if ("all".equals(type)) {
                ps.setString(idx++, "%" + keyword + "%");
                ps.setString(idx++, "%" + keyword + "%");
                ps.setString(idx++, "%" + keyword + "%");
            } else {
                ps.setString(idx++, "%" + keyword + "%");
            }

            ps.setInt(idx++, offset);
            ps.setInt(idx, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BoardVO vo = new BoardVO();
                    vo.setNum(rs.getInt("num"));
                    vo.setCategory(rs.getString("category"));
                    vo.setTitle(rs.getString("title"));
                    vo.setAuthor(rs.getString("author"));
                    vo.setPrice(rs.getInt("price"));
                    vo.setCreatedAt(rs.getTimestamp("created_at"));
                    vo.setViewCount(rs.getInt("view_count"));
                    vo.setSystem_filename(rs.getString("system_filename"));
                    list.add(vo);
                }
            }
        } 
        // catch 블록을 제거하여 예외 발생 시 호출부(Servlet)에서 500 에러 처리를 하도록 유도합니다.
        return list;
    }  
    


    

 // 3. 상품 상세 조회
    public BoardVO getBoard(int num) {
        BoardVO vo = null;
        String sql = "SELECT p_id as num, category, p_name as title, author, p_desc as content, price, system_filename, created_at, view_count "
                   + "FROM products WHERE p_id=?";
        try (Connection conn = DBCPUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, num);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    vo = new BoardVO();
                    vo.setNum(rs.getInt("num"));
                    vo.setCategory(rs.getString("category"));
                    vo.setTitle(rs.getString("title"));
                    vo.setAuthor(rs.getString("author"));
                    vo.setContent(rs.getString("content"));
                    vo.setPrice(rs.getInt("price"));
                    vo.setSystem_filename(rs.getString("system_filename"));
                    vo.setCreatedAt(rs.getTimestamp("created_at"));
                    vo.setViewCount(rs.getInt("view_count"));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return vo;
    }

 // 4. 상품 등록
    public int insertBoard(BoardVO vo) throws Exception {
        int result = 0;
        String sql = "INSERT INTO products (category, p_name, author, p_desc, price, system_filename) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";
                   
        try (Connection conn = DBCPUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            pstmt.setString(1, vo.getCategory());
            pstmt.setString(2, vo.getTitle());
            pstmt.setString(3, vo.getAuthor());
            pstmt.setString(4, vo.getContent());
            pstmt.setInt(5, vo.getPrice());
            pstmt.setString(6, vo.getSystem_filename());
            
            result = pstmt.executeUpdate();
        } 
        // catch 블록을 제거하여 예외 발생 시 호출부(Servlet)로 에러를 던집니다.
        return result;
    }

    
 // 5. 상품 삭제
    public int deleteBoard(int num) throws Exception {
        int result = 0;
        String sql = "DELETE FROM products WHERE p_id=?";
        
        try (Connection conn = DBCPUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            pstmt.setInt(1, num);
            result = pstmt.executeUpdate();
            
        } 
        // catch 블록을 제거하여 예외 발생 시 호출부(Servlet)로 에러를 던집니다.
        return result;
    }

    // 6. 전체 상품 개수 조회
    public int getBoardCount() throws Exception {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM products";
        try (Connection conn = DBCPUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) count = rs.getInt(1);
        }
        return count;
    }
    
    
 // 7. 전체 상품 페이징 목록 조회
    public List<BoardVO> getBoardListPaging(int offset, int limit) throws Exception {
        List<BoardVO> list = new ArrayList<>();
        String sql = "SELECT p_id as num, category, p_name as title, author, price, created_at, view_count, system_filename "
                   + "FROM products "
                   + "ORDER BY p_id DESC "
                   + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
                   
        try (Connection conn = DBCPUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setInt(1, offset);
            ps.setInt(2, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BoardVO vo = new BoardVO();
                    vo.setNum(rs.getInt("num"));
                    vo.setCategory(rs.getString("category"));
                    vo.setTitle(rs.getString("title"));
                    vo.setAuthor(rs.getString("author"));
                    vo.setPrice(rs.getInt("price"));
                    vo.setCreatedAt(rs.getTimestamp("created_at"));
                    vo.setViewCount(rs.getInt("view_count"));
                    vo.setSystem_filename(rs.getString("system_filename"));
                    list.add(vo);
                }
            }
        } 
        // catch 블록을 제거하여 예외 발생 시 호출부(Servlet)에서 500 에러 처리를 하도록 합니다.
        return list;
    }
    
 // 8. 카테고리별 상품 목록 조회   
    public List<BoardVO> getBoardListByCategory(String keyword) throws Exception {

        List<BoardVO> list = new ArrayList<>();

        String sql = "SELECT p_id as num, category, p_name as title, author, price, created_at, view_count, system_filename "
                   + "FROM products WHERE category LIKE ? "
                   + "ORDER BY p_id DESC";

        try (Connection conn = DBCPUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");

            try (ResultSet rs = ps.executeQuery()) {

                while(rs.next()){

                    BoardVO vo = new BoardVO();

                    vo.setNum(rs.getInt("num"));
                    vo.setCategory(rs.getString("category"));
                    vo.setTitle(rs.getString("title"));
                    vo.setAuthor(rs.getString("author"));
                    vo.setPrice(rs.getInt("price"));
                    vo.setCreatedAt(rs.getTimestamp("created_at"));
                    vo.setViewCount(rs.getInt("view_count"));
                    vo.setSystem_filename(rs.getString("system_filename"));

                    list.add(vo);
                }
            }
        }

        return list;
    }  

 // 9. 상품 정보 수정
    public int updateBoard(BoardVO vo) throws Exception {
        int result = 0;
        String sql = "UPDATE products SET category=?, p_name=?, author=?, p_desc=?, price=?, "
                   + "system_filename=?, updated_at=SYSTIMESTAMP WHERE p_id=?";
                   
        try (Connection conn = DBCPUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            pstmt.setString(1, vo.getCategory());
            pstmt.setString(2, vo.getTitle());
            pstmt.setString(3, vo.getAuthor());
            pstmt.setString(4, vo.getContent());
            pstmt.setInt(5, vo.getPrice());
            pstmt.setString(6, vo.getSystem_filename());
            pstmt.setInt(7, vo.getNum());
            
            result = pstmt.executeUpdate();
        } 
        // catch 블록을 제거하여 예외 발생 시 호출부(Servlet)로 에러를 던집니다.
        return result;
    }
} // end BoardDAO class

