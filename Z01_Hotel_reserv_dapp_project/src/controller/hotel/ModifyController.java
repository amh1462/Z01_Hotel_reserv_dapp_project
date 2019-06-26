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
import dto.HotelVO;
import dto.RoomVO;

@WebServlet("/modify")
public class ModifyController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type = (String)request.getParameter("type");
		if(type.equals("hotel")) {
			HotelDAO hDao = HotelDAO.getInstance();
			HttpSession session = request.getSession();
			String hotelId = (String)session.getAttribute("hotelid");
			
			request.setAttribute("hotelname", hDao.select(hotelId).getHotelname());
			request.setAttribute("country", hDao.select(hotelId).getCountry());
			request.setAttribute("city", hDao.select(hotelId).getCity());
			request.setAttribute("detailaddr", hDao.select(hotelId).getDetailaddr());
			request.setAttribute("phone", hDao.select(hotelId).getPhone());
			request.setAttribute("hwallet", hDao.select(hotelId).getHwallet());
			request.setAttribute("cancelfee1", hDao.select(hotelId).getCancelfee1());
			request.setAttribute("cancelfee2", hDao.select(hotelId).getCancelfee2());
			request.setAttribute("cancelfee3", hDao.select(hotelId).getCancelfee3());
			request.setAttribute("cancelfee4", hDao.select(hotelId).getCancelfee4());
			request.setAttribute("cancelday1", hDao.select(hotelId).getCancelday1());
			request.setAttribute("cancelday2", hDao.select(hotelId).getCancelday2());
			
			request.getRequestDispatcher("hotelMain.jsp?contentPage=modify.jsp").forward(request, response);
		} else if(type.equals("room")){
			// 객실 수정 눌렀을 때 여기로 오니까 수정 창에 객실 정보 담아서 보내주면 됨.
			RoomDAO rDao = RoomDAO.getInstance();
			String rNum = (String)request.getParameter("no");
			request.setAttribute("rvo", rDao.selectOne(rNum));
			request.getRequestDispatcher("hotelMain.jsp?contentPage=roomModify.jsp").forward(request, response);
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		String uploadPath = request.getServletContext().getRealPath("/uploadFiles");
		MultipartRequest multi = new MultipartRequest(request, uploadPath, 10 * 1024 * 1024 /*(1MB)*/ ,
													 "utf-8", new DefaultFileRenamePolicy());
		
		String hiddenValue = (String)multi.getParameter("hiddenValue");
		System.out.println("히든밸류: "+hiddenValue);
		HttpSession session = request.getSession();
		
		if(hiddenValue.equals("hotel")) {
			HotelDAO hDao = HotelDAO.getInstance();
			HotelVO hVo = new HotelVO();
			
			if(multi.getParameter("password").trim().length() !=0) {
				hVo.setPassword(multi.getParameter("password"));
			}
			
			hVo.setHotelname(multi.getParameter("hotelname"));
			hVo.setCountry(multi.getParameter("country"));
			hVo.setCity(multi.getParameter("city"));
			hVo.setDetailaddr(multi.getParameter("detailaddr"));
			hVo.setPhone(multi.getParameter("phone"));
			hVo.setHwallet(multi.getParameter("hwallet"));
			hVo.setHotelid((String)session.getAttribute("hotelid"));
			
			hVo.setCancelfee1(multi.getParameter("cancelfee1"));
			hVo.setCancelfee2(multi.getParameter("cancelfee2"));
			hVo.setCancelfee3(multi.getParameter("cancelfee3"));
			hVo.setCancelfee4(multi.getParameter("cancelfee4"));
			hVo.setCancelday1(multi.getParameter("cancelday1"));
			hVo.setCancelday2(multi.getParameter("cancelday2"));
			
			if(hDao.update(hVo)>0) {
				session.setAttribute("hotelname", hVo.getHotelname());
				session.setAttribute("country", hVo.getCountry());
				session.setAttribute("city", hVo.getCity());
				session.setAttribute("detailaddr", hVo.getDetailaddr());
				session.setAttribute("phone", hVo.getPhone());
				session.setAttribute("hwallet", hVo.getHwallet());
				
				session.setAttribute("cancelfee1", hVo.getCancelfee1());
				session.setAttribute("cancelfee2", hVo.getCancelfee2());
				session.setAttribute("cancelfee3", hVo.getCancelfee3());
				session.setAttribute("cancelfee4", hVo.getCancelfee4());
				session.setAttribute("cancelday1", hVo.getCancelday1());
				session.setAttribute("cancelday2", hVo.getCancelday2());
				
				response.setContentType("text/html; charset=utf-8");
				response.getWriter().println("<script>alert('수정이 완료되었습니다.');"
						+ "location.href='hotelMain.jsp?contentPage=hotelInfo.jsp';</script>");
			} else {
				response.setContentType("text/html; charset=utf-8");
				response.getWriter().println("<script>alert('수정에 실패했습니다.');"
						+ "history.back();</script>");
			}
		}
		else if(hiddenValue.equals("room")) { 
			// room modify
			RoomDAO rDao = RoomDAO.getInstance();
			RoomVO rVo = new RoomVO();
			rVo.setRoomno(multi.getParameter("roomno"));
			rVo.setRoomname(multi.getParameter("roomname"));
			rVo.setRoominfo(multi.getParameter("roominfo"));
			rVo.setAllowedman(multi.getParameter("allowedman"));
			rVo.setDailyprice(multi.getParameter("dailyprice"));
			rVo.setWeekendprice(multi.getParameter("weekendprice"));
			rVo.setTotalcount(multi.getParameter("totalcount"));
			rVo.setRestcount(multi.getParameter("restcount"));
			if(multi.getOriginalFileName("photo") == null) {
				String previousPhoto = rDao.selectOne(multi.getParameter("roomno")).getPhoto();
				System.out.println("포토가 널일때");
				rVo.setPhoto(previousPhoto);
			} else {
				rVo.setPhoto("uploadFiles/" + multi.getOriginalFileName("photo"));
			}
			//rVo.setContract(multi.getParameter("contract")); // 어차피 컨트랙트는 그대로..
			
			System.out.println(rVo.toString());
			
			if(rDao.update(rVo) > 0) {
				response.setContentType("text/html; charset=utf-8");
				response.getWriter().println("<script>alert('방 수정이 완료되었습니다.'); location.href='manageroom?type=show';</script>");
			} else {
				response.setContentType("text/html; charset=utf-8");
				response.getWriter().println("<script>alert('DB 등록에 오류가 발생했습니다.\\n 다시 수정해주십시오.'); history.back();</script>");
			}

		}
		
	}	
}
