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
import dto.RoomVO;

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
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		RoomVO rVo = new RoomVO();
		RoomDAO rDao = RoomDAO.getInstance();
		
		rVo.setHotelid((String)session.getAttribute("hotelid"));
		rVo.setRoomname(request.getParameter("roomname"));
		rVo.setRoominfo(request.getParameter("roominfo"));
		rVo.setAllowedman(request.getParameter("allowedman"));
		rVo.setDailyprice(request.getParameter("dailyprice"));
		rVo.setWeekendprice(request.getParameter("weekendprice"));
		rVo.setTotalcount(request.getParameter("totalcount"));
		rVo.setRestcount(request.getParameter("totalcount"));
		rVo.setPhoto(request.getParameter("photo"));
		rVo.setContract(request.getParameter("contract"));
		System.out.println(rVo.toString());
		
		if(rDao.insert(rVo) > 0) {
			response.setContentType("text/html; charset=utf-8");
			response.getWriter().println("<script>alert('방 등록이 완료되었습니다.'); location.href='manageroom?type=show';</script>");
		} else {
			response.setContentType("text/html; charset=utf-8");
			response.getWriter().println("<script>alert('DB 등록에 오류가 발생했습니다.\n 다시 등록해주십시오.'); history.back();</script>");
		}
	}

}
