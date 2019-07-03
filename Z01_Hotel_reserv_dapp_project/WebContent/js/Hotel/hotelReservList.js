/**
 * 
 */

function z(id){return document.getElementById(id);}
var reservContractObj; // onload 후에 설정했음.
var web3js;
var tr, contract, uwallet, resno;

window.onload = function(){
	// Provider(메타마스크) 등록
	if(typeof web3 !== 'undefined'){ // !==는 타입까지 체크
		console.log('web3 인식 성공');
		web3js = new Web3(web3.currentProvider);
	}
	else{
		console.log('web3인식 X');
		alert('취소 및 정산을 위해 메타마스크를 설치해주시고 로그인 해주십시오. \n만약 브라우저가 Chrome이 아니라면 실행할 수 없습니다.');
		window.open("about:blank").location.href = 'https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn?hl=ko';
		history.back();
	}
	
	// 정산 버튼을 눌렀을 때
	document.getElementsByClassName('withdrawBtn').onclick = function(){
		var withdrawBtn = document.getElementsByClassName('withdrawBtn');
		tr = withdrawBtn.parent().parent();
		contract = tr.children().eq(0).text();
		uwallet = tr.children().eq(1).text();
		resno = tr.children().eq(2).text();
		console.log("contract: " + contract + ", uwallet: " + uwallet + ", resno: " + resno);
		
		reservContractObj = web3js.eth.contract(reservation_contract_ABI).at(contract);
		withdraw(uwallet);
		var paymentCompleteEvent = reservContractObj.PaymentCompleteEvent();
		paymentCompleteEvent.watch(function(err,res){
			if(err) console.error("지불 이벤트 발생 에러",err);
			else {
				console.log("이벤트에서 받아온값: ", res.args.account + "," + res.args.amount + "," + res.args.isContractHasEther);
				alert('이더 받을 계좌: '+res.args.account+'\n이더량: '+res.args.amount+'ether\n컨트랙트 이더 보유여부: '+res.args.isContractHasEther);
				$.ajax({
					url: 'showReservation?withdrawOk=1&resno='+resno,
					async: false,
					success:function(data, statusTxt, xhr){
						// isWithdraw => 1로 처리 성공했을 시
						console.log('/'+data+'/');
						alert(data);
						location.reload();
					},
					error: function(xhr,statusTxt,c){ console.log("통신에 실패했습니다."); }
				});
				
			}
		})
	}
	
	// 취소 버튼을 눌렀을 때
	document.getElementsByClassName('cancelBtn').onclick = function(){
		var cancelBtn = document.getElementsByClassName('cancelBtn');
		tr = cancelBtn.parent().parent();
		contract = tr.children().eq(0).text();
		uwallet = tr.children().eq(1).text();
		resno = tr.children().eq(2).text();
		console.log("contract: " + contract + ", uwallet: " + uwallet + ", resno: " + resno);
		
		reservContractObj = web3js.eth.contract(reservation_contract_ABI).at(contract);
		cancel(uwallet);
		var cancelEvent = reservContractObj.CancelEvent();
		cancelEvent.watch(function(err,res){
			if(err) console.error('cancelEvent 에러');
			else {
				console.log("이벤트에서 받은 값: 게스트 지갑 주소: " + res.args.guest + ", 취소 수수료: " + res.args.cancelFee + " , 호텔의 전액환불인지: " + res.args.inevitable);
				alert("게스트 지갑 주소: " + res.args.guest + "\n취소 수수료: " + res.args.cancelFee + "\n호텔의 전액환불인지: " + res.args.inevitable);
				$.ajax({
					url: "showReservation?cancelOk=1&resno="+resno,
					async: false,
					success: function(data, statusTxt, xhr){
						console.log('/'+data+'/');
						alert(data);
						location.reload();
					},
					error: function(xhr,statusTxt,c){ console.log("통신에 실패했습니다."); }
				});
			}
		})
	}
}

function withdraw(uwallet){
	// 정산 - 해당 날짜(현재는 체크인날짜)가 되면 컨트랙트에 보관된 예약금을 호텔 계좌에 받는 작업.
	reservContractObj.withDrawal.sendTransaction(uwallet,function(err,res){
		if(err) console.error("정산 트랜잭션 에러",err);
		else{
			console.log("sendTransaction 결과(txid):",res);
			
			var txChkInterval = setInterval(function(){
				// 트랜잭션 발생이 성공인지 실패인지 알기 위해
				web3.eth.getTransactionReceipt(res, function(err2,res2){
					if(err2) console.error("getTransactionReceipt에러",err2);
					else{
						console.log("getTransactionReceipt결과:",res2.status);
						if(res2.status == '0x0')/*실패*/ console.log("트랜잭션 실패(txid):", res2);
						else if(res2 != null && res2.status == '0x1'){
							console.log("트랜잭션 성공(txid):", res2);
							clearInterval(txChkInterval);
						}
						clearInterval(txChkInterval);
					}
				})
			},100); //0.1초마다 실행
		}
	})
}


function cancel(uwallet){
	// 불가피한 취소 - 게스트가 어쩔 수 없는 사정으로 취소했다고 참작됐을 때 100% 환불
	reservContractObj.inevitableCancel.sendTransaction(uwallet, function(err,res){
		if(err) console.error('취소 에러');
		else{
			console.log('sendTransaction 결과(txid): ',res);
			
			var txChkInterval = setInterval(function(){
				web3.eth.getReceiptTransaction(res, function(err2,res2){
					if(err2) console.error('getReceiptTransaction 에러');
					else{
						console.log('getReceiptTransaction 결과:',res2);
						if(res2.status == '0x0') console.log('트랜잭션 실패(txid):',res2);
						else if(res2.status != null && res2.status == '0x1'){
							console.log('트랜잭션 성공(txid):',res2);
							clearInterval(txChkInterval);
						}
						clearInterval(txChkInterval);
					}
				})
			},100);
		}//else
	})// sendTransaction
}
	