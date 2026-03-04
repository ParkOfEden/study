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

        MemberDAO dao = new MemberDAO();

        // 1. 페이징 처리 변수 설정
        int listCount = dao.getMemberCount(); // 전체 회원 수 조회 (DB 메서드 추가 필요)
        int currentPage = 1; // 현재 페이지 (기본값 1)
        
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }

        int boardLimit = 10; // 한 페이지에 보여줄 회원 수
        int pageLimit = 5;   // 하단에 보여줄 페이지 번호 개수

        // 2. 페이지 계산 (PageInfo 로직)
        int maxPage = (int) Math.ceil((double) listCount / boardLimit);
        int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
        int endPage = startPage + pageLimit - 1;

        if (maxPage < endPage) {
            endPage = maxPage;
        }

        // Map이나 별도의 VO 객체에 페이징 정보 담기
        Map<String, Object> pi = new HashMap<>();
        pi.put("currentPage", currentPage);
        pi.put("maxPage", maxPage);
        pi.put("startPage", startPage);
        pi.put("endPage", endPage);

        // 3. 현재 페이지에 맞는 회원 목록만 가져오기
        // DB 쿼리에서 ROWNUM 등을 활용해 페이징 처리를 해야 합니다.
        List<MemberVO> list = dao.getMembersByPage(currentPage, boardLimit);

        request.setAttribute("memberList", list);
        request.setAttribute("pi", pi); // 페이지 정보 전달

        request.getRequestDispatcher("memberList.jsp").forward(request, response);
    }
}