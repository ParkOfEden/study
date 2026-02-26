<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- footer.jsp -->

<style>
  .menu {
    display: flex;
    justify-content: space-between;
  }

  .menu a {
    text-decoration: none;
    color: black;
    font-size: 20px;
    font-weight: bold;
  }

  .menu a:hover {
    color: red;
  }

  .company {
    font-size: 30px;
    font-weight: bold;
    margin-top: 20px;
  }

  .footer-info {
    text-align: left;
    font-weight: bold;
    margin-top: 20px;
  }
</style>

<div class="menu">
  <a href="shopinfo.jsp">매장안내</a>
  <a href="shopinfo.jsp">고객센터</a>
  <a href="shopinfo.jsp">개인정보처리방침</a> 
</div>

<hr><br><br>

<div class="company">
  WOL_CL (월클) (주)
</div>

<footer>
  <div class="footer-info">
    <div>© since 1982</div>
    <div>Address : 부산시 동래구 충렬대로 미녀역 8호선</div>
    <div>Phone : 051-1234-5678</div>
  </div>
</footer>