package controller.hotel;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ReservDAO;

@WebServlet("/showReservation")
public class ShowReservationController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ReservDAO resDao = ReservDAO.getInstance();
		String s = request.getParameter("resIndex");
		
		int resIndexParam = Integer.parseInt((s !=null) ? s : "1");
		
		if(request.getParameter("withdrawOk") != null) { // ajax로 withdraw여부 체크
			String msg = resDao.updateIsWithdraw(request.getParameter("resno"));
			response.setContentType("text/html; charset=utf-8");
			response.getWriter().println(msg); 	

		}
		else if(request.getParameter("cancelOk") != null) { // ajax로 cancel여부 체크
			String msg = resDao.updateIsCancel(request.getParameter("resno"));
			response.setContentType("text/html; charset=utf-8");
			response.getWriter().println(msg);
		}
		else { // 예약 현황 눌렀을 때
			if(request.getParameter("searchKeyword") !=null) {
				String category = request.getParameter("searchField");
				String keyword = request.getParameter("searchKeyword");
				String hotelid = request.getParameter("hotelid");
				request.setAttribute("lastListNum", resDao.lastPageNum(category,keyword,hotelid));
				request.setAttribute("startList", resDao.getStartList(resIndexParam));
				request.setAttribute("endList", resDao.getEndList(resIndexParam,category,keyword,hotelid));
				request.setAttribute("reslist", resDao.selectAll(resIndexParam,category,keyword,hotelid));
			}else {
				HttpSession session = request.getSession();
				String hotelid = (String)session.getAttribute("hotelid");
				request.setAttribute("lastListNum", resDao.lastPageNum(hotelid));
				request.setAttribute("startList", resDao.getStartList(resIndexParam));
				request.setAttribute("endList", resDao.getEndList(resIndexParam,hotelid));
				request.setAttribute("reslist", resDao.selectAll(resIndexParam,hotelid));
			}
			
			request.getRequestDispatcher("hotelMain.jsp?contentPage=hotelReservList.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
