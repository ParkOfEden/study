package com.board.controller; // 위에서 적은 Java package 이름과 같아야 함

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

// 이 주소("/BoardWriteController")가 JSP의 form action 주소와 일치해야 합니다.
@WebServlet("/BoardWriteController")
public class BoardWriteController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @SuppressWarnings("unused")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 한글 깨짐 방지
        request.setCharacterEncoding("UTF-8");

        // 2. JSP에서 name 속성으로 보낸 데이터 읽기
        String category = request.getParameter("category");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String content = request.getParameter("content");

        // 3. 데이터가 잘 들어왔는지 이클립스 Console창에서 확인
        System.out.println("데이터 수신 완료: " + title + ", " + author);

        // 4. (중요) 글쓰기 완료 후 이동할 페이지 설정
        // 성공 후 목록 페이지(boardList.jsp)로 이동하게 합니다.
        response.sendRedirect(request.getContextPath() + "/boardList.jsp");
    }
}