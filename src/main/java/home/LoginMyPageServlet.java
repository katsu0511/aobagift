package home;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginMyPageServlet
 */
@WebServlet("/site.login")
public class LoginMyPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginMyPageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Management mng = new Management();
		@SuppressWarnings("unchecked")
		ArrayList<Map<String, String>> users = (ArrayList<Map<String, String>>) mng.ManagementUser();
		boolean exist_management = false;
		
		if (session.getAttribute("userId") == null || session.getAttribute("password") == null) {
			request.getRequestDispatcher("/WEB-INF/app/user/site_login.jsp").forward(request, response);
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
				response.sendRedirect(request.getContextPath() + "/my_page");
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		// 文字化け対策
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		// 接続情報
		AobagiftDAO db = new AobagiftDAO();
		Connection conn = null;
		
		// SQL
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		// 送信情報の取得
		String siteId = request.getParameter("siteId");
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");

		// エラーメッセージ
		String errorMessage = null;
		
		// データベース接続管理クラスの変数宣言
		DBManager dbm = new DBManager();
		
		// ログインユーザー情報取得
		UserDTO user = dbm.getLoginUser(userId, password);
			
		if (siteId.equals("") || userId.equals("") || password.equals("")) {
			
			errorMessage = "サイトID、ユーザーID、パスワードをすべて入力してください";
			request.setAttribute("errorMessage", errorMessage);
			request.getRequestDispatcher("/WEB-INF/app/user/site_login.jsp").forward(request, response);
			
		} else if (user != null) {
			
			try {
				// データベース接続情報取得
				conn = db.getConnection();
				
				// SITEID取得
				String sql = "SELECT SITEID FROM SITE WHERE USERID=? AND PASSWD=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userId);
				pstmt.setString(2, password);
				rset = pstmt.executeQuery();
				String SITEID = null;
				
				if (rset.next()) {
					SITEID = rset.getString(1);
				}
				
				
				
				if (SITEID == null) {
					errorMessage = "このユーザーID、パスワードではサイトにログインできません";
					request.setAttribute("errorMessage", errorMessage);
					request.getRequestDispatcher("/WEB-INF/app/user/site_login.jsp").forward(request, response);
				} else if (SITEID.equals(siteId)) {
					HttpSession session = request.getSession();
					session.setAttribute("siteId", siteId);
					session.setAttribute("userId", userId);
					session.setAttribute("password", password);
					
					siteId = URLEncoder.encode(siteId, "UTF-8");
					userId = URLEncoder.encode(userId, "UTF-8");
					password = URLEncoder.encode(password, "UTF-8");
					
					response.sendRedirect(request.getContextPath() + "/my_page");
				} else {
					errorMessage = "サイトIDが間違っています";
					request.setAttribute("errorMessage", errorMessage);
					request.getRequestDispatcher("/WEB-INF/app/user/site_login.jsp").forward(request, response);
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				
				try {
					pstmt.close();
				} catch (SQLException e) { }
				
				try {
					conn.close();
				} catch (SQLException e) {  }
			}
			
		} else {
			
			errorMessage = "ユーザーIDかパスワードが間違っています";
			request.setAttribute("errorMessage", errorMessage);
			request.getRequestDispatcher("/WEB-INF/app/user/site_login.jsp").forward(request, response);
			
		}
	}

}
