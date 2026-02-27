<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.*" %>

<%
    // 1. 한글 깨짐 방지 인코딩
    request.setCharacterEncoding("UTF-8");

    // 2. 파라미터 받기 (input 태그의 name 속성값들)
    String id     = request.getParameter("id");
    String pass   = request.getParameter("pass");
    String name   = request.getParameter("name");
    String addr   = request.getParameter("addr");
    String phone  = request.getParameter("phone");
    String gender = request.getParameter("gender");
    String email  = request.getParameter("email");
    String ageStr = request.getParameter("age");

    // 나이 데이터 정수 변환 (Null 및 빈 문자열 체크로 안정성 확보)
    int age = 0;
    if(ageStr != null && !ageStr.equals("")) {
        try {
            age = Integer.parseInt(ageStr);
        } catch(NumberFormatException e) {
            age = 0; 
        }
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    String msg = "";
    boolean isSuccess = false;

    try {
        // 3. DB 연결
        conn = DBCPUtil.getConnection();

        // 4. UPDATE 문 작성 (아이디는 고유값이므로 WHERE 조건에 사용)
        String sql = "UPDATE test_member SET "
                   + "pass=?, name=?, addr=?, phone=?, gender=?, age=?, email=? "
                   + "WHERE id=?";

        pstmt = conn.prepareStatement(sql);

        // 5. ? 채우기 (순서 주의)
        pstmt.setString(1, pass);
        pstmt.setString(2, name);
        pstmt.setString(3, addr);
        pstmt.setString(4, phone);
        pstmt.setString(5, gender);
        pstmt.setInt(6, age);
        pstmt.setString(7, email);
        pstmt.setString(8, id);

        int result = pstmt.executeUpdate();

        if(result > 0) {
            isSuccess = true;
            msg = "회원 정보가 성공적으로 수정되었습니다.";
            // [센스!] 이름이 변경되었을 수 있으므로 세션 정보도 갱신해줍니다.
            session.setAttribute("userName", name);
        } else {
            msg = "정보 수정에 실패했습니다. (일치하는 아이디 없음)";
        }

    } catch(Exception e) {
        e.printStackTrace();
        msg = "DB 오류 발생: " + e.getMessage();
    } finally {
        // 6. 자원 반납
        DBCPUtil.close(pstmt, conn);
    }
%>

<script>
    alert('<%= msg %>');
    <% if(isSuccess) { %>
        location.href = 'index.jsp'; // 성공 시 메인으로 이동
    <% } else { %>
        history.back(); // 실패 시 이전 페이지(수정 폼)로 이동
    <% } %>
</script>