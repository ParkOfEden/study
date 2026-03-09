<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 상세 보기</title>
<style>
    /* 기존 스타일 유지 */
    .reply-view { margin-top: 20px; border-top: 1px solid #ccc; padding-top: 10px; }
    .reply-content { padding: 15px; background-color: #f9f9f9; border: 1px solid #ddd; min-height: 50px; }
    .admin-only-section { margin-top: 30px; }
    fieldset { border: 2px dashed #ffd700; padding: 20px; background-color: #fff9e6; }
    textarea { width: 100%; height: 100px; margin-bottom: 10px; resize: vertical; }
    .btn-submit { background-color: #4CAF50; color: white; padding: 10px 20px; border: none; cursor: pointer; }
    .btn-list { background-color: #333; color: white; padding: 10px 20px; text-decoration: none; display: inline-block; margin-top: 10px; }
</style>
</head>
<body>

    <h2>문의 상세 내용</h2>
    <table border="1" style="width:100%; border-collapse: collapse;">
        <tr>
            <th width="150">이메일</th>
            <td>${inquiry.email}</td>
        </tr>
        <tr>
            <th>내용</th>
            <td>${inquiry.content}</td>
        </tr>
        <tr>
            <th>등록일</th>
            <td>${inquiry.regDate}</td>
        </tr>
    </table>

    <div class="reply-view">
        <h3>관리자 답변 확인</h3>
        <div class="reply-content">
            <c:choose>
                <c:when test="${empty inquiry.reply}">
                    아직 등록된 답변이 없습니다.
                </c:when>
                <c:otherwise>
                    ${inquiry.reply}
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <c:if test="${loginUser.isAdmin == 'Y'}"> 
        <div class="admin-only-section">
            <fieldset>
                <legend>[관리자 전용 답변 작성란]</legend>
                <form action="insertReply.do" method="post">
                    <input type="hidden" name="inquiryNo" value="${inquiry.no}">
                    <textarea name="replyContent" placeholder="답변 내용을 입력하세요" required></textarea>
                    <br>
                    <button type="submit" class="btn-submit">답변 등록하기</button>
                </form>
            </fieldset>
        </div>
    </c:if>

    <br>
    <a href="inquiryList.do" class="btn-list">목록으로 돌아가기</a>

</body>
</html>