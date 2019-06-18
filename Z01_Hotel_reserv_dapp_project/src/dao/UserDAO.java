package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dto.HotelVO;

public class UserDAO {
	
	private static Connection conn = DBConn.getInstance();
	private static UserDAO uDao = new UserDAO();
	
	public static UserDAO getInstance() {
		return uDao;
	}
	
	public List<HotelVO> selectAll(String hotelname) {
		
		List<HotelVO> hlist = new ArrayList<HotelVO>();
		
		String query = "select * from hotel where hotelname = '" + hotelname + "'";
		
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while(rs.next()) {
				
				HotelVO hVo = new HotelVO();
				hVo.setHotelname(rs.getString("hotelname"));
				hVo.setCity(rs.getString("city"));
				hVo.setDetailaddr(rs.getString("detailaddr"));
				hVo.setPhone(rs.getString("phone"));
				hVo.setPhoto(rs.getString("photo"));
				hVo.setHotelname(rs.getString("hotelname"));
				hVo.setCountry(rs.getString("country"));				
			}
			
			rs.close();
			stmt.close();
			
		} catch (SQLException e ) {
			e.printStackTrace();
		}
		return hlist;
		
	}
}
