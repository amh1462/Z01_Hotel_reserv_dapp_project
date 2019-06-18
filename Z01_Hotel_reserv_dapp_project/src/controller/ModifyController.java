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
	private static final long serialVersionUID = 1L;
	
	public ModifyController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("modify.jsp").forward(request, response);
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
				
				response.sendRedirect("hotelMain.jsp?contentPage=hotelInfo.jsp");
			}else {
				System.out.println(""+hDao.update(hVo));
			}
		}
		
	}	
}
