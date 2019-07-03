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
	<link rel="stylesheet" type="text/css" href="css/main.css?ver=2">
	
	<!-- jquery ì¬ì© -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
	<c:if test="${ empty hotelid }"> <!-- id라는 name값이 비어있으면 실행한다..(즉, 로그인 처리가 안 됐으면 올 수 없게..) -->
		<script>
			alert("로그인이 필요합니다.");
			location.href = './logout' // session이 없으면 알아서 로그아웃 처리..
		</script>
	</c:if>
	<div class="limiter">
		<div class="container-login102">
			<div style="margin-top: 0px;" class="wrap-login100">
				<form class="login100-form validate-form" action="modify" method="post" onkeydown="return notUseEnterKey(event);"
					onsubmit ="document.forms[0].city.disabled = false; return chkValid2()" enctype="multipart/form-data">
					<script>
						function notUseEnterKey(e){
							if(e.keyCode === 13 && e.srcElement.type != 'textarea') e.preventDefault();
						}
					</script>
					<input type="hidden" name="hiddenValue" value="hotel">
					<span class="login100-form-title p-b-40">
						회원 정보수정
					</span>
					
					비밀번호
					<div class="wrap-input100 m-b-16" data-validate = "비밀번호를 수정해주시기 바랍니다.">
						<input class="input100" type="password" name="password" oninput="chkMatchPw()" >
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<span class="lnr lnr-lock"></span>
						</span>
					</div>

					비밀번호 확인
					<div class="wrap-input100 m-b-16" data-validate = "비밀번호가 일치하지 않습니다..">
						<input class="input100" type="password" name="pw2" oninput="chkMatchPw()">
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<span class="lnr lnr-lock"></span>
						</span>
					</div>
					<div class="wrap-input100 m-b-16 m-l-50" id='matchPw' style="color: red; text-align: center;" ></div>

					
					<div class="wrap-input100">호텔명</div>
					<div class="wrap-input100 m-b-16">
						<input class="input100" name="hotelname" value="${ hotelname }" >
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<span class="lnr lnr-apartment"></span>
						</span>
					</div>
					
					<div class="wrap-input100 m-b-16">
						나라
						<select name="country" class="input100">
							<option value="">선택</option>
							<option value="kr">대한민국</option>
							<option value="us">미국</option>
							<option value="fr">프랑스</option>
							<option value="cn">중국</option>
						</select>
						<script>
							var sel = document.forms[0].country;
							for(i=0; i<sel.options.length; i++){
								// 선택했던 나라로 select되어있게
								if(sel.options[i].value == '${ country }'){
									sel.options[i].selected = true;
								}
							}
						</script>
					</div>
					
					도시
					<div class="wrap-input100 validate-input m-b-16" data-validate = "도시를 입력해주세요.">
						<input class="input100" name="city" value="${ city }">
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<span style="position: absolute;" class="lnr lnr-map"></span>
						</span>
					</div>
					<div id="selectCity" class="wrap-input100 m-b-16 m-l-50" style="color: red; text-align: center;"></div>
					
					상세주소
					<div class="wrap-input100 validate-input m-b-16" data-validate = "상세주소를 입력해주세요.">
						<input class="input100" name="detailaddr" value="${ detailaddr }" >
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<span class="lnr lnr-map-marker"></span>
						</span>
					</div>
					
					연락처
					<div class="wrap-input100 validate-input m-b-16" data-validate = "연락처를 입력해주세요.">
						<input class="input100" name="phone" value="${ phone }" >
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<span class="lnr lnr-phone-handset"></span>
						</span>
					</div>
					
					이더지갑 주소
					<div class="wrap-input100 m-b-16">
						<input class="input100" name="hwallet" placeholder="앞에 0x를 써줘야합니다." value="${ hwallet }">
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<span class="lnr lnr-database"></span>
						</span>
					</div>
					
					<div class="contact100-form-checkbox m-l-4 m-b-16">
						<input class="input-checkbox100" id="chkBox" type="checkbox" onclick="getAccount(this.checked)">
						<label class="label-checkbox100" for="chkBox">
							메타마스크에서 가져오기
						</label>
					</div>
					
					<div class="wrap-input100">취소 수수료</div>
					
					<div style="border: 3px solid beige" class="wrap-input100">
						<div class="wrap-input100 m-b-16 m-t-10" style="height:52px;">
							<span class="m-l-10" style="float: left; line-height: 52px;">당일 취소시:</span> 
							<span class="m-r-10" style="float: right; line-height: 52px">%</span>
							<input class="input30-float-r" name="cancelfee1" value="${ cancelfee1 }">
						</div>
						
						<div class="wrap-input100 m-b-16" style="height:52px;">
							<span class="m-l-10" style="float: left; line-height: 52px;">1 일전 취소시:</span> 
							<span class="m-r-10" style="float: right; line-height: 52px">%</span>
							<input class="input30-float-r" name="cancelfee2" value="${ cancelfee2 }">
						</div>
						
						<div class="wrap-input100 m-b-16" style="height:52px;">
							<input class="input30-float-l m-l-10" name="cancelday1" value="${ cancelday1 }">
							<span style="float: left; line-height: 52px;">일전 취소:</span> 
							<span class="m-r-10" style="float: right; line-height: 52px">%</span>
							<input class="input30-float-r" name="cancelfee3" value="${ cancelfee3 }">
						</div>
						
						<div class="wrap-input100 m-b-16" style="height:52px;">
							<input class="input30-float-l m-l-10" name="cancelday2" value="${ cancelday2 }">
							<span style="float: left; line-height: 52px;">일전 취소:</span> 
							<span class="m-r-10" style="float: right; line-height: 52px">%</span>	
							<input class="input30-float-r" name="cancelfee4" value="${ cancelfee4 }">
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
	
	

	
	
	
	<!-- web3 import -->
	<script src="https://github.com/ethereum/web3.js/blob/master/dist/web3.min.js"></script>
	
	<!-- js ì²ë¦¬ íì¼ -->
	<script src="js/Hotel/join.js"></script>
	
	<!-- google places api import -->
	<script src="https://maps.googleapis.com/maps/api/js?
	key=AIzaSyAxyGBL5WEFEwsRjIDYuXLPpXeiUXY5zj0&libraries=places&callback=activatePlacesSearch"></script>
	
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="js/Hotel/main.js"></script>

</body>
</html>