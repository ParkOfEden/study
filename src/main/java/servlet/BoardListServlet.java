/* BoardListServlet.java */
package servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import dao.BoardDAO;
import vo.BoardVO;
import utils.Criteria;
import utils.PageMaker;

@WebServlet("/boardList.do")
public class BoardListServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. 파라미터 받기
            String paramPage = request.getParameter("page");
            String type = request.getParameter("type");
            String keyword = request.getParameter("keyword");
            String category = request.getParameter("category");

            if ("p_name".equals(type)) {
                type = "title";
            }

            int pageNum = 1;

            if (paramPage != null && !paramPage.trim().isEmpty()) {
                try {
                    pageNum = Integer.parseInt(paramPage);
                } catch (NumberFormatException e) {
                	// 400 페이지가 없으므로, 잘못된 페이지 요청은 404 에러 페이지로 유도
                    response.sendError(HttpServletResponse.SC_NOT_FOUND); // error_404.jsp 호출
                    return;
                }
            }

            // 2. Criteria 생성
            Criteria cri = new Criteria(pageNum, 10);
            BoardDAO dao = new BoardDAO();

            int totalCount = 0;
            List<BoardVO> list = null;

            // 3. 데이터 조회 (DAO 메서드들이 throws Exception 상태이므로 여기서 예외가 발생하면 catch로 넘어감)
            if (category != null && !category.trim().isEmpty()) {
                totalCount = dao.getSearchBoardCount("category", category);
                list = dao.getSearchBoardListPaging(
                        "category",
                        category,
                        cri.offset(),
                        cri.getPerPageNum()
                );
            } else if (keyword != null && !keyword.trim().isEmpty()) {
                totalCount = dao.getSearchBoardCount(type, keyword);
                list = dao.getSearchBoardListPaging(
                        type,
                        keyword,
                        cri.offset(),
                        cri.getPerPageNum()
                );
            } else {
                totalCount = dao.getBoardCount();
                list = dao.getBoardListPaging(
                        cri.offset(),
                        cri.getPerPageNum()
                );
            }

            // 4. PageMaker 생성
            PageMaker pm = new PageMaker(cri, totalCount, 10);

            // 5. JSP에 전달
            request.setAttribute("boardList", list);
            request.setAttribute("pageMaker", pm);

            request.getRequestDispatcher("/boardList.jsp").forward(request, response);

        } catch (Exception e) {
            // DB 연결 실패, SQL 오류 등 모든 예외 발생 시 서버 로그 출력 후 500 에러 페이지 호출
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }

    } // end doGet method

}// end BoardListServlet class
