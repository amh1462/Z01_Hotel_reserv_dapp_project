package controller.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.HotelDAO;
import dao.ReservDAO;
import dto.HotelVO;

@WebServlet("/bookconfirm")
public class BookconfirmController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BookconfirmController() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HotelDAO hDao = HotelDAO.getInstance();
		HotelVO hVo = new HotelVO();
		
		if(request.getParameter("hotelid") != null) {
			hVo = hDao.select(request.getParameter("hotelid"));
			response.setContentType("text/html; charset=utf-8");
			response.getWriter().println(hVo.getCancelfee1());
			response.getWriter().println(hVo.getCancelfee2());
			response.getWriter().println(hVo.getCancelfee3());
			response.getWriter().println(hVo.getCancelfee4());
			response.getWriter().println(hVo.getCancelday1());
			response.getWriter().println(hVo.getCancelday2());
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		ReservDAO uresDao = ReservDAO.getInstance();
		
		HttpSession session = request.getSession();
		
		String phone = request.getParameter("phone");
		String guestname = request.getParameter("guestname");
		String email = request.getParameter("email");
		
		request.setAttribute("phone", phone);
		request.setAttribute("guestname", guestname);
		request.setAttribute("email", email);
		
		String s = request.getParameter("resIndex");
		
		int resIndexParam = Integer.parseInt((s !=null)? s: "1");
		
			request.setAttribute("lastListNum", uresDao.userLastPageNum(phone));
			request.setAttribute("startList", uresDao.getStartList(resIndexParam));
			request.setAttribute("endList", uresDao.getUserEndList(resIndexParam, phone));
			request.setAttribute("ureslist", uresDao.userSelectAll(resIndexParam, guestname, phone, email));
		
		request.getRequestDispatcher("userbookstatus.jsp").forward(request, response);

	}
}
