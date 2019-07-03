/**
 * 
 */
function z(id){return document.getElementById(id);}
var web3js;

function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
     	// 사진 선택한 것을 바로 img태그에 띄워줌.
        reader.onload = function(e) {
     		z('roomImg').getAttributeNode('src').value = e.target.result;
            console.log('e?', e.target.result);
        }
        reader.readAsDataURL(input.files[0]); //이게 onload보다 먼저
    }
}

z('inputFile').onchange = function() {
    readURL(this);
};

function deployContract(){
	var reservContract = web3js.eth.contract(reservation_contract_ABI);
	alert('예약 컨트랙트 배포를 시작합니다. \n메타마스크 계좌에서 약간의 수수료가 지불될 수 있습니다.');
	if(web3js.eth.accounts[0] == null) alert('먼저 메타마스크에 로그인해주세요.\n 방 등록시 결제할 지갑이 필요합니다.');
	else{
		// 컨트랙트 배포
    	reservContract.new(document.forms[0].hwallet.value, cancelfee1, cancelfee2, cancelfee3, cancelfee4, cancelday1, cancelday2,{
			data: reservation_contract_bytecode,
			from: web3js.eth.accounts[0],
			//gas: web3.eth.estimateGas({data: reservation_contract_bytecode});
			gas: 2000000
		}, function(err,res){
			if(err) {
				console.log('배포 에러', err);
				// submit 취소
				alert('컨트랙트 배포에 실패했습니다. 다시 등록해주십시오.');
			}
			else{
				if(res.address == null){
					console.log("트랜잭션 해시",res.transactionHash);
					console.log("컨트랙트 주소",res.address);
					
				} else { // res.address를 DB에 저장.
					console.log("컨트랙트 주소",res.address);
					document.forms[0].contract.value = res.address;
					alert('컨트랙트 배포 완료!');
					document.forms[0].submit();
				}
			}
		}); // reservContract.new
	} // else
};

window.onload = function() {
	// 메타마스크 설치 체크
	if(typeof web3 !== 'undefined'){ // !==는 타입까지 체크
		console.log('web3 인식 성공');
		web3js = new Web3(web3.currentProvider);
	}
	else{
		console.log('web3인식 X');
		alert('컨트랙트 배포를 위해 메타마스크를 설치해주시고 로그인 해주십시오. \n만약 브라우저가 Chrome이 아니라면 실행할 수 없습니다.');
		window.open("about:blank").location.href = 'https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn?hl=ko';
		history.back();
	}
}
