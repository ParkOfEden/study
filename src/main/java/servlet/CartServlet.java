package servlet;

import java.io.IOException;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // 1. HttpSession import 필수

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // 폼에서 넘어온 값 받기
        String productName = request.getParameter("p_name");
        String price = request.getParameter("price");

        // 2. request 객체에서 직접 session을 꺼내와야 합니다.
        HttpSession session = request.getSession();

        // 세션에서 리스트 꺼내기
        ArrayList<String> cart = (ArrayList<String>) session.getAttribute("cart");
        
        if (cart == null) {
            cart = new ArrayList<String>();
            session.setAttribute("cart", cart);
        }

        // "상품명|가격" 형태로 저장
        if (productName != null && price != null) {
            cart.add(productName + "|" + price);
        }

        response.sendRedirect("cartView.jsp");
    }
}