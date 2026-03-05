<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. 세션에서 "cart"라는 이름으로 저장된 리스트를 삭제합니다.
    session.removeAttribute("cart");

    // 2. 비우기가 완료된 후 다시 장바구니 페이지로 돌아갑니다.
    // (사용자가 비워진 결과를 바로 확인할 수 있도록 합니다.)
    response.sendRedirect("cartView.jsp"); 
%>