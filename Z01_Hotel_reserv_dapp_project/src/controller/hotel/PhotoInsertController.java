package controller.hotel;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.HotelDAO;
import dto.HotelVO;

@WebServlet("/photoinsert")
public class PhotoInsertController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("write.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		request.setCharacterEncoding("utf-8");
		
		String uploadPath = request.getServletContext().getRealPath("/uploadFiles");
		
		int maxPostSize = 10 * 1024 * 1024;
		

		MultipartRequest multi = new MultipartRequest(request, uploadPath, maxPostSize,
													 "utf-8", new DefaultFileRenamePolicy());
		Enumeration files = multi.getFileNames();
		
		String file01 = (String)files.nextElement();
		String fileName1 = multi.getFilesystemName(file01);
		
		
		String file02 = (String)files.nextElement();
		String fileName2 = multi.getFilesystemName(file02);
		
		
		String file03 = (String)files.nextElement();
		String fileName3 = multi.getFilesystemName(file03);

		
		String file04 = (String)files.nextElement();
		String fileName4 = multi.getFilesystemName(file04);
		
		
		String file05 = (String)files.nextElement();
		String fileName5 = multi.getFilesystemName(file05);
		
				
		HttpSession session = request.getSession();
		HotelDAO hDao = HotelDAO.getInstance();
		HotelVO hVo = new HotelVO();
		
		hVo.setHotelid((String)session.getAttribute("hotelid"));
		
		hVo.setPhoto("uploadFiles/" + fileName1);
		hVo.setPhoto2("uploadFiles/" + fileName2);
		hVo.setPhoto3("uploadFiles/" + fileName3);
		hVo.setPhoto4("uploadFiles/" + fileName4);
		hVo.setPhoto5("uploadFiles/" + fileName5);
		
		
		
		if(hDao.photoUpdate(hVo)>0) {
			
			session.setAttribute("photo", hVo.getPhoto());
			session.setAttribute("photo2", hVo.getPhoto2());
			session.setAttribute("photo3", hVo.getPhoto3());
			session.setAttribute("photo4", hVo.getPhoto4());
			session.setAttribute("photo5", hVo.getPhoto5());
			
			response.setContentType("text/html; charset=utf-8");
			response.getWriter().println("<script>"
					+ "window.opener.location.reload();"
					+ "window.close();"
					+ "</script>");
		}else {
			System.out.println(""+hDao.photoUpdate(hVo));
		}
		
	}	
	
}
