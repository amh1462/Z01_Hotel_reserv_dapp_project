<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<%
	request.setCharacterEncoding("UTF-8");
%>
<html>

<head>
    <meta charset="UTF-8">
    <link rel='stylesheet' href='css/User/userSearch.css' type='text/css' media='all' />
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
    <link rel='stylesheet' href='css/User/jquery.rateyo.min.css' type='text/css' media='all' />
    <link rel='stylesheet' href='css/User/jquery.mmenu.all.css' type='text/css' media='all' />
    <link rel='stylesheet' href='css/User/bootstrap-grid.css' type='text/css' media='all' />
    <link rel='stylesheet' href='fonts/web-icons/web-icons.min.css' type='text/css' media='all' />
</head>

<body class="loaded">
    <div class="site-all">
        <div id="header">
            <div class="row-header">
                <div class="container">
                    <h1 class="slogan">Hotelnara</h1>
                    <form id="search-form" method="POST">
                        <center><div class="inputs" name="searchKeyword">
                            <input type="text" name="city" placeholder="<%= request.getParameter("city") %>">
                            <select name="country" id="q" style="padding-right: 10px;">
                                <option value="#" selected>국가</option>
                                <option value="kr">Korea</option>
                                <option value="us">USA</option>
                                <option value="cn">China</option>
                                <option value="jp">Japan</option>
                                <option value="uk">England</option>
                                <option value="aus">Australia</option>
                            </select>
                        </div></center>
                        <center><ul>
                            <label>Check In : <%= request.getParameter("t-start") %></label>
                            <label>Check Out : <%= request.getParameter("t-end") %></label>
                            <label>방 갯수 : <%= request.getParameter("roomCount") %></label>
                        </ul></center>
                        <div>
                            <div class="blank_top"></div>
                            <article class="hotelSearch">
                                <div class="">
                                    <section class="imgSection">
                                        <div>
                                            <img class="hotelImg" src="css/User/content/hotelSample.jpg">
                                        </div>
                                    </section>
                                    <section class="">
                                        <div class="hotelInfo">
                                            <li class="hotelName">호텔명 : 
                                                asldjfoajsdslkfjlkajflkjaslkdjflkajsdlkfjadjflkjaslkdjflajsdf</li>
                                            <li class="hotelName">호텔주소 : </li>
                                            <li class="hotelName">호텔 연락처 :  </li>
                                            <li class="hotelName">최소요금 :  </li>
                                        </div>
                                    </section>
                                    <section class="hotelBtnSection">
                                        <center><input class="hotelBtn" type="button" value="방 선택"></center>
                                    </section>
                                </div>
                            </article>
                            <div class="blank_mid"></div>
                            <article class="hotelSearch">
                                <div class="">
                                    <section class="imgSection">
                                        <div>
                                            <img class="hotelImg" src="css/User/content/hotelSample.jpg">
                                        </div>
                                    </section>
                                    <section class="">
                                        <div class="hotelInfo">
                                            <div class="hotelInfo">
                                            <li class="hotelName">호텔명 : 
                                                asldjfoajsdslkfjlkajflkjaslkdjflkajsdlkfjadjflkjaslkdjflajsdf</li>
                                            <li class="hotelName">호텔주소 : </li>
                                            <li class="hotelName">호텔 연락처 :  </li>
                                            <li class="hotelName">최소요금 :  </li>
                                        </div>
                                        </div>
                                    </section>
                                    <section class="hotelBtnSection">
                                        <center><input class="hotelBtn" type="button" value="방 선택"></center>
                                    </section>
                                </div>
                            </article>
                            <div class="blank_mid"></div>
                            <article class="hotelSearch">
                                <div class="">
                                    <section class="imgSection">
                                        <div>
                                            <img class="hotelImg" src="css/User/content/hotelSample.jpg">
                                        </div>
                                    </section>
                                    <section class="">
                                        <div class="hotelInfo">
                                            <div class="hotelInfo">
                                            <li class="hotelName">호텔명 : 
                                                asldjfoajsdslkfjlkajflkjaslkdjflkajsdlkfjadjflkjaslkdjflajsdf</li>
                                            <li class="hotelName">호텔주소 : </li>
                                            <li class="hotelName">호텔 연락처 :  </li>
                                            <li class="hotelName">최소요금 :  </li>
                                        </div>
                                        </div>
                                    </section>
                                    <section class="hotelBtnSection">
                                        <center><input class="hotelBtn" type="button" value="방 선택"></center>
                                    </section>
                                </div>
                            </article>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script type='text/javascript' src='js/User/jquery.js'></script>
    <script type='text/javascript' src='js/User/superfish.min.js'></script>
    <script type='text/javascript' src='js/User/jquery.sumoselect.min.js'></script>
    <script type='text/javascript' src='js/User/owl.carousel.min.js'></script>
    <script type='text/javascript' src='js/User/init.js'></script>
</body>

</html>