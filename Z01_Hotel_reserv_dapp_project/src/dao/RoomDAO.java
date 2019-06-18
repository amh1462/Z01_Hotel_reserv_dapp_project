package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dto.RoomVO;

public class RoomDAO {
	private static RoomDAO rDao = new RoomDAO();
	private static Connection conn = DBConn.getInstance();

	public static RoomDAO getInstance() {
		return rDao;
	}
	
	public List<RoomVO> selectAll(String hotelid){
		List<RoomVO> rlist = new ArrayList<RoomVO>();
		String query = "select * from room where hotelid = '" + hotelid + "'";
		System.out.println(query);
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
				rVo.setTime(rs.getString("time"));
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

}
