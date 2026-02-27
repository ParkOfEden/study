<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.*" %>

<%
    // 1. 한글 깨짐 방지 인코딩
    request.setCharacterEncoding("utf-8");

    // 2. 폼에서 넘어온 데이터 수집 (input 태그의 name 속성값들)
    String id = request.getParameter("id");
    String pass = request.getParameter("pass");
    String name = request.getParameter("name");
    String addr = request.getParameter("addr");
    String phone = request.getParameter("phone");
    String gender = request.getParameter("gender");
    String ageStr = request.getParameter("age"); // 숫자는 일단 문자열로 받음
    String email = request.getParameter("email");

    // 나이 데이터 정수 변환 (비어있을 경우 대비)
    int age = 0;
    if(ageStr != null && !ageStr.equals("")) {
        age = Integer.parseInt(ageStr);
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // 3. DB 연결 및 UPDATE 쿼리 실행
        conn = DBCPUtil.getConnection();
        
        // 아이디(id)는 고유값이므로 WHERE 조건에 넣고 나머지를 수정합니다.
        String sql = "UPDATE test_member SET pass=?, name=?, addr=?, phone=?, gender=?, age=?, email=? WHERE id=?";
        
        pstmt = conn.prepareStatement(sql);
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
            // [성공] 이름이 바뀌었을 수도 있으니 세션의 userName도 업데이트 해주는게 센스!
            session.setAttribute("userName", name);
%>
            <script>
                alert("회원 정보가 성공적으로 수정되었습니다.");
                location.href = "memberInfo.jsp"; // 다시 정보 확인 페이지로 이동
            </script>
<%
        } else {
%>
            <script>
                alert("정보 수정에 실패했습니다.");
                history.back(); // 이전 폼으로 이동
            </script>
<%
        }
    } catch(Exception e) {
        e.printStackTrace();
%>
        <script>
            alert("DB 오류 발생: <%= e.getMessage() %>");
            history.back();
        </script>
<%
    } finally {
        DBCPUtil.close(null, pstmt, conn);
    }
%>