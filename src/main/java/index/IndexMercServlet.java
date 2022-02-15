package index;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
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
 * Servlet implementation class IndexMercServlet
 */
@WebServlet("/index/merc")
public class IndexMercServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IndexMercServlet() {
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
				
				// SQL情報管理
				PreparedStatement pstmt1 = null;
				PreparedStatement pstmt2 = null;
				ResultSet rset1 = null;
				ResultSet rset2 = null;
				
				// ログイン情報の取得
				String USERID = (String) session.getAttribute("userId");
				String PASSWD = (String) session.getAttribute("password");

				try {
					// データベース接続情報取得
					conn = db.getConnection();
					
					// SITEIDの取得
					String sql1 = "SELECT SITEID FROM SITE WHERE USERID=? AND PASSWD=?";
					pstmt1 = conn.prepareStatement(sql1);
					pstmt1.setString(1, USERID);
					pstmt1.setString(2, PASSWD);
					rset1 = pstmt1.executeQuery();
					String SITEID = null;
					
					if (rset1.next()) {
						SITEID = rset1.getString(1);
					}
					
					request.setAttribute("SITEID", SITEID);
					
					
					
					// MHMMの情報取得
					String sql2 = "SELECT MERCCD,MERCNM FROM MHMM WHERE SITEID=? ORDER BY MERCCD";
					pstmt2 = conn.prepareStatement(sql2);
					pstmt2.setString(1, SITEID);
					rset2 = pstmt2.executeQuery();
					ArrayList<Map<String, String>> mercs = new ArrayList<Map<String, String>>();
					
					while (rset2.next()) {
						Map<String, String> merc = new HashMap<>();
						merc.put("MERCCD", rset2.getString(1));
						merc.put("MERCNM", rset2.getString(2));
						mercs.add(merc);
					}
					
					request.setAttribute("mercs", mercs);
					
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					try {
						pstmt1.close();
					} catch (SQLException e) { }
					
					try {
						pstmt2.close();
					} catch (SQLException e) { }
					
					try {
						conn.close();
					} catch (SQLException e) {  }
				}
				
				request.getRequestDispatcher("/WEB-INF/app/index/index_merc.jsp").forward(request, response);
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
