<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

	<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>호텔 정보 메인 페이지</title>

  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="css/modern-business.css" rel="stylesheet">
</head>
<script type="text/javascript">
	function move() {
		location.href = "hotelMain.jsp?contentPage=modify.jsp";
	}
	
	function popup() {
		var url = "photoinsert";
		var name = "photos"
		var option = "width = 700, height = 500 top = 100"
					 + "location = no"
		window.open(url,name, option);
	}
</script>

<body>
	<div class="container">

    	<div class="row">

      <div style="width:455.5px; height:360.5px;">
      	<c:if test="${!empty photo }" >
      	<img style="width:455.5px; height:360.5px;" src="${ photo }">
      	</c:if>
        
      </div>

      <div style="padding-left:15px;">
        <ul>
          <li>호텔 명 : <input onfocus="this.blur()" style="width: 200px; margin-left: 10px;" type="text" value = "${ hotelname }" ></li>
          <li style="margin-top: 15px;">도시 : <input style="width: 200px; margin-left: 31px;" type="text" onfocus="this.blur()" value="${city}"></li>  
          <li style="margin-top: 15px;">상세주소: <input style="width: 200px;margin-left: 4px;" type="text" onfocus="this.blur()" value="${detailaddr}"></li>
          <li style="margin-top: 15px;">지갑주소 : <input style="width: 200px;" type="text" onfocus="this.blur()" value="${wallet}"></li>
          <li style="margin-top: 15px;">연 락 처 : <input style="width: 200px; margin-left: 8px;" type="text" onfocus="this.blur()" value="${phone}"></li>
        </ul>
        <input style=" margin-top: 30px; margin-left: 270px;" type="button" value="사진 올리기(test)" onclick="popup()" >
        <input style=" margin-top: 30px; margin-left: 270px;" type="button" value="수정" onclick="move()" >
      </div>

    </div>
    <!-- /.row -->

    <!-- Related Projects Row -->
    <h3 class="my-4">Related Projects</h3>

    <div class="row">

      <div class="col-md-3 col-sm-6 mb-4">
        <a href="#">
          <img class="img-fluid" src="http://placehold.it/500x300" alt="">
        </a>
      </div>

      <div class="col-md-3 col-sm-6 mb-4">
        <a href="#">
          <img style="width:85.5; height:142.5;" class="img-fluid" src="http://placehold.it/500x300" alt="">
        </a>
      </div>

      <div class="col-md-3 col-sm-6 mb-4">
        <a href="#">
          <img class="img-fluid" src="http://placehold.it/500x300" alt="">
        </a>
      </div>

      <div class="col-md-3 col-sm-6 mb-4">
        <a href="#">
          <img class="img-fluid" src="http://placehold.it/500x300" alt="">
        </a>
      </div>

    </div>
    <!-- /.row -->

  </div>
  <!-- /.container -->
  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>