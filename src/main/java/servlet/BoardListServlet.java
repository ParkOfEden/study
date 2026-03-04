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

        // 1. 파라미터 받기
        String paramPage = request.getParameter("page");
        String type = request.getParameter("type");
        String keyword = request.getParameter("keyword");

        if ("p_name".equals(type)) {
            type = "title";
        }

        int pageNum = 1;

        if (paramPage != null && !paramPage.trim().isEmpty()) {
            try {
                pageNum = Integer.parseInt(paramPage);
            } catch (NumberFormatException e) {
                pageNum = 1;
            }
        }

        // 2. Criteria 생성
        Criteria cri = new Criteria(pageNum, 10);

        BoardDAO dao = new BoardDAO();

        int totalCount = 0;
        List<BoardVO> list = null;

        // 3. 데이터 조회
        if (keyword != null && !keyword.trim().isEmpty()) {

            totalCount = dao.getSearchBoardCount(type, keyword);

            list = dao.getSearchBoardListPaging(
                    type,
                    keyword,
                    cri.offset(),
                    cri.getPerPageNum()
            );

            System.out.println("검색 결과 수: " + list.size());

        } else {

            totalCount = dao.getBoardCount();

            list = dao.getBoardListPaging(
                    cri.offset(),
                    cri.getPerPageNum()
            );

            System.out.println("전체 게시글 수: " + list.size());
        }

        // 4. PageMaker 생성
        PageMaker pm = new PageMaker(cri, totalCount, 10);

        // 5. JSP에 전달
        request.setAttribute("boardList", list);
        request.setAttribute("pageMaker", pm);

        // 6. Forward 분기
        // view 타입
        String viewType = request.getParameter("include");
      
        // view 분기
        if ("grid".equals(viewType)) {

            request.getRequestDispatcher("/gridTable.jsp")
                   .forward(request, response);

        } else {

            request.getRequestDispatcher("/boardTableNew.jsp")
                   .forward(request, response);
        }

    } // end doGet method

}// end BoardListServlet class
