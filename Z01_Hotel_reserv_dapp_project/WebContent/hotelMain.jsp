<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<title>호텔나라</title>
	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">	
  	<meta name="description" content="">
  	<meta name="author" content="">

  	<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  	<link href="css/modern-business.css" rel="stylesheet">
  	<link rel="stylesheet" type="text/css" href="css/main.css">
</head>

<style type="text/css">
	body {
  padding-top: 56px;
}

.carousel-item {
  height: 65vh;
  min-height: 300px;
  background: no-repeat center center scroll;
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
}

.portfolio-item {
  margin-bottom: 30px;
}
</style>

<body>
	<c:if test="${ empty hotelid }"> <!-- id라는 name값이 비어있으면 실행한다..(즉, 로그인 처리가 안 됐으면 올 수 없게..) -->
		<script>
			alert("로그인이 필요합니다.");
			location.href = './logout' // session이 없으면 알아서 로그아웃 처리..
		</script>
	</c:if>
  <nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-info fixed-top">
   <div class="container">
      <a class="navbar-brand" style="color:white;" href="hotelMain.jsp?contentPage=hotelInfo.jsp">HotelNara</a>
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li>
          	<a class="nav-link" style="color:white;" href="logout">Logout</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="container">
   
    <ol style="margin-top: 100px;" class="breadcrumb">
      <li class="breadcrumb-item">
        <a href="hotelMain.jsp?contentPage=hotelInfo.jsp">Home</a>
      </li>
      <li class="breadcrumb-item Active"> 호텔 사용자 </li>
      
    </ol>

    <!-- Content Row -->
    <div class="row">
      <!-- Sidebar Column -->
      <div class="col-lg-3 mb-4">
        <div class="list-group">
          <a href="hotelMain.jsp?contentPage=hotelInfo.jsp" class="list-group-item">호텔 정보</a>
          <a href="manageRoom?type=show&pIndex=1" class="list-group-item">객실 현황</a>
          <a href="showReservation" class="list-group-item">예약 현황</a>
        </div>
      </div>
      <!-- Content Column -->
      <div class="col-lg-9 mb-4">
       <c:set var="contentPage" value="${ param.contentPage}"/>
       <c:if test="${contentPage == null }">
       	<jsp:include page="hotelInfo.jsp"/>
       </c:if>
       <jsp:include page="${contentPage}"/>
      </div>
    </div>
    <!-- /.row -->

  </div>
  <!-- /.container -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>