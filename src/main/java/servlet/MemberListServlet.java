package servlet;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import dao.MemberDAO;
import vo.MemberVO;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/memberList.do")
public class MemberListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 0. 관리자 권한 체크 (회원 목록은 관리자만 접근 가능하므로 403 활용)
            HttpSession session = request.getSession(false);
            if (session == null || !"admin".equals(session.getAttribute("authUser"))) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN); // error_403.jsp 호출
                return;
            }

            MemberDAO dao = new MemberDAO();

            // 1. 페이징 처리 변수 설정 (DAO가 예외를 던지므로 try 블록 내부 위치)
            int listCount = dao.getMemberCount(); 
            int currentPage = 1; 
            
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.trim().isEmpty()) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                    // 페이지 번호가 숫자가 아니면 404 페이지 유도
                    response.sendError(HttpServletResponse.SC_NOT_FOUND); // error_404.jsp 호출
                    return;
                }
            }

            int boardLimit = 10; 
            int pageLimit = 5;   

            // 2. 페이지 계산 (PageInfo 로직)
            int maxPage = (int) Math.ceil((double) listCount / boardLimit);
            
            // 데이터가 없는데 페이지 번호가 범위를 벗어난 경우 처리
            if (currentPage > maxPage && maxPage > 0) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
            int endPage = startPage + pageLimit - 1;

            if (maxPage < endPage) {
                endPage = maxPage;
            }

            Map<String, Object> pi = new HashMap<>();
            pi.put("currentPage", currentPage);
            pi.put("maxPage", maxPage);
            pi.put("startPage", startPage);
            pi.put("endPage", endPage);

            // 3. 현재 페이지에 맞는 회원 목록 가져오기
            List<MemberVO> list = dao.getMembersByPage(currentPage, boardLimit);

            request.setAttribute("memberList", list);
            request.setAttribute("pi", pi); 

            request.getRequestDispatcher("memberList.jsp").forward(request, response);

        } catch (Exception e) {
            // DB 연결 실패 또는 쿼리 오류 시 500 에러 페이지 유도
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // error_500.jsp 호출
        }
    }
}