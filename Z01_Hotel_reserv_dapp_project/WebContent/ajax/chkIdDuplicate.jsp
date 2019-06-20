<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="dao.DBConn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//ajax로 호출된 페이지
	// 먼저 파라미터를 받아보자.
	
	String id = request.getParameter("hotelid");
	if( id != null){
		//db에서 id가 있는지 어떻게 체크할까?
		Statement stmt = DBConn.getInstance().createStatement();
		ResultSet rs = stmt.executeQuery("select * from hotel where hotelid = '"+ id +"'");
		if(rs.next()){
			out.write("ajaxResult(1)");
		} else {
			out.write("ajaxResult(0)");
		}
		rs.close();
		stmt.close();		
	}	
	//out.write(request.getParameter("id")+"<hr>");
	//out.write("이미 있는 아이디입니다.");
	//out.write("사용할 수 있는 아이디입니다.");
%>