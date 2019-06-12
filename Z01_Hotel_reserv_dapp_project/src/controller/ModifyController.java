package controller;

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

@WebServlet("/modify")
public class ModifyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public ModifyController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("modify.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		HotelVO hVo = new HotelVO();
		HotelDAO hDao = HotelDAO.getInstance();
		HttpSession session  = request.getSession();
		
		System.out.println(request.getParameter("hiddenvalue"));
		
		if(request.getParameter("hiddenvalue")==null) {
			
			String uploadPath = request.getServletContext().getRealPath("/uploadFiles");
			
			int maxSize = 1024 * 1024 * 10;
			
			MultipartRequest multi = new MultipartRequest(
					request,
					uploadPath,
					maxSize,
					"utf-8",
					new DefaultFileRenamePolicy()
					);
			
			Enumeration files = multi.getFileNames();
			
			String renewName01 = "";
			System.out.println("renew name : "+renewName01);
			System.out.println(""+files.hasMoreElements());
			
			while(files.hasMoreElements()) {
				String file01 = (String) files.nextElement();
				System.out.println(""+file01);
				String originName01 = multi.getOriginalFileName(file01);
				System.out.println(originName01);
				renewName01 = multi.getFilesystemName(file01);
				System.out.println(renewName01);
			}
			
			if(multi.getParameter("password").trim().length() !=0) {
				hVo.setPassword(multi.getParameter("password"));
			}
		
			
			hVo.setHotelid((String)session.getAttribute("hotelid"));
			hVo.setHotelname(multi.getParameter("hotelname"));
			hVo.setCountry(multi.getParameter("country"));
			hVo.setCity(multi.getParameter("city"));
			hVo.setDetailaddr(multi.getParameter("detailaddr"));
			hVo.setPhone(multi.getParameter("phone"));
			hVo.setHwallet(multi.getParameter("hwallet"));
			hVo.setPhoto("uploadFiles/"+renewName01);
			System.out.println(hVo.toString());
			/*
			hVo.setPhoto2("uploadFiles/"+renewName01);
			hVo.setPhoto3("uploadFiles/"+renewName01);
			hVo.setPhoto4("uploadFiles/"+renewName01);
			hVo.setPhoto5("uploadFiles/"+renewName01);
			*/
			if(hDao.update(hVo)>0) {
				
				session.setAttribute("hotelname", hVo.getHotelname());
				session.setAttribute("country", hVo.getCountry());
				session.setAttribute("city", hVo.getCity());
				session.setAttribute("detailaddr", hVo.getDetailaddr());
				session.setAttribute("phone", hVo.getPhone());
				session.setAttribute("hwallet", hVo.getHwallet());
				session.setAttribute("photo", hVo.getPhoto());
				System.out.println(hVo.toString());
				response.sendRedirect("./hotelMain.jsp?contentPage=hotelInfo.jsp");
				
				System.out.println();
			}else {
				response.sendRedirect("./hotelMain.jsp?contentPage=faq.jsp");
			}
		}
	}
	
}
