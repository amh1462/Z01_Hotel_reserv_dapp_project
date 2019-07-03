package controller.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.HotelDAO;
import dao.ReservDAO;
import dto.HotelVO;

@WebServlet("/reservConfirm")
public class ReservConfirmController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HotelDAO hDao = HotelDAO.getInstance();
		HotelVO hVo = new HotelVO();
		
		if(request.getParameter("hotelid") != null) { // ajax로 cancelfee 정보 요청했을 때
			hVo = hDao.select(request.getParameter("hotelid"));
			response.setContentType("text/html; charset=utf-8");
			response.getWriter().println(hVo.getCancelfee1());
			response.getWriter().println(hVo.getCancelfee2());
			response.getWriter().println(hVo.getCancelfee3());
			response.getWriter().println(hVo.getCancelfee4());
			response.getWriter().println(hVo.getCancelday1());
			response.getWriter().println(hVo.getCancelday2());
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		ReservDAO uresDao = ReservDAO.getInstance();
		
		// userReservConfirm.jsp에서 이름, 연락처, 이메일 적고 예약확인을 눌렀을 때
		String phone = request.getParameter("phone");
		String guestname = request.getParameter("guestname");
		String email = request.getParameter("email");
		
		request.setAttribute("phone", phone);
		request.setAttribute("guestname", guestname);
		request.setAttribute("email", email);
		
		String s = request.getParameter("resIndex");
		
		int resIndexParam = Integer.parseInt((s !=null)? s: "1");
		
		// 해당 이름, 연락처, 이메일에 대한 list를 보내줌.
		request.setAttribute("lastListNum", uresDao.userLastPageNum(phone));
		request.setAttribute("startList", uresDao.getStartList(resIndexParam));
		request.setAttribute("endList", uresDao.getUserEndList(resIndexParam, phone));
		request.setAttribute("ureslist", uresDao.userSelectAll(resIndexParam, guestname, phone, email));
		
		request.getRequestDispatcher("userReservList.jsp").forward(request, response);

	}
}
