<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp" %>

<script type="text/javascript" src="js/inputCheck.js"></script>

<section>
    <form class="form-card" action="joinCheck.jsp" method="POST" enctype="multipart/form-data" onsubmit="return validateFinal()">
        <input type="hidden" id="phone_verified_status" name="phone_verified" value="false" />

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
        <textarea name="addr" data-msg="주소" placeholder="INSERT ADDR HERE"></textarea>
    </td>
</tr>


            <tr>
                <td>전화번호</td>
                <td>
                    <input type="text" name="phone" id="user_phone" placeholder="01012345678" required/>
                    <button type="button" onclick="sendSMS()">인증번호 발송</button>
                    <div id="recaptcha-container"></div>
                </td>
            </tr>
            <tr id="sms-input-row" style="display:none;">
                <td>SMS&nbsp;인증번호</td>
                
                <td>
                    <input type="text" id="sms_auth_code" placeholder="6자리 숫자" maxlength="6" />
                    <button type="button" onclick="confirmSMS()">번호 확인</button>
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
        <label style="margin-right: 15px;"><input type="radio" name="gender" value="남성" checked /> 남성</label>
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
                <td>프로필 사진</td>
                <td>
                    <input type="file" name="profile_img" accept="image/*" onchange="previewImage(this)"/>
                    <div id="image_preview" style="margin-top: 5px; display: none;">
                        <img id="preview" src="#" alt="미리보기" style="max-width: 100px; border-radius: 50%; border: 1px solid #ccc;"/>
                    </div>
                </td>
            </tr>

            <tr>
                <th colspan="2">
                    <button type="submit">회원가입</button>
                </th>
            </tr>
        </table>
    </form> </section>
    <script>
// 이미지 미리보기 함수 (script 태그 내 혹은 외부 파일에 추가)
function previewImage(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById('preview').src = e.target.result;
            document.getElementById('image_preview').style.display = 'block';
        }
        reader.readAsDataURL(input.files[0]);
    }
}
</script>
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth, RecaptchaVerifier, signInWithPhoneNumber } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";

  const firebaseConfig = {
    apiKey: "AIzaSyAloROprTB-4uGjKYQ8KjF-ESzDPVOQZKw",
    authDomain: "phone-auth-f582c.firebaseapp.com",
    projectId: "phone-auth-f582c",
    storageBucket: "phone-auth-f582c.firebasestorage.app",
    messagingSenderId: "723140801352",
    appId: "1:723140801352:web:70e100300482783094f97d"
  };

  const app = initializeApp(firebaseConfig);
  const auth = getAuth(app);

  // 1. 인증번호 발송 함수
  window.sendSMS = function() {
    let rawPhone = document.getElementById("user_phone").value;
    rawPhone = rawPhone.replace(/[^0-9]/g, ""); 
    
    if(rawPhone.length < 10) {
        alert("올바른 전화번호를 입력하세요.");
        return;
    }

    let phoneNumber = "+82" + rawPhone.substring(1); 

    if(!window.recaptchaVerifier) {
        window.recaptchaVerifier = new RecaptchaVerifier(auth, 'recaptcha-container', { 
            'size': 'normal' 
        });
    }

    signInWithPhoneNumber(auth, phoneNumber, window.recaptchaVerifier)
      .then((confirmationResult) => {
        window.confirmationResult = confirmationResult;
        alert("인증번호가 발송되었습니다.");
        
        // UI 변경: 캡차 숨기고 인증번호 입력칸 표시
        document.getElementById("recaptcha-container").style.display = "none";
        document.getElementById("sms-input-row").style.display = "table-row";
      }).catch((err) => {
        console.error(err);
        alert("발송 실패: " + err.code);
        if(window.recaptchaVerifier) window.recaptchaVerifier.render(); // 실패 시 캡차 재설정
      });
  };

  // 2. 인증번호 확인 함수 (추가됨)
  window.confirmSMS = function() {
    const code = document.getElementById("sms_auth_code").value;
    if (code.length !== 6) {
        alert("6자리 인증번호를 입력하십시오.");
        return;
    }

    window.confirmationResult.confirm(code)
      .then((result) => {
        alert("휴대폰 인증이 완료되었습니다.");
        
        // 최종 상태 업데이트 및 UI 잠금
        document.getElementById("phone_verified_status").value = "true";
        document.getElementById("user_phone").readOnly = true;
        document.getElementById("sms_auth_code").readOnly = true;
        
        // 버튼 상태 변경 (완료 표시)
        const sendBtn = document.querySelector("button[onclick='sendSMS()']");
        const confirmBtn = document.querySelector("button[onclick='confirmSMS()']");
        if(sendBtn) sendBtn.disabled = true;
        if(confirmBtn) {
            confirmBtn.innerText = "인증 완료";
            confirmBtn.disabled = true;
            confirmBtn.style.backgroundColor = "#777"; // 시각적 비활성화
        }
      }).catch((err) => {
        console.error(err);
        alert("인증번호가 일치하지 않습니다.");
      });
  };
</script><style>
  section {
    display: flex;
    justify-content: center;
    padding: 40px 0;
  }

  .form-card {
    width: 500px; /* 전체 폼 너비를 약간 확장하여 가독성 확보 */
    margin: 0 auto;
  }

  .pd-table {
    width: 100%;
    border-collapse: collapse;
    border: 1px solid #ccc;
  }

  .pd-table td {
    border: 1px solid #ccc;
    padding: 10px;
    vertical-align: middle;
    text-align: left; /* 입력 칸 내부 요소 왼쪽 정렬 */
  }

  /* 왼쪽 항목명(Label) 영역 */
  .pd-table tr td:first-child {
    text-align: center;
    background-color: #f9f9f9;
    font-weight: bold;
    width: 100px; /* 라벨 너비 고정 */
    font-size: 13px;
  }

  /* 모든 입력 필드 너비 통일 (닉네임 설명이 잘리지 않도록 조정) */
  .pd-table input[type="text"],
  .pd-table input[type="password"],
  .pd-table input[type="email"],
  .pd-table input[type="number"],
  .pd-table textarea[name="addr"] {
    width: 100%; /* 부모 컨테이너(td)의 너비를 따름 */
    max-width: 320px; /* 최대 너비를 제한하여 줄 맞춤 */
    height: 32px;
    box-sizing: border-box;
    padding: 0 8px;
    border: 1px solid #ddd;
    border-radius: 3px;
    font-size: 13px;
    display: inline-block;
    vertical-align: middle;
  }

  /* 주소창 높이만 별도 조절 */
  .pd-table textarea[name="addr"] {
    height: 60px;
    padding: 5px 8px;
    resize: none;
  }

  /* 특수 케이스: 버튼이 포함된 입력 칸 (전화번호, 인증번호) */
  #user_phone, #sms_auth_code {
    width: calc(100% - 95px) !important; /* 버튼 공간 제외한 나머지 너비 차지 */
    max-width: 220px !important;
  }

  .pd-table button {
    height: 32px;
    padding: 0 12px;
    background-color: #d9534f;
    color: white;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 11px;
    vertical-align: middle;
    margin-left: 5px;
  }

  .pd-table th[colspan="2"] {
    padding: 20px 0;
    text-align: center;
  }

  .pd-table button[type="submit"] {
    width: 140px;
    height: 40px;
    font-size: 15px;
  }
  
  /* 제목 스타일 수정 */
  .pd-table h1 {
    font-size: 20px;
    margin: 0;
    color: #333;
  }
</style>

<%@ include file="common/footer.jsp" %>