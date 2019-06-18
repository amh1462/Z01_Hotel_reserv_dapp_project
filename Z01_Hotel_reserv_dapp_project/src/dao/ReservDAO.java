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

import javax.servlet.http.HttpSession;

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
				resVo.setTotalprice(rs.getString("totalprice"));
				resVo.setTime(rs.getString("time"));
				resVo.setCheckin(rs.getString("checkin"));
				resVo.setCheckout(rs.getString("checkout"));
				resVo.setIscancel(rs.getString("iscancel"));
				resVo.setIswithdraw(rs.getString("iswithdraw"));
			}
			rs.close();
		} catch (Exception e) {e.printStackTrace();}
		
		return resVo;
	}
	
	// 예약 등록 추후 작성
	
	
	// 예약 리스트화
	public List<ReservVO> selectAll(int pidx, String hotelid){
		
		List<ReservVO> reslist = new ArrayList<ReservVO>();
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
				resVo.setTotalprice(rs.getString("totalprice"));
				resVo.setIscancel(rs.getString("iscancel"));
				resVo.setIswithdraw(rs.getString("iswithdraw"));
				
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
	// 검색기능
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
				resVo.setTotalprice(rs.getString("totalprice"));
				resVo.setIscancel(rs.getString("iscancel"));
				resVo.setIswithdraw(rs.getString("iswithdraw"));
				
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
	
	
	
	// 마지막 페이지 구하기
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
}
