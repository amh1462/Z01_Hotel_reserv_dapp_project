<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호텔나라</title>
<link rel="stylesheet" type="text/css" href="css/main.css?ver=4">
</head>

<script>
	function navigator1() {
		location.href="./userSearch.html"
	}
	function navigator2() {
		location.href="./hotelLogin.html"
	}
</script>

<body>
	<div class="bg-img">
		<div>
			<div style="height: 250px;">
				<div style=" font-family: ansangsu-bold; font-size: 150px; color: white; "> HotelNara </div>
				<div style=" font-size: 20px; color: white; ">호텔나라에 오신 것을 환영합니다!</div>
				<div style=" font-size: 20px; color: white; ">예약을 원하시면 게스트 창을, 방 등록을 원하시면 호텔 창을 이용해주세요!</div>
			</div>
			<div class="wrap-moveMain" onclick="navigator1()">
				<div class="wrap-moveMain-page">
					<img src="css/Luggage_Cartoon.png" height="180" width="180">
					<h1 class=".moveMain-page">게 스 트</h1>
					<ul>
						<li>호텔 검색</li>
						<li>방 예약</li>
						<li>예약 확인</li>
					</ul>
				</div>
			</div>
			<div style="display: inline-block; width: 200px;" ></div>
			<div class="wrap-moveMain" onclick="navigator2()">
				<div class="wrap-moveMain-page">
					<img src="css/hotel_cartoon.png" height="180" width="180">
					<h1 class=".moveMain-page">호 텔</h1>
					<ul>
						<li>호텔 등록</li>
						<li>방 등록</li>
						<li>요금 징수</li>
					</ul>
				</div> 
			</div>
		</div>	
	</div>
</body>
</html>