package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.HotelDAO;
import dao.UserDAO;
import oracle.net.aso.s;

@WebServlet("/UserSearch")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		UserDAO uDao = UserDAO.getInstance();

		String s = request.getParameter("pIndex");
		int pIndexParam = Integer.parseInt((s != null) ? s : "1");

		String keyword = request.getParameter("city");

//		request.setAttribute("lastListNum", uDao.lastPageNum(keyword));
//		request.setAttribute("startList", uDao.getStartList(pIndexParam));
//		request.setAttribute("endList", uDao.getEndList(pIndexParam, keyword));
		request.setAttribute("hlist", uDao.selectAll(keyword));
		
		RequestDispatcher rd = request.getRequestDispatcher("userSearch.jsp");
		rd.forward(request, response);

	}

}
