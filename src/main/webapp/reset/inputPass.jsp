<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 1. 경로 수정: ../를 붙여 상위 폴더의 common을 찾도록 함 --%>
<%@ include file="../common/header.jsp" %>

<%
    // 발신 코드와 사용자가 입력한 코드가 일치하는지 확인
    String sendCode = request.getParameter("sendCode");
    String code = request.getParameter("code");
    String id = request.getParameter("id");
    
    // 비정상적인 접근 차단
    if(sendCode == null || code == null || id == null) {
        out.println("<script>alert('잘못된 접근입니다.'); location.href='resetPass.jsp';</script>");
        return;
    }

    if(!sendCode.equals(code)){
%>
    <script>
        alert("인증 실패, 다시 확인 후 요청해 주세요.");
        history.back();
    </script>
<%
        return;
    }
%>

<style>
    .pass-container {
        max-width: 600px;
        margin: 60px auto;
    }
    .pass-title-area {
        background-color: #d16464;
        color: white;
        padding: 20px 0;
        text-align: center;
        border-radius: 8px 8px 0 0;
    }
    .pass-title-area h2 { margin: 0; font-size: 1.5rem; }
    .pass-content {
        padding: 40px 30px;
        background: #fff;
        border: 1px solid #ddd;
        border-top: none;
        border-radius: 0 0 8px 8px;
    }
    .input-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    .input-table td { padding: 15px; border-top: 1px solid #eee; }
    .label-td { background: #f9f9f9; font-weight: bold; width: 35%; text-align: center; }
    .pass-input { width: 100%; padding: 10px; border: 1px solid #ccc; }
    .submit-btn {
        width: 100%; padding: 15px; background: #333; color: #fff;
        border: none; font-size: 1.1rem; font-weight: bold; cursor: pointer;
        margin-top: 25px; border-radius: 4px;
    }
</style>

<section class="section-base">
    <div class="pass-container">
        <div class="pass-title-area">
            <h2>새 비밀번호 설정</h2>
        </div>

        <div class="pass-content">
            <div style="text-align:center; color:#666; margin-bottom:20px;">
                <p><strong><%=id%></strong>님, 인증에 성공하였습니다.</p>
                <p>새롭게 사용할 비밀번호를 입력해 주세요.</p>
            </div>

            <form action="updatePass.jsp" method="POST" onsubmit="return validatePass()">
                <input type="hidden" name="id" value="<%=id%>">
                
                <table class="input-table">
                    <tr>
                        <td class="label-td">새 비밀번호</td>
                        <td>
                            <input type="password" name="password" id="password" class="pass-input" placeholder="새 비밀번호 입력" required>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-td">비밀번호 확인</td>
                        <td>
                            <input type="password" name="rePassword" id="rePassword" class="pass-input" placeholder="비밀번호 확인" required>
                        </td>
                    </tr>
                </table>

                <button type="submit" class="submit-btn">비밀번호 변경하기</button>
            </form>
        </div>
    </div>
</section>

<script>
    function validatePass() {
        var pw = document.getElementById("password").value;
        var rpw = document.getElementById("rePassword").value;
        if(pw !== rpw) {
            alert("비밀번호가 일치하지 않습니다.");
            return false;
        }
        return true;
    }
</script>

<%@ include file="../common/footer.jsp" %>