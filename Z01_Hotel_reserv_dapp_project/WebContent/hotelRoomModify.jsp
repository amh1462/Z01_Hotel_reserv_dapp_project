<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

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
        <form action="modify" method="post" enctype="multipart/form-data" onkeydown="return notUseEnterKey(event);">
          <script>
			  function notUseEnterKey(e){
			      if(e.keyCode === 13 && e.srcElement.type != 'textarea') e.preventDefault();
			  }
		  </script>
          <input type="hidden" name="hiddenValue" value="room">
          <input type="hidden" name="roomno" value="${ requestScope.rvo.roomno }">
          <ul style="list-style-type: none; width: 400px;">
	          <li>방 이름 : <br><input name="roomname" style="width: 250px;" value="${ requestScope.rvo.roomname }" required></li>  
	          <li style="margin-top: 15px;">방 설명 : <textarea name="roominfo" cols="70" rows="8" style="resize: none; border: 1px solid;">${ requestScope.rvo.roominfo }</textarea></li>
	          <li style="margin-top: 15px;">허용 인원: <br>
	          	<select name="allowedman" style="width: 50px">
	          		<c:forEach var="i" begin="2" end="9">
	          			<option>${ i }</option>
	          		</c:forEach>
	          	</select>
	          	<script>
		          	var sel = document.forms[0].allowedman;
					for(i=0; i<sel.options.length; i++){
						if(sel.options[i].value == '${ requestScope.rvo.allowedman }'){
							sel.options[i].selected = true;
						}
					}
	          	</script>
	          </li>
	          <li style="margin-top: 15px;">평일 1박요금 : <br><input name="dailyprice" style="width: 250px;" value="${ requestScope.rvo.dailyprice }" required>(단위:원)</li>
	          <li style="margin-top: 15px;">주말 1박요금: <br><input name="weekendprice" style="width: 250px;" value="${ requestScope.rvo.weekendprice }" required>(단위:원)</li>
	          <li style="margin-top: 15px;">전체 방 개수 : <br><input name="totalcount" style="width: 250px;" value="${ requestScope.rvo.totalcount }" required></li>
	          <li style="margin-top: 15px;">남은 방 개수 : <br><input name="restcount" style="width: 250px;" value="${ requestScope.rvo.restcount }" required></li><br>
	          <li style="margin-top: 15px;">
	          	<div style="height:420px;">
	          		사진 : <input type="file" name="photo" id="inputFile">
	          		<div style="border:1px solid; width:400px; height:400px;"><img id="roomImg" src="${ requestScope.rvo.photo }" style="width:400px; height:400px; " alt="사진을 추가해주세요."></div>
	          	</div>
	          </li><br>
	          <li style="margin-top: 15px;">수취 계좌(이더지갑): <br><input id="hwallet" style="width: 400px;" value="${ hwallet }" readonly><br>
	          <div style="width: 500px">※ 수취 계좌를 변경하시려면 <a href="hotelMain.jsp?contentPage=hotelModify.jsp">호텔 정보</a>에서 수정해주세요.</div>
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
          		<div style="width: 500px">※ 취소 수수료를 변경하시려면 <a href="hotelMain.jsp?contentPage=hotelModify.jsp">호텔 정보</a>에서 수정해주세요.</div>
	          </li>
          </ul>
          <input style=" margin-top: 30px; margin-left: 235px;" id="submitBtn" type="button" value="등록">
          <input id="cancelBtn" type="button" value="취소" onclick="location.href='manageRoom?type=show&pIndex=1'">
        </form>
      </div>
    </div>
    <script>
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
	                $('#roomImg').attr('src', e.target.result);
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
		    		if(document.forms[0].hwallet.value == res[0] && ${cancelfee1} == res[1] && ${cancelfee2} == res[2] && ${cancelfee3} == res[3] && 
		    				${cancelfee4} == res[4] && ${cancelday1} == res[5] && ${cancelday2} == res[6]){ 
		    			// 호텔 계좌, 취소수수료같은 컨트랙트에 넣을 요소는 그대로일 때
		    			console.log('컨트랙트를 바꾸지 않아도 됨.')
		    			document.forms[0].submit();
		    		}
		    		else {
		    			// 상태변수 업데이트하는 컨트랙트의 함수 실행.
		    			reservContractObj.updateStateValue.sendTransaction(document.forms[0].hwallet.value, ${cancelfee1}, ${cancelfee2}, ${cancelfee3}, ${cancelfee4}, ${cancelday1}, ${cancelday2}
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
			
			reservContractObj = web3js.eth.contract(reservation_contract_ABI).at( '${ requestScope.rvo.contract }' );
			console.log("예약컨트랙트객체:", reservContractObj);
		}
    </script>
  </div>
  <!-- /.container -->
  
  <!-- Bootstrap core JavaScript -->
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  
  <!-- web3.js -->
  <script language="javascript" type="text/javascript" src="https://github.com/ethereum/web3.js/blob/master/dist/web3.min.js"></script>
  
  <!-- abi, bytecode -->
  <script src="js/reservation_contract_abi3.js"></script>
  <script src="js/reservation_contract_bytecode.js"></script>

</body>
</html>