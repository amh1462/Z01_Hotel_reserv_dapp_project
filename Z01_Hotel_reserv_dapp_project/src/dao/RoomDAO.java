package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import dto.RoomVO;

public class RoomDAO {
	private static RoomDAO rDao = new RoomDAO();
	private static Connection conn = DBConn.getInstance();

	public static RoomDAO getInstance() {
		return rDao;
	}
	
	public List<RoomVO> selectAll(String hotelid, int pIndex, String category, String keyword){
		List<RoomVO> rlist = new ArrayList<RoomVO>();
		
		int pSize = 3;
		int startIdx = (pIndex-1) * pSize + 1;
		int endIdx = pIndex * pSize;
		String query = "";
		if(keyword != null) {
			query = "select * from"
							+ "(select rownum r1, v1.* from"
							+ "(select * from room where hotelid='" + hotelid + "' and " + category + " like '%" + keyword + "%'"
							+ " order by roomno desc) v1)"
							+ "where r1 between " + startIdx + " and "+ endIdx;
		} else {
			query = "select * from"
					+ "(select rownum r1, v1.* from"
					+ "(select * from room where hotelid='" + hotelid + "' order by roomno desc) v1)"
					+ "where r1 between " + startIdx + " and "+ endIdx;
		}
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while(rs.next()) {
				RoomVO rVo = new RoomVO();
				rVo.setRoomno(rs.getString("roomno"));
				rVo.setHotelid(rs.getString("hotelid"));
				rVo.setRoomname(rs.getString("roomname"));
				rVo.setRoominfo(rs.getString("roominfo"));
				rVo.setAllowedman(rs.getString("allowedman"));
				rVo.setDailyprice(rs.getString("dailyprice"));
				rVo.setWeekendprice(rs.getString("weekendprice"));
				rVo.setTotalcount(rs.getString("totalcount"));
				rVo.setRestcount(rs.getString("restcount"));
				rVo.setPhoto(rs.getString("photo"));
				long formatted = Long.parseLong(rs.getString("time") + "000");
				String time = new SimpleDateFormat("yyyy-MM-dd a hh시 mm분 ss초").format(formatted);
				rVo.setTime(time);
				rVo.setContract(rs.getString("contract"));
				rlist.add(rVo);
			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rlist;
	}
	
	public int getStartList(int pIndex) {
		return (pIndex-1) / 10 * 10 + 1;
	}
	
	public int getEndList(int pIndex) {
		return (pIndex-1) / 10 * 10 + 10;
	}
	
	public int lastPageNum(String hotelid, String category, String keyword) {
		int result = 0;
		String query = "";
		if(keyword != null) {
			query = "select count(*) as cnt from room where hotelid='" + hotelid + "' and " + category + " like '%" + keyword + "%'";
		} else {
			query = "select count(*) as cnt from room where hotelid='" + hotelid + "'";
		}
		
		try {
			PreparedStatement pst = conn.prepareStatement(query);
			ResultSet rs = pst.executeQuery();
			if(rs.next()) {
				result = rs.getInt("cnt");
			}
			result = (int)Math.ceil(result/3.0);
			rs.close();
			pst.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public int insert(RoomVO rVo) {
		int result = 0;
		String query = "insert into room values (rno_seq.nextval,?,?,?,?,?,?,?,?,?,?,?)";
		
		String now = "" + System.currentTimeMillis() / 1000;
		
		try {
			PreparedStatement pst = conn.prepareStatement(query);
			pst.setString(1, rVo.getHotelid());
			pst.setString(2, rVo.getRoomname());
			pst.setString(3, rVo.getRoominfo());
			pst.setString(4, rVo.getAllowedman());
			pst.setString(5, rVo.getDailyprice());
			pst.setString(6, rVo.getWeekendprice());
			pst.setString(7, rVo.getTotalcount());
			pst.setString(8, rVo.getRestcount());
			pst.setString(9, rVo.getPhoto());
			pst.setString(10, now);
			pst.setString(11, rVo.getContract());
			
			result = pst.executeUpdate();
			pst.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	//---------------------userSelectAll---------------------
	
	public List<RoomVO> userSelectAll(int pidx, String hotelid){
		int start = (pidx -1) * 10 + 1;
		int end = pidx * 10;
		List<RoomVO> roomlist = new ArrayList<RoomVO>();
		
		String pquery = "select * from room where hotelid = '"+hotelid+"'";
		
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(pquery);
			
			while(rs.next()) {
				RoomVO roomVo = new RoomVO();
				
				roomVo.setAllowedman(rs.getString("allowedman"));
				roomVo.setRoomname(rs.getString("roomname"));
				roomVo.setDailyprice(rs.getString("dailyprice"));
				roomVo.setWeekendprice(rs.getString("weekendprice"));
				roomVo.setTotalcount(rs.getString("totalcount"));
				roomlist.add(roomVo);
			}
			rs.close();
			stmt.close();
		} catch (Exception e) {e.printStackTrace();}
		return roomlist;
	}
	
	public List<RoomVO> userSelectAll(String pidx, String hotelid){
		List<RoomVO> roomlist = new ArrayList<RoomVO>();
		
		String pquery = "select * from room where hotelid = '"+hotelid+"' and roomname = '"+pidx+"'";
		
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(pquery);
			
			while(rs.next()) {
				RoomVO roomVo = new RoomVO();
				
				roomVo.setAllowedman(rs.getString("allowedman"));
				roomVo.setRoomname(rs.getString("roomname"));
				roomVo.setDailyprice(rs.getString("dailyprice"));
				roomVo.setWeekendprice(rs.getString("weekendprice"));
				roomVo.setTotalcount(rs.getString("totalcount"));
				roomlist.add(roomVo);
			}
			rs.close();
			stmt.close();
		} catch (Exception e) {e.printStackTrace();}
		return roomlist;
	}
	
	public int lastPageNum(String hotelid) {
		int result = 0;
		
		try {
			String query = "select count(*) as cnt from room where hotelid = '"+hotelid+"'";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			if(rs.next()) {
				result = rs.getInt("cnt");
			}
			
			result = (int)Math.ceil(result/1.0);
			stmt.close();
		} catch (Exception e) {e.printStackTrace();}
		
		return result;
	}
	
	public int getEndList(int resIndexParam, String hotelid) {
		return Math.min(lastPageNum(hotelid), 10);
	}
	
	public List<RoomVO> userSelect(int pidx, String hotelid){
		int start = (pidx -1) * 10 + 1;
		int end = pidx * 10;
		List<RoomVO> rolist = new ArrayList<RoomVO>();
		
		String pquery = "select * from room where hotelid = '"+hotelid+"'";
		
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(pquery);
			
			while(rs.next()) {
				RoomVO roVo = new RoomVO();
				roVo.setRoomname(rs.getString("roomname"));
				rolist.add(roVo);
			}
			rs.close();
			stmt.close();
		} catch (Exception e) {e.printStackTrace();}
		return rolist;
	}
	
	public List<RoomVO> userSelect(String pidx, String hotelid){
		List<RoomVO> rolist = new ArrayList<RoomVO>();
		
		String pquery = "select * from room where hotelid = '"+hotelid+"' and roomname = '"+pidx+"'";
		
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(pquery);
			
			while(rs.next()) {
				RoomVO roVo = new RoomVO();
				roVo.setRoomname(rs.getString("roomname"));
				rolist.add(roVo);
			}
			rs.close();
			stmt.close();
		} catch (Exception e) {e.printStackTrace();}
		return rolist;
	}
}
