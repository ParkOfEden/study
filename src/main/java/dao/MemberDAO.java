package dao;

import java.sql.*;
import java.util.*;
import vo.MemberVO;
import utils.DBCPUtil;

public class MemberDAO {
	
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
