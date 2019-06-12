package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConn {
	private static Connection conn = null;
	
	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		
			
			String url = "jdbc:oracle:thin:@blockchains.csirtg1es6cl.ap-northeast-2.rds.amazonaws.com:1521:ORCL";
			String user = "project";
			String password = "12345678";
			conn = DriverManager.getConnection(url, user, password);
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public static Connection getInstance() {
		return conn;
	}

}
