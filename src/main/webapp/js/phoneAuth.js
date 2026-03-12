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

// 1. 인증번호 발송
const sendSMS = () => {
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
        document.getElementById("recaptcha-container").style.display = "none";
        document.getElementById("sms-input-row").style.display = "table-row";
      }).catch((err) => {
        console.error(err);
        alert("발송 실패: " + err.code);
        if(window.recaptchaVerifier) window.recaptchaVerifier.render();
      });
};

// 2. 인증번호 확인
const confirmSMS = () => {
    const code = document.getElementById("sms_auth_code").value;
    if (code.length !== 6) {
        alert("6자리 인증번호를 입력하십시오.");
        return;
    }

    window.confirmationResult.confirm(code)
      .then((result) => {
        alert("휴대폰 인증이 완료되었습니다.");
        
        document.getElementById("phone_verified_status").value = "true";
        document.getElementById("user_phone").readOnly = true;
        document.getElementById("sms_auth_code").readOnly = true;
        
        const sendBtn = document.getElementById("btn-send-sms");
        const confirmBtn = document.getElementById("btn-confirm-sms");
        
        if(sendBtn) sendBtn.disabled = true;
        if(confirmBtn) {
            confirmBtn.innerText = "인증 완료";
            confirmBtn.disabled = true;
            confirmBtn.style.backgroundColor = "#777";
        }
      }).catch((err) => {
        console.error(err);
        alert("인증번호가 일치하지 않습니다.");
      });
};

// 이벤트 리스너 등록
document.getElementById("btn-send-sms").addEventListener("click", sendSMS);
document.getElementById("btn-confirm-sms").addEventListener("click", confirmSMS);