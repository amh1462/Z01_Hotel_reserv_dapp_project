<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
  <title>호텔나라</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  
</head>
<script>
	var totalPriceETH = 0.0;
	var totalPriceKRW = ${ requestScope.totalprice };
	var contractAddr = '${ requestScope.roominfo.contract }';
	var checkIn = '${ requestScope.checkin }'; 
</script>
<body>

  <!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark static-top">
    <div class="container">
      <a class="navbar-brand" style="color: white;" >예약 창</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
     <div class="collapse navbar-collapse" id="navbarResponsive">
		<ul class="navbar-nav ml-auto">
			<li class="nav-item active"><a class="nav-link"
				href="userSearch.html">Home <span class="sr-only">(current)</span>
			</a></li>
			<li class="nav-item"><a class="nav-link" style="cursor:pointer"
				onclick="reservConfirm()">예약확인</a></li>
		</ul>
	</div>
   </div>
  </nav>

  <!-- Page Content -->
  <div style="padding-top: 100px; padding-left: 15%;" class="container">
    <form method="post" action="./registerReserv">
    
    <input type="hidden" name="hotelid" value="${ requestScope.hotelinfo.hotelid }">
    <input type="hidden" name="roomno" value="${ requestScope.roominfo.roomno }">
    <input type="hidden" name="totalprice">
    <input type="hidden" name="roomcount" value="${ requestScope.roomcount }">
    <input type="hidden" name="checkin" value="${ requestScope.checkin }">
    <input type="hidden" name="checkout" value="${ requestScope.checkout }">
    <input type="hidden" name="contract" value="${ requestScope.roominfo.contract }">
    
    <div class="row">
    	<h1 class="my-4">Reservation</h1>
      <div class="col-lg-12">
        <div style="max-width: 70%" class="card mb-4">
          <div class="card-img-top" style="height: auto;" >
          	<label style="padding-left: 60px; padding-top: 30px;">예약자 명 : </label> <input style="width: 50%;" type="text" name="guestname" required>
          	<br>
          	<label style="padding-left: 60px; padding-top: 15px;" >휴 대 폰 : </label> <input style="margin-left:12px; width: 50%;" type="text" name="phone" required>
          	<br>
          	<label style="padding-left: 60px; padding-top: 15px;">이 메 일 : </label> <input style="margin-left:12px; width: 50%;" type="text" name="email" required>
          	<br>
          	<label style="padding-left: 60px; padding-top: 30px;">지갑 주소 : </label> <input style="width: 70%;" type="text" name="uwallet" readonly>
          	<div id='walletLogin' style="padding-left: 145px; color: red; height: 40px;" >메타마스크에 결제할 계좌 주소로 로그인 해주십시오.</div>
          </div>
          <hr style="margin: 10px;">
          <div style="padding: 10px;" class="card-body">
            <h2 style="font-weight: 1000;" class="card-title">예약 정보</h2><br>
            <p style="display: inline-block;" class="card-text">호텔 명 : </p><label style="padding-left: 10px;">${ requestScope.hotelinfo.hotelname }</label>
            <br>
            <p style="display: inline-block;" class="card-text">호텔 주소 : </p><label style="padding-left: 10px;">${ requestScope.country } ${ requestScope.hotelinfo.city } ${ requestScope.hotelinfo.detailaddr }</label>
            <br>
            <p style="display: inline-block;" class="card-text">방 종류 : </p><label style="padding-left: 10px;">${ requestScope.roominfo.roomname }</label>
            <br><br>
            <p style="display: inline-block;" class="card-text">호텔 체크인 : </p><label style="padding-left: 10px;">${ requestScope.checkin }</label>
            <br>
            <p style="display: inline-block;" class="card-text">호텔 체크아웃 : </p><label style="padding-left: 10px;">${ requestScope.checkout }</label>
            <br>
            <p style="display: inline-block;" class="card-text">방 개수 : </p><label style="padding-left: 10px;">${ requestScope.roomcount } 개</label>
            <br>
            <label>총 : ${ requestScope.stayNight }박(1박당 <fmt:formatNumber value="${ requestScope.roominfo.dailyprice}" pattern="#,###.##"/>)</label>
            <label style="padding-left: 100px">전체 요금 : </label>
            <label style="padding-left: 10px;"><fmt:formatNumber value="${requestScope.totalprice}" pattern="#,###.##"/>원</label>
            <hr>
            <span style="font-size: 10px">예약하기 전에 먼저 컨트랙트에 등록이 필요합니다.</span>
            <button style="float:right; margin-right: 20px;" id="registerBtn" class="btn btn-primary" type="button" onclick="setCheckInPrice();">등록하기 &rarr;</button>
            <!--<button style="float:right; margin-right: 20px; display: none;" id="regCancelBtn" class="btn btn-primary" type="button" onclick="deleteCheckInPrice();">등록해제 &rarr;</button>-->
            <br><br><hr><br>
            <h4 style="display: inline-block; font-weight:bold" class="card-text">취소 수수료 정책</h4>
            <hr>
            <p>당일 취소시: ${ requestScope.hotelinfo.cancelfee1 } % 의 금액 ( <fmt:formatNumber value="${ requestScope.cancelPriceTheDay }" pattern="#,###.##"/> 원 ) </p>
            <p>1일전 취소시:  ${ requestScope.hotelinfo.cancelfee2 } % 의 금액 ( <fmt:formatNumber value="${ requestScope.cancelPriceOneDay }" pattern="#,###.##"/> 원 ) </p>
            <p>${ requestScope.hotelinfo.cancelday1 }일전 취소시:  ${ requestScope.hotelinfo.cancelfee3 } % 의 금액 ( <fmt:formatNumber value="${ requestScope.cancelPriceSetDay1 }" pattern="#,###.##"/> 원 ) </p>
            <p>${ requestScope.hotelinfo.cancelday2 }일전 취소시:  ${ requestScope.hotelinfo.cancelfee4 } % 의 금액 ( <fmt:formatNumber value="${ requestScope.cancelPriceSetDay2 }" pattern="#,###.##"/> 원 ) </p>
            <hr>
            <input id="cancelFeeCheck" type="checkbox">
            <label for="cancelFeeCheck">
            	취소 수수료 정책을 읽어보았고 정책에 따를 것을 동의하십니까?
            </label>
            <br><br><br>
            <h4 style="display: inline-block; font-weight:bold" class="card-text">이더 가격 확인</h4>
            <hr>
            <p> 
            	현재 1 ETH당 <span id="oneEtherToKRW"></span>원 이므로<br>
            	총 가격(<fmt:formatNumber value="${ requestScope.totalprice }" pattern="#,###.##"/> 원) 에 해당하는 이더는 <span id="totalPriceToEther"></span> ETH 입니다.
            </p>
            <hr>
            <input id="etherCheck" type="checkbox">
            <label for="etherCheck">
            	방 가격(원화)에 대한 이더 가격을 확인하셨습니까?
            </label>
            <hr>
            <button style="float:right;" id="reservBtn" class="btn btn-secondary" type="button" onclick="chkValid();">예약하기 &rarr;</button> 
            <div id='registerFirst' style="padding-right: 10px; float: right; color: red; height: 40px;" >컨트랙트 등록을 먼저 해야합니다.</div>
          </div>
        </div>
      </div>
    </div>
    </form>
  </div>
  
  
  <!-- jquery 사용 -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  
  <script src="js/reservation_contract_abi3.js"></script>
  <script src="js/reservation_contract_bytecode.js"></script>
  
  <!-- js 처리 파일 -->
  <script src="js/User/userRegisterReserv.js"></script>
  
</body>

</html>
