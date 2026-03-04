<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setAttribute("pageTitle", "관리자 상품 등록");
%>   
<%@ include file="common/header.jsp" %>

<%
    // 관리자 권한 체크
    if (authUser == null || !"admin".equals(authUser)) {
%>
    <script>
        alert("관리자만 접근할 수 있습니다.");
        location.href = "index.jsp"; 
    </script>
<%
        return; 
    }
%>

<form class="form-card" action="boardWrite.do" method="POST" enctype="multipart/form-data">
    <table class="pd-table">
        <tr>
            <th colspan="2">
                <h3>[전체 카테고리] 신규 상품 등록</h3>
            </th>
        </tr>
        
        <tr>
            <td>분류 선택</td>
            <td>
                <select name="category" required style="width: 100%; padding: 5px;">
                    <option value="">-- 카테고리를 선택하세요 --</option>
                    <optgroup label="NEW&amp;BEST">
                    	<option value="신상품">신상품</option>
                    	<option value="Best 상품">Best 상품</option>
                    	<option value="MD 추천">MD 추천</option>                    
                    </optgroup>
                    <optgroup label="TOP">
                        <option value="티셔츠">티셔츠</option>
                        <option value="블라우스">블라우스</option>
                        <option value="셔츠">셔츠</option>
                        <option value="니트&amp;스웨터">니트&amp;스웨터</option>
                        <option value="카디건">카디건</option>
                        <option value="후드&amp;맨투맨">후드&amp;맨투맨</option>                        
                	</optgroup>
                    <optgroup label="TOP">
                        <option value="자켓">자켓</option>
                        <option value="코트">코트</option>
                        <option value="패딩&amp;경량">패딩&amp;경량</option>
                        <option value="조끼">조끼</option>
                        <option value="가디건">가디건</option>                       
                	</optgroup> 
                    <optgroup label="BOTTOM">
                        <option value="데님">데님</option>
                        <option value="슬랙스">슬랙스</option>
                        <option value="와이드 팬츠">와이드 팬츠</option>
                        <option value="스커트">스커트</option>
                        <option value="쇼츠">쇼츠</option>   
                        <option value="트레이닝">트레이닝</option>                     
                	</optgroup>      
                    <optgroup label="ONE-PIECE">
                        <option value="원피스">원피스</option>
                        <option value="점프수트">점프수트</option>
                        <option value="로퍼">로퍼</option>                   
                	</optgroup>                	
                    <optgroup label="SHOSE&amp;BAG">
                        <option value="스니커즈">스니커즈</option>
                        <option value="구두">구두</option>
                        <option value="힐">힐</option> 
                        <option value="부츠">부츠</option>
                        <option value="가방">가방</option>
                        <option value="모자&amp;액세서리">모자&amp;액세서리</option>                                                
                	</optgroup>    
                    <optgroup label="SALE">
                        <option value="전상품 할인">전상품 할인</option>
                        <option value="시즌 오프">시즌 오프</option>
                        <option value="특가존">특가존</option>                   
                	</optgroup>                  	            	          	               	
            	</select>
            </td>
        </tr>

        <tr>
            <td>상품명</td>
            <td>
                <input type="text" name="p_name" required placeholder="상품명을 입력하세요" style="width: 100%;">
            </td>				
        </tr>

        <tr>
            <td>판매 가격</td>
            <td>
                <input type="number" name="price" required min="0" placeholder="판매 가격(숫자)을 입력하세요" style="width: 100%;">
            </td>				
        </tr>

        <tr>
            <td>작성자(관리자)</td>
            <td>
                <input type="text" name="author" value="admin" readonly style="background-color: #eee;">
            </td>				
        </tr>

        <tr>
            <td>상품 이미지</td>
            <td>
                <input type="file" name="uploadFile" >
                <p style="font-size: 11px; color: gray;">* 실제 상품 이미지를 업로드해주세요.</p>
            </td>
        </tr>

        <tr>
            <td>상품 상세설명</td>
            <td>
                <textarea name="p_desc" required cols="40" rows="10" style="width: 100%;" placeholder="상품에 대한 설명을 적어주세요"></textarea>
            </td>				
        </tr>

        <tr>
            <th colspan="2" style="text-align: center; padding: 15px 0;">
                <button type="submit" style="padding: 10px 20px; background-color: #007bff; color: white; border: none; cursor: pointer;">상품 등록 완료</button>
                <button type="button" onclick="location.href='boardList.do'" style="padding: 10px 20px;">취소</button>
            </th>
        </tr>
    </table>
</form>

<%@ include file="common/footer.jsp"%>