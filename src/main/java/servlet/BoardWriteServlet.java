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
        
        request.setCharacterEncoding("UTF-8");
        
        // 1. 데이터 추출 (JSP의 name 속성과 일치시켜야 함)
        String category = request.getParameter("category");
        String p_name = request.getParameter("p_name");   // title -> p_name
        String author = request.getParameter("author");
        String p_desc = request.getParameter("p_desc");   // content -> p_desc
        
        // 가격 처리 (문자열을 숫자로 변환)
        String priceStr = request.getParameter("price");
        int price = (priceStr != null && !priceStr.isEmpty()) ? Integer.parseInt(priceStr) : 0;

        // 2. 파일 업로드 처리
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

        // 3. VO 객체에 데이터 담기 (ProductVO 또는 수정한 BoardVO)
        BoardVO vo = new BoardVO();
        vo.setCategory(category);
        vo.setTitle(p_name);    // VO 내부 변수명이 title이라도 값은 p_name을 넣음
        vo.setAuthor(author);
        vo.setContent(p_desc);  // VO 내부 변수명이 content라도 값은 p_desc를 넣음
        vo.setSystem_filename(system_filename); 
        vo.setPrice(price);     // 반드시 BoardVO에 setPrice 메서드가 있어야 함

        // 4. DAO 호출
        BoardDAO dao = new BoardDAO();
        int result = dao.insertBoard(vo); // 이 메서드 안의 SQL이 중요함

        if (result > 0) {
            response.sendRedirect("boardList.do");
        } else {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('등록 실패: DB 연동 에러'); history.back();</script>");
        }
    }
}