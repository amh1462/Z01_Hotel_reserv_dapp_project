<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <title>객실 등록</title>

  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="css/modern-business.css" rel="stylesheet">
  
  <script type="text/javascript" src="vendor/jquery/jquery.min.js"></script>
</head>

<body>
  <div class="container">
    <div class="row">
      <div class="col-md-6">
        <form action="./manageroom" method="post" enctype="multipart/form-data" onkeydown="return notUseEnterKey(event);">
          <script>
			  function notUseEnterKey(e){
			      if(e.keyCode === 13 && e.srcElement.type != 'textarea') e.preventDefault();
			  }
		  </script>
          <ul style="list-style-type: none; width: 400px;">
	          <li>방 이름 : <br><input name="roomname" style="width: 250px;" required></li>  
	          <li style="margin-top: 15px;">방 설명 : <textarea name="roominfo" cols="70" rows="8" style="resize: none;"></textarea></li>
	          <li style="margin-top: 15px;">허용 인원: <br>
	          	<select name="allowedman" style="width: 50px">
	          		<c:forEach var="i" begin="2" end="9">
	          			<option>${ i }</option>
	          		</c:forEach>
	          	</select>
	          </li>
	          <li style="margin-top: 15px;">평일 1박요금 : <br><input name="dailyprice" style="width: 250px;" required>(단위:원)</li>
	          <li style="margin-top: 15px;">주말 1박요금: <br><input name="weekendprice" style="width: 250px;" required>(단위:원)</li>
	          <li style="margin-top: 15px;">전체 방 개수 : <br><input name="totalcount" style="width: 250px;" required></li><br>
	          <li style="margin-top: 15px;">
	          	<div style="height:420px;">
	          		사진 : <input type="file" name="photo" id="inputFile">
	          		<div style="border:1px solid; width:400px; height:400px;"><img id="roomImg" src="#" style="width:400px; height:400px; " alt="사진을 추가해주세요."></div>
	          	</div>
	          </li><br>
	          <li style="margin-top: 15px;">수취 계좌(이더지갑): <br><input id="hwallet" style="width: 400px;" value="${ hwallet }" readonly><br>
	          <div style="width: 500px">※ 수취 계좌를 변경하시려면 <a href="hotelMain.jsp?contentPage=modify.jsp">호텔 정보</a>에서 수정해주세요.</div>
	          <br>
	          <li>
	          	<span>취소 수수료 정책</span>
	          	<div style="border: 3px solid beige; width: 500px; padding: 10px 0 0 10px">
          			<span>당일 취소 : &nbsp;<input style="width:50px" value="${ cancelfee1 }" readonly> %</span><br> 
          			<span>1일전 취소: <input style="width:50px" value="${ cancelfee2 }" readonly> %</span><br>
          			<span>
          				<input style="width:30px" value="${ cancelday1 }" readonly>일전 취소: 
          				<input style="width:50px" value="${ cancelfee3 }" readonly> %
          			</span><br>
          			<span>
          				<input style="width:30px" value="${ cancelday2 }" readonly>일전 취소: 
          				<input style="width:50px" value="${ cancelfee4 }" readonly> %
          			</span><br><br>
          		</div>
          		<div style="width: 500px">※ 취소 수수료를 변경하시려면 <a href="hotelMain.jsp?contentPage=modify.jsp">호텔 정보</a>에서 수정해주세요.</div>
	          </li>
          </ul>
          <input type="hidden" name="contract">
          <input style=" margin-top: 30px; margin-left: 235px;" id="submitBtn" type="button" value="등록" onclick="deployContract();">
        </form>
      </div>
    </div>
    <script>
    	function z(id){return document.getElementById(id);}
    	var web3js;
		
	    function readURL(input) {
	        if (input.files && input.files[0]) {
	            var reader = new FileReader();
	            reader.onload = function(e) {
	                $('#roomImg').attr('src', e.target.result);
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
	    	reservContract.new(document.forms[0].hwallet.value, ${cancelfee1}, ${cancelfee2}, ${cancelfee3}, ${cancelfee4}, ${cancelday1}, ${cancelday2},{
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
						// res.address를 DB에 저장.
					} else {
						console.log("컨트랙트 주소",res.address);
						document.forms[0].contract.value = res.address;
						alert('컨트랙트 배포 완료!');
						document.forms[0].submit();
					}
				}
			});
	    };
	    
	    onload = function() {
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
		}
    </script>
  </div>
  <!-- /.container -->
  
  <!-- Bootstrap core JavaScript -->
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  
  <!-- web3.js -->
  <script language="javascript" type="text/javascript" src="https://github.com/ethereum/web3.js/blob/master/dist/web3.min.js"></script>
  
  <!-- abi, bytecode -->
  <script src="js/reservation_contract_abi.js"></script>
  <script src="js/reservation_contract_bytecode.js"></script>

</body>
</html>