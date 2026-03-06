package servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        try {
            request.setCharacterEncoding("UTF-8");
            
            String productIdStr = request.getParameter("p_id");
            HttpSession session = request.getSession();

            Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
            
            if (cart == null) {
                cart = new HashMap<>();
                session.setAttribute("cart", cart);
            }

            // 1. 파라미터가 아예 없는 경우 -> 403(권한/금지된 접근) 또는 404 처리
            if (productIdStr == null || productIdStr.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN); // 403 에러 페이지로 이동
                return;
            }

            try {
                int productId = Integer.parseInt(productIdStr);
                cart.put(productId, cart.getOrDefault(productId, 0) + 1);
            } catch (NumberFormatException e) {
                // 2. 파라미터 형식이 잘못된 경우 -> 404(찾을 수 없는 자원) 처리
                response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404 에러 페이지로 이동
                return;
            }

            response.sendRedirect("cartView.jsp");

        } catch (Exception e) {
            // 3. 서버 내부 로직 오류 -> 500 에러 페이지로 이동
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}