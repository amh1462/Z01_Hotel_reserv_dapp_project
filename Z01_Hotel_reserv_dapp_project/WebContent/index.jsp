<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OO호텔에 오신 것을 환영합니다.</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>

<script>
	function navigator1() {
		location.href="./userIndex.html"
	}
	function navigator2() {
		location.href="./login.html"
	}
</script>

<body>
	<div class="bg-img">
		<div>
			<div style="height: 250px;">
				<h1 style=" font-family: ansangsu-bold; font-size: 150px; color: white; "> Hotel Nara </h1>
			</div>
			<div class="wrap-moveMain" onclick="navigator1()">
				<div class="wrap-moveMain-page">
					<img src="css/users.png">
					<h1 class=".moveMain-page">사  용  자</h1>
				</div>
			</div>
			<div style="display: inline-block; width: 200px;" ></div>
			<div class="wrap-moveMain" onclick="navigator2()">
				<div class="wrap-moveMain-page">
					<img src="css/hotel.png">
					<h1 class=".moveMain-page">호			텔</h1>
				</div> 
			</div>
		</div>	
	</div>
</body>
</html>