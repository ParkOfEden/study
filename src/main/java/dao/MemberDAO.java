package dao;

import java.sql.*;
import java.util.*;
import vo.MemberVO;
import utils.DBCPUtil;

public class MemberDAO {

    // [추가] 전체 회원 수 조회 메서드
    public int getMemberCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM accounts";

        try (Connection conn = DBCPUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    // [추가] 특정 페이지 범위의 회원만 조회 메서드 (Oracle 기준)
    public List<MemberVO> getMembersByPage(int page, int limit) {
        List<MemberVO> list = new ArrayList<>();
        int startRow = (page - 1) * limit + 1;
        int endRow = page * limit;

        // RNUM을 사용하여 페이징 쿼리 작성
        String sql = "SELECT * FROM ("
                   + "  SELECT ROWNUM RNUM, A.* FROM ("
                   + "    SELECT * FROM accounts ORDER BY num DESC"
                   + "  ) A"
                   + ") WHERE RNUM BETWEEN ? AND ?";

        try (Connection conn = DBCPUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, startRow);
            pstmt.setInt(2, endRow);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    MemberVO vo = new MemberVO();
                    vo.setNum(rs.getInt("num"));
                    vo.setId(rs.getString("id"));
                    vo.setPass(rs.getString("pass"));
                    vo.setName(rs.getString("name"));
                    vo.setAddr(rs.getString("addr"));
                    vo.setPhone(rs.getString("phone"));
                    vo.setGender(rs.getString("gender"));
                    vo.setAge(rs.getInt("age"));
                    list.add(vo);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 기존에 있던 메서드 (필요 없다면 지워도 무방합니다)
    public List<MemberVO> getAllMembers() {
        List<MemberVO> list = new ArrayList<>();
        String sql = "SELECT * FROM accounts ORDER BY num DESC";
        try (Connection conn = DBCPUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {

                MemberVO vo = new MemberVO();
                vo.setNum(rs.getInt("num"));
                vo.setId(rs.getString("id"));
                vo.setPass(rs.getString("pass"));
                vo.setName(rs.getString("name"));
                vo.setAddr(rs.getString("addr"));
                vo.setPhone(rs.getString("phone"));
                vo.setGender(rs.getString("gender"));
                vo.setAge(rs.getInt("age"));

                list.add(vo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}