package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.BoardDAO;
import vo.BoardVO;

@WebServlet("/boardUpdate.do")
public class BoardUpdateServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        int num = Integer.parseInt(request.getParameter("num"));
        String category = request.getParameter("category");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String imgUrl = request.getParameter("imgUrl");

        BoardVO vo = new BoardVO();
        vo.setNum(num);
        vo.setCategory(category);
        vo.setTitle(title);
        vo.setContent(content);
        vo.setImgUrl(imgUrl);

        BoardDAO dao = new BoardDAO();
        dao.updateBoard(vo);

        response.sendRedirect("boardDetail.do?num=" + num);
    }
}