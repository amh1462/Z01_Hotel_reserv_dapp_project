package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.HotelVO;
import dao.HotelDAO;

@WebServlet("/UserSearch")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("UserSearch.html");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		HotelDAO hDao = HotelDAO.getInstance();
		
		
		if(request.getParameter("city") != null) { // 검색한 내용이 있다면.
			String category = request.getParameter("searchField");
			String keyword =  request.getParameter("city");

			request.setAttribute("lastListNum", bDao.lastPageNum(category,keyword));
			request.setAttribute("startList", bDao.getStartList(pIndexParam));
			request.setAttribute("endList", bDao.getEndList(pIndexParam,category,keyword));
			request.setAttribute("blist", bDao.selectAll(pIndexParam,category,keyword));
			
		} else {//검색한 내용이 없다면...
			request.setAttribute("lastListNum", bDao.lastPageNum());
			request.setAttribute("startList", bDao.getStartList(pIndexParam));
			request.setAttribute("endList", bDao.getEndList(pIndexParam));
			request.setAttribute("blist", bDao.selectAll(pIndexParam));
		}
		
		//if(request.getParameter(""))
	}

}
