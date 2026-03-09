package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.BoardDAO;

@WebServlet("/boardDelete.do")
public class BoardDeleteServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // 1. 권한 체크: 관리자가 아니면 403 Forbidden 페이지로 유도
            HttpSession session = request.getSession(false);
            if (session == null || !"admin".equals(session.getAttribute("authUser"))) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN); // error_403.jsp 호출
                return;
            }

            // 2. 파라미터 체크: num이 없거나 숫자가 아니면 404 Not Found 페이지로 유도
            String numStr = request.getParameter("num");
            if (numStr == null || numStr.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND); 
                return;
            }

            int num;
            try {
                num = Integer.parseInt(numStr);
            } catch (NumberFormatException e) {
                // 400 페이지가 없으므로 404로 처리
                response.sendError(HttpServletResponse.SC_NOT_FOUND); // error_404.jsp 호출
                return;
            }

            // 3. 삭제 로직 실행 (DAO가 예외를 던지면 아래 catch 블록으로 이동)
            BoardDAO dao = new BoardDAO();
            int result = dao.deleteBoard(num);

            if (result > 0) {
                response.sendRedirect("boardList.do");
            } else {
                // 삭제할 대상이 이미 없는 경우 404 처리
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }

        } catch (Exception e) {
            // 4. DB 장애 등 시스템 오류 발생 시 500 에러 페이지로 유도
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // error_500.jsp 호출
        }
    }
}