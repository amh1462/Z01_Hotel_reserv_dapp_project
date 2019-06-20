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
<<<<<<< HEAD
	
=======
		
		HotelDAO hDao = HotelDAO.getInstance();
		
<<<<<<< HEAD
		/*
		if(request.getParameter("city") != null) { // 검색한 내용이 있다면.
=======
		
		if(request.getParameter("city") != null) { // °Ë»öÇÑ ³»¿ëÀÌ ÀÖ´Ù¸é.
>>>>>>> branch 'develop' of https://github.com/amh1462/Z01_Hotel_reserv_dapp_project
			String category = request.getParameter("searchField");
			String keyword =  request.getParameter("city");

			request.setAttribute("lastListNum", bDao.lastPageNum(category,keyword));
			request.setAttribute("startList", bDao.getStartList(pIndexParam));
			request.setAttribute("endList", bDao.getEndList(pIndexParam,category,keyword));
			request.setAttribute("blist", bDao.selectAll(pIndexParam,category,keyword));
			
		} else {//°Ë»öÇÑ ³»¿ëÀÌ ¾ø´Ù¸é...
			request.setAttribute("lastListNum", bDao.lastPageNum());
			request.setAttribute("startList", bDao.getStartList(pIndexParam));
			request.setAttribute("endList", bDao.getEndList(pIndexParam));
			request.setAttribute("blist", bDao.selectAll(pIndexParam));
		}
		*/
		//if(request.getParameter(""))
>>>>>>> branch 'develop' of https://github.com/amh1462/Z01_Hotel_reserv_dapp_project
	}

}
