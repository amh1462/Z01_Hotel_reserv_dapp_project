<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <title>호텔나라</title>

  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

</head>

<body>

  <!-- Page Content -->
  <div style="margin-top: 8%; margin-left: 20%;" class="container">
    <form method="post" action="./reservConfirm">
    <div class="row">
    	<h1 style="font-weight: 300;" class="my-4">예약확인</h1>
      <div class="col-lg-12">
        <div style="max-width: 70%" class="card mb-4">
          <div class="card-img-top" style="height: auto;" >
          	<label style="padding-left: 20px; padding-top: 20px;">예약자 명 : </label> <input style="width: 70%;" type="text" name="guestname">
          	<br>
          	<label style="padding-left: 20px; padding-top: 15px;" >휴 대 폰 : </label> <input style="margin-left:12px; width: 70%;" type="text" name="phone">
          	<br>
          	<label style="padding-left: 20px; padding-top: 15px;">이 메 일 : </label> <input style="margin-left:12px; width: 70%;" type="text" name="email">
          </div>
          <hr style="margin: 10px;">
          <div style="padding: 10px;" class="card-body">
            <button style="margin-left: 73%;" class="btn btn-primary">예약확인</button>
          </div>
        </div>
      </div>
    </div>
    </form>
  </div>

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.slim.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>
