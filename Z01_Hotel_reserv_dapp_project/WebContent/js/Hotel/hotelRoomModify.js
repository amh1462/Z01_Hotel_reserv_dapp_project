/**
 * 
 */
function z(id){return document.getElementById(id);}
var web3js;
var reservContractObj; // onload 후에 설정했음.

z('inputFile').onchange = function() {
    readURL(this);
};    

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

function update() {
	// 취소수수료가 바뀌었는지를 체크하기 위해, 컨트랙트에 등록된 상태변수를 불러옴.
	reservContractObj.getStateValue.call(function(err,res){
		if(err) console.log("상태변수 호출 에러",err);
		else {
    		if(document.forms[0].hwallet.value == res[0] && cancelfee1 == res[1] && cancelfee2 == res[2] && cancelfee3 == res[3] && 
    				cancelfee4 == res[4] && cancelday1 == res[5] && cancelday2 == res[6]){ 
    			// 호텔 계좌, 취소수수료같은 컨트랙트에 넣을 요소는 그대로일 때
    			console.log('컨트랙트를 바꾸지 않아도 됨.')
    			document.forms[0].submit();
    		}
    		else {
    			// 상태변수 업데이트하는 컨트랙트의 함수 실행.
    			reservContractObj.updateStateValue.sendTransaction(document.forms[0].hwallet.value, cancelfee1, cancelfee2, cancelfee3, cancelfee4, cancelday1, cancelday2
    			,function(err,res){
    				if(err) console.log("수정 에러", err);
    				else {
    					console.log("sendTransaction 결과(txid?):",res);
    				}
    				
    				var txChkInterval = setInterval(function(){
    					web3.eth.getTransactionReceipt(res, function(err2,res2){ // 위에 일어난 tx의 해시값을 받아 처리.
    						if(err2) {console.error("에러2",err2); clearInterval(txChkInterval);}
    						if(res2 != null){
    							console.log("트랜잭션결과:",res2.status);
    							if (res2.status == '0x0'){
    								// tx 실패면..
    								console.log("tx 실패!:", res2);
    							}
    							else if( res2 != null && res2.status == '0x1'){
    								// tx 성공이면..
    								console.log("tx 성공!:", res2);
    								document.forms[0].submit(); // 컨트랙트 업데이트 후 배포하게끔.
    							}
    							clearInterval(txChkInterval);
    						}
    					})
    				}, 100);
    			}) // updateContract.sendTransaction
    		} // else
		} // if(err) -> else
	}); // getStateValue.call
} 

z('submitBtn').onclick = function(){
	if(web3js.eth.accounts[0] == null){
		alert('먼저 메타마스크에 로그인해주세요.\n 수정시 결제할 지갑이 필요합니다.');
	}
	else
		update();
}

window.onload = function() {
	// 메타마스크 
	if(typeof web3 !== 'undefined'){ // !==는 타입까지 체크
		console.log('web3 인식 성공');
		web3js = new Web3(web3.currentProvider);
	}
	else{
		console.log('web3인식 X');
		alert('컨트랙트 배포를 위해 메타마스크를 설치해주시고 로그인 해주십시오. \n만약 브라우저가 Chrome이 아니라면 실행할 수 없습니다.');
		window.open("about:blank").location.href = 'https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn?hl=ko';
	}
	
	reservContractObj = web3js.eth.contract(reservation_contract_ABI).at( contractAddr );
	console.log("예약컨트랙트객체:", reservContractObj);
}