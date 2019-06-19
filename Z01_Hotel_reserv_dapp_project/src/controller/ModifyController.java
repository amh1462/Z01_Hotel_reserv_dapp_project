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

@WebServlet("/modify")
public class ModifyController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HotelDAO hDao = HotelDAO.getInstance();
		HttpSession session = request.getSession();
		String hotelId = (String)session.getAttribute("hotelid");
		
		request.setAttribute("hotelname", hDao.select(hotelId).getHotelname());
		request.setAttribute("country", hDao.select(hotelId).getCountry());
		request.setAttribute("city", hDao.select(hotelId).getCity());
		request.setAttribute("detailaddr", hDao.select(hotelId).getDetailaddr());
		request.setAttribute("phone", hDao.select(hotelId).getPhone());
		request.setAttribute("hwallet", hDao.select(hotelId).getHwallet());
		request.setAttribute("cancelfee1", hDao.select(hotelId).getCancelfee1());
		request.setAttribute("cancelfee2", hDao.select(hotelId).getCancelfee2());
		request.setAttribute("cancelfee3", hDao.select(hotelId).getCancelfee3());
		request.setAttribute("cancelfee4", hDao.select(hotelId).getCancelfee4());
		request.setAttribute("cancelday1", hDao.select(hotelId).getCancelday1());
		request.setAttribute("cancelday2", hDao.select(hotelId).getCancelday2());
		request.getRequestDispatcher("hotelMain.jsp?contentPage=modify.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		HotelDAO hDao = HotelDAO.getInstance();
		HttpSession session = request.getSession();
		if(request.getParameter("hiddenValue") != null) {
			System.out.println(request.getParameter("hiddenValue"));
			HotelVO hVo = new HotelVO();
			
			if(request.getParameter("password").trim().length() !=0) {
				hVo.setPassword(request.getParameter("password"));
			}
			
			hVo.setHotelname(request.getParameter("hotelname"));
			hVo.setCountry(request.getParameter("country"));
			hVo.setCity(request.getParameter("city"));
			hVo.setDetailaddr(request.getParameter("detailaddr"));
			hVo.setPhone(request.getParameter("phone"));
			hVo.setHwallet(request.getParameter("hwallet"));
			hVo.setHotelid((String)session.getAttribute("hotelid"));
			
			hVo.setCancelfee1(request.getParameter("cancelfee1"));
			hVo.setCancelfee2(request.getParameter("cancelfee2"));
			hVo.setCancelfee3(request.getParameter("cancelfee3"));
			hVo.setCancelfee4(request.getParameter("cancelfee4"));
			hVo.setCancelday1(request.getParameter("cancelday1"));
			hVo.setCancelday2(request.getParameter("cancelday2"));
			
			if(hDao.update(hVo)>0) {
				session.setAttribute("hotelname", hVo.getHotelname());
				session.setAttribute("country", hVo.getCountry());
				session.setAttribute("city", hVo.getCity());
				session.setAttribute("detailaddr", hVo.getDetailaddr());
				session.setAttribute("phone", hVo.getPhone());
				session.setAttribute("hwallet", hVo.getHwallet());
				
				session.setAttribute("cancelfee1", hVo.getCancelfee1());
				session.setAttribute("cancelfee2", hVo.getCancelfee2());
				session.setAttribute("cancelfee3", hVo.getCancelfee3());
				session.setAttribute("cancelfee4", hVo.getCancelfee4());
				session.setAttribute("cancelday1", hVo.getCancelday1());
				session.setAttribute("cancelday2", hVo.getCancelday2());
				
				response.sendRedirect("hotelMain.jsp?contentPage=hotelInfo.jsp");
			}else {
				System.out.println(""+hDao.update(hVo));
			}
		}
		
	}	
}
