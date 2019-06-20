package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.ReservDAO;

@WebServlet("/showrservation")
public class ShowReservationController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		ReservDAO resDao = ReservDAO.getInstance();
		String s = request.getParameter("pIndex");
		int resIndexParam = Integer.parseInt((s !=null) ? s : "1");
		if(request.getParameter("no") == null) {
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
			
			request.getRequestDispatcher("hotelMain.jsp?contentPage=bookStatus.jsp").forward(request, response);
		}else {
			request.setAttribute("resVo", resDao.select(request.getParameter("no"),request.getParameter("hotelid")));
			System.out.println("no");
			request.getRequestDispatcher("hotelMain.jsp").forward(request, response);		
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
