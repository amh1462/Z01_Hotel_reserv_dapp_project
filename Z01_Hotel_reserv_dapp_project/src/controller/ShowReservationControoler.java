package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ReservDAO;


@WebServlet("/showrservation")
public class ShowReservationControoler extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ReservDAO resDao = ReservDAO.getInstance();
		String s = request.getParameter("resIndex");
		
		
		int resIndexParam = Integer.parseInt((s !=null) ? s : "1");
	
		if(request.getParameter("no") == null) {
			if(request.getParameter("searchKeyword") !=null) {
				String category = request.getParameter("searchField");
				String keyword = request.getParameter("searchKeyword");
				
				request.setAttribute("lastListNum", resDao.lastPageNum(category,keyword));
				request.setAttribute("startList", resDao.getStartList(resIndexParam));
				request.setAttribute("endList", resDao.getEndList(resIndexParam,category,keyword));
				request.setAttribute("reslist", resDao.selectAll(resIndexParam,category,keyword));
			}else {
				request.setAttribute("lastListNum", resDao.lastPageNum());
				request.setAttribute("startList", resDao.getStartList(resIndexParam));
				request.setAttribute("endList", resDao.getEndList(resIndexParam));
				request.setAttribute("reslist", resDao.selectAll(resIndexParam));
			}
			
			request.getRequestDispatcher("hotelMain.jsp?contentPage=bookStatus.jsp").forward(request, response);
		}else {
			request.setAttribute("resVo", resDao.select(request.getParameter("no")));
			System.out.println("no");
			request.getRequestDispatcher("hotelMain.jsp").forward(request, response);		
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
