<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>호텔나라</title>

<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/shop-item.css" rel="stylesheet">
<script src="vendor/jquery/jquery.min.js"></script>
</head>

<style>
table {
	width: 100%;
}
</style>
<script type="text/javascript">
	function popup() {
		var url = "bookConfirm.jsp";
		var name = "confirm"
		var option = "width = 680px, height = 500px, top = 150 left = 700 location = no"
		window.open(url,confirm, option);
	}
</script>
<body>

	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container">
			<a class="navbar-brand" style="color: white;" >방 목록 창</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarResponsive" aria-controls="navbarResponsive"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item active"><a class="nav-link"
						href="userIndex.html">Home<span class="sr-only">(current)</span>
					</a></li>
					<li class="nav-item"><a class="nav-link"
						onclick="popup()">예약확인</a></li>
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

					<c:forEach var="roVo" items="${ roomNameList }">
						<a href="./showroom?roomno=${roVo.roomno}&hotelId=${ requestScope.hotelinfo.hotelid }&checkIn=${requestScope.checkIn}
								&checkOut=${requestScope.checkOut}&roomCount=${requestScope.roomCount}" 
								class="list-group-item <c:if test='${ param.roomno == roVo.roomno}' >active</c:if> ">
							${roVo.roomname}
						</a>
					</c:forEach>
				</div>
			</div>
			<!-- /.col-lg-3 -->
			<form style="margin-top: 10px;" class="col-lg-9" method="get"
				action="./registerbook">
				<div class="col-lg-9">
					<div class="card mt-4">
						<div class="card-body">
							<h5 style="font-weight: bold;">호텔 명 : ${ requestScope.hotelinfo.hotelname }</h5>
							<h5 style="font-weight: bold;">상세주소 : ${requestScope.country} ${requestScope.hotelinfo.city} ${requestScope.hotelinfo.detailaddr}</h5>
							<h5 style="font-weight: bold;">체크 인 : ${requestScope.checkIn}</h5>
							<h5 style="font-weight: bold;">체크아웃 : ${requestScope.checkOut}</h5>
							<h5 style="font-weight: bold; display: inline-block;">방 개수 : ${requestScope.roomCount}</h5>
							<input type="hidden" name="hotelid" value="${ requestScope.hotelinfo.hotelid }">
							<input type="hidden" name="checkin" value="${requestScope.checkIn}">
							<input type="hidden" name="checkout" value="${requestScope.checkOut}">
							<input type="hidden" name="roomcount" value="${requestScope.roomCount}">
							<input type="hidden" name="country" value="${requestScope.country}">
						</div>
						<c:forEach var="roomVo" items="${roomlist}">
							<input type="hidden" name="roomno" value="${roomVo.roomno}">
							<img style="" class="card-img-top img-fluid"
								src="${ roomVo.photo }">
							<div class="card-body">
								<h2 class="card-title">${ roomVo.roomname }</h2>
								<input type="hidden" name="roomname" value="${roomVo.roomname}">
								<h4>
									평일 :
									<fmt:formatNumber value="${roomVo.dailyprice}"
										pattern="#,###.##" />
									원
								</h4>
								<input type="hidden" name="dailyprice"
									value="${roomVo.dailyprice}">
								<h4>
									주말 :
									<fmt:formatNumber value="${roomVo.weekendprice}"
										pattern="#,###.##" />
									원
								</h4>
								<h4>남은 방: ${ roomVo.restcount } 개</h4><br>
								<h4>방 설명:</h4><br>
								<p class="card-text"> ${roomVo.roominfo } </p>
								<span class="text-warning">&#9733; &#9733; &#9733;
									&#9733; &#9734;</span> 4.0 stars
							</div>
						</c:forEach>
					</div>
					<!-- /.card -->

					<c:if test="${ requestScope.roomno != null }">
					<div class="card card-outline-secondary my-4">
						<div class="card-header">객실 개요 / 어메니티</div>
						<div class="card-body">
							<table>
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
							<table>
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
							<button class="btn btn-success" style="float: right;">예약하기</button>
						</div>
					</div>
					<!-- /.card -->
					</c:if>
				</div>
			</form>
			<!-- /.col-lg-9 -->

		</div>

	</div>
	<!-- /.container -->

	<!-- Footer -->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Your
				Website 2019</p>
		</div>
		<!-- /.container -->
	</footer>

	<!-- Bootstrap core JavaScript -->
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>

</html>
