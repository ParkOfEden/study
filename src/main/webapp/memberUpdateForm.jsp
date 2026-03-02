<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" isErrorPage="true" %>
<%@ include file="common/header.jsp" %>
<%@ page import="java.sql.*, utils.*" %>

<%
    String id = (String)session.getAttribute("authUser");
    if(id == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    // 초기값 설정을 위한 변수들
    String name="", addr="", phone="", email="", gender="", pass="";
    int age=0;
    int num=0;   // memberDelete.jsp 실행에 필요
    
    try {
        conn = DBCPUtil.getConnection();
        System.out.println("연결 성공! 조회 ID: " + id); // 서버 콘솔 확인용
        
        
        pstmt = conn.prepareStatement("SELECT * FROM ACCOUNTS WHERE id = ?");
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();
        
        
        if(rs.next()) {
        	System.out.println("데이터 찾음!"); // 데이터가 있을 때만 출력
        	num    = rs.getInt("num");   // memberDelete.jsp 실행에 필요
            pass   = rs.getString("pass");
            name   = rs.getString("name");
            addr   = rs.getString("addr");
            phone  = rs.getString("phone");
            gender = rs.getString("gender");
            age    = rs.getInt("age");
            email  = rs.getString("email");
        }else {
            System.out.println("데이터가 테이블에 없습니다."); // ID는 있는데 DB에 데이터가 없을 때
        }
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        DBCPUtil.close(rs, pstmt, conn);
    }
%>

		<section>
		    <form class="form-card" action="memberUpdate.jsp" method="post">
		        <h2>내 정보 수정하기</h2>
		        <table class="form-table">
		            <tr>
		                <th>아이디</th>
		                <td><%= id %><input type="hidden" name="id" value="<%= id %>" style="text-align: center;" ></td>
		            </tr>
		            <tr>
		                <th>비밀번호</th>
		                <td><input type="text" name="pass" value="<%= pass %>"style="text-align: center;" required></td>
		            </tr>
		            <tr>
		                <th>이름</th>
		                <td><input type="text" name="name" value="<%= name %>" style="text-align: center;" required></td>
		            </tr>
		            <tr>
		                <th>주소</th>
		                <td><input type="text" name="addr" value="<%= addr %>" style="text-align: center;" style="width:90%;"></td>
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
		                <td><input type="number" name="age" value="<%= age %>" style="text-align: center;"> 
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
		                    <button type="button" onclick="location.href='memberUpdate.jsp'">취소</button>	                    
		                </td>
		            </tr>
		        </table>
		    </form>
			<!-- 회원탈퇴 폼 -->
			<form action="memberDelete.jsp" method="post"
			      onsubmit="return confirm('정말 탈퇴하시겠습니까?');"
			      style="text-align:center; margin-top:15px;">
			      
			    <input type="hidden" name="num" value="<%= num %>">
			    <button type="submit" class="btn btn-danger">회원탈퇴</button>
			</form>		    
		</section>

<%@ include file="common/footer.jsp" %>