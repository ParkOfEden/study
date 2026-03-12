package servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.MemberDAO;
import vo.MemberVO;

@WebServlet("/displayProfile")
public class DisplayProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. 파라미터로 넘어온 ID 추출
        String id = request.getParameter("id");
        if (id == null || id.isEmpty()) return;

        MemberDAO dao = new MemberDAO();
        try {
            // 2. DB에서 해당 ID의 회원 정보 조회 (profile_blob 포함)
            // 주의: MemberDAO에 getMemberById(id) 메서드가 구현되어 있어야 합니다.
            MemberVO vo = dao.getMemberById(id); 

            if (vo != null && vo.getProfileBlob() != null) {
                byte[] imageBytes = vo.getProfileBlob();

                // 3. 브라우저에게 보낼 데이터의 형식을 이미지로 설정
                response.setContentType("image/jpeg"); // 또는 image/png, image/gif
                response.setContentLength(imageBytes.length);

                // 4. 출력 스트림을 통해 바이너리 데이터 전송
                ServletOutputStream out = response.getOutputStream();
                out.write(imageBytes);
                out.flush();
                out.close();
            } else {
            	// 프로필 사진이 없을 경우 지정하신 기본 이미지로 리다이렉트
                // 경로: /프로젝트명/img/images.png
                response.sendRedirect(request.getContextPath() + "/img/images.png");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}