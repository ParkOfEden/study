<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id"); // URL의 ?id=값 받기
    // 여기서 DB SELECT 쿼리로 제목과 내용을 가져와 출력합니다 (생략)
%>
<h3>상세 보기 (번호: <%= id %>)</h3>
<hr>
<h4>관리자 답변 작성</h4>
<form action="inquiryAdminReply_process.jsp" method="post">
    <input type="hidden" name="id" value="<%= id %>">
    <textarea name="answer" rows="5" cols="60" placeholder="답변 내용을 입력하세요"></textarea><br>
    <button type="submit">답변 등록</button>
</form>