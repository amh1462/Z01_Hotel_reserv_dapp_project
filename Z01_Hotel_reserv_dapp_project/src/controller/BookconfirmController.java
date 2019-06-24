package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ReservDAO;

@WebServlet("/bookconfirm")
public class BookconfirmController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BookconfirmController() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		ReservDAO uresDao = ReservDAO.getInstance();
		HttpSession session = request.getSession();
		String phone = (String)session.getAttribute("phone");
		String guestname = (String)session.getAttribute("guestname");
		String email = (String)session.getAttribute("email");
		
		String s = request.getParameter("resIndex");
		
		int resIndexParam = Integer.parseInt((s !=null)? s: "1");
		
			request.setAttribute("lastListNum", uresDao.userLastPageNum(phone));
			request.setAttribute("startList", uresDao.getStartList(resIndexParam));
			request.setAttribute("endList", uresDao.getUserEndList(resIndexParam, phone));
			request.setAttribute("ureslist", uresDao.userSelectAll(resIndexParam, guestname, phone, email));
		
		request.getRequestDispatcher("userbookstatus.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		ReservDAO uresDao = ReservDAO.getInstance();
		
		HttpSession session = request.getSession();
		
		String phone = request.getParameter("phone");
		String guestname = request.getParameter("guestname");
		String email = request.getParameter("email");
		
		session.setAttribute("phone", phone);
		session.setAttribute("guestname", guestname);
		session.setAttribute("email", email);
		
		String s = request.getParameter("resIndex");
		
		int resIndexParam = Integer.parseInt((s !=null)? s: "1");
		
			request.setAttribute("lastListNum", uresDao.userLastPageNum(phone));
			request.setAttribute("startList", uresDao.getStartList(resIndexParam));
			request.setAttribute("endList", uresDao.getUserEndList(resIndexParam, phone));
			request.setAttribute("ureslist", uresDao.userSelectAll(resIndexParam, guestname, phone, email));
		
		request.getRequestDispatcher("userbookstatus.jsp").forward(request, response);

	}
}
