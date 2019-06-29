<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>호텔나라</title>
	<!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link rel="icon" type="image/png" href="images/icons/favicon.ico">
  <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" type="text/css" href="fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
  <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
  <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
  <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
  <link rel="stylesheet" type="text/css" href="css/util.css">
  <link rel="stylesheet" type="text/css" href="css/main.css">
	
</head>

<style>
table {
  border-collapse: collapse;
  width: 100%;
}
table td, table th {
  border: 1px solid gray;
  text-align: center;
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
<script type="text/javascript">
	var web3js;
	var tr, contract, uwallet, resno, hotelid;
	var reservContractObj;
	
	function popup() {
		opener.document.location.href="userIndex.html";
		self.close();
	}
	
	onload = function(){
		$('.userCancel').on('click',function(){
			if(typeof web3 !== 'undefined'){
				console.log('web3 인식 성공');
				web3js = new Web3(web3.currentProvider);
			} else { 
				console.log('web3 인식 실패');
				alert('예약 취소를 위해 메타마스크를 설치해주세요.\n브라우저가 Google Chrome이 아니면 실행할 수 없습니다.');
				window.open('about:blank').location.href = 'https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn?hl=ko';
			}
			
			var userCancelBtn = $(this);
			tr = userCancelBtn.parent().parent();
			contract = tr.children().eq(0).text();
			uwallet = tr.children().eq(1).text();
			resno = tr.children().eq(2).text();
			hotelid = tr.children().eq(3).text();
			console.log("contract: " + contract + ", uwallet: " + uwallet + ", resno: " + resno + ", hotelid: " + hotelid);
			var userCancelFlag = false;
			
			reservContractObj = web3js.eth.contract(reservation_contract_ABI).at(contract);
			var cancelPercent = calculateCancel(hotelid);
			var totalPrice = Number(tr.children().eq(8).text());
			var cancelFee = Math.floor((totalPrice/100 * cancelPercent) * 10000) / 10000;
			var cancelFeeMsg = '취소 수수료 퍼센트: ' + cancelPercent + '%, 취소 수수료: ' + cancelFee + '이더, 환불 금액: ' 
			+ Math.floor((totalPrice - cancelFee)*10000) / 10000 + '이더입니다.\n취소하시겠습니까?';
			if(confirm(cancelFeeMsg)){
				userCancel(uwallet);
				
				reservContractObj.CancelEvent().watch(function(err,res){
					if(err) console.error('cancel event 에러');
					else if(!userCancelFlag){
						// cancel이 잘 되었다면..
						console.log('이벤트에서 받은 값: 게스트주소: ' + res.args.guest + ", 취소수수료: " + res.args.cancelFee + ", 전액 환불 여부: " + res.args.inevitable);
						alert("게스트 지갑 주소: " + res.args.guest + "\n취소 수수료: " + res.args.cancelFee + "\n호텔의 전액환불인지: " + res.args.inevitable);
						$.ajax({
							url: "showreservation?cancelOk=1&resno=" + resno,
							success : function(data, statusTxt, xhr){
								console.log('/'+data+'/');
								userCancelFlag = true;
								alert(data);
								location.reload();
							},
							error : function(xhr, statusTxt, c) {console.log('통신에 실패했습니다.');}
						});
					}
				}); // cancelEvent.watch
			}// if(confirm())
		}); // onclick
	}
	
	function userCancel(uwallet){
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
	
	function calculateCancel(hotelid){
		var cancelPercent1 = 0; cancelPercent2 = 0;  cancelPercent3 = 0;  cancelPercent4 = 0;  cancelDay1 = 0;  cancelDay2 = 0; 
		$.ajax({
			url: 'bookconfirm?hotelid='+ hotelid,
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
		
		console.log('calculateCancel에서 tr:', tr);
		var remainPeriod = (new Date(tr.children().eq(6).text()).getTime() / 1000 - 32400) - Math.floor(Date.now() / 1000); // number
		console.log('체크인날짜:',(new Date(tr.children().eq(6).text()).getTime()) / 1000);
		console.log('지금날짜:',Math.floor(Date.now()/1000));
		console.log('남은기간:',remainPeriod);
		console.log('이게 왜 거짓?',remainPeriod <= cancelDay1 * 86400);
		console.log('cancelDay1',cancelDay1);
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
			alert('왜 일루와?');
			return 0;
		}
	}
</script>	
	
<body>

  <!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark static-top">
    <div class="container">
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item active">
            <a style="cursor:pointer" class="nav-link" onclick="popup()">Home
              <span class="sr-only">(current)</span>
            </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- Page Content -->
  <div class="container">
    <div class="row">
      <div style="margin-top: 10%" class="col-lg-12">
       <div class="card-img-top" style="height: auto;" >
          	<label style="padding-left: 50px; padding-top: 20px;">예약자 명 : </label> <label>${ requestScope.guestname }</label>
          	<br>
          	<label style="padding-left: 50px; padding-top: 15px;" >휴대폰 : </label> <label>${ requestScope.phone }</label>
          	<br>
          	<label style="padding-left: 50px; padding-top: 15px;">이메일 : </label> <label>${ requestScope.email }</label>
        </div>
        <hr>
          <div class="card-body">
           <table>
          <tr>
            <th>호텔  명</th>
            <th>방 종류</th>
            <th>체크인</th>
            <th>체크아웃</th>
            <th>총 요금(ETH)</th>
            <th>취  소</th>
          </tr>
	        <tr>
	        <c:forEach var="uresVo" items="${ ureslist }">
	        	<td style="display:none">${ uresVo.contract }</td>
	        	<td style="display:none">${ uresVo.uwallet }</td>
	        	<td style="display:none">${ uresVo.resno }</td>
	        	<td style="display:none">${ uresVo.hotelid }</td>
	        	<td>${ uresVo.hotelname } </td>
	        	<td>${ uresVo.roomno }</td>
	        	<td>${ uresVo.checkin }</td>
	        	<td>${ uresVo.checkout }</td>
	        	<td>${ uresVo.totalprice }</td>
	        	<c:choose>
	        		<c:when test="${ uresVo.iscancel eq 1 }"><td><a>취소완료</a></td></c:when>		
	        		<c:when test="${ uresVo.iswithdraw eq 1 }"><td><a>정산완료</a></td></c:when>
	        		<c:when test="${ uresVo.iscancel eq 0 }"><td><button class="btn_hgray userCancel">취 소</button></td></c:when>
	        	</c:choose>
	        	</tr>
	        </c:forEach>
        </table>
        <!-- <td>${ resVo.iscancel}</td>
	         <td>${ resVo.iswithdraw}</td> -->
        <ul class="pagination justify-content-center">
					<li class="page-item <c:if test='${startList == 1}'>disabled</c:if>">
						<a class="page-link" href="bookconfirm?pIndex=${ startList-1 }"> <span
							class="lnr lnr-arrow-left"></span>
					</a>
					</li>
					<c:forEach var="pIdx" begin="${ startList }" end="${ endList }">
						<li
							class="page-item <c:if test='${param.resIndex == pIdx}'> active</c:if>">
							<a class="page-link" href="bookconfirm?resIndex=${ pIdx }">${ pIdx }</a>
						</li>
					</c:forEach>
					<li
						class="page-item <c:if test='${endList % 10 != 0}'> disabled</c:if>">
						<a class="page-link" href="bookconfirm?pIndex=${ endList+1 }"> <span
							class="lnr lnr-arrow-right"></span>
					</a>
					</li>
				</ul>
				<input type="hidden" name="hotelid" value="${ hVo.hotelid }" >
          <div class="card-footer text-muted">
          HotelNara
          </div>
      </div>
    </div>
  </div>
  
  <script src="js/reservation_contract_abi3.js"></script>
  <script src="js/reservation_contract_bytecode.js"></script>

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  
  <script src="vendor/jquery/jquery-3.2.1.min.js"></script>

</body>

</html>
