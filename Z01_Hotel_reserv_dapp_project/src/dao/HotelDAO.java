package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import dto.HotelVO;

public class HotelDAO {
	
	
	private static Connection conn = DBConn.getInstance();
	private static HotelDAO hDao = new HotelDAO();
	
	public static HotelDAO getInstance() {
		return hDao;
	}
	
	// 회원가입 
	
	public int insert(HotelVO hVo) {
		
		int result = 0;
		
		String query = "insert into hotel (hotelno, hotelid, password, hotelname, country, city, detailaddr, phone, hwallet)"
				+ "values(hno_seq.nextval,?,?,?,?,?,?,?,?)";
		
		try {
			
			PreparedStatement pst = conn.prepareStatement(query);
			pst.setString(1, hVo.getHotelid());
			pst.setString(2, hVo.getPassword());
			pst.setString(3, hVo.getHotelname());
			pst.setString(4, hVo.getCountry());
			pst.setString(5, hVo.getCity());
			pst.setString(6, hVo.getDetailaddr());
			pst.setString(7, hVo.getPhone());
			pst.setString(8, hVo.getHwallet());
			
			result = pst.executeUpdate();
			pst.close();
			
		} catch (Exception e) { e.printStackTrace();}
		
		return result;
	}
	
	
	// 로그인
	public int MachIdPw(String hotelid, String password) {
		int result = 0;
		
		String query = "select password from hotel where hotelid ='"+ hotelid +"'";
		
		try {
			
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			
			if(rs.next()) {
				if(rs.getString("password").equals(password)) {
					result = 1;
				}
			}

		} catch (Exception e) {e.printStackTrace();}
		
		return result;
	}
	// 정보 불러오기	
	public HotelVO select(String hotelid) {
		HotelVO hVo = null;
		
		String query = "select * from hotel where hotelid ='"+ hotelid +"'";
		
		try {
			ResultSet rs = conn.createStatement().executeQuery(query);
			
			if(rs.next()) {
				hVo = new HotelVO();
				hVo.setHotelid(rs.getString("hotelid"));
				hVo.setPassword(rs.getString("password"));
				hVo.setHotelname(rs.getString("hotelname"));
				hVo.setCity(rs.getString("city"));
				hVo.setDetailaddr(rs.getString("detailaddr"));
				hVo.setPhone(rs.getString("phone"));
				hVo.setPhoto(rs.getString("photo"));
				hVo.setHwallet(rs.getString("hwallet"));
				hVo.setCountry(rs.getString("country"));
			}
			
		} catch (Exception e) {e.printStackTrace();}
		
		return hVo;
	}
	
	// 회원정보수정
	public int update(HotelVO hVo) {
		int result =0;
		
		try {
			
			Statement stmt = conn.createStatement();
			
			String pwStr = (hVo.getPassword() == null) ? "" : "password = '" + hVo.getPassword()+"' ,";
			
			String sql = "update hotel set " + pwStr + "hotelname = '" + hVo.getHotelname() + "', " + "country = '"
						+ hVo.getCountry() + "', city = '" + hVo.getCity() + "', detailaddr = '"
						+ hVo.getDetailaddr() + "', hwallet = '" + hVo.getHwallet() + "', photo= '" 
						+ hVo.getPhoto() + "', photo2 = '" + hVo.getPhoto2() + "', photo3= '"  
						+ hVo.getPhoto3() + "', photo4 = '" + hVo.getPhoto4()+ "', photo5= '"
						+ hVo.getPhoto5()+ "' where hotelid = '" + hVo.getHotelid() + "'";
			result = stmt.executeUpdate(sql);
			stmt.close();
		} catch (Exception e) {e.printStackTrace(); }
		return result;
	}
	
}
