package controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.HotelDAO;
import dao.ReservDAO;
import dao.RoomDAO;
import dto.HotelVO;
import dto.ReservVO;
import dto.RoomVO;


@WebServlet("/registerbook")
public class RegisterbookController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public RegisterbookController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		HotelDAO hDao = HotelDAO.getInstance();
		RoomDAO rDao = RoomDAO.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date checkInDate = null;
		Date checkOutDate = null;
		try {
			checkInDate = sdf.parse(request.getParameter("checkin"));
			checkOutDate = sdf.parse(request.getParameter("checkout"));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		long checkin = checkInDate.getTime()/1000;
		long checkout = checkOutDate.getTime()/1000;
		int roomcount= Integer.parseInt(request.getParameter("roomcount"));
		int stayNight = (int)((checkout - checkin) / 86400); // 1일은 86400초, 몇 밤 묵냐를 세야해서 +1 안 해줘도 됨.
		int dailyprice = Integer.parseInt(request.getParameter("dailyprice"));
		int totalprice = dailyprice * stayNight * roomcount;
		HotelVO selectedHotelVO = hDao.select(request.getParameter("hotelid"));
		RoomVO selectedRoomVO = rDao.selectOne(request.getParameter("roomno"));
		
		request.setAttribute("stayNight", Integer.toString(stayNight));
		request.setAttribute("totalprice", Integer.toString(totalprice));
		request.setAttribute("checkin", request.getParameter("checkin"));
		request.setAttribute("checkout", request.getParameter("checkout"));
		request.setAttribute("roomcount", request.getParameter("roomcount"));
		request.setAttribute("country", request.getParameter("country"));
		request.setAttribute("hotelinfo", selectedHotelVO);
		request.setAttribute("roominfo", selectedRoomVO);
		
		double cancelPriceTheDay = (totalprice/100.0) * Integer.parseInt(selectedHotelVO.getCancelfee1());
		double cancelPriceOneDay = (totalprice/100.0) * Integer.parseInt(selectedHotelVO.getCancelfee2());
		double cancelPriceSetDay1 = (totalprice/100.0) * Integer.parseInt(selectedHotelVO.getCancelfee3());
		double cancelPriceSetDay2 = (totalprice/100.0) * Integer.parseInt(selectedHotelVO.getCancelfee4());
		
		request.setAttribute("cancelPriceTheDay", (int)cancelPriceTheDay);
		request.setAttribute("cancelPriceOneDay", (int)cancelPriceOneDay);
		request.setAttribute("cancelPriceSetDay1", (int)cancelPriceSetDay1);
		request.setAttribute("cancelPriceSetDay2", (int)cancelPriceSetDay2);
		
		request.getRequestDispatcher("registerbook.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		ReservDAO resDao = ReservDAO.getInstance();
		ReservVO resVo = new ReservVO();
		
		resVo.setRoomno(request.getParameter("roomno"));
		resVo.setHotelid(request.getParameter("hotelid"));
		resVo.setGuestname(request.getParameter("guestname"));
		resVo.setEmail(request.getParameter("email"));
		resVo.setPhone(request.getParameter("phone"));
		resVo.setUwallet(request.getParameter("uwallet"));
		resVo.setTotalprice(request.getParameter("totalprice"));
		resVo.setOrdernum(request.getParameter("roomcount"));
		resVo.setContract(request.getParameter("contract"));
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date checkInDate = null;
		Date checkOutDate = null;
		try {
			checkInDate = sdf.parse(request.getParameter("checkin"));
			checkOutDate = sdf.parse(request.getParameter("checkout"));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		long checkin = checkInDate.getTime()/1000;
		long checkout = checkOutDate.getTime()/1000;
		
		resVo.setCheckin(Long.toString(checkin));
		resVo.setCheckout(Long.toString(checkout));
		
		if(resDao.insert(resVo)>0) {
			response.setContentType("text/html; charset=utf-8");
			response.getWriter().println("<script> "
					+ "alert('예약이 완료되었습니다.');"
					+ "location.href='./payComplete.html';"
					+ " </script>");
		}else {
			response.setContentType("text/html; charset=utf-8");
			response.getWriter().println("<script> "
					+ "alert('죄송합니다. 오류로 인해 예약 처리되지 않았습니다.');"
					+ "history.back();"
					+ " </script>");
			
		}
	}

}
