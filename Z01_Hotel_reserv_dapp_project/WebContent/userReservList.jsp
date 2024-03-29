<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

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
            <a style="cursor:pointer" class="nav-link" onclick="reservConfirm()">Home
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
	        		<c:when test="${ uresVo.iscancel eq 0 }"><td><button class="btn_hgray" onclick="userCancelBtnClick(this)">취 소</button></td></c:when>
	        	</c:choose>
	        	</tr>
	        </c:forEach>
        </table>
        <!-- <td>${ resVo.iscancel}</td>
	         <td>${ resVo.iswithdraw}</td> -->
        <ul class="pagination justify-content-center">
					<li class="page-item <c:if test='${startList == 1}'>disabled</c:if>">
						<a class="page-link" href="reservConfirm?pIndex=${ startList-1 }"> <span
							class="lnr lnr-arrow-left"></span>
					</a>
					</li>
					<c:forEach var="pIdx" begin="${ startList }" end="${ endList }">
						<li
							class="page-item <c:if test='${param.resIndex == pIdx}'> active</c:if>">
							<a class="page-link" href="reservConfirm?resIndex=${ pIdx }">${ pIdx }</a>
						</li>
					</c:forEach>
					<li
						class="page-item <c:if test='${endList % 10 != 0}'> disabled</c:if>">
						<a class="page-link" href="reservConfirm?pIndex=${ endList+1 }"> <span
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

  <!-- js 처리 파일 -->
  <script src="js/User/userReservList.js"></script>
</body>

</html>
