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
	
	public List<RoomVO> selectAll(String hotelid){
		List<RoomVO> rlist = new ArrayList<RoomVO>();
		String query = "select * from room where hotelid = '"+hotelid+"'";
		
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
	
	public RoomVO selectOne(String rNum) {
		RoomVO rVo = new RoomVO();
		String query = "select * from room where roomno = '" + rNum +"'";
		
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while(rs.next()) {
				rVo.setRoomno(rs.getString("roomno"));
				rVo.setRoomname(rs.getString("roomname"));
				rVo.setRoominfo(rs.getString("roominfo"));
				rVo.setAllowedman(rs.getString("allowedman"));
				rVo.setDailyprice(rs.getString("dailyprice"));
				rVo.setWeekendprice(rs.getString("weekendprice"));
				rVo.setTotalcount(rs.getString("totalcount"));
				rVo.setRestcount(rs.getString("restcount"));
				rVo.setPhoto(rs.getString("photo"));
				rVo.setContract(rs.getString("contract"));
			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rVo;
	}
	
	public List<RoomVO> selectOneList(String rNum) {
		List<RoomVO> rlist = new ArrayList<RoomVO>();
		String query = "select * from room where roomno = '" + rNum +"'";
		
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
	
	public int update(RoomVO rVo) {
		int result = 0;
		String query = "update room set roomname=?, roominfo=?, allowedman=?,"
				+ " dailyprice=?, weekendprice=?, totalcount=?, restcount=?, photo=?"
				+ " where roomno = ?";
		
		try {
			PreparedStatement pst = conn.prepareStatement(query);
			pst.setString(1, rVo.getRoomname());
			pst.setString(2, rVo.getRoominfo());
			pst.setString(3, rVo.getAllowedman());
			pst.setString(4, rVo.getDailyprice());
			pst.setString(5, rVo.getWeekendprice());
			pst.setString(6, rVo.getTotalcount());
			pst.setString(7, rVo.getRestcount());
			pst.setString(8, rVo.getPhoto());
			pst.setString(9, rVo.getRoomno());
			
			result = pst.executeUpdate();
			pst.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return result;
	}
	
}
