package dao;

import java.sql.*;
import java.util.*;
import vo.BoardVO;
import utils.DBCPUtil;

public class BoardDAO {
	
	// 전체 목록 조회
	
	public List<BoardVO> getAllBoards() {

	    List<BoardVO> list = new ArrayList<>();

	    String sql = "SELECT * FROM board_test ORDER BY num DESC";

	    try (Connection conn = DBCPUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql);
	         ResultSet rs = pstmt.executeQuery()) {

	        while (rs.next()) {
	            BoardVO vo = new BoardVO();
	            vo.setNum(rs.getInt("num"));
	            vo.setCategory(rs.getString("category"));
	            vo.setTitle(rs.getString("title"));
	            vo.setAuthor(rs.getString("author"));
	            vo.setContent(rs.getString("content"));
	            vo.setImgUrl(rs.getString("img_url"));
	            vo.setCreatedAt(rs.getTimestamp("created_at"));
	            vo.setUpdatedAt(rs.getTimestamp("updated_at"));
	            vo.setViewCount(rs.getInt("view_count"));

	            list.add(vo);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}
	
	// 전체 개수 조회
	
		public int getBoardCount() {

		    int totalCount = 0;

		    String sql = "SELECT COUNT(*) FROM board_test";

		    try (Connection conn = DBCPUtil.getConnection();
		         PreparedStatement pstmt = conn.prepareStatement(sql);
		         ResultSet rs = pstmt.executeQuery()) {

		        if (rs.next()) {
		            totalCount = rs.getInt(1);
		        }

		    } catch (Exception e) {
		        e.printStackTrace();
		    }

		    return totalCount;
		}	
	
	// 페이징용 목록 조회 (Oracle 12c 이상)
	
	public List<BoardVO> getBoardListPaging(int offset, int perPageNum) {

	    List<BoardVO> list = new ArrayList<>();

	    String sql = "SELECT num, category, title, author, created_at, view_count "
	               + "FROM board_test "
	               + "ORDER BY num DESC "
	               + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

	    try (Connection conn = DBCPUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, offset);
	        pstmt.setInt(2, perPageNum);

	        try (ResultSet rs = pstmt.executeQuery()) {

	            while (rs.next()) {

	                BoardVO vo = new BoardVO();
	                vo.setNum(rs.getInt("num"));
	                vo.setCategory(rs.getString("category"));
	                vo.setTitle(rs.getString("title"));
	                vo.setAuthor(rs.getString("author"));
	                vo.setCreatedAt(rs.getTimestamp("created_at"));
	                vo.setViewCount(rs.getInt("view_count"));

	                list.add(vo);
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}
	
	// 게시글 1개 조회 (수정폼용)
	
	public BoardVO getBoard(int num) {

	    BoardVO vo = null;

	    String sql = "SELECT * FROM board_test WHERE num=?";

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
	                vo.setImgUrl(rs.getString("img_url"));
	                vo.setCreatedAt(rs.getTimestamp("created_at"));
	                vo.setUpdatedAt(rs.getTimestamp("updated_at"));
	                vo.setViewCount(rs.getInt("view_count"));
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return vo;
	}	
	
	// 게시글 등록 메서드
	
	public int insertBoard(BoardVO vo) {

	    int result = 0;

	    String sql = "INSERT INTO board_test "
	               + "(category, title, author, content, img_url) "
	               + "VALUES (?, ?, ?, ?, ?)";

	    try (Connection conn = DBCPUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, vo.getCategory());
	        pstmt.setString(2, vo.getTitle());
	        pstmt.setString(3, vo.getAuthor());
	        pstmt.setString(4, vo.getContent());
	        pstmt.setString(5, vo.getImgUrl());

	        result = pstmt.executeUpdate();

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return result;
	}
	
    // 게시글 수정
    public int updateBoard(BoardVO vo) {

        int result = 0;

        String sql = "UPDATE board_test "
                   + "SET category=?, title=?, content=?, img_url=?, "
                   + "updated_at=SYSTIMESTAMP "
                   + "WHERE num=?";

        try (Connection conn = DBCPUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, vo.getCategory());
            pstmt.setString(2, vo.getTitle());
            pstmt.setString(3, vo.getContent());
            pstmt.setString(4, vo.getImgUrl());
            pstmt.setInt(5, vo.getNum());

            result = pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

}
