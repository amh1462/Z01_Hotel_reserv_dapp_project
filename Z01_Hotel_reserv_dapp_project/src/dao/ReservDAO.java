package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
	public int insert (ReservVO resVo) {
		int result = 0;
		
		String query = "insert into reservation(resno, roomname, guestname, email, phone, uwallet, totalprice ordernum, checkin, checkout,time) values"+
					   " (resno_seq.nextval,?,?,?,?,?,?,?,?,?,?,?,time";
		
		try {
			PreparedStatement pst = conn.prepareStatement(query);
			
			String now = "" + System.currentTimeMillis()/1000;
			
			
			result = pst.executeUpdate();
			pst.close();
		} catch (Exception e) {e.printStackTrace();}

		return result;
	}	
	
	// 예약 리스트화
	public List<ReservVO> selectAll(int pidx){
		List<ReservVO> list = new ArrayList<ReservVO>();
		
		int start = (pidx -1) * 10 + 1;
		int end = pidx*10;
		
		String pquery = "";
		
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(pquery);
			
			while(rs.next()) {
				ReservVO resVo = new ReservVO();
				resVo.setResno(rs.getString("resno"));
			}
			stmt.close();
		} catch (Exception e) {e.printStackTrace();}
		
		
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
	
	
	
	
	
	
	
}
