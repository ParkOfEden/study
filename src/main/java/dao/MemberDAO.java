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
    public MemberVO getMemberById(String id) {
        MemberVO vo = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBCPUtil.getConnection();
            String sql = "SELECT id, profile_blob FROM ACCOUNTS WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                vo = new MemberVO();
                vo.setId(rs.getString("id"));
                // BLOB 데이터를 byte 배열로 변환
                Blob blob = rs.getBlob("profile_blob");
                if (blob != null) {
                    vo.setProfileBlob(blob.getBytes(1, (int) blob.length()));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBCPUtil.close(rs, pstmt, conn);
        }
        return vo;
    }
    public int insertMember(MemberVO vo) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;

        // profile_blob 컬럼을 포함한 SQL
        String sql = "INSERT INTO ACCOUNTS (id, pass, nickname, name, addr, phone, gender, age, email, profile_blob) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            conn = DBCPUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, vo.getId());
            pstmt.setString(2, vo.getPass());
            pstmt.setString(3, vo.getNickname());
            pstmt.setString(4, vo.getName());
            pstmt.setString(5, vo.getAddr());
            pstmt.setString(6, vo.getPhone());
            pstmt.setString(7, vo.getGender());
            pstmt.setInt(8, vo.getAge());
            pstmt.setString(9, vo.getEmail());

            // byte[] 형태로 저장된 프로필 이미지 처리
            if (vo.getProfileBlob() != null) {
                pstmt.setBytes(10, vo.getProfileBlob());
            } else {
                pstmt.setNull(10, java.sql.Types.BLOB);
            }

            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBCPUtil.close(null, pstmt, conn);
        }
        return result;
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