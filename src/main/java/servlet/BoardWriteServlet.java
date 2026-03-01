/* BoardWriteServlet.java */
package servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import dao.BoardDAO;
import vo.BoardVO;

@WebServlet("/boardWrite.do")
public class BoardWriteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        BoardVO vo = new BoardVO();
        vo.setCategory(request.getParameter("category"));
        vo.setTitle(request.getParameter("title"));
        vo.setAuthor(request.getParameter("author"));
        vo.setContent(request.getParameter("content"));
        vo.setImgUrl(request.getParameter("imgUrl"));

        BoardDAO dao = new BoardDAO();
        int result = dao.insertBoard(vo);

        if (result > 0) {
            response.sendRedirect("boardList.do");
        } else {
            response.getWriter().println("등록 실패");
        }
    }
}
