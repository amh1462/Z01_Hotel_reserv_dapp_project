<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <title>호텔나라</title>

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
        <form action="./manageRoom" method="post" enctype="multipart/form-data" onkeydown="return notUseEnterKey(event);">
          <script>
			  function notUseEnterKey(e){
			      if(e.keyCode === 13 && e.srcElement.type != 'textarea') e.preventDefault();
			  }
		  </script>
          <ul style="list-style-type: none; width: 400px;">
	          <li>방 이름 : <br><input name="roomname" style="width: 250px;" required></li>  
	          <li style="margin-top: 15px;">방 설명 : <textarea name="roominfo" cols="70" rows="8" style="resize: none; border: 1px solid;"></textarea></li>
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
          <input type="hidden" name="contract">
          <input style=" margin-top: 30px; margin-left: 235px;" id="submitBtn" type="button" value="등록" onclick="deployContract();">
        </form>
      </div>
    </div>
    <script>
    	var cancelfee1 = ${cancelfee1};
    	var cancelfee2 = ${cancelfee2};
    	var cancelfee3 = ${cancelfee3};
    	var cancelfee4 = ${cancelfee4};
    	var cancelday1 = ${cancelday1};
    	var cancelday2 = ${cancelday2};
	</script>
  </div>
  <!-- /.container -->
  
  <!-- Bootstrap core JavaScript -->
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  
  <!-- web3.js -->
  <script language="javascript" type="text/javascript" src="https://github.com/ethereum/web3.js/blob/master/dist/web3.min.js"></script>
  
  <!-- abi, bytecode -->
  <script src="js/reservation_contract_abi3.js?ver=1"></script>
  <script src="js/reservation_contract_bytecode.js?ver=1"></script>
  
  <!-- js 처리 파일 -->
  <script src="js/Hotel/hotelRegisterRoom.js"></script>

</body>
</html>