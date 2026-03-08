<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!-- inquiry.jsp -->

<section>
	<h3> 여기는 1:1 문의하기 페이지입니다. </h3>
</section>

<section>
<h2>1:1 문의하기</h2>

<form action="inquiryResult.jsp"  method="post">
<p>문의 유형</p>
<select name="category">
	<option>배송문의</option>
	<option>교환 / 환불</option>
	<option>상품 문의</option>
	<option>기타</option>
</select>



<p>이메일</p>
<input type="email"  name="email"   placeholder="이메일을 입력하세요" required>
	
<p>문의 제목</p>
<input type="text"   name="title"   placeholder="제목을 입력하세요"  required>
	
<p>문의 내용</p>
<textarea name="content"   rows="8"   cols="60"  
placeholder="문의 내용을 입력해 주세요"></textarea>
	
	<br>
	<br>
	
<button type="submit">문의 보내기</button>
	
</form>

</section>  