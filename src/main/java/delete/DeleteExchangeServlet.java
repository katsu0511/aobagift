package delete;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import home.AobagiftDAO;
import home.Management;

/**
 * Servlet implementation class DeleteExchangeServlet
 */
@WebServlet("/delete/exchange")
public class DeleteExchangeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteExchangeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Management mng = new Management();
		@SuppressWarnings("unchecked")
		ArrayList<Map<String, String>> users = (ArrayList<Map<String, String>>) mng.ManagementUser();
		boolean exist_management = false;
		
		if (session.getAttribute("userId") == null || session.getAttribute("password") == null) {
			response.sendRedirect(request.getContextPath() + "/site.login");
		} else {
			for (Map<String, String> user: users) {
				if (session.getAttribute("userId").equals(user.get("user_id")) &&
					session.getAttribute("password").equals(user.get("password"))) {
					exist_management = true;
				}
			}
			
			if (exist_management) {
				response.sendRedirect(request.getContextPath() + "/top");
			} else {
				// 文字化け対策
				request.setCharacterEncoding("UTF-8");
				response.setContentType("text/html;charset=UTF-8");
				
				// 接続情報
				AobagiftDAO db = new AobagiftDAO();
				Connection conn = null;
				
				// SQL
				PreparedStatement pstmt1 = null;
				
				try {
					// データベース接続情報取得
					conn = db.getConnection();
					
					// 送信情報の取得
					String merc_cd = request.getParameter("id");
					String[] exchcodes = request.getParameterValues("exchcodes");
					String[] exch_codes = exchcodes[0].split(",", 0);
					
					// SQL実行準備
					String sql1 = "DELETE FROM MHEM WHERE MERCCD=? AND SHOPCD=?";
					pstmt1 = conn.prepareStatement(sql1);
					pstmt1.setString(1, merc_cd);
					for (String exch_code: exch_codes) {
						pstmt1.setString(2, exch_code);
						pstmt1.executeUpdate();
					}
					
					// エンコード
					merc_cd = URLEncoder.encode(merc_cd, "UTF-8");

					// レスポンス処理
					response.setContentType("text/plain");
					response.setCharacterEncoding("utf8");
					
				} catch (Exception err) {
					((HttpServletResponse) request).sendError(HttpServletResponse.SC_BAD_REQUEST);
				} finally {
					try {
						pstmt1.close();
					} catch (SQLException e) { }
					
					try {
						conn.close();
					} catch (SQLException e) {  }
				}
			}
		}
	}

}
