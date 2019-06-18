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
import dao.UserDAO;

@WebServlet("/UserSearch")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("UserSearch.html");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		UserDAO uDao = UserDAO.getInstance();
		HotelVO hVo = new HotelVO();
		
		if(request.getParameter("searchKeyword") != null) { // �˻��� ������ �ִٸ�.
			String category = request.getParameter("searchField");
			String keyword =  request.getParameter("searchKeyword");

			request.setAttribute("lastListNum", bDao.lastPageNum(category,keyword));
			request.setAttribute("startList", bDao.getStartList(pIndexParam));
			request.setAttribute("endList", bDao.getEndList(pIndexParam,category,keyword));
			request.setAttribute("blist", bDao.selectAll(pIndexParam,category,keyword));
			
		} else {//�˻��� ������ ���ٸ�...
			request.setAttribute("lastListNum", bDao.lastPageNum());
			request.setAttribute("startList", bDao.getStartList(pIndexParam));
			request.setAttribute("endList", bDao.getEndList(pIndexParam));
			request.setAttribute("blist", bDao.selectAll(pIndexParam));
		}
	}

}
