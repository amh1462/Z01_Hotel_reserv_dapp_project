package controller.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.HotelDAO;

@WebServlet("/userSearch")
public class UserSearchController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		HotelDAO hDao = HotelDAO.getInstance();

		// userSearch.html에서 도시를 검색했을 때
		String pIdx = request.getParameter("pIndex");
		int pIndexParam = Integer.parseInt((pIdx != null) ? pIdx : "1");

		String keyword = request.getParameter("city");

		// keyword(도시 이름)에 맞는 호텔을 List로 전달.
		request.setAttribute("hlist", hDao.selectAll(keyword));
		
		RequestDispatcher rd = request.getRequestDispatcher("userHotelList.jsp");
		rd.forward(request, response);

	}

}
