<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>

</head>

<body>
    <div>
        <form id="user-search">
            <div class="inputs">
                <input type="text" name="city" placeholder="검색">
                <select name="country" id="q" style="padding-right: 10px;">
                    <option value="#" selected>국가</option>
                    <option value="kr">Korea</option>
                    <option value="us">USA</option>
                    <option value="cn">China</option>
                    <option value="jp">Japan</option>
                    <option value="uk">England</option>
                    <option value="aus">Australia</option>
                </select>
            </div>
            <ul>
               <li>방 갯수 : <%= request.getParameter("roomCount") %></li>
            </ul>
    </div>
</body>

</html>