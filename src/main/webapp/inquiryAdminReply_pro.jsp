<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 1. 한글 깨짐 방지 및 파라미터 수집
    request.setCharacterEncoding("UTF-8");
    int id = Integer.parseInt(request.getParameter("id")); // 숨겨진 ID 값
    String answer = request.getParameter("answer");       // 입력한 답변 내용

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // 2. DB 연결 (DEVELOP_JSP 계정 사용)
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "DEVELOP_JSP", "12345");

        // 3. SQL 실행: ANSWER 컬럼을 채우고 STATUS를 1(답변완료)로 변경
        String sql = "UPDATE INQUIRY SET ANSWER = ?, STATUS = 1 WHERE ID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, answer);
        pstmt.setInt(2, id);

        int result = pstmt.executeUpdate();

        if(result > 0) {
%>
            <script>
                alert("답변이 정상적으로 등록되었습니다.");
                location.href = "inquiryList.jsp"; // 목록으로 돌아가서 바뀐 상태 확인
            </script>
<%
        }
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        if(pstmt != null) pstmt.close();
        if(conn != null) conn.close();
    }
%>