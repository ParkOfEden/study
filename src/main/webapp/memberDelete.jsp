<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.*" %>

<%
    // 1. 삭제할 번호(num) 파라미터 받기
    Integer sessionNum = (Integer)session.getAttribute("authNum");
    String numStr = request.getParameter("num");
    
    if(sessionNum == null || numStr == null ||
    	       sessionNum != Integer.parseInt(numStr)) {
    
        out.println("<script>alert('잘못된 접근입니다.'); location.href='index.jsp';</script>");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        // 2. DB 연결 (DBCPUtil 사용)
        conn = DBCPUtil.getConnection();
        
        // 3. SQL문 작성 (번호를 기준으로 삭제)
        String sql = "DELETE FROM ACCOUNTS WHERE num = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, sessionNum);
        
        // 4. 실행
        int result = pstmt.executeUpdate();
        
        if (result > 0) {
            // 삭제 성공 시 세션 비우기 (로그아웃 처리)
            session.invalidate();
%>
            <script>
                alert("회원 탈퇴가 완료되었습니다.");
                location.href = "join.jsp"; // 가입 페이지로 이동
            </script>
<%
        } else {
            // 삭제 실패 시 (이미 삭제됐거나 번호가 없을 때)
%>
            <script>
                alert("삭제할 회원 정보를 찾을 수 없습니다.");
                history.back();
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
        <script>
        alert("시스템 오류가 발생했습니다."); // alert("에러 발생: <%= e.getMessage() %>"); => 테스트용(보안 취약)
        history.back();
        </script>
<%
    } finally {
        // 5. 자원 해제
        DBCPUtil.close(null, pstmt, conn);
    }
%>









