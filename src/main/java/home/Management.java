package home;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class Management extends AobagiftDAO {
	public Object ManagementUser() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Map<String, String>> manage_users = new ArrayList<Map<String, String>>();
		
		try {
			// データベース接続情報取得
			conn = getConnection();
			
			// SELECT文の登録と実行
			String sql = "SELECT * FROM MNUS";
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			while (rset.next()) {
				String user_id = rset.getString(2);
				String password = rset.getString(3);
				
				Map<String, String> manage_user = new HashMap<>();
				manage_user.put("user_id", user_id);
				manage_user.put("password", password);
				manage_users.add(manage_user);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
			close(conn);
		}
		
		return manage_users;
	}
}
