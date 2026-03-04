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
        String type = request.getParameter("type");
        String keyword = request.getParameter("keyword");    
        
        // Console 출력 확인
        System.out.println("type = [" + type + "]");
        System.out.println("keyword = [" + keyword + "]");
        
        if (keyword != null) {
            keyword = new String(keyword.getBytes("ISO-8859-1"), "UTF-8");
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
        
        if(keyword != null && !keyword.trim().isEmpty()) {
        	
        	totalCount = dao.getSearchBoardCount(type, keyword);
        	
            list = dao.getSearchBoardListPaging(
                    type,
                    keyword,
                    cri.offset(),
                    cri.getPerPageNum()
            );
            
            System.out.println("search list size = " + list.size());
            
        } else {
        	
            totalCount = dao.getBoardCount();

            list = dao.getBoardListPaging(
                    cri.offset(),
                    cri.getPerPageNum()
            );
            
            System.out.println("list size = " + list.size());
            
        }

        // 3. PageMaker 생성
        PageMaker pm = new PageMaker(cri, totalCount, 10);     
        
        // 4. JSP에 전달
        request.setAttribute("boardList", list);
        request.setAttribute("pageMaker", pm);

        // forward 분기 처리
        String include = request.getParameter("include");

        if ("table".equals(include)) {
            request.getRequestDispatcher("/boardTable.jsp")
                   .forward(request, response);
        } else {
            request.getRequestDispatcher("/boardList.jsp")
                   .forward(request, response);
        }
    } // end doGet method	

} // end BoardListServlet class
