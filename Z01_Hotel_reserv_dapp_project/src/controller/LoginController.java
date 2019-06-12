package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.HotelDAO;
import dto.HotelVO;

@WebServlet("/login")
public class LoginController extends HttpServlet  {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		
		HotelDAO hDao = HotelDAO.getInstance();
		
		String hotelid = request.getParameter("hotelid");
		String password = request.getParameter("password");
		
		int matchresult = hDao.MachIdPw(hotelid, password); 
		if( matchresult == 1){ // 아이디에 대한 비밀번호의 일치여부 판단			
			HotelVO hVo = hDao.select(hotelid);
			HttpSession session = request.getSession();
			session.setAttribute("hotelid", hotelid);
			session.setAttribute("hotelname", hVo.getHotelname());
			session.setAttribute("city", hVo.getCity());
			session.setAttribute("detailaddr", hVo.getDetailaddr());
			session.setAttribute("wallet", hVo.getHwallet());
			session.setAttribute("phone", hVo.getPhone());
			session.setAttribute("photo", hVo.getPhoto());
			
			
			
			response.sendRedirect("hotelMain.jsp?contentPage=hotelInfo.jsp");
			
		}else if(matchresult == 0){ // 아이디에 대한 비밀번호의 일치여부 판단			
			response.setContentType("text/html; charset=utf-8");
			response.getWriter().println("<script> "
					+ "alert('아이디 혹은 비밀번호가 틀립니다.');"
					+ "history.back();"
					+ " </script>");
		}
	}
}
