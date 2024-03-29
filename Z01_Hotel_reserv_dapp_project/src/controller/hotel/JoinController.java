package controller.hotel;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.HotelDAO;
import dto.HotelVO;

@WebServlet("/join")
public class JoinController extends HttpServlet  {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("hotelJoin.html");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		HotelDAO hDao = HotelDAO.getInstance();
		
		HotelVO hVo = new HotelVO();
		
		// hotelJoin.html에서 받은 정보들을 hVo에 넣음.
		hVo.setHotelid(request.getParameter("hotelid"));
		hVo.setPassword(request.getParameter("password"));
		hVo.setHotelname(request.getParameter("hotelname"));
		hVo.setCountry(request.getParameter("country"));
		hVo.setCity(request.getParameter("city"));
		hVo.setDetailaddr(request.getParameter("detailaddr"));
		hVo.setPhone(request.getParameter("phone"));
		hVo.setHwallet(request.getParameter("hwallet"));
		
		hVo.setCancelfee1(request.getParameter("cancelfee1"));
		hVo.setCancelfee2(request.getParameter("cancelfee2"));
		hVo.setCancelfee3(request.getParameter("cancelfee3"));
		hVo.setCancelfee4(request.getParameter("cancelfee4"));
		hVo.setCancelday1(request.getParameter("cancelday1"));
		hVo.setCancelday2(request.getParameter("cancelday2"));
		
		// hVo를 insert 함수에 전달.
		if(hDao.insert(hVo)>0) {
			response.sendRedirect("./hotelLogin.html");
		}else {
			response.setContentType("text/html; charset=utf-8");
			response.getWriter().println("<script> "
					+ "alert('죄송합니다. 오류로 인해 회원가입이 취소되었습니다.');"
					+ "history.back();"
					+ " </script>");
			
		}
	}
}
