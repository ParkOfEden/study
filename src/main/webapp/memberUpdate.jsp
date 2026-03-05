<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.*" %>
<%
    // 1. 한글 깨짐 방지 인코딩
    request.setCharacterEncoding("UTF-8");

    // 2. 수정 대상 ID 가져오기 (중요!)
    // 폼에서 <input type="hidden" name="id" value="...">로 보낸 값을 우선 사용합니다.
    String id = request.getParameter("id");
    
    // 로그인 세션 확인 (권한 체크용)
    String authUser = (String)session.getAttribute("authUser");
    
    if(authUser == null){
        response.sendRedirect("login.jsp");
        return;
    }    
    
    // 만약 폼에서 넘어온 id가 없다면 본인 정보를 수정하는 것으로 간주
    if(id == null || id.isEmpty()) {
        id = authUser;
    }
    
    System.out.println("수정 실행 대상 id = [" + id + "]");	
    
    // 나머지 파라미터 수집
    String pass   = request.getParameter("pass");
    String name   = request.getParameter("name");
    String addr   = request.getParameter("addr");
    String phone  = request.getParameter("phone");
    String gender = request.getParameter("gender");
    String email  = request.getParameter("email");
    String ageStr = request.getParameter("age");

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
        conn = DBCPUtil.getConnection();

        // UPDATE 문 작성
        String sql = "UPDATE ACCOUNTS SET "
                   + "pass=?, name=?, addr=?, phone=?, gender=?, age=?, email=? "
                   + "WHERE id=?";

        pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, pass);
        pstmt.setString(2, name);
        pstmt.setString(3, addr);
        pstmt.setString(4, phone);
        pstmt.setString(5, gender);
        pstmt.setInt(6, age);
        pstmt.setString(7, email);
        pstmt.setString(8, id); // 여기서 파라미터로 받은 id를 사용함

        int result = pstmt.executeUpdate();

        if(result > 0) {
            isSuccess = true;
            msg = "회원 정보가 성공적으로 수정되었습니다.";
            
            // [수정 포인트] 
            // 1. String 키워드를 빼고 기존에 이미 선언된 authUser 변수(header 등에서 온 것)를 재사용하거나,
            // 2. 아래처럼 바로 비교 연산에 사용합니다.
            
            String loginId = (String)session.getAttribute("authUser");
            if(id != null && id.equals(loginId)) {
                session.setAttribute("userName", name);
            }
        }else {
            msg = "정보 수정에 실패했습니다.";
        }

    } catch(Exception e) {
        e.printStackTrace();
        msg = "DB 오류 발생: " + e.getMessage();
    } finally {
        DBCPUtil.close(pstmt, conn);
    }
%>
<script>
    alert('<%= msg %>');
    <% if(isSuccess) { %>
        <%-- 세션에 저장된 authUser가 'admin'인지 체크하여 경로 분기 --%>
        <% if("admin".equals(session.getAttribute("authUser"))) { %>
            location.href = 'memberList.do'; 
        <% } else { %>
            location.href = 'memberUpdateForm.jsp'; 
        <% } %>
    <% } else { %>
        history.back();
    <% } %>
</script>