<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
	
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
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

tr, td {
	overflow:hidden; 
	text-overflow:ellipsis; 
	white-space:nowrap;
}

</style>

<body>
	<div class="limiter">
		<div class="container-login101">
			<div style="position:absolute; top: 10px;" class="wrap-main100">
				<span class="login100-form-title p-b-30">객실 현황</span>
				<a href='manageroom?type=register' class='btn_hgray' style='float: left'>객실 등록</a>
				<div style='text-align: right;'>
					<form action="manageroom">
						<input type="hidden" name="type" value="show">
						<input type="hidden" name="pIndex" value="1">
						<select name='searchField'>
							<option value='roomname'>방 이름</option>
							<option value='dailyprice'>평일가</option>
							<option value='weekendprice'>주말가</option>
							<option value='restcount'>남은 방</option>
							<option value='time'>등록날짜</option>
							<option value='contract'>컨트랙트</option>
						</select> 
						<input name='searchKeyword'>
						<input type='submit' value='검색' style='width: 70px;'>
					</form>
				</div><br>
				<script>
					// searchField and searchKeyword remain if page are changed.
					if(${ !empty param.searchField && !empty param.searchKeyword }){
						var sel = document.forms[0].searchField;
						for(i=0; i<sel.options.length; i++){
							if(sel.options[i].value == '${ param.searchField }'){
								sel.options[i].selected = true;
							}
						}
						document.forms[0].searchKeyword.value = '${ param.searchKeyword }'
					}
				</script>
				<table style="table-layout: fixed; width: 100%">
					<tr>
						<th width="30">no</th>
						<th width="100">방 사진</th>
						<th width="250">내용</th>
						<th width="30">수 정</th>
					</tr>
					<c:forEach var="rvo" items="${ rlist }">
						<tr>
							<td>${ rvo.roomno }</td>
							<td><img style="width:208px; height:300px; padding:10px;" src="${ rvo.photo }"></td>
							<td style="text-align: left; padding: 10px;">
								<span style="font-weight: bold">방 이름:</span> ${ rvo.roomname }<br><br>
								<div style="font-weight: bold">방 설명:</div> ${ rvo.roominfo }<br><br>
								<span style="font-weight: bold">평일가:</span> ${ rvo.dailyprice } 원<br>
								<span style="font-weight: bold">주말가:</span> ${ rvo.weekendprice } 원<br>
								<span style="font-weight: bold">남은 방:</span> ${ rvo.restcount } 개<br>
								<span style="font-weight: bold">등록 날짜:</span> ${ rvo.time }<br>
								<span style="font-weight: bold">컨트랙트 주소:</span> ${ rvo.contract }
							</td>
							<td><a class='btn_hgray' href="manageroom?type=show&no=${ rvo.roomno }" >수정</a></td>
						</tr>
					</c:forEach>
				</table>
				<div style="height: 10px;"></div>
				<ul class="pagination justify-content-center">
					<li class="page-item <c:if test='${startList == 1}'>disabled</c:if>">
						<a class="page-link" href="manageroom?type=show
						<c:if test="${ !empty param.searchField && !empty param.searchKeyword }">
							&searchField=${ param.searchField }&searchKeyword=${ param.searchKeyword }
						</c:if>
						&pIndex=${ startList-1 }"> 
							<span class="lnr lnr-arrow-left"></span>
						</a>
					</li>
					<c:forEach var="pIdx" begin="${ startList }" end="${ endList }">
						<li class="page-item <c:if test="${ param.pIndex == pIdx }">active</c:if>">
							<a class="page-link" href="manageroom?type=show
							<c:if test="${ !empty param.searchField && !empty param.searchKeyword }">
								&searchField=${ param.searchField }&searchKeyword=${ param.searchKeyword }
							</c:if>
							&pIndex=${ pIdx }">
								${ pIdx }
							</a>
						</li>
					</c:forEach>
					<li class="page-item <c:if test='${ (endList-lastListNum) / 10 == 0 }'> disabled</c:if>">
						<a class="page-link" href="manageroom?type=show
						<c:if test="${ !empty param.searchField && !empty param.searchKeyword }">
							&searchField=${ param.searchField }&searchKeyword=${ param.searchKeyword }
						</c:if>
						&pIndex=${ endList+1 }"> 
							<span class="lnr lnr-arrow-right"></span>
						</a>
					</li>
				</ul>
				<br><br><br><br><br><br>
			</div>
		</div>
	</div>

</body>
</html>