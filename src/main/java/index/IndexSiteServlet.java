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
 * Servlet implementation class IndexSiteServlet
 */
@WebServlet("/index/site")
public class IndexSiteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IndexSiteServlet() {
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
				
				// SQL情報管理
				PreparedStatement pstmt1 = null;
				PreparedStatement pstmt2 = null;
				PreparedStatement pstmt3 = null;
				ResultSet rset1 = null;
				ResultSet rset2 = null;
				ResultSet rset3 = null;

				try {
					// データベース接続情報取得
					conn = db.getConnection();
					
					// SITEの情報取得
					String sql1 = "SELECT SITEID,SITENM,CHNLNM,REQUNM FROM SITE ORDER BY ETDTTM ASC";
					pstmt1 = conn.prepareStatement(sql1);
					rset1 = pstmt1.executeQuery();
					ArrayList<Map<String, String>> sites = new ArrayList<Map<String, String>>();
					
					while (rset1.next()) {
						Map<String, String> site = new HashMap<>();
						site.put("SITEID", rset1.getString(1));
						site.put("SITENM", rset1.getString(2));
						site.put("CHNLNM", rset1.getString(3));
						site.put("REQUNM", rset1.getString(4));
						sites.add(site);
					}
					
					request.setAttribute("sites", sites);
					
					// MHCMの情報取得
					String sql2 = "SELECT CHNLNM FROM MHCM ORDER BY CHNLCD ASC";
					pstmt2 = conn.prepareStatement(sql2);
					rset2 = pstmt2.executeQuery();
					ArrayList<String> channels = new ArrayList<String>();
					
					while (rset2.next()) {
						channels.add(rset2.getString(1));
					}
					
					request.setAttribute("channels", channels);
					
					// MHRMの情報取得
					String sql3 = "SELECT REQUNM FROM MHRM ORDER BY REQUCD ASC";
					pstmt3 = conn.prepareStatement(sql3);
					rset3 = pstmt3.executeQuery();
					ArrayList<String> requesters = new ArrayList<String>();
					
					while (rset3.next()) {
						requesters.add(rset3.getString(1));
					}
					
					request.setAttribute("requesters", requesters);
					
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
						conn.close();
					} catch (SQLException e) {  }
				}
				
				request.getRequestDispatcher("/WEB-INF/app/index/index_site.jsp").forward(request, response);
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
		doGet(request, response);
	}

}
