/**
 *  메인(index.jsp) 상단부 카테고리 영역 스크롤 기능 수정
 */
/* 클릭(click) 시 스크롤
console.log("scroll js loaded");

document.addEventListener("DOMContentLoaded", function(){

	const scrollBox = document.querySelector(".category-scroll");
	
	document.querySelector(".scroll-btn.left").addEventListener("click", ()=>{
	    scrollBox.scrollBy({ left:-300, behavior:"smooth" });
	});
	
	document.querySelector(".scroll-btn.right").addEventListener("click", ()=>{
	    scrollBox.scrollBy({ left:300, behavior:"smooth" });
	});

});
*/

/* 마우스 오버(hover) 시 계속 스크롤  */
document.addEventListener("DOMContentLoaded", function(){

const scrollBox = document.querySelector(".category-scroll");

let scrollInterval;

document.querySelector(".scroll-btn.left").addEventListener("mouseenter", ()=>{
    scrollInterval = setInterval(()=>{
        scrollBox.scrollLeft -= 5;
    },10);
});

document.querySelector(".scroll-btn.right").addEventListener("mouseenter", ()=>{
    scrollInterval = setInterval(()=>{
        scrollBox.scrollLeft += 5;
    },10);
});

document.querySelectorAll(".scroll-btn").forEach(btn=>{
    btn.addEventListener("mouseleave", ()=>{
        clearInterval(scrollInterval);
    });
});

});