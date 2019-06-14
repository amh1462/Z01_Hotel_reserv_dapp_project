<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<title>객실 현황</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
</head>

<style>
.logoutBtn:active {
	position:relative;
	top:1px;
}

.btn_hgray {
	background-color: #fff;
	border: 1px solid #000;
	border-radius: 2px;
	font-size: 14px;
	display: inline-block;
	cursor: pointer;
	color: #555;
	padding: 0px 16px;
}

.btn_hgray:hover {
	background: lightgray;
	color: #333;
}

</style>

<body>
	<div class="limiter">
		<div class="container-login101">
			<div style="position:absolute; top: 10px;" class="wrap-main100">
				<span class="login100-form-title p-b-30">객실 현황</span>
				<div style='text-align: right;'>
					<form>
						<select name='searchField'>
							<option value='title'>방 종류</option>
							<option value='content'>요  금</option>
							<option value='writer'>방 개수</option>
						</select> 
						<input name='searchKeyword'>
						<input type='submit' value='검색' style='width: 70px;'>
					</form>
				</div><br>
				<table>
					<tr>
						<th>방 종류</th>
						<th>요 금</th>
						<th>등록날짜</th>
						<th>방 개수</th>
						<th>수 정</th>
					</tr>
				</table>
				<div style="height: 10px;"></div>
				<ul class="pagination justify-content-center">
					<li class="page-item <c:if test='${startList == 1}'>disabled</c:if>">
						<a class="page-link" href="board?pIndex=${ startList-1 }"> <span
							class="lnr lnr-arrow-left"></span>
					</a>
					</li>
					<li
						class="page-item <c:if test='${endList % 10 != 0}'> disabled</c:if>">
						<a class="page-link" href="board?pIndex=${ endList+1 }"> <span
							class="lnr lnr-arrow-right"></span>
					</a>
					</li>
				</ul>
				<a href='registerRoom' class='btn_hgray' style='float: left'>객실 등록</a>
			</div>
		</div>
	</div>
	

	
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>

</body>
</html>