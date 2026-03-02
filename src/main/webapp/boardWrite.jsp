<!-- boardWrite.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 타이틀은 여기서 작업하면 반영됩니다. -->
<%
request.setAttribute("pageTitle", "관리자 게시글 작성");
%>   
<%@ include file="common/header.jsp" %>
<%
    
    // 1. 로그인을 안 했거나 2. 아이디가 admin이 아니면 쫓아냄
    if (authUser == null || !"admin".equals(authUser)) {
%>
    <script>
        alert("관리자만 접근할 수 있는 페이지입니다.");
        location.href = "index.jsp"; 
    </script>
<%
        return; // 아래의 글쓰기 HTML 양식이 실행되지 않도록 강제 종료
    }
%>

    <!-- 학원 코드 스타일 그대로 적용 -->
    <form class="form-card" action="boardWrite.do" method="POST">
        <table class="pd-table">
            <tr>
                <th colspan="2">
                    <h3>상품/게시글 등록</h3>
                </th>
            </tr>
            
            
            <tr>
               <td>분류 선택</td>
                <td>
                    <select name="category" required>
                        <option value="">-- 카테고리를 선택하세요 --</option>
                        
                        <optgroup label="NEW & BEST">
                            <option value="신상품">신상품 (New)</option>
                            <option value="베스트">베스트 (Best)</option>
                            <option value="MD추천">MD 추천</option>
                        </optgroup>

                        <optgroup label="TOP">
                            <option value="티셔츠">티셔츠</option>
                            <option value="블라우스">블라우스</option>
                            <option value="셔츠">셔츠</option>
                            <option value="니트/스웨터">니트/스웨터</option>
                            <option value="카디건">카디건</option>
                            <option value="후드/맨투맨">후드/맨투맨</option>
                        </optgroup>

                        <optgroup label="OUTER">
                            <option value="자켓">자켓</option>
                            <option value="코트">코트</option>
                            <option value="패딩/경량">패딩/경량</option>
                            <option value="조끼">조끼</option>
                            <option value="가디건">가디건</option>
                        </optgroup>

                        <optgroup label="BOTTOM">
                            <option value="데님">데님 (Jeans)</option>
                            <option value="슬랙스">슬랙스</option>
                            <option value="와이드팬츠">와이드 팬츠</option>
                            <option value="스커트">스커트</option>
                            <option value="쇼츠">쇼츠</option>
                            <option value="트레이닝">트레이닝</option>
                        </optgroup>

                        <optgroup label="ONE-PIECE">
                            <option value="원피스">원피스</option>
                            <option value="점프수트">점프수트</option>
                            <option value="롬퍼">롬퍼</option>
                        </optgroup>

                        <optgroup label="SHOES & BAG">
                            <option value="스니커즈">스니커즈</option>
                            <option value="구두/힐">구두/힐</option>
                            <option value="부츠">부츠</option>
                            <option value="가방">가방</option>
                            <option value="악세서리">모자/액세서리</option>
                        </optgroup>

                        <optgroup label="SALE">
                            <option value="할인">전상품 할인</option>
                            <option value="시즌오프">시즌 오프</option>
                            <option value="특가">특가 존</option>
                        </optgroup>
                    </select>
                </td>
            </tr>

            <tr>
                <td>글 제목</td>
                <td>
                    <input type="text" name="title" required placeholder="제목을 입력하세요">
                </td>				
            </tr>

            <tr>
                <td>작성자</td>
                <td>
                    <input type="text" name="author" value="admin" readonly>
                </td>				
            </tr>
            <tr>
                <td>사진 URL</td>
                <td>
                    <input type="text" name="imgUrl" style="width:100%;" placeholder=".../a.jpg">
                </td>
            </tr>
            <tr>
                <td>글 내용</td>
                <td>
                    <textarea name="content" required cols="40" rows="10"></textarea>
                </td>				
            </tr>
            <tr>
                <th colspan="2">
                    <button type="submit">작성완료</button>
                    <button type="button" onclick="location.href='boardList.jsp'">취소</button>
                </th>
            </tr>
        </table>
    </form>

<%@ include file="common/footer.jsp"%>