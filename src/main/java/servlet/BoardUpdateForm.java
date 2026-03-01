/* BoardUpdateForm.java */
package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.BoardDAO;
import vo.BoardVO;

@WebServlet("/boardUpdateForm.do")
	public class BoardUpdateForm extends HttpServlet {
		
	private static final long serialVersionUID = 1L;

		protected void doGet(HttpServletRequest request,
	            HttpServletResponse response)
	throws ServletException, IOException {
	
	int num = Integer.parseInt(request.getParameter("num"));
	
	BoardDAO dao = new BoardDAO();
	BoardVO board = dao.getBoard(num);
	
	request.setAttribute("board", board);
	
	request.getRequestDispatcher("boardUpdateForm.jsp")
	  .forward(request, response);
	}
}
