/**
 * inputCheck.js
 */
// 문서가 모두 로드 되면 실행
window.onload = function(){
	
	var form = document.querySelector(".form-card");
	if(!form) return;

	var input = form.querySelectorAll("input");

	form.onsubmit = function(event){

	    for(var i = 0; i < input.length; i++){

	        if(input[i].name == "keyword") continue;
	        if(input[i].type == "checkbox") continue;
	        if(input[i].type == "hidden") continue;

	        if(input[i].value.length == 0){
	            var msg = (input[i].dataset.msg || "입력값")+"를 확인해주세요.";
	            alert(msg);
	            input[i].focus();
	            event.preventDefault();
	            return false;
	        }
	    }

	    return true;
	}
}










