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

@WebServlet("/manageroom")
public class ManageRoomController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type = (String)request.getParameter("type");
		if(type.equals("show")) {
			RoomDAO rDao = RoomDAO.getInstance();
			HttpSession session = request.getSession();
			request.setAttribute("rlist", rDao.selectAll((String)session.getAttribute("hotelid")));
			
			RequestDispatcher rd = request.getRequestDispatcher("./hotelMain.jsp?contentPage=statusRoom.jsp");
			rd.forward(request,response);
		}
		else if(type.equals("register")) {	
			request.getRequestDispatcher("./hotelMain.jsp?contentPage=registerRoom.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("manageroom post");
	}

}
