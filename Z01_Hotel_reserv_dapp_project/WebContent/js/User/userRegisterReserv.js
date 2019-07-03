/**
 * 
 */
function z(id){return document.getElementById(id);}
var reservContractObj; // onload 후에 설정했음.
var web3js;

window.onload = function(){
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
			totalPriceETH = Math.floor((Number(totalPriceKRW) * data2.ETH)*10000) / 10000; // 소숫점 5째자리에서 내림.
			console.log("토탈프라이스",totalPriceETH);
			z('totalPriceToEther').innerHTML = totalPriceETH;
			document.forms[0].totalprice.value = totalPriceETH;
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
		// 새 탭에서 메타마스크 다운로드 띄우기
		window.open("about:blank").location.href = 'https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn?hl=ko';
		history.back();
	}
  	reservContractObj = web3js.eth.contract(reservation_contract_ABI).at(contractAddr);
}

var isWalletLogin = false;
// 메타마스크 로그인 실시간 확인
var accountInterval = setInterval(function() {
	// 로그인 됐으면 경고문 없애기
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
	else if(totalPriceETH == 0) alert('잠시 뒤에 다시 실행해 주십시오.\n이 알림이 계속 뜬다면 새로고침을 해 주십시오.');
	else{
		// contract set
		console.log('체크인, 총가격 올리기 시작');
		var unixTimeCheckIn = new Date(checkIn).getTime()/1000 - 32400;
		console.log('체크인시간:', unixTimeCheckIn);
		console.log('총 가격', totalPriceETH);
		// 등록 트랜잭션 발생 함수
		setTransaction(unixTimeCheckIn, totalPriceETH);
		
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
	
	console.log("총가격:",totalPriceETH);
	console.log("투웨이", typeof web3.toWei(totalPriceETH, 'ether'));
	
	// 이더 전송 트랜잭션 발생 함수
	etherSendTransaction(totalPriceETH);
	
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

// 예약확인 버튼을 눌렀을 때
function reservConfirm() {
	var url = "userReservConfirm.jsp";
	var name = "confirm"
	var option = "width = 800px, height = 600px, top = 150 left = 700 location = no"
	window.open(url,confirm, option);
}


//이더리움 관련 함수들	
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
		to: contractAddr,
		value: web3.toWei(totalPrice, 'ether'),
		gas: 100000
	},function(err,res){ // callback
		if(err) console.log("여기서 에러?");
		else console.log("왠callback? ", res);
	});
}