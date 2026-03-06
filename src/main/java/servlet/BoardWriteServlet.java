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
    fileSizeThreshold = 1024 * 1024 * 1,  
    maxFileSize = 1024 * 1024 * 10,       
    maxRequestSize = 1024 * 1024 * 15    
)
public class BoardWriteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            request.setCharacterEncoding("UTF-8");
            
            // 1. 데이터 추출 및 유효성 검사
            String category = request.getParameter("category");
            String p_name = request.getParameter("p_name");   
            String author = request.getParameter("author");
            String p_desc = request.getParameter("p_desc");   
            String priceStr = request.getParameter("price");

            // 필수 파라미터가 아예 없는 경우 403 Forbidden 페이지로 유도
            if (p_name == null || author == null) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN); // error_403.jsp
                return;
            }

            // 2. 가격 처리 (숫자 변환 실패 시 404 Not Found 페이지로 유도)
            int price = 0;
            if (priceStr != null && !priceStr.trim().isEmpty()) {
                try {
                    price = Integer.parseInt(priceStr);
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND); // error_404.jsp
                    return;
                }
            }

            // 3. 파일 업로드 처리
            Part filePart = request.getPart("uploadFile");
            String system_filename = null;
            
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = filePart.getSubmittedFileName();
                system_filename = System.currentTimeMillis() + "_" + fileName;
                
                String uploadPath = getServletContext().getRealPath("/css/img/upload");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();
                
                filePart.write(uploadPath + File.separator + system_filename);
            }

            // 4. VO 객체 생성 및 데이터 바인딩
            BoardVO vo = new BoardVO();
            vo.setCategory(category);
            vo.setTitle(p_name);    
            vo.setAuthor(author);
            vo.setContent(p_desc);  
            vo.setPrice(price);     
            vo.setSystem_filename(system_filename); 

            // 5. DAO 호출 (DAO가 throws Exception 상태이므로 catch로 이동 가능)
            BoardDAO dao = new BoardDAO();
            int result = dao.insertBoard(vo); 

            if (result > 0) {
                response.sendRedirect("boardList.do");
            } else {
                // 논리적 등록 실패 시 500 에러 처리
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }

        } catch (Exception e) {
            // 파일 업로드 용량 초과, DB 접속 장애 등 발생 시 500 에러 페이지로 유도
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // error_500.jsp
        }
    }
}