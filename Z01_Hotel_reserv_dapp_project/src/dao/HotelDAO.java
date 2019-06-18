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
		
		String query = "insert into hotel "
				+ "(hotelno, hotelid, password, hotelname, country, city, detailaddr, phone, hwallet, cancelfee1, cancelfee2, cancelfee3, cancelfee4, cancelday1, cancelday2)"
				+ "values(hno_seq.nextval,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		
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
			pst.setString(9, hVo.getCancelfee1());
			pst.setString(10, hVo.getCancelfee2());
			pst.setString(11, hVo.getCancelfee3());
			pst.setString(12, hVo.getCancelfee4());
			pst.setString(13, hVo.getCancelday1());
			pst.setString(14, hVo.getCancelday2());
			
			result = pst.executeUpdate();
			pst.close();
			
		} catch (Exception e) { e.printStackTrace();}
		
		return result;
	}
	
	public int photoUpdate(HotelVO hVo) {
		int result = 0;
		
		String query ="update hotel set photo = '" + hVo.getPhoto() + 
				   "', photo2 = '" + hVo.getPhoto2() + "', photo3 = '"
				   + hVo.getPhoto3()+ "', photo4 = '" + hVo.getPhoto4()
				   + "', photo5 = '" + hVo.getPhoto5() 
				   + "' where hotelid = '" + hVo.getHotelid() + "'";
		
		try {
			Statement stmt = conn.createStatement();
			
			result = stmt.executeUpdate(query);
			stmt.close();
		} catch (Exception e) {e.printStackTrace();}
		
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
				hVo.setPhoto2(rs.getString("photo2"));
				hVo.setPhoto3(rs.getString("photo3"));
				hVo.setPhoto4(rs.getString("photo4"));
				hVo.setPhoto5(rs.getString("photo5"));
				hVo.setCancelfee1(rs.getString("cancelfee1"));
				hVo.setCancelfee2(rs.getString("cancelfee2"));
				hVo.setCancelfee3(rs.getString("cancelfee3"));
				hVo.setCancelfee4(rs.getString("cancelfee4"));
				hVo.setCancelday1(rs.getString("cancelday1"));
				hVo.setCancelday2(rs.getString("cancelday2"));
			}
			
		} catch (Exception e) {e.printStackTrace();}
		
		return hVo;
	}
	
	// 회원정보수정
	public int update(HotelVO hVo) {
		int result =0;
		
		try {
			
			Statement stmt = conn.createStatement();
			
			String pwStr = hVo.getPassword() == null ? "" : String.format("password='%s',", hVo.getPassword());
			
			String sql = "update hotel set " + pwStr + "hotelname = '" + hVo.getHotelname() + "', " + "country = '"
						+ hVo.getCountry() + "', city = '" + hVo.getCity() + "', detailaddr = '"
						+ hVo.getDetailaddr() + "', hwallet = '" + hVo.getHwallet() + "', cancelfee1 ='" 
						+ hVo.getCancelfee1() + "', cancelfee2 ='" + hVo.getCancelfee2() + "', cancelfee3 ='" 
						+ hVo.getCancelfee3() + "', cancelfee4 ='" + hVo.getCancelfee4() + "', cancelday1 ='" + hVo.getCancelday1() + "', cancelday2 ='" + hVo.getCancelday2() 
						+ "' where hotelid = '" + hVo.getHotelid() + "'";
			result = stmt.executeUpdate(sql);
			stmt.close();
		} catch (Exception e) {e.printStackTrace(); }
		return result;
	}
	
}
