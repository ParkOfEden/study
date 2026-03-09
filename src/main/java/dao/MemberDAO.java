package dao;

import java.sql.*;
import java.util.*;
import vo.MemberVO;
import utils.DBCPUtil;

public class MemberDAO {

    // 전체 회원 수 조회 메서드 (기존과 동일)
    public int getMemberCount() throws Exception {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM accounts";

        try (Connection conn = DBCPUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } 
        return count;
    }

    // [수정] 특정 페이지 범위의 회원 조회
    public List<MemberVO> getMembersByPage(int page, int limit) throws Exception {
        List<MemberVO> list = new ArrayList<>();
        int startRow = (page - 1) * limit + 1;
        int endRow = page * limit;

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
                    // [추가] 닉네임 꺼내기
                    vo.setNickname(rs.getString("nickname")); 
                    vo.setPass(rs.getString("pass"));
                    vo.setName(rs.getString("name"));
                    vo.setAddr(rs.getString("addr"));
                    vo.setPhone(rs.getString("phone"));
                    vo.setEmail(rs.getString("email"));
                    vo.setGender(rs.getString("gender"));
                    vo.setAge(rs.getInt("age"));
                    list.add(vo);
                }
            }
        }
        return list;
    }

    // [수정] 전체 회원 조회
    public List<MemberVO> getAllMembers() throws Exception {
        List<MemberVO> list = new ArrayList<>();
        String sql = "SELECT * FROM accounts ORDER BY num DESC";
        
        try (Connection conn = DBCPUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                MemberVO vo = new MemberVO();
                vo.setNum(rs.getInt("num"));
                vo.setId(rs.getString("id"));
                // [추가] 닉네임 꺼내기
                vo.setNickname(rs.getString("nickname")); 
                vo.setPass(rs.getString("pass"));
                vo.setName(rs.getString("name"));
                vo.setAddr(rs.getString("addr"));
                vo.setPhone(rs.getString("phone"));
                vo.setEmail(rs.getString("email"));
                vo.setGender(rs.getString("gender"));
                vo.setAge(rs.getInt("age"));
                list.add(vo);
            }
        }
        return list;
    }
}