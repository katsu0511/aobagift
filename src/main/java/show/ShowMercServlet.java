package show;

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
 * Servlet implementation class ShowMercServlet
 */
@WebServlet("/show/merc")
public class ShowMercServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShowMercServlet() {
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
				PreparedStatement pstmt3 = null;
				PreparedStatement pstmt4 = null;
				PreparedStatement pstmt5 = null;
				PreparedStatement pstmt6 = null;
				ResultSet rset1 = null;
				ResultSet rset2 = null;
				ResultSet rset3 = null;
				ResultSet rset4 = null;
				ResultSet rset5 = null;
				ResultSet rset6 = null;
				
				// MERCCDの取得
				String MERCCD = request.getParameter("id");
				
				try {
					// データベース接続情報取得
					conn = db.getConnection();
					
					// MHMMの情報取得
					String sql1 = "SELECT * FROM MHMM WHERE MERCCD=?";
					pstmt1 = conn.prepareStatement(sql1);
					pstmt1.setString(1, MERCCD);
					rset1 = pstmt1.executeQuery();
					ArrayList<String> merc = new ArrayList<>();
					String SITEID = null;
					
					if (rset1.next()) {
						for (int i = 1; i <= 6; i++){
							merc.add(rset1.getString(i));
						}
						SITEID = rset1.getString(2);
					}
					
					request.setAttribute("merc", merc);
					
					
					
					
					// SITENMの情報取得
					String sql2 = "SELECT SITENM FROM SITE WHERE SITEID=?";
					pstmt2 = conn.prepareStatement(sql2);
					pstmt2.setString(1, SITEID);
					rset2 = pstmt2.executeQuery();
					String SITENM = null;
					
					if (rset2.next()) {
						SITENM = rset2.getString(1);
					}
					
					request.setAttribute("SITENM", SITENM);
					
					
					
					// MHEMの情報取得
					String sql3 = "SELECT SHOPCD FROM MHEM WHERE MERCCD=?";
					pstmt3 = conn.prepareStatement(sql3);
					pstmt3.setString(1, MERCCD);
					rset3 = pstmt3.executeQuery();
					ArrayList<Map<String, String>> exch_shops = new ArrayList<Map<String, String>>();
					
					while (rset3.next()) {
						String SHOPCD = rset3.getString(1);
						
						// SHOPNMの取得
						String sql4 = "SELECT SHOPNM FROM MHSM WHERE SHOPCD=?";
						pstmt4 = conn.prepareStatement(sql4);
						pstmt4.setString(1, SHOPCD);
						rset4 = pstmt4.executeQuery();
						if (rset4.next()) {
							Map<String, String> exch_shop = new HashMap<>();
							exch_shop.put("SHOPCD", rset3.getString(1));
							exch_shop.put("SHOPNM", rset4.getString(1));
							exch_shops.add(exch_shop);
						}
					}
					
					request.setAttribute("exch_shops", exch_shops);
					
					
					
					
					// CHNLCDの情報取得
					String sql5 = "SELECT CHNLCD FROM SITE WHERE SITEID=?";
					pstmt5 = conn.prepareStatement(sql5);
					pstmt5.setString(1, SITEID);
					rset5 = pstmt5.executeQuery();
					String CHNLCD = null;
					
					if (rset5.next()) {
						CHNLCD = rset5.getString(1);
					}
					
					
					
					
					// 指定のチャネルコードに属しているショップを取得
					String sql6 = "SELECT SHOPCD,SHOPNM FROM MHSM WHERE CHNLCD=?";
					pstmt6 = conn.prepareStatement(sql6);
					pstmt6.setString(1, CHNLCD);
					rset6 = pstmt6.executeQuery();
					ArrayList<Map<String, String>> shops = new ArrayList<Map<String, String>>();
					
					while (rset6.next()) {
						Map<String, String> shop = new HashMap<>();
						shop.put("SHOPCD", rset6.getString(1));
						shop.put("SHOPNM", rset6.getString(2));
						shops.add(shop);
					}
					
					request.setAttribute("shops", shops);
					
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
						if (rset3.next()) {
							pstmt4.close();
						}
					} catch (SQLException e) { }
					
					try {
						pstmt5.close();
					} catch (SQLException e) { }
					
					try {
						pstmt6.close();
					} catch (SQLException e) { }
					
					try {
						conn.close();
					} catch (SQLException e) {  }
				}
				
				request.getRequestDispatcher("/WEB-INF/app/show/show_merc.jsp").forward(request, response);
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
