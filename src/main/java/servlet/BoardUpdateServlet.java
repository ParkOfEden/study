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
    	
    	HttpSession session = request.getSession(false);

    	if (session == null || !"admin".equals(session.getAttribute("authUser"))) {
    	    response.sendRedirect("index.jsp");
    	    return;
    	}

        request.setCharacterEncoding("UTF-8");

        int num = Integer.parseInt(request.getParameter("num"));
        String category = request.getParameter("category");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        
        // 업데이트 폼에 반영되는 파라미터
        int price = Integer.parseInt(request.getParameter("price"));
        String system_filename = request.getParameter("system_filename");

        BoardDAO dao = new BoardDAO();
        BoardVO old = dao.getBoard(num);
        
        BoardVO vo = new BoardVO();
        vo.setNum(num);
        vo.setCategory(category);
        vo.setTitle(title);
        vo.setAuthor(old.getAuthor());   // 기존 작성자 유지
        vo.setContent(content);
        
        vo.setPrice(price);
        vo.setSystem_filename(system_filename);

        dao.updateBoard(vo);

        response.sendRedirect("boardDetail.do?num=" + num);
    }
}