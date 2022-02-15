package home;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class AobagiftDAO {
	private final String DSN = "jdbc:mysql://us-cdbr-east-05.cleardb.net/heroku_6404c6c62c18961?reconnect=true&useSSL=false&useUnicode=true&characterEncoding=utf8&characterSetResults=utf8";
	private final String USER = "bae832441baf16";
	private final String PASSWORD = "ce0e85ee";
	//private final String DSN = "jdbc:mysql://localhost:3306/aobagift?useSSL=false";
	//private final String USER = "root";
	//private final String PASSWORD = "tkznemou19";
	
	public Connection getConnection() {
		Connection conn = null;
		
		try {
			// JDBCドライバのロード
			Class.forName("com.mysql.jdbc.Driver");
			
			// データベースへ接続
			conn = DriverManager.getConnection(DSN, USER, PASSWORD);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return conn;
	}
	
	// Connection型変数が持つデータベースとJDBCリソースの解放
	public void close(Connection conn) {
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	// PreparedStatement型変数が持つデータベースとJDBCリソースの解放
	public void close(Statement stmt) {
		if (stmt != null) {
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	// ResultSet型変数が持つデータベースとJDBCリソースの解放
	public void close(ResultSet rset) {
		if (rset != null) {
			try {
				rset.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
