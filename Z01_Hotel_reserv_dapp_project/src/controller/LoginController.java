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
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		
		HotelDAO hDao = HotelDAO.getInstance();
		
		String hotelid = request.getParameter("hotelid");
		String password = request.getParameter("password");
		
		int matchresult = hDao.MachIdPw(hotelid, password); 
		if( matchresult == 1){ 
			HotelVO hVo = hDao.select(hotelid);
			HttpSession session = request.getSession();
			session.setAttribute("hotelid", hotelid);
			session.setAttribute("hotelname", hVo.getHotelname());
			session.setAttribute("city", hVo.getCity());
			session.setAttribute("detailaddr", hVo.getDetailaddr());
			session.setAttribute("hwallet", hVo.getHwallet());
			session.setAttribute("phone", hVo.getPhone());
			session.setAttribute("photo", hVo.getPhoto());
			session.setAttribute("photo2", hVo.getPhoto2());
			session.setAttribute("photo3", hVo.getPhoto3());
			session.setAttribute("photo4", hVo.getPhoto4());
			session.setAttribute("photo5", hVo.getPhoto5());
			session.setAttribute("cancelfee1", hVo.getCancelfee1());
			session.setAttribute("cancelfee2", hVo.getCancelfee2());
			session.setAttribute("cancelfee3", hVo.getCancelfee3());
			session.setAttribute("cancelfee4", hVo.getCancelfee4());
			session.setAttribute("cancelday1", hVo.getCancelday1());
			session.setAttribute("cancelday2", hVo.getCancelday2());
			
			System.out.println(hVo.getPhoto2());
			response.sendRedirect("hotelMain.jsp?contentPage=hotelInfo.jsp");
			
		}else if(matchresult == 0){ // 로그인 매치 
			response.setContentType("text/html; charset=utf-8");
			response.getWriter().println("<script> "
					+ "alert('아이디를 다시 확인하세요.');"
					+ "history.back();"
					+ " </script>");
		}
	}
}
