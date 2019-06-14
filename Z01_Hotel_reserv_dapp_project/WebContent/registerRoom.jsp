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

  <title>객실 등록</title>

  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="css/modern-business.css" rel="stylesheet">
</head>
<body>
	<div class="container">

    	<div class="row">
	  <!--
      <div class="col-md-5">
        <img class="img-fluid" src="http://placehold.it/400x400" alt="객실 사진">
      </div>
	  -->
      <div class="col-md-6">
        <form action="#" method="post">
          <ul style="list-style-type: none">
	          <li>방 종류 : <br><input style="width: 250px;"></li>  
	          <li style="margin-top: 15px;">방 설명 : <textarea cols="40" rows="8"></textarea></li>
	          <li style="margin-top: 15px;">허용 인원: <br>
	          	<select style="width: 50px">
	          		<c:forEach var="i" begin="2" end="9">
	          			<option>${ i }</option>
	          		</c:forEach>
	          	</select>
	          </li>
	          <li style="margin-top: 15px;">평일 1박요금 : <br><input style="width: 250px;"></li>
	          <li style="margin-top: 15px;">주말 1박요금: <br><input style="width: 250px;"></li>
	          <li style="margin-top: 15px;">전체 방 개수 : <br><input style="width: 250px;"></li>
          </ul>
          <input style=" margin-top: 30px; margin-left: 235px;" type="button" value="등록">
        </form>
      </div>

    </div>

  </div>
  <!-- /.container -->
  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>