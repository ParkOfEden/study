<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ include file="common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니 확인</title>
    <style>
        .cart-container { width: 500px; margin: 20px auto; border: 1px solid #ddd; padding: 20px; border-radius: 8px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { border-bottom: 1px solid #eee; padding: 10px; text-align: left; }
        .total-area { text-align: right; font-size: 1.2em; font-weight: bold; color: #e74c3c; }
        .btn-area { display: flex; justify-content: space-between; }
    </style>
</head>
<body>
    <div class="cart-container">
        <h2>🛒 내 장바구니</h2>
        <table>
            <thead>
                <tr>
                    <th>상품명</th>
                    <th>가격</th>
                </tr>
            </thead>
            <tbody>
            <%
                ArrayList<String> cart = (ArrayList<String>) session.getAttribute("cart");
                int totalPrice = 0; // 총 합계를 저장할 변수

                if (cart != null && !cart.isEmpty()) {
                    for (String item : cart) {
                        // "이름|가격" 데이터를 분리합니다.
                        String[] data = item.split("\\|"); 
                        String name = data[0];
                        int price = Integer.parseInt(data[1]);
                        totalPrice += price; // 합계 누적
            %>
                <tr>
                    <td><strong><%= name %></strong></td>
                    <td><%= price %>원</td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="2" style="text-align: center; color: gray;">장바구니가 비어 있습니다.</td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>

        <div class="total-area">
            총 결제 예정 금액: <%= totalPrice %>원
        </div>

        <hr>
        
        <div class="btn-area">
            <button onclick="location.href='boardList.do'">쇼핑 계속하기</button>
            <% if (cart != null && !cart.isEmpty()) { %>
                <button onclick="if(confirm('장바구니를 비울까요?')) location.href='cartClear.jsp'" style="background-color: #95a5a6; color: white; border: none; padding: 5px 10px; cursor: pointer;">장바구니 비우기</button>
                <button onclick="alert('주문 기능은 준비 중입니다.')" style="background-color: #2ecc71; color: white; border: none; padding: 5px 15px; cursor: pointer; font-weight: bold;">주문하기</button>
            <% } %>
        </div>
    </div>
</body>
</html>
<%@ include file="common/footer.jsp"%>