<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>호텔나라</title>
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
	.filebox {display:inline-block; margin-right: 10px;}
	
	.filebox label {
	display: inline-block;
	padding: .5em .75em;
	color: #999;
	font-size: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #fdfdfd;
	cursor: pointer;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
	}
	
	.filebox input[type="file"] { 
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip:rect(0,0,0,0);
	border: 0;
	}
	
	.filebox.bs3-primary label {
	  color: #fff;
	  background-color: #337ab7;
	  border-color: #2e6da4;
	}
	
	.filebox.bs3-success label {
	  color: #fff;
	  background-color: #5cb85c;
	  border-color: #4cae4c;
	}
	
</style>

<body>
	<div class="limiter">
		<div class="container-login102">
			<div style="position: absolute; margin-top: -90px;" class="wrap-login100">
				<form class="login100-form validate-form" action="modify" method="post"
					onsubmit ="return chkValidate2()" enctype="multipart/form-data" >
					<span class="login100-form-title p-b-30">
						회원 정보수정 
					</span>
					<input type="hidden" name="hiddenvalue" value=1>	
					
					<div style="display: none;" class="wrap-input100 m-b-16" data-validate = "아이디가 없습니다.">
						<input class="input100" type="text" name="hotelid" value="${hVo.hotelid}" disabled placeholder="아이디">
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<span class="lnr lnr-user"></span>
						</span>
					</div>
					
					<div class="wrap-input100 m-b-16" data-validate = "비밀번호를 수정해주시기 바랍니다.">
						<input class="input100" type="password" name="password" placeholder="비밀번호" oninput="chkMatchPw2()" >
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<span class="lnr lnr-lock"></span>
						</span>
					</div>

					<div class="wrap-input100 m-b-16" data-validate = "비밀번호가 일치하지 않습니다..">
						<input class="input100" type="password" name="pw2" placeholder="비밀번호 확인" oninput="chkMatchPw2()">
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<span class="lnr lnr-lock"></span>
						</span>
						<div id='matchPw' style="color: red; text-align: center;" ></div>
					</div>
					
					
					
					<div class="wrap-input100 m-b-16">
						<input class="input100" name="hotelname" placeholder="호텔 명" value="${ hVo.hotelname }" >
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<span class="lnr lnr-apartment"></span>
						</span>
					</div>
					
					<div class="wrap-input100 m-b-16">
					<select name="country" class="input100">
						<option value="" selected>선택</option>
						<option value="kr">대한민국</option>
						<option value="us">미국</option>
						<option value="fr">프랑스</option>
						<option value="cn">중국</option>
					</select>
					</div>
					
					<div class="wrap-input100 validate-input m-b-16" data-validate = "도시를 입력해주세요.">
						<input class="input100" name="city" placeholder="도시" value="${ hVo.city }" disabled>
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<span style="position: absolute;" class="lnr lnr-map"></span>
						</span>
						<div id='selectCity' style="color: red; text-align: center;"></div>
					</div>
					
					<div class="wrap-input100 validate-input m-b-16" data-validate = "상세주소를 입력해주세요.">
						<input class="input100" name="detailaddr" placeholder="상세주소" value="${ hVo.detailaddr }" >
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<span class="lnr lnr-map-marker"></span>
						</span>
					</div>
					
					<div class="wrap-input100 validate-input m-b-16" data-validate = "연락처를 입력해주세요.">
						<input class="input100" name="phone" placeholder="연락처" value="${ hVo.phone }" >
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<span class="lnr lnr-phone-handset"></span>
						</span>
					</div>
					
					<div class="wrap-input100 m-b-16">
						<input class="input100" name="hwallet" placeholder="지갑주소 예) 앞에 0x를 써줘야합니다." value="${ hVo.hwallet }">
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<span class="lnr lnr-database"></span>
						</span>
					</div>
					
					<div class="contact100-form-checkbox m-l-4">
						<input class="input-checkbox100" id="chkBox" type="checkbox" onclick="getAccount(this.checked)">
						<label class="label-checkbox100" for="chkBox">
							메타마스크에서 가져오기
						</label>
					</div>
					
					<div style="margin-top:5px;"  class="wrap-input100">
						 
						<div style="margin-left:13px;" class="filebox bs3-primary" >
							<label for="photo">업로드</label> 
                          <input style="visibility:hidden;" type="file" id="photo"> 
						</div>
						
						<!-- <input type="file" name="photo"> -->
						
						<div class="filebox bs3-primary" >
							<label for="photo2">업로드</label> 
                          <input style="display:none;" type="file" id="photo2"> 
						</div>
						
						<div class="filebox bs3-primary" >
							<label for="photo3">업로드</label> 
                          <input style="display:none;" type="file" id="photo3"> 
						</div>
						
						<div class="filebox bs3-primary" >
							<label for="photo4">업로드</label> 
                          <input style="display:none;" type="file" id="photo4"> 
						</div>
						
						<div class="filebox bs3-primary" >
							<label for="photo5">업로드</label> 
                          <input style="display:none;" type="file" id="photo5"> 
						</div>
						
					</div>
					
					<div class="container-login100-form-btn p-t-25">
						<button class="login100-form-btn">
							회원정보수정
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	

	
	<!-- jquery ì¬ì© -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	
	<!-- web3 import -->
	<script src="https://github.com/ethereum/web3.js/blob/master/dist/web3.min.js"></script>
	
	<!-- js ì²ë¦¬ íì¼ -->
	<script src="js/join.js"></script>
	
	<!-- google places api import -->
	<script src="https://maps.googleapis.com/maps/api/js?
	key=AIzaSyAxyGBL5WEFEwsRjIDYuXLPpXeiUXY5zj0&libraries=places&callback=activatePlacesSearch"></script>
	
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>

</body>
</html>