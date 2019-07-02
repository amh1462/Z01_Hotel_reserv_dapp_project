package controller.user;

import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.HotelDAO;
import dao.RoomDAO;

@WebServlet("/showRoom")
public class ShowRoomController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String hotelId = request.getParameter("hotelId");

		HotelDAO hDao = HotelDAO.getInstance();
		RoomDAO rDao = RoomDAO.getInstance();

		// 이전 페이지에서 가져온 hotelId, checkIn 등을 다시 다음페이지에 들어갈 request에 넣어줌. 
		request.setAttribute("hotelinfo", hDao.select(hotelId));
		request.setAttribute("checkIn", request.getParameter("checkIn"));
		request.setAttribute("checkOut", request.getParameter("checkOut"));
		request.setAttribute("roomCount", request.getParameter("roomCount"));
		request.setAttribute("country", countryNameChange(hDao.select(hotelId).getCountry()));
		
		if(request.getParameter("roomno") == null) { // roomList 전체 보여줌.
			request.setAttribute("roomlist", rDao.selectAll(hotelId));
			request.setAttribute("roomNameList", rDao.selectAll(hotelId));
			
			request.getRequestDispatcher("userRoomList.jsp").forward(request, response);
		} else { // 선택한 room만 보여줌.
			 request.setAttribute("roomlist", rDao.selectOneList(request.getParameter("roomno")));
			 request.setAttribute("roomNameList", rDao.selectAll(hotelId));
			 request.setAttribute("roomno", request.getParameter("roomno"));
			 
			 request.getRequestDispatcher("userRoomList.jsp").forward(request, response);
		}
	}
	
	private String countryNameChange(String country) {
		String result = "";
		switch(country) {
		case "kr":
			result = "대한민국";
			break;
		case "us":
			result = "미 국";
			break;
		case "cn":
			result = "중 국";
			break;
		case "jp":
			result = "일 본";
			break;
		case "uk":
			result = "영 국";
			break;
		case "aus":
			result = "호 주";
			break;
		case "fr":
			result = "프랑스";
			break;
		}
		return result;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// showroom post
	}

}