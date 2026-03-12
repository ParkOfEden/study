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
            nickname = rs.getString("nickname");
            addr     = rs.getString("addr");
            phone    = rs.getString("phone");
            gender   = rs.getString("gender");
            age      = rs.getInt("age");
            email    = rs.getString("email");
            
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

<section style="display: flex; flex-direction: column; align-items: center; padding: 40px 0;">
    <table style="border-collapse: collapse; width: 500px; border: 1px solid #ccc;">
        <tr>
            <th colspan="2" style="padding: 20px; background-color: #f4f4f4; border-bottom: 1px solid #ccc;">
                <%-- 1. 프로필 이미지 출력부 추가 --%>
                <div style="margin-bottom: 15px;">
                    <img src="${pageContext.request.contextPath}/displayProfile?id=<%= id %>" 
                         alt="프로필 이미지" 
                         style="width: 120px; height: 120px; border-radius: 50%; object-fit: cover; border: 3px solid #d9534f; background-color: #fff;">
                </div>
                <h3><%= nickname %>님의 회원정보</h3>
            </th>
        </tr>
        <tr>
            <td style="width:150px; padding:12px; background-color: #fafafa; font-weight: bold; text-align: center; border: 1px solid #ccc;">아이디</td>
            <td style="padding:12px; border: 1px solid #ccc;"><%= id %></td>
        </tr>
        <tr>
            <td style="padding:12px; background-color: #fafafa; font-weight: bold; text-align: center; border: 1px solid #ccc;">닉네임</td>
            <td style="padding:12px; border: 1px solid #ccc;"><strong><%= nickname %></strong></td>
        </tr>
        <tr>
            <td style="padding:12px; background-color: #fafafa; font-weight: bold; text-align: center; border: 1px solid #ccc;">비밀번호</td>
            <td style="padding:12px; border: 1px solid #ccc;"><%= pass %></td>
        </tr>
        <tr>
            <td style="padding:12px; background-color: #fafafa; font-weight: bold; text-align: center; border: 1px solid #ccc;">이름</td>
            <td style="padding:12px; border: 1px solid #ccc;"><%= name %></td>
        </tr>
        <tr>
            <td style="padding:12px; background-color: #fafafa; font-weight: bold; text-align: center; border: 1px solid #ccc;">주소</td>
            <td style="padding:12px; border: 1px solid #ccc;"><%= addr %></td>
        </tr>
        <tr>
            <td style="padding:12px; background-color: #fafafa; font-weight: bold; text-align: center; border: 1px solid #ccc;">전화번호</td>
            <td style="padding:12px; border: 1px solid #ccc;"><%= phone %></td>
        </tr>
        <tr>
            <td style="padding:12px; background-color: #fafafa; font-weight: bold; text-align: center; border: 1px solid #ccc;">성별</td>
            <td style="padding:12px; border: 1px solid #ccc;"><%= gender %></td>
        </tr>
        <tr>
            <td style="padding:12px; background-color: #fafafa; font-weight: bold; text-align: center; border: 1px solid #ccc;">나이</td>
            <td style="padding:12px; border: 1px solid #ccc;"><%= age %> 세</td>
        </tr>
        <tr>
            <td style="padding:12px; background-color: #fafafa; font-weight: bold; text-align: center; border: 1px solid #ccc;">이메일</td>
            <td style="padding:12px; border: 1px solid #ccc;"><%= email %></td>
        </tr>
        <tr>
            <th colspan="2" style="padding:20px; text-align: center;">
                <a href="memberUpdateForm.jsp" style="text-decoration: none; color: #333; font-weight: bold;">수정하기</a> 
                <span style="margin: 0 10px; color: #ccc;">|</span>
                <a href="#" onclick="deleteMember(<%= num %>)" style="color:red; text-decoration: none; font-weight: bold;">탈퇴하기</a>
            </th>
        </tr>
    </table>
</section>

<%@ include file="common/footer.jsp" %>