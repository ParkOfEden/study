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
            // 1. 파라미터 받기 (sort 추가)
            String paramPage = request.getParameter("page");
            String type = request.getParameter("type");
            String keyword = request.getParameter("keyword");
            String category = request.getParameter("category");
            String sort = request.getParameter("sort"); // 정렬 파라미터 수집

            if ("p_name".equals(type)) {
                type = "title";
            }

            int pageNum = 1;
            if (paramPage != null && !paramPage.trim().isEmpty()) {
                try {
                    pageNum = Integer.parseInt(paramPage);
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    return;
                }
            }

            // 2. Criteria 생성
            Criteria cri = new Criteria(pageNum, 10);
            BoardDAO dao = new BoardDAO();

            int totalCount = 0;
            List<BoardVO> list = null;

            // 3. 데이터 조회 (정렬 파라미터 sort를 DAO 메서드에 전달)
            if (category != null && !category.trim().isEmpty()) {
                totalCount = dao.getSearchBoardCount("category", category);
                list = dao.getSearchBoardListPaging(
                        "category",
                        category,
                        cri.offset(),
                        cri.getPerPageNum(),
                        sort // sort 인자 추가
                );
            } else if (keyword != null && !keyword.trim().isEmpty()) {
                totalCount = dao.getSearchBoardCount(type, keyword);
                list = dao.getSearchBoardListPaging(
                        type,
                        keyword,
                        cri.offset(),
                        cri.getPerPageNum(),
                        sort // sort 인자 추가
                );
            } else {
                totalCount = dao.getBoardCount();
                list = dao.getBoardListPaging(
                        cri.offset(),
                        cri.getPerPageNum(),
                        sort // sort 인자 추가
                );
            }

            // 4. PageMaker 생성
            PageMaker pm = new PageMaker(cri, totalCount, 10);

            // 5. JSP에 전달
            request.setAttribute("boardList", list);
            request.setAttribute("pageMaker", pm);
            request.setAttribute("currentSort", sort); // JSP UI 유지를 위해 전달

            request.getRequestDispatcher("/boardList.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
