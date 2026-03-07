<!--  inquiryAdminReply.jsp  (관리자용: 답변작성 페이지)  -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h3>문의 내용: 배송 언제 되나요?</h3>
<p>작성자: admin | 날짜: 2026-03-16</p>

<form action="replySave.jsp" method="post">
    <textarea name="replyContent" placeholder="답변 내용을 입력하세요" rows="5" cols="50"></textarea>
    <br>
    <button type="submit">답변 등록하기</button>
</form>   

