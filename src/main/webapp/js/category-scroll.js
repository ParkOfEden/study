/**
 *  메인(index.jsp) 상단부 카테고리 영역 스크롤 기능 수정
 */

document.addEventListener("DOMContentLoaded", function(){

	const scrollBox = document.querySelector(".category-scroll");
	
	document.querySelector(".scroll-btn.left").addEventListener("mouseenter", ()=>{
	    scrollBox.scrollBy({ left:-300, behavior:"smooth" });
	});
	
	document.querySelector(".scroll-btn.right").addEventListener("mouseenter", ()=>{
	    scrollBox.scrollBy({ left:300, behavior:"smooth" });
	});

});