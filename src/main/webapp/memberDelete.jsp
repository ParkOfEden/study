<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.*" %>
<%
    String authUser = (String)session.getAttribute("authUser");
    String numStr = request.getParameter("num");

    if (authUser == null || numStr == null) {
        out.println("<script>alert('비정상적인 접근입니다.'); location.href='login.jsp';</script>");
        return;
    }

    int targetNum = Integer.parseInt(numStr);
    int sessionNum = (Integer)session.getAttribute("authNum");
    boolean isAdmin = "admin".equals(authUser);

    // [검증 로직]
    if (isAdmin) {
        // 관리자가 자기 자신을 삭제하려 할 때만 차단
        if (targetNum == sessionNum) {
            out.println("<script>alert('관리자 계정은 직접 탈퇴할 수 없습니다.'); history.back();</script>");
            return;
        }
        // 관리자가 타인을 삭제하는 것은 통과
    } else {
        // 일반 사용자가 타인의 번호를 삭제하려 할 때 차단
        if (targetNum != sessionNum) {
            out.println("<script>alert('본인 정보만 삭제 가능합니다.'); history.back();</script>");
            return;
        }
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        conn = DBCPUtil.getConnection();
        // 세션 번호가 아닌 파라미터로 넘어온 targetNum을 사용
        String sql = "DELETE FROM ACCOUNTS WHERE num = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, targetNum);
        
        int result = pstmt.executeUpdate();
        
        if (result > 0) {
            if (!isAdmin) {
                // 일반 회원이 본인 탈퇴 시 세션 무효화
                session.invalidate();
                out.println("<script>alert('회원 탈퇴가 완료되었습니다.'); location.href='join.jsp';</script>");
            } else {
                // 관리자가 삭제 시 세션 유지 및 목록 이동
                out.println("<script>alert('해당 회원이 삭제되었습니다.'); location.href='memberList.do';</script>");
            }
        } else {
            out.println("<script>alert('삭제 대상을 찾을 수 없습니다.'); history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        DBCPUtil.close(null, pstmt, conn);
    }
%>









