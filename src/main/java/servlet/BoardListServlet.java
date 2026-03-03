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
import utils.PageMaker;   // 현재 패키지에 맞게 수정

@WebServlet("/boardList.do")
public class BoardListServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

    	// 1. 파라미터 받기
        String paramPage = request.getParameter("page");
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
        
        // 3. 전체 개수 조회       
        int totalCount = dao.getBoardCount();
        
        // 4. 페이징 목록 조회     
        List<BoardVO> list =
        		dao.getBoardListPaging(cri.offset(), cri.getPerPageNum());
        
        // 5. PageMaker 생성
        PageMaker pm = new PageMaker(cri, totalCount, 10);     
        
        // 6. JSP에 전달
        request.setAttribute("boardList", list);
        request.setAttribute("pageMaker", pm);

        request.getRequestDispatcher("boardList.jsp")
               .forward(request, response);
    } // end doGet method	

} // end BoardListServlet class
