/**
 * inputCheck.js
 */
// 문서가 모두 로드 되면 실행
window.onload = function(){
	
	// class="form-card" 를 가진 form 요소 선택 
	// (로그인, 회원가입 등 입력폼만 검사하기 위함)
	var form = document.querySelector(".form-card");
	// 해당 form이 없는 페이지에서는 스크립트 실행하지 않음
	// (게시판, 메인페이지 등에서 오류 방지)
	if(!form) return;

	// 선택된 form 내부의 모든 input 요소 가져오기 
	// header 검색 input 등 다른 영역 input은 포함되지 않음
	var input = form.querySelectorAll("input");
	// form submit 이벤트 발생 시 실행되는 함수	
	form.onsubmit = function(event){
		// 모든 input을 순회하면서 값이 비어있는지 검사
	    for(var i = 0; i < input.length; i++){
			// header 검색 input은 검사 제외
	        if(input[i].name == "keyword") continue;
			// checkbox는 값 입력 대상이 아니므로 제외
	        if(input[i].type == "checkbox") continue;
			// hidden input도 사용자 입력 대상이 아니므로 제외
	        if(input[i].type == "hidden") continue;
			// input 값이 비어있는 경우
	        if(input[i].value.length == 0){
				// data-msg 속성에 정의된 메시지를 사용
				// 없을 경우 기본 메시지 "입력값" 사용				
	            var msg = (input[i].dataset.msg || "입력값")+"를 확인해주세요.";
				// 경고 메시지 출력
	            alert(msg);
				// 해당 input으로 포커스 이동
	            input[i].focus();
				// form submit 기본 동작 차단
	            event.preventDefault();
	            return false;
	        }
	    }
		// 모든 input 검사를 통과하면 정상적으로 submit 진행
	    return true;
	}
}










