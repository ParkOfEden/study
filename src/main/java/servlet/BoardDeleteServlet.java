package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.BoardDAO;

@WebServlet("/boardDelete.do")
public class BoardDeleteServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
    	
    	HttpSession session = request.getSession(false);

    	if (session == null || !"admin".equals(session.getAttribute("authUser"))) {
    	    response.sendRedirect("index.jsp");
    	    return;
    	}

        int num = Integer.parseInt(request.getParameter("num"));

        BoardDAO dao = new BoardDAO();
        dao.deleteBoard(num);

        response.sendRedirect("boardList.do");
    }
    
}
