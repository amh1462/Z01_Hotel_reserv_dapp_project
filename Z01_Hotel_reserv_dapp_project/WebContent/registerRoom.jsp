<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>

	<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>객실 등록</title>

  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="css/modern-business.css" rel="stylesheet">
</head>
<body>
	<div class="container">

    	<div class="row">
	  <!--
      <div class="col-md-5">
        <img class="img-fluid" src="http://placehold.it/400x400" alt="객실 사진">
      </div>
	  -->
      <div class="col-md-6">
        <form action="#" method="post" enctype="multipart/form-data">
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
	          		<div style="border:1px solid; width:400px; height:400px;"><img id="foo" src="#" style="width:400px; height:400px; " alt="사진을 추가해주세요."></div>
	          	</div>
	          </li><br>
	          <li style="margin-top: 15px;">수취 계좌(이더지갑): <br><input name="hwallet" style="width: 250px;" required><br>
	          	<input id="chkBox" type="checkbox" onclick="getAccount(this.checked)">
				<label for="chkBox">
					메타마스크에서 가져오기
				</label>
				<script>
				function getAccount(checked){ // 메타마스크에서 지갑 가져오기
					if(checked){
						// web3 인식 여부
						if(typeof web3 !== 'undefined'){ // !==는 타입까지 체크
							console.log("web3 인식 성공");
							web3js = new Web3(web3.currentProvider);
						}
						else{
							console.log("web3 인식 실패");
							alert('메타마스크를 설치해주십시오. \n만약 브라우저가 Chrome이 아니라면 실행할 수 없습니다.');
						}
						
						// 메타마스크에 접속되어 있는지 여부(접속되었으면 출력)
						if(web3js.eth.accounts[0] != null){
							console.log(web3js.eth.accounts[0]);
							if(confirm('지갑에서 주소를 불러옵니까?\n주소가 맞는지 잘 확인하세요!'))
								document.forms[0].hwallet.value = web3js.eth.accounts[0];
						}
						else {
							alert('메타마스크에 먼저 로그인 해야합니다.');
							document.getElementById('chkBox').checked = false;
						}
					} 
					else { // 체크 해제시
						document.forms[0].hwallet.value = '';
					}
				}
				
			    function readURL(input) {
			        if (input.files && input.files[0]) {
			            var reader = new FileReader();
			            reader.onload = function(e) {
			                $('#foo').attr('src', e.target.result);
			                console.log('e?', e.target.result);
			            }
			            reader.readAsDataURL(input.files[0]); //이게 onload보다 먼저
			        }
			    }

			    document.getElementById('inputFile').onchange = function() {
			        readURL(this);
			    };
				</script>          
	          </li>
	          <li style="margin-top: 15px;">취소수수료 : <br><input style="width: 250px;"></li>
          </ul>
          <input style=" margin-top: 30px; margin-left: 235px;" type="submit" value="등록">
        </form>
      </div>

    </div>

  </div>
  <!-- /.container -->
  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>