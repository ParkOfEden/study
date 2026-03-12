<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!-- header.jsp에서 관리함(중복 코드) 
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
 -->
<!-- 절대경로 path 지정을 header.jsp에서 했으나, 정적 include 의 형태에서는 
	 header.jsp에서 선언한 path 를 사용할 수 없음. => 500 error
-->

 <footer class="footer">
<section>
	<div class="line1">
	  <!-- EL 사용하여 contextPath 자동 적용 -->
	  <a href="${pageContext.request.contextPath}/shopinfo.jsp">매장 안내</a> | 
	  <a href="${pageContext.request.contextPath}/customerService.jsp">고객센터</a> | 
	  <a href="${pageContext.request.contextPath}/privacy.jsp">개인정보처리방침</a>
	  
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