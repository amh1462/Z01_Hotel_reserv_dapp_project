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
	function z(id){return document.getElementById(id);}
	var totalPrice = 0.0;
	var reservContractObj; // onload 후에 설정했음.
	var web3js;
	
  	onload = function(){
  		//이더->원화 변환
	  	$.ajax({
	  		url:'https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=KRW',
			success:function(data, statusTxt, xhr){
				console.log('/',data,'/');
				z('oneEtherToKRW').style.color = 'blue';
				z('oneEtherToKRW').innerHTML = data.KRW;
			},
			error: function(xhr,statusTxt,c){ console.log("통신에 실패했습니다."); }
	  	});
  		
  		//원화->이더 변환
	  	$.ajax({
	  		url:'https://min-api.cryptocompare.com/data/price?fsym=KRW&tsyms=ETH',
			success:function(data2, statusTxt, xhr){
				console.log('/',data2,'/');
				z('totalPriceToEther').style.color = 'blue';
				totalPrice = Math.floor((Number(${ requestScope.totalprice }) * data2.ETH)*10000) / 10000; // 소숫점 5째자리에서 반올림.
				console.log("토탈프라이스",totalPrice);
				z('totalPriceToEther').innerHTML = totalPrice;
				document.forms[0].totalprice.value = totalPrice;
			},
			error: function(xhr,statusTxt,c){ console.log("통신에 실패했습니다."); }
	  	});
	  	
  		//WEB3 설정
	  	if(typeof web3 !== 'undefined'){ // !==는 타입까지 체크
			console.log('web3 인식 성공');
			web3js = new Web3(web3.currentProvider);
		}
		else{
			console.log('web3인식 X');
			alert('컨트랙트 등록 및 이더 전송을 위해 메타마스크를 설치해주시고 로그인 해주십시오. \n만약 브라우저가 Chrome이 아니라면 실행할 수 없습니다.');
			window.open("about:blank").location.href = 'https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn?hl=ko';
			history.back();
		}
	  	reservContractObj = web3js.eth.contract(reservation_contract_ABI).at('${ requestScope.roominfo.contract }');
	  	console.log("예약컨트랙트 객체:", reservContractObj);
  	}
  	
  	var isWalletLogin = false;
  	// 메타마스크 로그인 실시간 확인
  	var accountInterval = setInterval(function() {
  		if(web3js.eth.accounts[0] == null){
  			document.forms[0].uwallet.value = '';
  			z('walletLogin').style.display = 'block';
  			isWalletLogin = false;
  		}
  		else {
			document.forms[0].uwallet.value = web3js.eth.accounts[0];
			z('walletLogin').style.display = 'none';
			isWalletLogin = true;
		}
	}, 100); // 0.1초마다 실행.
	
 	// 유효성 검사
  	function chkValid(){
		if(document.forms[0].guestname.value=='' || document.forms[0].phone.value=='' || document.forms[0].email.value==''){
			alert('예약자명, 연락처, 이메일을 작성해주세요.');
			event.preventDefault();
		}
		else if(!isWalletLogin){
			alert('메타마스크 이더지갑에 먼저 로그인해주세요.\n만약 등록 후 지갑을 바꿨다면 다시 등록해야합니다.');
			event.preventDefault();
		}
		else if(!z('cancelFeeCheck').checked){
			alert('취소수수료 정책에 동의여부에 체크해주세요.');
			event.preventDefault();
		}
		else if(!z('etherCheck').checked){
			alert('이더가격을 확인여부에 체크해주세요.');
			event.preventDefault();
		} else{
			sendEther();
		}
	}
 
	//체크인, 총가격 컨트랙트에 등록
	function setCheckInPrice(){
		if(!isWalletLogin){
			alert('먼저 메타마스크에 로그인해주세요.\n결제가 가능한 이더지갑이어야 합니다.');
		} 
		else if(totalPrice == 0) alert('잠시 뒤에 다시 실행해 주십시오.\n이 알림이 계속 뜬다면 새로고침을 해 주십시오.');
		else{
			// contract set
			console.log('체크인, 총가격 올리기 시작');
			var unixTimeCheckIn = new Date('${ requestScope.checkin }').getTime()/1000 - 32400;
			console.log('체크인시간:', unixTimeCheckIn);
			console.log('총 가격', totalPrice);
			// 등록 트랜잭션 발생 함수
			setTransaction(unixTimeCheckIn, totalPrice);
			
		}
	}
	
  	// 총 가격만큼의 이더 전송
  	function sendEther(){
  		// send Ether to Contract
  		alert('예약을 시작합니다.');
  		reservContractObj.getCheckIn_roomPrice_myPayment.call(function(err,res){
			if(err) console.error('체크인,총요금,내 지불금 가져오기 에러',err);
			else {
				console.log('체크인,총요금:',res[0]+','+res[1]+','+res[2]+','+res[3]);
				var checkInDate = new Date(res[0]*1000);
				var nowDate = new Date(res[1]*1000);
				console.log('체크인날짜: '+ checkInDate.getFullYear()+'년 '+(checkInDate.getMonth()+1)+'월 '+checkInDate.getDate() + '일 '
				+'현재시간: '+ nowDate.getFullYear()+'년 '+(nowDate.getMonth()+1)+'월 '+nowDate.getDate() + '일 '
				+'총요금: '+web3.fromWei(res[2],'ether')
				+'내 지불금: '+web3.fromWei(res[3],'ether'));
			}
		})
  		
  		console.log("총가격:",totalPrice);
  		console.log("투웨이", typeof web3.toWei(totalPrice, 'ether'));
  		
  		// 이더 전송 트랜잭션 발생 함수
  		etherSendTransaction(totalPrice);
  		
  		var paymentCompleteEvent = reservContractObj.PaymentCompleteEvent();
  		// 이벤트 발생시 submit까지
  		paymentCompleteEvent.watch(function(err,res){
			if(err) console.log("지불완료이벤트에러",err);
			else { // 전송 진짜 완료
				console.log("이벤트에서 받아온값: ", res.args.account + "," + res.args.amount + "," + res.args.isContractHasEther);
				document.forms[0].submit();
			}
		})
  	}
  	
  	function popup() {
		var url = "bookConfirm.jsp";
		var name = "confirm"
		var option = "width = 680px, height = 500px, top = 150 left = 700 location = no"
		window.open(url,confirm, option);
	}
  	
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
				href="userIndex.html">Home <span class="sr-only">(current)</span>
			</a></li>
			<li class="nav-item"><a class="nav-link" style="cursor:pointer"
				onclick="popup()">예약확인</a></li>
		</ul>
	</div>
   </div>
  </nav>

  <!-- Page Content -->
  <div style="padding-top: 100px; padding-left: 15%;" class="container">
    <form method="post" action="./registerbook">
    
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
  
  <script>
  
  	// 이더리움 관련 함수들
  	
  	// 체크인, 총가격 등록 트랜잭션
  	function setTransaction(unixTimeCheckIn, totalPrice){
		reservContractObj.setCheckIn_roomPrice.sendTransaction(unixTimeCheckIn, web3.toWei(totalPrice,'ether'), function(err,res){
			if(err) console.error("체크인, 총 가격 올리기 에러",err);
			else{
				console.log("sendTransaction 결과(txid?):",res);
				
				// txid를 interval하여.. 블록체인에 들어가면 성공처리
				var txChkInterval = setInterval(function(){
					// 0.1초마다 tx정보를 얻자!
					web3.eth.getTransactionReceipt(res, function(err2,res2){ // 위에 일어난 tx의 해시값을 받아 처리.
						if(err2) {console.error("트랜잭션 정보 얻기 실패",err2); clearInterval(txChkInterval);}
						if(res2 != null){
							console.log("트랜잭션결과:",res2.status);
							if (res2.status == '0x0'){
								// tx 실패면..
								console.log("트랜잭션 실패(txid):", res2);
							}
							else if( res2 != null && res2.status == '0x1'){
								// tx 성공이면..
								console.log("트랜잭션 성공(txid):", res2);
								// 성공 시 등록 완료, 예약하기 버튼 활성화 및 red div display:none
								z('reservBtn').classList.remove('btn-secondary');
								z('reservBtn').classList.add('btn-primary');
								z('reservBtn').disabled = false;
								z('registerFirst').style.display = 'none';
								
								z('registerBtn').classList.remove('btn-primary');
								z('registerBtn').classList.add('btn-secondary');
								z('registerBtn').disabled = true;
							}
							clearInterval(txChkInterval);
						}
					})
				}, 100); // setInterval
			} // if(err) else
		}) // sendTransaction
	}
  	
  	// 총 가격만큼 이더 전송
  	function etherSendTransaction(totalPrice){
		web3.eth.sendTransaction({
			from: web3js.eth.accounts[0],
			to: '${ requestScope.roominfo.contract }',
			value: web3.toWei(totalPrice, 'ether'),
			gas: 100000
		},function(err,res){ // callback
			if(err) console.log("여기서 에러?");
			else console.log("왠callback? ", res);
		});
	}
  </script>
  
  
  <!-- jquery 사용 -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  
  <script src="js/reservation_contract_abi3.js"></script>
  <script src="js/reservation_contract_bytecode.js"></script>
  
</body>

</html>
