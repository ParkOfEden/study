<!-- webapp/reset/acceptCode.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/common/header.jsp" %>
    
    <%
    String code = (String)request.getAttribute("code");
    String id = (String)request.getAttribute("id");
%>
    <style>
    /* 이 페이지에만 특화된 스타일 조정 */
    .verify-container {
        max-width: 600px; /* 기존보다 너비 확장 */
        margin: 60px auto; /* 상하 여백 축소 */
    }
    .verify-title-area {
        background-color: #d16464; /* 헤더 색상 */
        color: white;
        padding: 20px 0;
        text-align: center;
        border-radius: 8px 8px 0 0;
    }
    .verify-title-area h2 {
        margin: 0;
        font-size: 1.5rem;
        line-height: 1.2; /* 글자 위치 수직 중앙 조정 */
    }
    .verify-content {
        padding: 40px 30px;
        background: #fff;
        border: 1px solid #ddd;
        border-top: none;
        border-radius: 0 0 8px 8px;
    }
    .input-row {
        display: flex;
        align-items: center;
        margin-top: 30px;
        border-top: 1px solid #eee;
        border-bottom: 1px solid #eee;
    }
    .input-label {
        flex: 1;
        background: #f9f9f9;
        padding: 20px;
        font-weight: bold;
        border-right: 1px solid #eee;
        text-align: center;
    }
    .input-field {
        flex: 2;
        padding: 10px 20px;
    }
    .input-field input {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        text-align: center;
        font-size: 1.1rem;
    }
    .submit-btn {
        width: 100%;
        padding: 15px;
        background: #333;
        color: #fff;
        border: none;
        font-size: 1.1rem;
        font-weight: bold;
        cursor: pointer;
        margin-top: 25px;
        border-radius: 4px;
    }
</style>

<section class="section-base">
    <div class="verify-container">
        <div class="verify-title-area">
            <h2>이메일 코드 인증</h2>
        </div>

        <div class="verify-content">
            <div style="text-align:center; color:#666;">
                <p>회원가입 시 등록한 이메일을 확인 후</p>
                <p>전송된 <strong>5자리 코드</strong>를 입력해 주세요.</p>
            </div>

            <form action="inputPass.jsp" method="POST">
                <input type="hidden" name="sendCode" value="<%=code%>">
                <input type="hidden" name="id" value="<%=id%>">

                <div class="input-row">
                    <div class="input-label">인증 코드</div>
                    <div class="input-field">
                        <input type="text" name="code" placeholder="코드 5자리 입력" required maxlength="5">
                    </div>
                </div>

                <button type="submit" class="submit-btn">인증 확인</button>
            </form>
        </div>
    </div>
</section>

<%@ include file="../common/footer.jsp" %>
