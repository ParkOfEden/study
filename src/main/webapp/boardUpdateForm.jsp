<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp" %>

<section class="section-base">
    <h2>상품 수정</h2>

    <form action="boardUpdate.do" method="post">
        
        <!-- num은 숨겨서 보냄 -->
        <input type="hidden" name="num" value="${board.num}"/>

        카테고리 :
        <input type="text" name="category" value="${board.category}" /><br><br>

        제목 :
        <input type="text" name="title" value="${board.title}" /><br><br>

        내용 :
        <textarea name="content" rows="5" cols="40">${board.content}</textarea><br><br>

        이미지 경로 :
        <input type="text" name="imgUrl" value="${board.imgUrl}" /><br><br>

        <input type="submit" value="수정 완료"/>
    </form>
</section>

<%@ include file="common/footer.jsp" %>