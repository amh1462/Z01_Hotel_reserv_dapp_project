<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<%
	request.setCharacterEncoding("UTF-8");
%>
<html>

<head>
	<title>호텔나라</title>
	<meta charset="UTF-8">
	<link rel='stylesheet' href='css/User/userSearch.css' type='text/css'
		media='all' />
	<link rel="stylesheet"
		href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
	<link rel='stylesheet' href='css/User/jquery.rateyo.min.css'
		type='text/css' media='all' />
	<link rel='stylesheet' href='css/User/jquery.mmenu.all.css'
		type='text/css' media='all' />
	<link rel='stylesheet' href='css/User/bootstrap-grid.css'
		type='text/css' media='all' />
	<link rel='stylesheet' href='fonts/web-icons/web-icons.min.css'
		type='text/css' media='all' />
	
	<script type='text/javascript' src='js/User/jquery.js'></script>
	
	<!-- t-datepicker -->
	<link href="css/User/t-datepicker.min.css" rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha384-tsQFqpEReu7ZLhBV2VZlAu7zcOV+rXbYlF2cqB8txI/8aZajjp4Bqd+V6D5IgvKT"
		crossorigin="anonymous"></script>
	<script src="js/User/t-datepicker.min.js"></script>
	
	<link href="css/User/theme/t-datepicker-bluegrey.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="js/User/calendar.js"></script>

	<!-- googleMap.js -->
	<script src="js/User/googleMap.js?ver=4"></script>
	
	<link rel="stylesheet" type="text/css" href="fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<style>
html,body {
	background: url('images/content/header-bg.jpg') no-repeat center center fixed; 
	height:100%;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}
</style>
<body class="loaded">
	<div class="site-all">
		<div id="header">
			<div class="row-header">
				<div class="container">
					<a href="index.jsp" style="text-decoration:none"><h1 class="slogan">HotelNara</h1></a>
					
					<!-- form1: 검색용 -->
					<form id="search-form" method="post" action="./userSearch" onkeydown="return notUseEnterKey(event);">
			          <script>
						  function notUseEnterKey(e){
						      if(e.keyCode === 13 && e.srcElement.type != 'textarea') e.preventDefault();
						  }
					  </script>
						<!-- <input type="hidden" name="hotelname" value="여성프라자"> <input
							type="hidden" name="hotelid" value="Lottehotel11"> <input
							type="hidden" name="country" value="fr"> <input
							type="hidden" name="city" value="디나흐"> <input
							type="hidden" name="detailaddr" value="금천구 디지털로 1023 남성프라자">
						<input type="hidden" name="checkin" value="1560870000"> <input
							type="hidden" name="checkout" value="1560956400"> -->

						<center>
							<div class="inputs">
								<input type="text" name="city" value="<%=request.getParameter("city")%>" style="color:black"> 
								<select name="country" id="q" style="padding-right: 10px; color: black">
									<option value="kr">Korea</option>
									<option value="us">USA</option>
									<option value="cn">China</option>
									<option value="jp">Japan</option>
									<option value="uk">England</option>
									<option value="fr">France</option>

								</select>
							</div>
						</center>
						<!-- t-datepicker --> 
						<div class="t-datepicker">
							<div class="t-check-in" name="checkIn"></div>
							<div class="t-check-out" name="checkOut"></div>
						</div>
						<script type="text/javascript">
							$(document).ready(function () {
								// t-datepicker 오픈 소스 설명 참고
								$('.t-datepicker').tDatePicker('updateCI', '<%=request.getParameter("t-start")%>');
								$('.t-datepicker').tDatePicker('updateCO', '<%=request.getParameter("t-end")%>');
							});
						</script>
						<center>
							<div class="inputs">
								<input name="roomCount" type="text" value="<%= request.getParameter("roomCount") %>" style="color:black"> <input type="submit" value="">
							</div>
						</center>
					</form>
					
					<!-- form2: 다음페이지로 이동할 때 데이터 전송용 -->
					<form id="forward-form" action="./showRoom">
						<div>
							<div class="blank_top"></div>
							<c:forEach var="hvo" items="${ requestScope.hlist }">
								<article class="hotelSearch" style="background-color:white">
									<div class="">
										<section class="imgSection">
											<div>
												<img class="hotelImg" src="${hvo.photo}">
											</div>
										</section>
										<section class="">
											<div class="hotelInfo">
												<li class="hotelName">호텔명 : ${hvo.hotelname}</li>
												<li class="hotelAddr">호텔주소 : ${hvo.country} ${hvo.city}
													${hvo.detailaddr}</li>
												<li class="hotelPhone">호텔 연락처 : ${hvo.phone }</li>
											</div>
										</section>
										<section class="hotelBtnSection">
											<center>
												<a style="height: 38px;" class="hotelBtn" href="showRoom?hotelId=${ hvo.hotelid }
												&checkIn=<%=request.getParameter("t-start")%>&checkOut=<%=request.getParameter("t-end")%>
												&roomCount=<%=request.getParameter("roomCount")%>">방 선택</a>
											</center>
										</section>
									</div>
								</article>
								<div class="blank_mid"></div>
							</c:forEach>
							
							<%-- <ul class="pagination justify-content-center">
								<li class="page-item <c:if test='${ startList == 1 }'>disabled</c:if>">
									<a href="userSearch?pIndex=${ startList+1 }">
										<span class="lnr lnr-arrow-left"></span>
									</a>
								</li>
								<c:forEach var="pIdx" begin="${ startList }" end="${ endList }">
									<li class="page-item <c:if test='${ param.pIndex == pIdx }'>active</c:if>">
										<a href="userSearch?pIndex=${ pIdx }">
											${ pIdx }
										</a>
									</li>
								</c:forEach>
								<li class="page-item <c:if test='${ (endList - lastPageNum) / 10 == 0 }'>disabled</c:if>">
									<a href="userSearch?pIndex=${ endList+1 }">
										<span class="lnr lnr-arrow-right"></span>
									</a>
								</li>
							</ul> --%>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- google map api -->
	<script src="https://maps.googleapis.com/maps/api/js?
	key=AIzaSyAxyGBL5WEFEwsRjIDYuXLPpXeiUXY5zj0&libraries=places&callback=activatePlacesSearch"></script>

	<script type='text/javascript' src='js/User/superfish.min.js'></script>
	<script type='text/javascript' src='js/User/jquery.sumoselect.min.js'></script>
	<script type='text/javascript' src='js/User/owl.carousel.min.js'></script>
	<script type='text/javascript' src='js/User/init.js'></script>
</body>

</html>