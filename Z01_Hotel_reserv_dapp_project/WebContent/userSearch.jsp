<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<%
	request.setCharacterEncoding("UTF-8");
%>
<html>

<head>
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
<link href="css/User/t-datepicker.min.css" rel="stylesheet"
	type="text/css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha384-tsQFqpEReu7ZLhBV2VZlAu7zcOV+rXbYlF2cqB8txI/8aZajjp4Bqd+V6D5IgvKT"
	crossorigin="anonymous"></script>
<script src="js/User/t-datepicker.min.js"></script>

<link href="css/User/theme/t-datepicker-bluegrey.css" rel="stylesheet"
	type="text/css">
<script type="text/javascript" src="js/User/calendar.js"></script>

<!-- googleMap.js -->
<script src="js/User/googleMap.js"></script>
</head>

<body class="loaded">
	<nav class="navbar"></nav>
	<div class="site-all">
		<div id="header">
			<div class="row-header">
				<div class="container">
					<h1 class="slogan">Hotelnara</h1>
					<form id="search-form" method="post" action="./showroom">
						<input type="hidden" name="hotelname" value="여성프라자"> <input
							type="hidden" name="hotelid" value="Lottehotel11"> <input
							type="hidden" name="country" value="fr"> <input
							type="hidden" name="city" value="디나흐"> <input
							type="hidden" name="detailaddr" value="금천구 디지털로 1023 남성프라자">
						<input type="hidden" name="checkin" value="1560870000"> <input
							type="hidden" name="checkout" value="1560956400">

						<center>
							<div class="inputs">
								<input type="text" name="city"
									value="<%=request.getParameter("city")%>"> <select
									name="searchField" id="q" style="padding-right: 10px;">
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
						<script>
							$(function () {
								$('.t-datepicker').tDatePicker({
									$(this).attr('value', $('.t-datepicker').val())
								});
							});

						</script>
						<center>
							<div class="inputs">
								<input name="roomCount" type='number' placeholder="<%= request.getParameter("roomCount") %>" min='1'
									max='99'> <input type="submit" value="">
							</div>
						</center>
						<center>
							<ul>
								<label>Check In : <%=request.getParameter("t-start")%></label>
								<label>~ Check Out : <%=request.getParameter("t-end")%>&nbsp;&nbsp;</label>
								<label>방 갯수 : <%=request.getParameter("roomCount")%></label>
							</ul>
						</center>
						<div>
							<div class="blank_top"></div>
							<c:forEach var="hvo" items="${ requestScope.hlist }">
								<article class="hotelSearch">
									<div class="">
										<section class="imgSection">
											<div>
												<img class="hotelImg" src="${hvo.photo}">
											</div>
										</section>
										<section class="">
											<div class="hotelInfo">
												<li class="hotelName">호텔명 : ${hvo.hotelname}</li>
												<li class="hotelName">호텔주소 : ${hvo.country} ${hvo.city}
													${hVo.detailaddr}</li>
												<li class="hotelName">호텔 연락처 : ${hvo.phone }</li>
											</div>
										</section>
										<section class="hotelBtnSection">
											<center>
												<button style="height: 38px;" class="hotelBtn">방 선택</button>
											</center>
										</section>
									</div>
								</article>
								<div class="blank_mid"></div>
							</c:forEach>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script type='text/javascript' src='js/User/superfish.min.js'></script>
	<script type='text/javascript' src='js/User/jquery.sumoselect.min.js'></script>
	<script type='text/javascript' src='js/User/owl.carousel.min.js'></script>
	<script type='text/javascript' src='js/User/init.js'></script>
</body>

</html>