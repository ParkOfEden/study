<!-- verifyCheck.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.*" %>

<%
request.setCharacterEncoding("utf-8");

String inputCode = request.getParameter("inputCode");
String sessionCode = (String)session.getAttribute("authCode");

String msg = "";
String nextPage = "";

if(sessionCode == null){
    msg = "세션 정보가 만료되었습니다.";
    nextPage = "join.jsp";
}
else if(inputCode == null || !inputCode.equals(sessionCode)){
    msg = "인증코드가 일치하지 않습니다.";
    nextPage = "verifyCode.jsp";
}
else {

    // 인증 성공 → 회원 DB 저장
    Connection conn = null;
    PreparedStatement pstmt = null;

    try{
        conn = DBCPUtil.getConnection();

        String sql = "INSERT INTO ACCOUNTS "
                   + "(id, pass, name, addr, phone, gender, age, email) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, (String)session.getAttribute("join_id"));
        pstmt.setString(2, (String)session.getAttribute("join_pass"));
        pstmt.setString(3, (String)session.getAttribute("join_name"));
        pstmt.setString(4, (String)session.getAttribute("join_addr"));
        pstmt.setString(5, (String)session.getAttribute("join_phone"));
        pstmt.setString(6, (String)session.getAttribute("join_gender"));
        pstmt.setInt(7, (Integer)session.getAttribute("join_age"));
        pstmt.setString(8, (String)session.getAttribute("join_email"));

        int result = pstmt.executeUpdate();

        if(result == 1){
            msg = "회원가입 성공 🎉";
            nextPage = "login.jsp";

            // 세션 정리
            session.removeAttribute("authCode");
            session.removeAttribute("join_id");
            session.removeAttribute("join_pass");
            session.removeAttribute("join_name");
            session.removeAttribute("join_addr");
            session.removeAttribute("join_phone");
            session.removeAttribute("join_gender");
            session.removeAttribute("join_age");
            session.removeAttribute("join_email");
        }
        else{
            msg = "회원가입 실패";
            nextPage = "join.jsp";
        }

    }catch(Exception e){
        e.printStackTrace();
        msg = "DB 오류 : " + e.getMessage();
        nextPage = "join.jsp";
    }finally{
        DBCPUtil.close(pstmt, conn);
    }
}
%>

<script>
alert("<%=msg%>");
location.href="<%=nextPage%>";
</script>