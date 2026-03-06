package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.BoardDAO;
import vo.BoardVO;

@WebServlet("/boardUpdate.do")
public class BoardUpdateServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // 1. 권한 체크: 관리자가 아니면 403 Forbidden 페이지로 유도
            HttpSession session = request.getSession(false);
            if (session == null || !"admin".equals(session.getAttribute("authUser"))) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN); // error_403.jsp 호출
                return;
            }

            request.setCharacterEncoding("UTF-8");

            // 2. 파라미터 수집 및 유효성 검사 (404 페이지 유도)
            String numStr = request.getParameter("num");
            String priceStr = request.getParameter("price");
            
            if (numStr == null || priceStr == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            int num, price;
            try {
                num = Integer.parseInt(numStr);
                price = Integer.parseInt(priceStr);
            } catch (NumberFormatException e) {
                // 숫자가 아닌 값이 들어오면 404 처리
                response.sendError(HttpServletResponse.SC_NOT_FOUND); // error_404.jsp 호출
                return;
            }

            String category = request.getParameter("category");
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String system_filename = request.getParameter("system_filename");

            BoardDAO dao = new BoardDAO();
            
            // 3. 기존 정보 조회 (수정 전 데이터 확인)
            BoardVO old = dao.getBoard(num);
            if (old == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            
            // 4. VO 객체 생성 및 세팅
            BoardVO vo = new BoardVO();
            vo.setNum(num);
            vo.setCategory(category);
            vo.setTitle(title);
            vo.setAuthor(old.getAuthor());   // 기존 작성자 유지
            vo.setContent(content);
            vo.setPrice(price);
            vo.setSystem_filename(system_filename);

            // 5. DB 업데이트 실행 (예외 발생 시 catch 블록으로 이동)
            int result = dao.updateBoard(vo);

            if (result > 0) {
                response.sendRedirect("boardDetail.do?num=" + num);
            } else {
                // 업데이트 실패 시 500 또는 404 처리
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }

        } catch (Exception e) {
            // 6. SQL 오류, DB 접속 장애 등 발생 시 500 에러 페이지로 유도
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // error_500.jsp 호출
        }
    }
}