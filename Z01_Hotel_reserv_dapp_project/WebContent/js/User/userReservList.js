/**
 * 
 */

var web3js;
var tr, contract, uwallet, resno, hotelid;
var reservContractObj;

// 예약확인 버튼을 눌렀을 때
function reservConfirm() {
	opener.document.location.href="userSearch.html";
	self.close();
}
function userCancelBtnClick(obj){
	// 먼저 메타마스크 설치 여부 확인
	if(typeof web3 !== 'undefined'){
		console.log('web3 인식 성공');
		web3js = new Web3(web3.currentProvider);
	} else { 
		console.log('web3 인식 실패');
		alert('예약 취소를 위해 메타마스크를 설치해주세요.\n브라우저가 Google Chrome이 아니면 실행할 수 없습니다.');
		window.open('about:blank').location.href = 'https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn?hl=ko';
	}
	
	var userCancelBtn = obj;
	tr = userCancelBtn.parentElement.parentElement;
	contract = tr.children[0].innerHTML;
	uwallet = tr.children[1].innerHTML;
	resno = tr.children[2].innerHTML;
	hotelid = tr.children[3].innerHTML;
	console.log('여긴 또 왜', hotelid);
	console.log("contract: " + contract + ", uwallet: " + uwallet + ", resno: " + resno + ", hotelid: " + hotelid);
	
	reservContractObj = web3js.eth.contract(reservation_contract_ABI).at(contract);
	// 예약자의 취소 수수료 %가 얼마나 되는지 확인(남은 날짜에 따라 다르기 때문에)
	var cancelPercent = calculateCancel(hotelid);
	var totalPrice = Number(tr.children[8].innerHTML);
	console.log('왜 안됨', totalPrice);
	var cancelFee = Math.floor((totalPrice/100 * cancelPercent) * 10000) / 10000; // 소숫점 5째자리에서 내림
	var cancelFeeMsg = '취소 수수료 퍼센트: ' + cancelPercent + '%, 취소 수수료: ' + cancelFee + '이더, 환불 금액: ' 
	+ Math.floor((totalPrice - cancelFee)*10000) / 10000 + '이더입니다.\n취소하시겠습니까?';
	if(confirm(cancelFeeMsg)){
		userCancel(uwallet);
		
		reservContractObj.CancelEvent().watch(function(err,res){
			if(err) console.error('cancel event 에러');
			else {
				// cancel이 잘 되었다면..
				console.log('이벤트에서 받은 값: 게스트주소: ' + res.args.guest + ", 취소수수료: " + res.args.cancelFee + ", 전액 환불 여부: " + res.args.inevitable);
				alert("게스트 지갑 주소: " + res.args.guest + "\n취소 수수료: " + res.args.cancelFee + "\n호텔의 전액환불인지: " + res.args.inevitable);
				$.ajax({
					url: "showReservation?cancelOk=1&resno=" + resno,
					async: false,
					success : function(data, statusTxt, xhr){
						console.log('/'+data+'/');
						alert(data);
						location.reload();
					},
					error : function(xhr, statusTxt, c) {console.log('통신에 실패했습니다.');}
				});
			}
		}); // cancelEvent.watch
	}// if(confirm())
} // onclick

function userCancel(uwallet){
	// 예약 취소 - 남은 날짜에 따라 취소 수수료가 까이고, 남은 금액을 환불 받을 수 있음.
	reservContractObj.cancelReservation.sendTransaction(function(err,res){
		if(err) console.error('유저 취소 에러');
		else{
			console.log('sendTransaction 결과(txid):',res);
			
			var txChkInterval = setInterval(function(){
				web3.eth.getReceiptTransaction(res,function(err2,res2){
					if(err2) console.error('getReceiptTransaction 에러');
					else{
						console.log('getReceiptTransaction 결과(txid):',res2);
						if(res2.status == '0x0'){
							console.log('트랜잭션 실패');
							clearInterval(txChkInterval);
						} else if(res2.status != null && res2.status == '0x1'){
							console.log('트랜잭션 성공');
							clearInterval(txChkInterval);
						}
					}
				});// getReceiptTransaction
			}, 100); // setInterval
		}
	});
} // userCancel

// 남은 날짜에 따라 취소 수수료 % 얼마인지 알아내는 함수
function calculateCancel(hotelid){
	var cancelPercent1 = 0; cancelPercent2 = 0;  cancelPercent3 = 0;  cancelPercent4 = 0;  cancelDay1 = 0;  cancelDay2 = 0; 
	$.ajax({
		url: 'reservConfirm?hotelid='+ hotelid,
		async: false,
		success: function(data, statusTxt, xhr){
			// cancelfee 정보
			var dataArr = data.split('\n');
			cancelPercent1 = Number(dataArr[0]);
			cancelPercent2 = Number(dataArr[1]);
			cancelPercent3 = Number(dataArr[2]);
			cancelPercent4 = Number(dataArr[3]);
			cancelDay1 = Number(dataArr[4]);
			cancelDay2 = Number(dataArr[5]);
			console.log('당일취소 %:', cancelPercent1);
			console.log('1일전 취소 %:', cancelPercent2);
			console.log(cancelDay1 + '일전 취소 %: ' + cancelPercent3);
			console.log(cancelDay2 + '일전 취소 %: ' + cancelPercent4);
		},
		error: function(statusTxt, xhr, c){ console.log('통신 실패'); }
	});
	
	// 남은 날짜 계산 (new Date를 하면 9시간이 더해진 값이 나와 32400초를 빼줬음) : 체크인날짜 - 지금날짜
	var remainPeriod = (new Date(tr.children[6].innerHTML).getTime() / 1000 - 32400) - Math.floor(Date.now() / 1000); // number
	console.log('체크인날짜:',(new Date(tr.children[6].innerHTML).getTime()) / 1000);
	console.log('지금날짜:',Math.floor(Date.now()/1000));
	console.log('남은기간:',remainPeriod);
	if(remainPeriod <= 0){
		// 당일 취소시
		return cancelPercent1;
	} 
	else if(remainPeriod <= 1 * 86400){
		// 1일전 취소시
		return cancelPercent2; 
	}
	else if(remainPeriod <= cancelDay1 * 86400){
		// setDay1 일전 취소시
		return cancelPercent3;
	}
	else if(remainPeriod <= cancelDay2 * 86400){
		// setDay2 일전 취소시
		return cancelPercent4;
	}
	else{
		// 위에 해당되지 않아서 전액 환불 가능
		return 0;
	}
}