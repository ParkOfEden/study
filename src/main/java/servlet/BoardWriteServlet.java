package servlet;

import java.io.File;
import java.io.IOException;

import dao.BoardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vo.BoardVO;

@WebServlet("/boardWrite.do")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 15    // 15MB
)
public class BoardWriteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        // 1. 일반 텍스트 데이터 추출
        String category = request.getParameter("category");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String content = request.getParameter("content");
        String imgUrl = request.getParameter("imgUrl");

        // 2. 파일 업로드 처리
        Part filePart = request.getPart("uploadFile");
        String systemFilename = null;
        
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = filePart.getSubmittedFileName();
            // 파일명 중복 방지를 위한 타임스탬프 결합
            systemFilename = System.currentTimeMillis() + "_" + fileName;
            
            // 서버상의 실제 저장 경로 (WebContent/upload 또는 src/main/webapp/upload)
            String uploadPath = getServletContext().getRealPath("/upload");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            
            filePart.write(uploadPath + File.separator + systemFilename);
        }

        // 3. VO 객체에 데이터 담기
        BoardVO vo = new BoardVO();
        vo.setCategory(category);
        vo.setTitle(title);
        vo.setAuthor(author);
        vo.setContent(content);
        vo.setImgUrl(imgUrl);
        vo.setSystemFilename(systemFilename); 

        // 4. DAO를 통해 DB 저장
        BoardDAO dao = new BoardDAO();
        int result = dao.insertBoard(vo);

        if (result > 0) {
            response.sendRedirect("boardList.do");
        } else {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('등록 실패'); history.back();</script>");
        }
    }
}