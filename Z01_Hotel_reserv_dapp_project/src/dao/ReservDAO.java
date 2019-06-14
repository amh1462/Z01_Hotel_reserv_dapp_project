package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import dto.ReservVO;

public class ReservDAO {
	private static ReservDAO reservDao = new ReservDAO();
	private static Connection conn = DBConn.getInstance();

	public static ReservDAO getInstance() {
		return reservDao;
	}
	// 예약 등록
	// 추후 작성
	
	// 예약 리스트화
	public List<ReservVO> selectAll(int pidx){
		List<ReservVO> list = new ArrayList<ReservVO>();
		
		int start = (pidx -1) * 10 + 1;
		int end = pidx*10;
		
		String pquery = "select * from (select rownum r1, v1.* from"
						+ "(select res.*, rm.roomname from reservation"
						+ "res, room rm where res.roomno = rm.roomno"
						+ "order by res.resno desc) v1) where r1 "
						+ "between" + start + "and" + end;
		
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(pquery);
			
			while(rs.next()) {
				ReservVO resVo = new ReservVO();
				resVo.setResno(rs.getString("resno"));
				resVo.setGuestname(rs.getString("guestname"));
				resVo.setRoomno(rs.getString("roomname"));
				resVo.setTotalprice(rs.getString("totalprice"));
				resVo.setCheckin(rs.getString("checkin"));
				resVo.setCheckout(rs.getString("checkout"));
				
				long formatted = Long.parseLong(rs.getString("time")+"000");
				String t = new SimpleDateFormat("yy-MM-dd HH:mm").format(formatted);
				
				resVo.setTime(t);
				list.add(resVo);
			}
			stmt.close();
		} catch (Exception e) {e.printStackTrace();}
		
		
		return list;
	}
	// 검색기능
	public Object selectAll(int resIndexParam, String category, String keyoword) {
		List<ReservDAO> list = new ArrayList<ReservDAO>();
		
		int resSize = 10;
		
		int start = (resIndexParam -1 ) * resSize + 1;
		int end = resIndexParam * resSize;
		
		String resquery = "";
		if(category.equals("guestname")) {
			
		}else if(category.equals("roomno")) {
			
		}else if(category.equals("time")) {
			
		}else if(category.equals("checkin")) {
			
		}else if(category.equals("checkout")) {
			
		}
		
		
		
		return list;
	}
	
	
	
	// 마지막 페이지 구하기
	public int lastPageNum() {
		int result = 0;
		try {
			String query = "select count(*) as cnt from reservation";
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
	
	public int getStartList(int resIndexParam) {
		return (resIndexParam -1) / 10 * 10 + 1;
	}
	
	public int getEndList(int resIndexParam) {
		return Math.min(lastPageNum(), (resIndexParam - 1)/ 10 * 10 + 10);
	}
	
	public int lastPageNum(String category, String keyword) {
		int result = 0;
		try {
			String query = "select count(*) as cnt from reservation"
						 + "where"+ category + "like '%" + keyword 
						 + "%'";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			if(rs.next()) {
				result = rs.getInt("cnt");
			}
			result = (int)Math.ceil(result/10.0);
			stmt.close();
		} catch (Exception e) {e.printStackTrace();}
		
		return result;
	}
	
	public Object getEndList(int resIndexParam, String category, String keyword) {
		return Math.min(lastPageNum(category, keyword), (resIndexParam -1) / 10 * 10 +10);
	}
	
	
	
	
	
	
}
