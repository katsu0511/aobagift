package delete;

import java.io.IOException;
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
 * Servlet implementation class DeleteSiteServlet
 */
@WebServlet("/delete/site")
public class DeleteSiteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteSiteServlet() {
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
				doPost(request, response);
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
				
				// SQL情報管理
				PreparedStatement pstmt1 = null;
				PreparedStatement pstmt2 = null;
				PreparedStatement pstmt3 = null;
				PreparedStatement pstmt4 = null;
				PreparedStatement pstmt5 = null;
				PreparedStatement pstmt6 = null;
				PreparedStatement pstmt7 = null;
				ResultSet rset1 = null;
				ResultSet rset2 = null;
				
				// SITEIDの取得
				String SITEID = request.getParameter("id");
				
				try {
					// データベース接続情報取得
					conn = db.getConnection();
					
					// USERID,PASSWD取得
					String sql1 = "SELECT USERID,PASSWD FROM SITE WHERE SITEID=?";
					pstmt1 = conn.prepareStatement(sql1);
					pstmt1.setString(1, SITEID);
					rset1 = pstmt1.executeQuery();
					String USERID = null;
					String PASSWD = null;
					
					if (rset1.next()) {
						USERID = rset1.getString(1);
						PASSWD = rset1.getString(2);
					}
					
					
					
					// MERCCD取得
					String sql2 = "SELECT MERCCD FROM MHMM WHERE SITEID=?";
					pstmt2 = conn.prepareStatement(sql2);
					pstmt2.setString(1, SITEID);
					rset2 = pstmt2.executeQuery();
					ArrayList<String> merccds = new ArrayList<>();
					
					while (rset2.next()) {
						merccds.add(rset2.getString(1));
					}
					
					
					
					// USERから削除
					String sql3 = "DELETE FROM USER WHERE USERID=? AND PASSWD=?";
					pstmt3 = conn.prepareStatement(sql3);
					pstmt3.setString(1, USERID);
					pstmt3.setString(2, PASSWD);
					pstmt3.executeUpdate();
					
					
					
					// MHEMから削除
					String sql4 = "DELETE FROM MHEM WHERE MERCCD=?";
					pstmt4 = conn.prepareStatement(sql4);
					for (String merccd: merccds) {
						pstmt4.setString(1, merccd);
						pstmt4.executeUpdate();
					}
					
					
					
					// MHMMから削除
					String sql5 = "DELETE FROM MHMM WHERE MERCCD=?";
					pstmt5 = conn.prepareStatement(sql5);
					for (String merccd: merccds) {
						pstmt5.setString(1, merccd);
						pstmt5.executeUpdate();
					}
					
					
					
					// SITEから削除
					String sql6 = "DELETE FROM SITE WHERE SITEID=?";
					pstmt6 = conn.prepareStatement(sql6);
					pstmt6.setString(1, SITEID);
					pstmt6.executeUpdate();
					
					
					
					// このSITEIDを登録しているMHGMのSITEIDを更新
					String sql7 = "UPDATE MHGM SET SITEID='' WHERE SITEID=?";
					pstmt7 = conn.prepareStatement(sql7);
					pstmt7.setString(1, SITEID);
					pstmt7.executeUpdate();
					
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
						pstmt3.close();
					} catch (SQLException e) { }
					
					try {
						pstmt4.close();
					} catch (SQLException e) { }
					
					try {
						pstmt5.close();
					} catch (SQLException e) { }
					
					try {
						pstmt6.close();
					} catch (SQLException e) { }
					
					try {
						pstmt7.close();
					} catch (SQLException e) { }
					
					try {
						conn.close();
					} catch (SQLException e) {  }
				}
				
				response.sendRedirect(request.getContextPath() + "/index/site");
			} else {
				response.sendRedirect(request.getContextPath() + "/my_page");
			}
		}
	}

}
