package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.HotelDAO;
import dto.HotelVO;

@WebServlet("/join")
public class JoinController extends HttpServlet  {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher rd = request.getRequestDispatcher("join.html");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		HotelDAO hDao = HotelDAO.getInstance();
		
		HotelVO hVo = new HotelVO();
		
		hVo.setHotelid(request.getParameter("hotelid"));
		hVo.setPassword(request.getParameter("password"));
		hVo.setHotelname(request.getParameter("hotelname"));
		hVo.setCountry(request.getParameter("country"));
		hVo.setCity(request.getParameter("city"));
		hVo.setDetailaddr(request.getParameter("detailaddr"));
		hVo.setPhone(request.getParameter("phone"));
		hVo.setHwallet(request.getParameter("hwallet"));
		
		if(hDao.insert(hVo)>0) {
			response.sendRedirect("./hotelMain.jsp?contentPage=hotelInfo.jsp");
		}else {
			response.sendRedirect("<script>history.back();</script>");
			
		}
	}
}
