package controller.hotel;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.HotelDAO;
import dao.RoomDAO;
import dto.RoomVO;

@WebServlet("/manageRoom")
public class ManageRoomController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HotelDAO hDao = HotelDAO.getInstance();
		HttpSession session = request.getSession();
		String hotelId = (String)session.getAttribute("hotelid");
		
		String type = (String)request.getParameter("type");
		if(type.equals("show")) {
			RoomDAO rDao = RoomDAO.getInstance();
			String pidx = request.getParameter("pIndex");
			
			int pIndexParam = Integer.parseInt( (pidx!=null) ? pidx : "1" ); //pidx가 없으면 1페이지로 자동으로 가게.. 있으면 해당 페이지로..
			String category = request.getParameter("searchField");
			String keyword = request.getParameter("searchKeyword");

			// room list를 List타입으로 전달.
			request.setAttribute("rlist", rDao.selectAll(hotelId, pIndexParam, category, keyword));
			request.setAttribute("startList", rDao.getStartList(pIndexParam)); // 1, 11, 21 같은 첫 index 판별.
			request.setAttribute("endList", rDao.lastPageNum(hotelId, category, keyword) < rDao.getEndList(pIndexParam) ? 
					rDao.lastPageNum(hotelId, category, keyword) : rDao.getEndList(pIndexParam)); // 10, 20, 30 같은 마지막 index 판별.
			request.setAttribute("lastListNum", rDao.lastPageNum(hotelId, category, keyword)); // 제일 끝 index 판별.
			request.setAttribute("pIndex", Integer.toString(pIndexParam));
			
			request.getRequestDispatcher("./hotelMain.jsp?contentPage=hotelRoomList.jsp").forward(request,response);
		}
		else if(type.equals("register")) {	
			request.getRequestDispatcher("./hotelMain.jsp?contentPage=hotelRegisterRoom.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String uploadPath = request.getServletContext().getRealPath("/uploadFiles");
		int maxPostSize = 10 * 1024 * 1024;
		
		// 방 등록 시, 사진도 등록하기 때문에 request를 Multipart로 바꿔서 사용함. 
		MultipartRequest multi = new MultipartRequest(request, uploadPath, maxPostSize,
													 "utf-8", new DefaultFileRenamePolicy());
		
		HttpSession session = request.getSession();
		RoomVO rVo = new RoomVO();
		RoomDAO rDao = RoomDAO.getInstance();
		
		// hotelRegisterRoom.jsp에서 받아온 정보들을 rVo에 저장.
		rVo.setHotelid((String)session.getAttribute("hotelid"));
		rVo.setRoomname(multi.getParameter("roomname"));
		rVo.setRoominfo(multi.getParameter("roominfo"));
		rVo.setAllowedman(multi.getParameter("allowedman"));
		rVo.setDailyprice(multi.getParameter("dailyprice"));
		rVo.setWeekendprice(multi.getParameter("weekendprice"));
		rVo.setTotalcount(multi.getParameter("totalcount"));
		rVo.setRestcount(multi.getParameter("totalcount"));
		rVo.setPhoto("uploadFiles/" + multi.getOriginalFileName("photo"));
		rVo.setContract(multi.getParameter("contract"));
		System.out.println(rVo.toString());
		
		// rVo를 insert 함수에 전달.
		if(rDao.insert(rVo) > 0) {
			response.setContentType("text/html; charset=utf-8");
			response.getWriter().println("<script>alert('방 등록이 완료되었습니다.'); location.href='manageRoom?type=show';</script>");
		} else {
			response.setContentType("text/html; charset=utf-8");
			response.getWriter().println("<script>alert('DB 등록에 오류가 발생했습니다.\n 다시 등록해주십시오.'); history.back();</script>");
		}
	}

}
