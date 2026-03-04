<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" isErrorPage="true" %>
<%@ include file="common/header.jsp" %>
<%@ page import="java.sql.*, utils.*" %>

<%
    // 1. URL 파라미터(id=user1000) 가져오기
    String targetId = request.getParameter("id");
    
    // 2. 로그인 세션 확인 (header.jsp에 선언된 authUser 변수 사용)
    // 만약 에러가 나면 String을 붙이지 말고 값만 할당하세요.
    if(session.getAttribute("authUser") == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
        return;
    }
    String currentLoginUser = (String)session.getAttribute("authUser");

    // 3. 파라미터가 없으면 본인 정보 조회
    if(targetId == null || targetId.isEmpty()) {
        targetId = currentLoginUser;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    String name="", addr="", phone="", email="", gender="", pass="";
    int age=0, num=0;
    
    try {
        conn = DBCPUtil.getConnection();
        pstmt = conn.prepareStatement("SELECT * FROM ACCOUNTS WHERE id = ?");
        pstmt.setString(1, targetId); 
        rs = pstmt.executeQuery();
        
        if(rs.next()) {
            num    = rs.getInt("num");
            pass   = rs.getString("pass");
            name   = rs.getString("name");
            addr   = rs.getString("addr");
            phone  = rs.getString("phone");
            gender = rs.getString("gender");
            age    = rs.getInt("age");
            email  = rs.getString("email");
        }
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        DBCPUtil.close(rs, pstmt, conn);
    }
%>

<section>
    <div class="form-card">
        <form action="memberDelete.jsp" method="post" onsubmit="return confirm('정말 탈퇴하시겠습니까?');" class="withdraw-form">
            <input type="hidden" name="num" value="<%= num %>">
            <button type="submit">회원탈퇴</button>
        </form>

        <form action="memberUpdate.jsp" method="post">
            <h2>내 정보 수정하기</h2>
            <table class="form-table">
                <tr>
                    <th>아이디</th>
                    <td>
                        <%= targetId %>
                        <input type="hidden" name="id" value="<%= targetId %>">
                    </td>
                </tr>
                <tr>
                    <th>비밀번호</th>
                    <td><input type="text" name="pass" value="<%= pass %>" style="text-align: center;" required></td>
                </tr>
                <tr>
                    <th>이름</th>
                    <td><input type="text" name="name" value="<%= name %>" style="text-align: center;" required></td>
                </tr>
                <tr>
                    <th>주소</th>
                    <td><input type="text" name="addr" value="<%= addr %>" style="text-align: center; width:90%;"></td>
                </tr>
                <tr>
                    <th>전화번호</th>
                    <td><input type="text" name="phone" value="<%= phone %>" style="text-align: center;"></td>
                </tr>
                <tr>
                    <th>성별</th>
                    <td>
                        <input type="radio" name="gender" value="남성" <%= "남성".equals(gender)?"checked":"" %>> 남성
                        <input type="radio" name="gender" value="여성" <%= "여성".equals(gender)?"checked":"" %>> 여성
                    </td>
                </tr>
                <tr>
                    <th>나이</th>
                    <td>
                        <input type="number" name="age" value="<%= age %>" style="text-align: center;"> 
                        <span class="age-unit">세</span>
                    </td>
                </tr>
                <tr>
                    <th>이메일</th>
                    <td><input type="email" name="email" value="<%= email %>" style="text-align: center;" required></td>
                </tr>
                <tr class="button-row">
                    <td colspan="2" style="text-align:center; padding:10px;">
                        <button type="submit">변경사항 저장</button>
                        <button type="button" onclick="history.back()">취소</button>	                    
                    </td>
                </tr>
            </table>
        </form>
    </div>
</section>

<%@ include file="common/footer.jsp" %>