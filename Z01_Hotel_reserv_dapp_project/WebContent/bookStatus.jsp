<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <title>예약현황</title>
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
<script>
	function z(id){return document.getElementById(id);}
	var reservContractObj; // onload 후에 설정했음.
	var web3js;
	
	onload = function(){
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
		
		$('#withdrawBtn').on('click',function(){
			var withdrawBtn = $(this);
			var tr = withdrawBtn.parent().parent();
			var td0 = tr.children().eq(0);
			var contract = td0.text();
			var uwallet = tr.children().eq(1).text();
			var resno = tr.children().eq(2).text();
			var count = 0;
			console.log("contract:",contract);
			console.log("resno", resno);
			
			reservContractObj = web3js.eth.contract(reservation_contract_ABI).at(contract);
			withdraw(uwallet);
			var paymentCompleteEvent = reservContractObj.PaymentCompleteEvent();
			paymentCompleteEvent.watch(function(err,res){
				if(err) console.error("지불 이벤트 발생 에러",err);
				else{
					console.log("이벤트에서 받아온값: ", res.args.account + "," + res.args.amount + "," + res.args.isContractHasEther);
					alert('이더 받을 계좌: '+res.args.account+'\n이더량: '+res.args.amount+'ether\n컨트랙트 이더 보유여부: '+res.args.isContractHasEther);
					$.ajax({
						url: 'showreservation?withdrawOk=1&resno='+resno,
						success:function(data, statusTxt, xhr){
							// isWithdraw => 1로 처리 성공했을 시
							console.log('/'+data+'/');
							if(count!=1){
								alert(data);
								location.reload();
							}
						},
						error: function(xhr,statusTxt,c){ console.log("통신에 실패했습니다."); }
					});
					
				}
			})
		})
	}
	
	function withdraw(uwallet){
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
							if(res2.statue == '0x0')/*실패*/ console.log("트랜잭션 실패(txid):", res2);
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
</script>
<body>
  <div class="limiter">
    <div class="container-login101">
      <div style="position:absolute; top: 10px;" class="wrap-main100">
      
        <span class="login100-form-title p-b-30">예약 현황</span>
        <div style='text-align: right;'>
          <form>
            <select name='searchField'>
              <option value='guestname'>예약자 명</option>
              <option value='roomno'>방 종류</option>
              <option value='time'>예약날짜</option>
              <option value='checkin'>체크인</option>
              <option value='checkout'>체크아웃</option>
            </select> 
            <input name='searchKeyword'>
            <input type='submit' value='검색' style='width: 70px;'>
            <input type="hidden" name="hotelid" value="${ hotelid }" >
          </form>
          <label style="pont-size:small; margin-top:10px; margin-bottom:-15px;" >날짜 검색시 ex) 19-12-25 (yy-mm-dd)</label>
        </div><br>
        <table>
          <tr>
            <th>예약자 명</th>
            <th>방 종류</th>
            <th>요 금(eth)</th>
            <th>예약날짜</th>
            <th>체크인</th>
            <th>체크아웃</th>
            <th>취 소</th>
            <th>정 산</th>
          </tr>
	        <c:forEach var="resVo" items="${ reslist }">
	          <tr>
	          	<td style="display:none;">${ resVo.contract }</td>
	          	<td style="display:none;">${ resVo.uwallet }</td>
	          	<td style="display:none;">${ resVo.resno }</td>
	        	<td>${ resVo.guestname }</td>
	        	<td>${ resVo.roomno }</td>
	        	<td>${ resVo.totalprice }</td>
	        	<td>${ resVo.time }</td>
	        	<td>${ resVo.checkin}</td>
	        	<td>${ resVo.checkout}</td>
	        	<c:choose>
	        		<c:when test="${ resVo.iscancel eq 0 }"><td><button id="cancelBtn" class="btn_hgray">취 소</button></td></c:when>
	        		<c:when test="${ resVo.iscancel eq 1 }"><td><a>취소 완료</a></td></c:when>		
	        	</c:choose>
	        	<c:choose>
		        	<c:when test="${ resVo.iswithdraw eq 0 }"><td><button id="withdrawBtn"class="btn_hgray">정 산</button></c:when>
	        		<c:when test="${ resVo.iswithdraw eq 1 }"><td><a>정산 완료</a></td></c:when>	 				
	        	</c:choose>
	        	</tr>
	        </c:forEach>
        </table>
        <!-- <td>${ resVo.iscancel}</td>
	         <td>${ resVo.iswithdraw}</td> -->
        <ul class="pagination justify-content-center">
					<li class="page-item <c:if test='${startList == 1}'>disabled</c:if>">
						<a class="page-link" href="showreservation?pIndex=${ startList-1 }"> <span
							class="lnr lnr-arrow-left"></span>
					</a>
					</li>
					<c:forEach var="pIdx" begin="${ startList }" end="${ endList }">
						<li
							class="page-item <c:if test='${param.pIndex == pIdx}'> active</c:if>">
							<a class="page-link" href="showreservation?pIndex=${ pIdx }">${ pIdx }</a>
						</li>
					</c:forEach>
					<li
						class="page-item <c:if test='${endList % 10 != 0}'> disabled</c:if>">
						<a class="page-link" href="showrserevation?pIndex=${ endList+1 }"> <span
							class="lnr lnr-arrow-right"></span>
					</a>
					</li>
				</ul>
        <input type="hidden" name="hotelid" value="${ hVo.hotelid }" >
        <div style="height: 10px;"></div>
        
        
      </div>
    </div>
  </div>
  

  
  <script src="js/reservation_contract_abi3.js"></script>
  <script src="js/reservation_contract_bytecode.js"></script>
  
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