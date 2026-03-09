<!-- verifyCode_Update.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp" %>

<section class="section-base">
    <div class="verify-wrapper">
        <div class="verify-text">
            <h2>정보 수정 인증</h2>
            <p>보안을 위해 입력하신 이메일로 인증코드를 발송했습니다.</p>
        </div>
    
        <form class="form-card verify-card" action="verifyCheck_Update.jsp" method="post">
           <input type="text" name="inputCode" placeholder="인증코드 6자리 입력" required>
           <button type="submit">인증 및 정보 수정</button>
        </form>
    </div>
</section>

<%@ include file="common/footer.jsp" %>