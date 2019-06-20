package controller;

import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.RoomDAO;

@WebServlet("/showroom")
public class ShowRoomController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("get 방식");
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		
		String hotelid = (String) session.getAttribute("hotelid");

		
		 RoomDAO roDao = RoomDAO.getInstance();
		 String s = request.getParameter("pIndex");
		 
		 int roomIndexParam = Integer.parseInt((s != null) ? s : "1");
		 
		 String rname = request.getParameter("roomname");
		 
		 
		 String rIndexParams = ((rname !=null) ? rname : "스탠다드 더블룸");  
		 
		 System.out.println(rIndexParams);
		 System.out.println(rIndexParams);
		 if(request.getParameter("no") == null) {
			 request.setAttribute("roomlist", roDao.userSelectAll(rIndexParams,hotelid));
			 request.setAttribute("rolist", roDao.userSelect(roomIndexParam, hotelid));
			 request.setAttribute("startList", roDao.getStartList(roomIndexParam));
			 request.setAttribute("endList", roDao.getEndList(roomIndexParam,hotelid));
			 
		 }
	
		request.getRequestDispatcher("userroomlist.jsp").forward(request, response);
}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String hotelid = request.getParameter("hotelid");
		String con = request.getParameter("country");		
		String country = "";
		switch(con) {
		case "kr":
			country = "대한민국";
			break;
		case "us":
			country = "미 국";
			break;
		case "cn":
			country = "중 국";
			break;
		case "jp":
			country = "일 본";
			break;
		case "uk":
			country = "영 국";
			break;
		case "aus":
			country = "호 주";
			break;
		case "fr":
			country = "프랑스";
			break;
		}
		String city = request.getParameter("city");
		String deatailaddr = request.getParameter("detailaddr");
		String checkin = request.getParameter("checkin");
		String checkout = request.getParameter("checkout");
		String hotelname = request.getParameter("hotelname");
		
		long formatted = Long.parseLong(checkin+"000");
		String t= new SimpleDateFormat("yy-MM-dd").format(formatted);
		long formatted2 = Long.parseLong(checkout+"000");
		String t2= new SimpleDateFormat("yy-MM-dd").format(formatted2);
		
		HttpSession session = request.getSession();
		session.setAttribute("checkin", t);
		session.setAttribute("checkout", t2);
		session.setAttribute("hotelid", hotelid);
		session.setAttribute("country", country);
		session.setAttribute("hotelname", hotelname);
		session.setAttribute("city", city);
		session.setAttribute("detailaddr", deatailaddr);
		
		System.out.println(t);
		System.out.println(t2);
		System.out.println(hotelid);
		System.out.println(country);
		System.out.println(hotelname);
		System.out.println(deatailaddr);
		System.out.println(city);
		
		 RoomDAO roDao = RoomDAO.getInstance();
		 String s = request.getParameter("pIndex");
		 
		 int roomIndexParam = Integer.parseInt((s != null) ? s : "1");
		 
		 if(request.getParameter("no") == null) {
			 request.setAttribute("roomlist", roDao.userSelectAll(roomIndexParam,hotelid));
			 request.setAttribute("rolist", roDao.userSelect(roomIndexParam, hotelid));
			 request.setAttribute("startList", roDao.getStartList(roomIndexParam));
			 request.setAttribute("endList", roDao.getEndList(roomIndexParam,hotelid));
			 
		 }
		
		 request.getRequestDispatcher("userroomlist.jsp").forward(request, response);
	}

}