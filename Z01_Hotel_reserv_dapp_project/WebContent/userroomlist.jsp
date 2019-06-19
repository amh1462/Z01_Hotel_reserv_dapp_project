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

  <title>호텔 나라</title>

  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="css/shop-item.css" rel="stylesheet">

</head>

<style>
      table {
        width: 100%;
      }
</style>

<body>

  <!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" style="color:white;">HotelNara</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item active">
            <a class="nav-link" href="userIndex.html">Home
              <span class="sr-only">(current)</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">예약확인</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="userSearch.jsp">호텔검색</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- Page Content -->
  <div class="container">

    <div class="row">

      <div class="col-lg-3">
        <h1 class="my-4">Room List</h1>
        
        <div class="list-group">
 
        <c:forEach var="pIdx" begin="${ startList }" end="${ endList }">
        	<c:forEach var="roomVos" items="${rolists}">
        	<a <c:if test='${param.pIndex == pIdx}'></c:if> 
        	href="showRoom?pIndex=${pIdx}" class="list-group-item active">객실 : ${roVo.roomname}</a>
        	</c:forEach>
        </c:forEach>
        
        <!-- 
          <a href="#" class="list-group-item active">Category 1</a>
          <a href="#" class="list-group-item">Category 2</a>
          <a href="#" class="list-group-item">Category 3</a>
         -->
        </div>
      </div>
      <!-- /.col-lg-3 -->

      <div class="col-lg-9">
         <c:forEach var="roomVo" items="${roomlist}">
        <div class="card mt-4">
        	<div class="card-body">
            <h5 style="font-weight: bold;" >호텔 명 : ${ hotelname }</h5>
            <h5 style="font-weight: bold;" >상세주소 : ${country} ${city} ${ detailaddr }</h5>            
            <h5 style="font-weight: bold;" >체크 인 : ${checkin}</h5>
            <h5 style="font-weight: bold; display:inline-block;" >체크아웃 : ${ checkout }</h5>
            <h5 style="font-weight: bold; display:inline-block; float: right;" >방 갯수 : ${ roomVo.totalcount }</h5>
                     
          </div>
          <img class="card-img-top img-fluid" src="https://t4.daumcdn.net/thumb/R720x0/?fname=http://t1.daumcdn.net/brunch/service/user/wlQ/image/oOAAtL-P_N2WSPum8fPYgS_ou1c.jpg" alt="">
          <div class="card-body">
            <h3 class="card-title">${ roomVo.roomname }</h3>
            <h4> 평일 : ${roomVo.dailyprice} 원</h4>
            <h4>주말 : ${roomVo.weekendprice} 원</h4>
            <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sapiente dicta fugit fugiat hic aliquam itaque facere, soluta. Totam id dolores, sint aperiam sequi pariatur praesentium animi perspiciatis molestias iure, ducimus!</p>
            <span class="text-warning">&#9733; &#9733; &#9733; &#9733; &#9734;</span>
            4.0 stars
          </div>
        </div>
       	 </c:forEach>
        <!-- /.card -->

        <div class="card card-outline-secondary my-4">
          <div class="card-header">
    		객실 개요 / 어메니티
          </div>
          <div class="card-body">
            <table >
            	<tbody>
            		<tr>
            			<th style="font-weight: bold;">침대 타입</th>
            			<td style="text-align: center;">더블 / 트윈</td>
            			<td style="font-weight: bold;">수용인원</td>
            			<td style="text-align: center;">2명</td>
            			<td style="font-weight: bold;">객실크기</td>
            			<td style="text-align: center;">7.9평</td>
            		</tr>
            		<tr>
            			<th style="font-weight: bold;">전 망</th>
            			<td style="text-align: center;">시티뷰</td>
            			<td style="font-weight: bold;">체크인</td>
            			<td style="text-align: center;">16:00</td>
            			<td style="font-weight: bold;">체크아웃</td>
            			<td style="text-align: center;">익일 12:00</td>
            		</tr>
            	</tbody>
            </table>
            <hr>
            <table >
            	<thead>
            		<tr>

            			<th style="text-align: center;">일반</th>

            			<th style="text-align: center;">욕실</th>

            			<th style="text-align: center;">기타</th>
            		</tr>
            	</thead>
            	<tbody>
            		<tr>

            			<td style="text-align: center;">FULL HD TV / 티포트 / 금고</td>

            			<td style="text-align: center;">비데/ 목욕가운 /</td>

            			<td style="text-align: center;">무료 생수 1일 2병</td>
            		</tr>
            		<tr>

            			<td style="text-align: center;"></td>

            			<td style="text-align: center;">헤어드라이어 / 1회용</td>

            			<td style="text-align: center;"></td>
            		</tr>
            		<tr>
            			<td style="text-align: center;"></td>

            			<td style="text-align: center;">칫솔 및 치약 / 욕실용품</td>

            			<td style="text-align: center;"></td>
            		</tr>
            	</tbody>
            </table>
            <hr>
            <a href="#" class="btn btn-success">예약하기</a>
          </div>
        </div>
        <!-- /.card -->

      </div>
      <!-- /.col-lg-9 -->

    </div>

  </div>
  <!-- /.container -->

  <!-- Footer -->
  <footer class="py-5 bg-dark">
    <div class="container">
      <p class="m-0 text-center text-white">Copyright &copy; Your Website 2019</p>
    </div>
    <!-- /.container -->
  </footer>

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>
