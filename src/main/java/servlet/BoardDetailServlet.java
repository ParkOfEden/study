package servlet;

import java.io.IOException;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import dao.BoardDAO;
import vo.BoardVO;

@WebServlet("/boardDetail.do")
public class BoardDetailServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
            			 HttpServletResponse response)
			throws ServletException, IOException {
			
		int num = Integer.parseInt(request.getParameter("num"));
		
		BoardDAO dao = new BoardDAO();
		BoardVO board = dao.getBoard(num);
		
		request.setAttribute("board", board);
		
		request.getRequestDispatcher("boardDetail.jsp")
		  	   .forward(request, response);
    } // end doGet method	

} // end BoardDetailServlet class
