package dao;

import java.sql.Connection;

import dto.RoomVO;

public class RoomDAO {
	private static RoomDAO rDao = new RoomDAO();
	private static Connection conn = DBConn.getInstance();

	public static RoomDAO getInstance() {
		return rDao;
	}

}
