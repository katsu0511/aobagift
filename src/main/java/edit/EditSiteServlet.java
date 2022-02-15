package edit;

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

import home.AobagiftDAO;
import home.Management;

/**
 * Servlet implementation class EditSiteServlet
 */
@WebServlet("/edit/site")
public class EditSiteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditSiteServlet() {
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
			response.sendRedirect(request.getContextPath() + "/login");
		} else {
			for (Map<String, String> user: users) {
				if (session.getAttribute("userId").equals(user.get("user_id")) &&
					session.getAttribute("password").equals(user.get("password"))) {
					exist_management = true;
				}
			}
			
			if (exist_management) {
				// 文字化け対策
				request.setCharacterEncoding("UTF-8");
				response.setContentType("text/html;charset=UTF-8");
				
				// 接続情報
				AobagiftDAO db = new AobagiftDAO();
				Connection conn = null;
				
				// SQL
				PreparedStatement pstmt = null;
				ResultSet rset = null;
				
				// SITEIDの取得
				String SITEID = request.getParameter("id");
				
				try {
					// データベース接続情報取得
					conn = db.getConnection();
					
					// SITEの情報取得
					String sql = "SELECT * FROM SITE WHERE SITEID=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, SITEID);
					rset = pstmt.executeQuery();
					ArrayList<String> site = new ArrayList<>();
					
					if (rset.next()) {
						for (int i = 1; i <= 29; i++){
							site.add(rset.getString(i));
						}
					}
					
					request.setAttribute("site", site);
					
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
				
				request.getRequestDispatcher("/WEB-INF/app/edit/edit_site.jsp").forward(request, response);
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
		HttpSession session = request.getSession();
		Management mng = new Management();
		@SuppressWarnings("unchecked")
		ArrayList<Map<String, String>> users = (ArrayList<Map<String, String>>) mng.ManagementUser();
		boolean exist_management = false;
		
		if (session.getAttribute("userId") == null || session.getAttribute("password") == null) {
			response.sendRedirect(request.getContextPath() + "/login");
		} else {
			for (Map<String, String> user: users) {
				if (session.getAttribute("userId").equals(user.get("user_id")) &&
					session.getAttribute("password").equals(user.get("password"))) {
					exist_management = true;
				}
			}
			
			if (exist_management) {
				// 文字化け対策
				request.setCharacterEncoding("UTF-8");
				response.setContentType("text/html;charset=UTF-8");
				
				// 接続情報
				AobagiftDAO db = new AobagiftDAO();
				Connection conn = null;
				
				// SQL
				PreparedStatement pstmt1 = null;
				PreparedStatement pstmt2 = null;
				
				// 送信情報の取得
				String site_id = request.getParameter("site_id");
				String user_id = request.getParameter("user_id");
				String password = request.getParameter("password2");
				String site_final_use = request.getParameter("site_final_use");
				String aoba_email = request.getParameter("aoba_email");
				String comment = request.getParameter("comment");
				
				try {
					// データベース接続情報取得
					conn = db.getConnection();
					
					// SITE情報変更
					String sql1 = "UPDATE SITE SET PASSWD=?,STSPDT=?,AOBEML=?,COMMNT=? WHERE SITEID=?";
					pstmt1 = conn.prepareStatement(sql1);
					pstmt1.setString(1, password);
					pstmt1.setString(2, site_final_use);
					pstmt1.setString(3, aoba_email);
					pstmt1.setString(4, comment);
					pstmt1.setString(5, site_id);
					pstmt1.executeUpdate();
					
					// USER情報変更
					String sql2 = "UPDATE USER SET PASSWD=? WHERE USERID=?";
					pstmt2 = conn.prepareStatement(sql2);
					pstmt2.setString(1, password);
					pstmt2.setString(2, user_id);
					pstmt2.executeUpdate();
					
					// エンコード
					user_id = URLEncoder.encode(user_id, "UTF-8");
					password = URLEncoder.encode(password, "UTF-8");
					site_final_use = URLEncoder.encode(site_final_use, "UTF-8");
					aoba_email = URLEncoder.encode(aoba_email, "UTF-8");
					comment = URLEncoder.encode(comment, "UTF-8");
					site_id = URLEncoder.encode(site_id, "UTF-8");
					
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
				
				String url = request.getContextPath() + "/show/site?id=" + site_id;
				response.sendRedirect(url);
			} else {
				response.sendRedirect(request.getContextPath() + "/my_page");
			}
		}
	}

}
