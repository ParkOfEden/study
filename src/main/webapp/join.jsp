<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp" %>

<script type="text/javascript" src="js/inputCheck.js"></script>
<section>
    <form class="form-card" action="joinCheck.jsp" method="POST">
        <table class="pd-table">
            <tr>
                <th colspan="2"><h1>회원가입</h1></th>
            </tr>
            <tr>
                <td>아이디</td>
                <td>
                    <input type="text" name="id" data-msg="아이디" placeholder="INSERT ID HERE" autofocus required/>
                </td>
            </tr>
            <tr>
                <td>닉네임</td>
                <td>
                    <input type="text" name="nickname" data-msg="닉네임" placeholder="미입력 시 아이디와 동일하게 설정됩니다."/>
                </td>
            </tr>
            <tr>
                <td>비밀번호</td>
                <td>
                    <input type="password" name="pass" data-msg="비밀번호" placeholder="INSERT PW HERE" required/>
                </td>
            </tr>
            <tr>
                <td>이름</td>
                <td>
                    <input type="text" name="name" data-msg="이름" placeholder="INSERT NAME HERE" required/>
                </td>
            </tr>
            <tr>
                <td>주소</td>
                <td>
                    <input type="text" name="addr" data-msg="주소" placeholder="INSERT ADDR HERE"/>
                </td>
            </tr>
            <tr>
                <td>전화번호</td>
                <td>
                    <input type="text" name="phone" data-msg="전화번호" placeholder="INSERT PHONE HERE"/>
                </td>
            </tr>
            <tr>
                <td>이메일</td>
                <td>
                    <input type="email" name="email" data-msg="이메일" placeholder="example@mail.com" required/>
                </td>
            </tr>
            <tr>
                <td>성별</td>
                <td>
                    <label><input type="radio" name="gender" value="남성" checked /> 남성</label>
                    <label><input type="radio" name="gender" value="여성" /> 여성</label>
                </td>
            </tr>
            <tr>
                <td>나이</td>
                <td>
                    <input type="number" name="age" data-msg="나이" placeholder="INSERT Age HERE"/>
                </td>
            </tr>
            <tr>
                <th colspan="2">
                    <button type="submit">회원가입</button>
                </th>
            </tr>
        </table>
    </form>
</section>

<%@ include file="common/footer.jsp" %>