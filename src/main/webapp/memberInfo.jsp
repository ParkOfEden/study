<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.*" %>
<%@ include file="common/header.jsp" %>

<%
    String id = (String)session.getAttribute("authUser");
    if(id == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
        return;
    }
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    // [추가] nickname 변수 초기화
    String name = "", addr = "", phone = "", email = "", gender = "", pass = "", nickname = "";
    int age = 0;
    int num = 0;

    try {
        conn = DBCPUtil.getConnection();
        String sql = "SELECT * FROM ACCOUNTS WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        if(rs.next()) {
            num      = rs.getInt("num");
            pass     = rs.getString("pass");
            name     = rs.getString("name");
            nickname = rs.getString("nickname"); // [추가] DB에서 닉네임 읽기
            addr     = rs.getString("addr");
            phone    = rs.getString("phone");
            gender   = rs.getString("gender");
            age      = rs.getInt("age");
            email    = rs.getString("email");
            
            // [추가] 닉네임 기본값 처리
            if (nickname == null || nickname.trim().isEmpty()) {
                nickname = id;
            }
        }
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        DBCPUtil.close(rs, pstmt, conn);
    }
%>

<section>
    <table>
        <tr>
            <%-- [수정] 이름 대신 닉네임으로 상단 제목 표시 --%>
            <th colspan="2"><h3><%= nickname %>님의 회원정보</h3></th>
        </tr>
        <tr>
            <td style="width:150px; padding:8px;">아이디</td>
            <td style="padding:8px;"><%= id %></td>
        </tr>
        <%-- [추가] 닉네임 표시 행 --%>
        <tr>
            <td style="padding:8px;">닉네임</td>
            <td style="padding:8px;"><strong><%= nickname %></strong></td>
        </tr>
        <tr>
            <td style="padding:8px;">비밀번호</td>
            <td style="padding:8px;"><%= pass %></td>
        </tr>
        <tr>
            <td style="padding:8px;">이름</td>
            <td style="padding:8px;"><%= name %></td>
        </tr>
        <tr>
            <td style="padding:8px;">주소</td>
            <td style="padding:8px;"><%= addr %></td>
        </tr>
        <tr>
            <td style="padding:8px;">전화번호</td>
            <td style="padding:8px;"><%= phone %></td>
        </tr>
        <tr>
            <td style="padding:8px;">성별</td>
            <td style="padding:8px;"><%= gender %></td>
        </tr>
        <tr>
            <td style="padding:8px;">나이</td>
            <td style="padding:8px;"><%= age %> 세</td>
        </tr>
        <tr>
            <td style="padding:8px;">이메일</td>
            <td style="padding:8px;"><%= email %></td>
        </tr>
        <tr>
            <th colspan="2" style="padding:15px;">
                <a href="memberUpdateForm.jsp">수정하기</a> | 
                <a href="#" onclick="deleteMember(<%= num %>)" style="color:red;">탈퇴하기</a>
            </th>
        </tr>
    </table>
</section>


<%@ include file="common/footer.jsp" %>









