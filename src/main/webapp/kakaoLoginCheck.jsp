<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*, java.io.*" %>
<%
    String code = request.getParameter("code");
    if (code != null) {
        try {
            String restApiKey = "412803eee2a93e9ee787821e916e63d4";
            String redirectUri = "http://localhost:8080/14_db_member_practice/kakaoLoginCheck.jsp";

            // 1. 액세스 토큰 요청
            URL url = new URL("https://kauth.kakao.com/oauth/token");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

            String params = "grant_type=authorization_code"
                          + "&client_id=" + restApiKey
                          + "&redirect_uri=" + redirectUri
                          + "&code=" + code;

            try (OutputStream os = conn.getOutputStream()) {
                os.write(params.getBytes("UTF-8"));
            }

            if (conn.getResponseCode() == 200) {
                // 토큰 읽기
                BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                String inputLine;
                StringBuffer resBody = new StringBuffer();
                while ((inputLine = in.readLine()) != null) resBody.append(inputLine);
                in.close();

                // 액세스 토큰 추출
                String accessToken = resBody.toString().split("\"access_token\":\"")[1].split("\"")[0];

                // 2. 사용자 정보 요청 (이 부분이 생략되어 있어서 userConn 오류가 났던 것임)
                URL userUrl = new URL("https://kapi.kakao.com/v2/user/me");
                HttpURLConnection userConn = (HttpURLConnection) userUrl.openConnection();
                userConn.setRequestMethod("GET");
                userConn.setRequestProperty("Authorization", "Bearer " + accessToken);

                if (userConn.getResponseCode() == 200) {
                    BufferedReader userIn = new BufferedReader(new InputStreamReader(userConn.getInputStream()));
                    String userRes = userIn.readLine();
                    userIn.close();

                    // 닉네임 파싱
                    String nickname = userRes.split("\"nickname\":\"")[1].split("\"")[0];

                    // 3. header.jsp의 변수명에 맞춰 세션 저장
                    session.setAttribute("authUser", "kakao_user"); // 로그인 여부 판단용
                    session.setAttribute("userNickname", nickname); // 헤더 표시용
                    session.setAttribute("userName", nickname);     // 기존 변수 유지용

                    response.sendRedirect("index.jsp");
                }
            } else {
                out.println("토큰 요청 실패: " + conn.getResponseCode());
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("오류 발생: " + e.getMessage());
        }
    }
%>