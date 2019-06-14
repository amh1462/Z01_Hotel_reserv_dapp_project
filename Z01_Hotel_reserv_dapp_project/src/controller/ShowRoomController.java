package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.RoomDAO;

@WebServlet("/showroom")
public class ShowRoomController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RoomDAO rDao = RoomDAO.getInstance();
		HttpSession session = request.getSession();
		System.out.println((String)session.getAttribute("hotelid"));
		request.setAttribute("rlist", rDao.selectAll((String)session.getAttribute("hotelid")));
		
		RequestDispatcher rd = request.getRequestDispatcher("./hotelMain.jsp?contentPage=statusRoom.jsp");
		rd.forward(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("여기?");
	}

}
