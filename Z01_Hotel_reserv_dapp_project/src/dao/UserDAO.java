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
	
	public List<HotelVO> selectAll(String keyword) {
		
		List<HotelVO> hlist = new ArrayList<HotelVO>();
		
		String query = "select * from hotel where city = '" + keyword + "'";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while(rs.next()) {
				
				HotelVO hVo = new HotelVO();
				hVo.setHotelid(rs.getString("hotelid"));
				hVo.setHotelname(rs.getString("hotelname"));
				hVo.setCity(rs.getString("city"));
				hVo.setDetailaddr(rs.getString("detailaddr"));
				hVo.setPhone(rs.getString("phone"));
				hVo.setPhoto(rs.getString("photo"));
				hVo.setCountry(rs.getString("country"));
				hlist.add(hVo);
			}
			rs.close();
			stmt.close();
			
		} catch (SQLException e ) {
			e.printStackTrace();
		}
		return hlist;
		
	}
	
	public int lastPageNum(String keyword) {
		int result = 0;
		try {
			String query = "select count(*) as cnt from hotel where " 
					+ "city like '%"+keyword+"%'";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			if(rs.next()) {
				result = rs.getInt("cnt");
			}
			
			result = (int)Math.ceil(result/10.0);
			stmt.close();
		} catch (SQLException e) { e.printStackTrace(); }

		return result;
	}
	
	public int getStartList(int pIndexParam) {
		return (pIndexParam - 1) / 10 * 10 + 1;
	}
	
	
	public Object getEndList(int pIndexParam, String keyword) {
		return Math.min(lastPageNum(keyword), (pIndexParam - 1) / 10 * 10 + 10);
	}
	
	
	
}
