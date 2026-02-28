<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- header.jsp에서 관리함(중복 코드 => 500 에러 발생) 
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
 -->
<!-- 절대경로 path 지정 -->
<% String path = request.getContextPath(); %>

<!-- 
<style>
	여기다가.. css 스타일 요소 부여하지 마시고 오직 footer.css에서만 작업하세요
	이유 : index.jsp 에서 include 해서 불러오면 여기다가 해놓은 style 속성이 그대로 적용되기 때문!!
</style>
-->

<footer class="footer">
<section>
	<div class="line1">
	
	  <a href="<%=path%>/shopinfo.jsp">매장 안내</a> | 
	  <a href="<%=path%>/customerService.jsp">고객센터</a> | 
	  <a href="<%=path%>/privacy.jsp">개인정보처리방침</a>
	  
	</div>

<!-- 중복되는 내용이지만 혹시 내용을 추가하게 될 때 재사용할 수 있으므로 놔둘게요. (직접 첨삭지도예정)
	<div class="menu">
	  <a href="#">매장안내</a>
	  <a href="#">고객센터</a>
	  <a href="#">개인정보처리방침</a> 
	</div>
 -->	
	<div class="line2">
	  WOL<span class="heart">♥</span>CL (월클 주식회사)
	</div>
	
	<div class="line3">
	  대표자 : SHIM  |  Address : 부산시 동래구 충렬대로 미녀역 8번 출구  |  Phone : 051-1234-5678
	</div>
	
	<div class="line4">
	  ©2026    |    WOL<span class="heart">♥</span>CL.com    |    ALL RIGHTS RESERVED
	</div>
</section>
</footer>

<!-- 아랫부분은 건드리지마세요 -->
</body>
</html>