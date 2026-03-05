<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp" %>

<section class="section-base">
    <h2>상품 정보 수정</h2>

    <%-- boardUpdateForm.jsp 수정본 --%>
<form class="form-card" action="boardUpdate.do" method="post">
    
    <input type="hidden" name="num" value="${board.num}"/>

    <table class="pd-table" style="width:100%; border-spacing: 10px;">
        <tr>
            <td>카테고리</td>
            <td><input type="text" name="category" value="${board.category}" style="width:100%;"/></td>
        </tr>

        <tr>
            <td>상품명</td>
            <td>
                <input type="text" name="title" value="${board.title}" style="width:100%;"/>
            </td>
        </tr>

        <tr>
            <td>판매 가격</td>
            <td>
                <input type="number" name="price" value="${board.price}" style="width:100%;"/>
            </td>
        </tr>

        <tr>
            <td>상품 설명</td>
            <td>
                <textarea name="content" rows="10" style="width:100%;">${board.content}</textarea>
            </td>
        </tr>

        <tr>
            <td>파일명(수정불가)</td>
            <td>
                <input type="text" name="system_filename" value="${board.systemFilename}" readonly style="background-color:#eee; width:100%;"/>
            </td>
        </tr>
    </table>

    <%-- 버튼 영역 추가 --%>
    <div style="text-align:center; margin-top:20px;">
        <button type="submit" style="padding:10px 20px; background-color: #007bff; color:white; border:none; cursor:pointer;">수정 완료</button>
        <button type="button" onclick="history.back()" style="padding:10px 20px; margin-left:10px;">취소</button>
    </div>
</form>
</section>

<%@ include file="common/footer.jsp" %>