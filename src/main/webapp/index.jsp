<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp" %>

<link rel="stylesheet" href="css/product.css">


	
			<section class="product-list">
			
				<div class="category-wrapper">
				
					<button class="scroll-btn left">◀</button>
					
						<div class="category-scroll">
					
							<div class="category">
					
							<table class="category-table">
								<tr>
									<td><a href="Headerjump/Tshirt.jsp"><img src="css/img/main/sort_link/T_shirt.jpg"></a></td>
									<td><a href="Headerjump/knsw.jsp"><img src="css/img/main/sort_link/Knit.jpg"></a></td>
									<td><a href="Headerjump/blouse.jsp"><img src="css/img/main/sort_link/Y_shirt.jpg"></a></td>
									<td><a href="Headerjump/skirt.jsp"><img src="css/img/main/sort_link/Skirt.jpg"></a></td>
									<td><a href="Headerjump/skirt.jsp"><img src="css/img/main/sort_link/Pants.jpg"></a></td>
									<td><a href="Headerjump/denim.jsp"><img src="css/img/main/sort_link/Denim.jpg"></a></td>
									<td><a href="Headerjump/outer.jsp"><img src="css/img/main/sort_link/Outer.jpg"></a></td>
									<td><a href="Headerjump/onepiece.jsp"><img src="css/img/main/sort_link/One_piece.jpg"></a></td>
									<td><a href="Headerjump/capacc.jsp"><img src="css/img/main/sort_link/etc.jpg"></a></td>
									<td><a href="Headerjump/alldis.jsp"><img src="css/img/main/sort_link/sale.jpg"></a></td>
								</tr>
								<tr>
									<td>티셔츠</td>
									<td>니트/스웨터</td>
									<td>블라우스/셔츠</td>
									<td>스커트</td>
									<td>팬츠</td>
									<td>데님</td>
									<td>아우터</td>
									<td>원피스</td>
									<td>패션잡화</td>
									<td>할인코너</td>
								</tr>
							</table>
							</div>
						</div>
						
						<button class="scroll-btn right">▶</button>
						
					</div>
			</section>
			
			<section class="section-base main">
			
				<div class="recommend">
					<h1>고객님을 위한 추천 아이템</h1>
					
						
						<table class="product-table">
							<tr>
								<td><a href="#"><img src="css/img/main/md/today_pick-01.jpg"></a></td>
								<td><a href="#"><img src="css/img/main/md/today_pick-02.jpg"></a></td>
								<td><a href="#"><img src="css/img/main/md/today_pick-03.jpg"></a></td>
								<td><a href="#"><img src="css/img/main/md/today_pick-04.jpg"></a></td>
							</tr>
							<tr>
								<td>상품 1</td>
								<td>상품 2</td>
								<td>상품 3</td>
								<td>상품 4</td>
							</tr>
						</table>
						
				</div>
			</section><section>
				<div>
					<jsp:include page="gridTable.jsp"/>
				</div>
			
			</section>
			
			<%-- 메인 상단 컨텐츠 아이콘 스크롤 기능 --%>
			<script src="js/category-scroll.js"></script>
	
<%@ include file="common/footer.jsp"%>