<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호텔나라</title>
</head>

<body>
	<form action="photoInsert" method="post" enctype="multipart/form-data">
	<div style="margin-top:5px;">	 
		<div style="margin-left:13px; margin-top:15px;">
    		<input type="file" name="photo">
		</div>
		<div style="margin-left:13px; margin-top:15px;" >
    		<input type="file" name="photo2"> 
			</div>					
		<div style="margin-left:13px; margin-top:15px;" >
    		<input type="file" name="photo3"> 
		</div>
		<div style="margin-left:13px; margin-top:15px;">
    		<input type="file" name="photo4"> 
		</div>				
		<div style="margin-left:13px; margin-top:15px;">
    		<input type="file" name="photo5"> 
		</div>
		
		<button style="margin-top:15px; margin-left:150px;" class="login100-form-btn">
		insert photo</button>
		<input type="hidden" value="testset">
	</div>
	</form>
</body>
</html>