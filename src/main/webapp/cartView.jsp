<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, utils.DBCPUtil" %>
<%@ include file="common/header.jsp" %>

<%
    // 세션에서 장바구니 Map 가져오기
    Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
    long totalPrice = 0;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니 확인</title>
    <style>
        .cart-container { width: 700px; margin: 20px auto; border: 1px solid #ddd; padding: 20px; border-radius: 8px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { border-bottom: 1px solid #eee; padding: 12px; text-align: center; }
        .text-left { text-align: left; }
        .total-area { text-align: right; font-size: 1.3em; color: #e74c3c; margin-top: 10px; }
        .btn-area { display: flex; justify-content: space-between; margin-top: 15px; }
    </style>
</head>
<body>
    <div class="cart-container">
        <h2>🛒 내 장바구니</h2>
        <table>
            <thead>
                <tr>
                    <th class="text-left">상품 정보</th>
                    <th>단가</th>
                    <th>수량</th>
                    <th>소계</th>
                </tr>
            </thead>
            <tbody>
            <%
                if (cart != null && !cart.isEmpty()) {
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        conn = DBCPUtil.getConnection();

                        for (Integer pid : cart.keySet()) {
                            int quantity = cart.get(pid);
                            String sql = "SELECT p_name, price FROM products WHERE p_id = ?";
                            pstmt = conn.prepareStatement(sql);
                            pstmt.setInt(1, pid);
                            rs = pstmt.executeQuery();

                            if (rs.next()) {
                                String name = rs.getString("p_name");
                                int price = rs.getInt("price");
                                int subTotal = price * quantity;
                                totalPrice += subTotal;
            %>
                <tr>
                    <td class="text-left"><strong><%= name %></strong></td>
                    <td><%= String.format("%,d", price) %>원</td>
                    <td><%= quantity %>개</td>
                    <td><%= String.format("%,d", subTotal) %>원</td>
                </tr>
            <%
                            }
                            DBCPUtil.close(rs, pstmt);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        DBCPUtil.close(conn);
                    }
                } else {
            %>
                <tr>
                    <td colspan="4" style="padding: 40px 0; color: gray;">장바구니가 비어 있습니다.</td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>

        <div class="total-area">
            최종 결제 금액: <%= String.format("%,d", totalPrice) %>원
        </div>

        <hr>
        <div class="btn-area">
            <button onclick="location.href='boardList.do'">쇼핑 계속하기</button>
            
            <% if (cart != null && !cart.isEmpty()) { %>
                <div>
                    <button onclick="if(confirm('장바구니를 비울까요?')) location.href='cartClear.jsp'" 
                            style="background-color: #95a5a6; color: white; border: none; padding: 8px 12px; cursor: pointer; border-radius: 4px;">
                        장바구니 비우기
                    </button>
                    <button onclick="alert('주문 기능은 준비 중입니다.')" 
                            style="background-color: #2ecc71; color: white; border: none; padding: 8px 20px; cursor: pointer; font-weight: bold; border-radius: 4px;">
                        주문하기
                    </button>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>
<%@ include file="common/footer.jsp" %>