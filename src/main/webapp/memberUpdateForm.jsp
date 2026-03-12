<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" isErrorPage="true" %>
<%@ include file="common/header.jsp" %>
<%@ page import="java.sql.*, utils.*" %>

<%
    String targetId = request.getParameter("id");
    
    if(session.getAttribute("authUser") == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
        return;
    }
    String currentLoginUser = (String)session.getAttribute("authUser");

    if(targetId == null || targetId.isEmpty()) {
        targetId = currentLoginUser;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    String name="", addr="", phone="", email="", gender="", pass="", nickname="";    
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
            nickname = rs.getString("nickname");
            addr   = rs.getString("addr");
            phone  = rs.getString("phone");
            gender = rs.getString("gender");
            age    = rs.getInt("age");
            email  = rs.getString("email");
            
            if(nickname == null || nickname.trim().isEmpty()) {
                nickname = targetId;
            }
        }
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        DBCPUtil.close(rs, pstmt, conn);
    }
%>

<section>
    <div class="form-card">
        <%-- 탈퇴 폼 유지 --%>
        <form action="memberDelete.jsp" method="post" onsubmit="return confirm('정말 탈퇴하시겠습니까?');" class="withdraw-form">
            <input type="hidden" name="num" value="<%= num %>">
            <button type="submit">회원탈퇴</button>
        </form>

        <%-- [수정] enctype 추가: 이미지 파일 전송을 위해 필수 --%>
        <form action="memberUpdate.jsp" method="post" enctype="multipart/form-data">
            <h2>내 정보 수정하기</h2>
            
            <%-- [추가] 프로필 이미지 미리보기 및 수정 --%>
            <div style="text-align: center; margin-bottom: 20px;">
                <img id="preview" src="${pageContext.request.contextPath}/displayProfile?id=<%= targetId %>" 
                     alt="프로필 이미지" 
                     style="width: 120px; height: 120px; border-radius: 50%; object-fit: cover; border: 2px solid #ccc; cursor: pointer;"
                     onclick="document.getElementById('profile_img').click();">
                <p style="font-size: 12px; color: #666; margin-top: 5px;">이미지를 클릭하여 변경</p>
                <input type="file" id="profile_img" name="profile_img" accept="image/*" style="display:none;" onchange="previewImage(this)">
            </div>

            <table class="form-table">
                <tr>
                    <th>아이디</th>
                    <td>
                        <%= targetId %>
                        <input type="hidden" name="id" value="<%= targetId %>">
                    </td>
                </tr>
                <%-- 기존 입력 필드들 --%>
                <tr>
                    <th>비밀번호</th>
                    <td><input type="text" name="pass" value="<%= pass %>" style="text-align: center;" required></td>
                </tr>
                <tr>
                    <th>이름</th>
                    <td><input type="text" name="name" value="<%= name %>" style="text-align: center;" required></td>
                </tr>
                <tr>
                    <th>닉네임</th>
                    <td><input type="text" name="nickname" value="<%= nickname %>" style="text-align: center;"></td>
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

<script>
// 이미지 선택 시 즉시 미리보기
function previewImage(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById('preview').src = e.target.result;
        }
        reader.readAsDataURL(input.files[0]);
    }
}
</script>

<%@ include file="common/footer.jsp" %>