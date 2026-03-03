package servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import dao.MemberDAO;
import vo.MemberVO;

@WebServlet("/memberList.do")
public class MemberListServlet extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

        MemberDAO dao = new MemberDAO();
        List<MemberVO> list = dao.getAllMembers();

        request.setAttribute("memberList", list);

        request.getRequestDispatcher("memberList.jsp")
               .forward(request, response);
    }	
	
}
