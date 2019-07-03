package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


import dto.ReservVO;

public class ReservDAO {
	private static ReservDAO reservDao = new ReservDAO();
	private static Connection conn = DBConn.getInstance();

	public static ReservDAO getInstance() {
		return reservDao;
	}
	
public ReservVO select(String resno, String hotelid) {
		ReservVO resVo = null;
		String resquery = "select res.*, rm.roomname from reservation res,"
				+ "room rm where res.roomno = rm.roomno and rm.hotelid = '"+ hotelid +"' and res.resno = '"+ resno +"'";
		try {
			ResultSet rs = conn.createStatement().executeQuery(resquery);
			if(rs.next()) {
				resVo = new ReservVO();
				resVo.setResno(rs.getString("resno"));
				resVo.setGuestname(rs.getString("guestname"));
				resVo.setTotalprice("0" + rs.getString("totalprice"));
				resVo.setTime(rs.getString("time"));
				resVo.setCheckin(rs.getString("checkin"));
				resVo.setCheckout(rs.getString("checkout"));
				resVo.setIscancel(rs.getString("iscancel"));
				resVo.setIswithdraw(rs.getString("iswithdraw"));
				resVo.setContract(rs.getString("contract"));
				resVo.setUwallet(rs.getString("uwallet"));
			}
			rs.close();
		} catch (Exception e) {e.printStackTrace();}
		
		return resVo;
	}
	
	// ���� ��� ���� �ۼ�
	
	
	// ���� ����Ʈȭ
	public List<ReservVO> selectAll(int pidx, String hotelid){
		
		List<ReservVO> reslist = new ArrayList<ReservVO>() ;
		int start = (pidx -1) * 10 + 1;
		int end = pidx*10;
		/*
		String pquery = "select * from (select rownum r1, v1.* from"
						+ "(select res.*, rm.roomname from reservation"
						+ "res, room rm where res.roomno = rm.roomno"
						+ "order by res.resno desc) v1) where r1 "
						+ "between " + start + " and " + end ;
		*/
		String pquery = "select * from (select rownum r1, v1.* from (select res.*, rm.roomname from reservation res, room rm where res.roomno = rm.roomno and rm.hotelid = '"+hotelid+"' order by res.resno desc) v1) where r1 between "+ start + " and "+ end;
		
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(pquery);
			
			while(rs.next()) {
				ReservVO resVo = new ReservVO();
				resVo.setResno(rs.getString("resno"));
				resVo.setGuestname(rs.getString("guestname"));
				resVo.setRoomno(rs.getString("roomname"));
				resVo.setTotalprice("0"+ rs.getString("totalprice"));
				resVo.setIscancel(rs.getString("iscancel"));
				resVo.setIswithdraw(rs.getString("iswithdraw"));
				resVo.setContract(rs.getString("contract"));
				resVo.setUwallet(rs.getString("uwallet"));
				
				long formatted = Long.parseLong(rs.getString("time")+"000");
				String t = new SimpleDateFormat("yy-MM-dd").format(formatted);
				resVo.setTime(t);
				
				long formatted2 = Long.parseLong(rs.getString("checkin")+"000");
				String t2 = new SimpleDateFormat("yy-MM-dd").format(formatted2);
				resVo.setCheckin(t2);
				
				long formatted3 = Long.parseLong(rs.getString("checkout")+"000");
				String t3 = new SimpleDateFormat("yy-MM-dd").format(formatted3);
				resVo.setCheckout(t3);

				reslist.add(resVo);
			}
			rs.close();
			stmt.close();
		} catch (Exception e) {e.printStackTrace();}
		
		return reslist;
	}
	// �˻����
	public Object selectAll(int resIndexParam, String category, String keyoword, String hotelid) {
		List<ReservVO> reslist = new ArrayList<ReservVO>();
		
		int resSize = 10;
		
		int start = (resIndexParam -1 ) * resSize + 1;
		int end = resIndexParam * resSize;
		String resquery = "";
		if(category.equals("guestname")) {
			/*
			resquery = "select * from ( select rownum r1, v1.*from "
					+ "(SELECT RES.*, rm.roomname from reservation res,"
					+ "room rm where res.ROOMNO = rm.ROOMNO  and guestname like "
					+ "'%" + keyoword +"%' order by res.resno desc) v1)  where "
							+ "r1 between"+ start +"and"+ end;
			*/
			resquery = "select * from ( select rownum r1, v1.*from (SELECT RES.*, rm.roomname from reservation res, room rm where res.ROOMNO = rm.ROOMNO and rm.hotelid = '"+ hotelid +"' and guestname like '%"+ keyoword +"%' order by res.resno desc) v1)  where r1 between " + start + " and " + end;
		}else if(category.equals("roomno")) {
			/*
			resquery = "select * from ( select rownum r1, v1.*from"
					+ "(SELECT RES.*, rm.roomname from reservation res,"
					+ "room rm where res.ROOMNO = rm.ROOMNO and rm.roomname"
					+ "like '%" + keyoword + "%' order by res.resno desc)"
					+ " v1) where r1 between"+ start +"and" + end;
			*/
			
			resquery = "select * from ( select rownum r1, v1.*from (SELECT RES.*, rm.roomname from reservation res, room rm where res.ROOMNO = rm.ROOMNO and rm.hotelid = '"+ hotelid +"' and rm.roomname like '%"+keyoword+"%' order by res.resno desc) v1) where r1 between "+ start +" and " + end;
		}else {
			/*
			resquery = "select * from ( select rownum r1, v1.*from"
					+ " (SELECT RES.*, rm.roomname from reservation res, "
					+ " room rm where res.ROOMNO = rm.ROOMNO and res."+category
					+ " like '%"+keyoword+"%' order by res.resno desc) v1)"
					+ " where r1 between" + start +"and" + end;
					*/
			String t= keyoword;
			DateFormat dataformat = new SimpleDateFormat("yy-MM-dd");
			try {
				Date date = dataformat.parse(t);
				long unixt = (long)date.getTime()/1000;
				String tt = ""+ unixt;
				resquery = "select * from ( select rownum r1, v1.*from (SELECT RES.*, rm.roomname from reservation res, room rm where res.ROOMNO = rm.ROOMNO and rm.hotelid = '"+hotelid+"' and res."+category+" like '%"+tt+"%' order by res.resno desc) v1) where r1 between " + start +" and " + end;
			} catch (ParseException e) {e.printStackTrace();}
			
		}
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(resquery);
			while(rs.next()) {
				ReservVO resVo = new ReservVO();
				resVo.setResno(rs.getString("resno"));
				resVo.setGuestname(rs.getString("guestname"));
				resVo.setRoomno(rs.getString("roomname"));
				resVo.setTotalprice("0" + rs.getString("totalprice"));
				resVo.setIscancel(rs.getString("iscancel"));
				resVo.setIswithdraw(rs.getString("iswithdraw"));
				resVo.setContract(rs.getString("contract"));
				resVo.setUwallet(rs.getString("uwallet"));
				
				long formatted = Long.parseLong(rs.getString("time")+"000");
				String t = new SimpleDateFormat("yy-MM-dd").format(formatted);
				resVo.setTime(t);
				
				long formatted2 = Long.parseLong(rs.getString("checkin")+"000");
				String t2 = new SimpleDateFormat("yy-MM-dd").format(formatted2);
				resVo.setCheckin(t2);
				
				long formatted3 = Long.parseLong(rs.getString("checkout")+"000");
				String t3 = new SimpleDateFormat("yy-MM-dd").format(formatted3);
				resVo.setCheckout(t3);
				
				reslist.add(resVo);
			}
			stmt.close();
		} catch (Exception e) {e.printStackTrace();}
		
		
		return reslist;
	}
	
	
	
	// ������ ������ ���ϱ�
	public int lastPageNum(String hotelid) {
		int result = 0;
		try {
			String query = "select count(*) as cnt from (select res.*, rm.roomname from reservation res, room rm where res.roomno = rm.roomno and rm.hotelid = '"+ hotelid +"' order by res.resno desc) v1";
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
	
	public int getEndList(int resIndexParam, String hotelid) {
		
		return Math.min(lastPageNum(hotelid), (resIndexParam - 1)/ 10 * 10 + 10);
	}
	
	public int lastPageNum(String category, String keyword, String hotelid) {
		int result = 0;
		try {
			String query = "select count(*) as cnt from (select res.*, rm.roomname from reservation res, room rm where res.roomno = rm.roomno and rm.hotelid = '"+hotelid+"' order by res.resno desc) v1 where "+ category + " like '%" + keyword + "%'";
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
	
	public Object getEndList(int resIndexParam, String category, String keyword, String hotelid) {
		return Math.min(lastPageNum(category, keyword,hotelid), (resIndexParam -1) / 10 * 10 +10);
	}
	
	public int insert(ReservVO resVo) {
		int result = 0;
		String query = "insert into reservation values (resno_seq.nextval,?,?,?,?,?,?,?,?,?,0,0,?,?,?)";
		// resno, roomno, guestname, email, phone, uwallet, totalprice, ordernum, checkin, checkout, iscancel, iswithdraw, time, hotelid, contract
		
		String now = "" + System.currentTimeMillis() / 1000;
		
		try {
			PreparedStatement pst = conn.prepareStatement(query);
			pst.setString(1, resVo.getRoomno());
			pst.setString(2, resVo.getGuestname());
			pst.setString(3, resVo.getEmail());
			pst.setString(4, resVo.getPhone());
			pst.setString(5, resVo.getUwallet());
			pst.setString(6, resVo.getTotalprice());
			pst.setString(7, resVo.getOrdernum());
			pst.setString(8, resVo.getCheckin());
			pst.setString(9, resVo.getCheckout());
			pst.setString(10, now);
			pst.setString(11, resVo.getHotelid());
			pst.setString(12, resVo.getContract());
			
			result = pst.executeUpdate();
			pst.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return result;
	}
	
	public String updateIsWithdraw(String resno) {
		String msg = null;
		int result = 0;
		String query = "update reservation set iswithdraw = 1 where resno = " + resno;
		
		try {
			Statement stmt = conn.createStatement();
			result = stmt.executeUpdate(query);
			if(result>0) {
				msg = "정산이 완료되었습니다.";
			} else {
				msg = "정산에 오류가 발생했습니다.";
			}
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return msg;
	}
	
	public String updateIsCancel(String resno) {
		String msg = null;
		int result = 0;
		String query = "update reservation set iscancel = 1 where resno = " + resno;
		
		try {
			Statement stmt = conn.createStatement();
			result = stmt.executeUpdate(query);
			if(result>0) {
				msg = "전액 취소가 완료되었습니다.";
			} else {
				msg = "전액 취소에 오류가 발생했습니다.";
			}
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return msg;
	}
	
	//--------------------------------User-------------------------------------------------------
	
	public List<ReservVO> userSelectAll(int pidx, String guestname, String phone, String email){
		List<ReservVO> ureslist = new ArrayList<ReservVO>() ;
		int start = (pidx -1) * 10 + 1;
		int end = pidx*10;
		String pquery = "";
		if(phone !=null && guestname !=null && email == "") {
			pquery = "select * from (select rownum r1, v1.* from (select res.*, rm.roomname, ho.hotelname from reservation res, room rm, hotel ho where res.roomno = rm.roomno and rm.hotelid = ho.hotelid and res.GUESTNAME = '"+ guestname + "' and res.phone = '"+ phone +"' order by res.resno desc) v1) where r1 between " + start +" and "+ end;
		}else if(phone !=null && email !=null && guestname == "") {
			pquery = "select * from (select rownum r1, v1.* from (select res.*, rm.roomname, ho.hotelname from reservation res, room rm, hotel ho where res.roomno = rm.roomno and rm.hotelid = ho.hotelid and res.email= '"+ email + "' and res.phone = '"+ phone +"' order by res.resno desc) v1) where r1 between " + start +" and "+ end;
		}else if(phone !=null && email !=null && guestname !=null){
			pquery = "select * from (select rownum r1, v1.* from (select res.*, rm.roomname, ho.hotelname from reservation res, room rm, hotel ho where res.roomno = rm.roomno and rm.hotelid = ho.hotelid and res.email= '"+ email + "' and res.phone = '"+ phone +"' and res.guestname = '"+guestname+"' order by res.resno desc) v1) where r1 between " + start +" and "+ end;
		}
		
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(pquery);
			
			while(rs.next()) {
				ReservVO uresVo = new ReservVO();
				uresVo.setResno(rs.getString("resno"));
				uresVo.setHotelid(rs.getString("hotelid"));
				uresVo.setHotelname(rs.getString("hotelname"));
				uresVo.setRoomno(rs.getString("roomname"));
				uresVo.setTotalprice("0" + rs.getString("totalprice"));
				uresVo.setIscancel(rs.getString("iscancel"));
				uresVo.setIswithdraw(rs.getString("iswithdraw"));
				uresVo.setContract(rs.getString("contract"));
				uresVo.setUwallet(rs.getString("uwallet"));
				
				long formatted2 = Long.parseLong(rs.getString("checkin")+"000");
				String t2 = new SimpleDateFormat("yyyy-MM-dd").format(formatted2);
				uresVo.setCheckin(t2);
				
				long formatted3 = Long.parseLong(rs.getString("checkout")+"000");
				String t3 = new SimpleDateFormat("yyyy-MM-dd").format(formatted3);
				uresVo.setCheckout(t3);

				ureslist.add(uresVo);
			}
			rs.close();
			stmt.close();
		} catch (Exception e) {e.printStackTrace();}
		
		return ureslist;
	}
	
	public int userLastPageNum(String phone) {
		int result = 0;
		try {
			String query = "select count(*) as cnt from (select res.*, rm.roomname from reservation res, room rm where res.roomno = rm.roomno and res.phone= '"+phone+"' order by res.resno desc) v1";
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
	
	public int getUserEndList(int resIndexParam, String guestname) {
		
		return Math.min(userLastPageNum(guestname), (resIndexParam - 1)/ 10 * 10 + 10);
	}
	
	public int usetGetEndList(int resIndexParam, String phone) {
		
		return Math.min(userLastPageNum(phone), (resIndexParam - 1)/ 10 * 10 + 10);
	}
}
