package delete;

import java.io.IOException;
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
 * Servlet implementation class DeleteShopServlet
 */
@WebServlet("/delete/shop")
public class DeleteShopServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteShopServlet() {
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
				
				// SHOPCDの取得
				String SHOPCD = request.getParameter("id");
				
				try {
					// データベース接続情報取得
					conn = db.getConnection();
					
					// MHSMから削除
					String sql1 = "DELETE FROM MHSM WHERE SHOPCD=?";
					pstmt1 = conn.prepareStatement(sql1);
					pstmt1.setString(1, SHOPCD);
					pstmt1.executeUpdate();
					
					// MHEMから削除
					String sql2 = "DELETE FROM MHEM WHERE SHOPCD=?";
					pstmt2 = conn.prepareStatement(sql2);
					pstmt2.setString(1, SHOPCD);
					pstmt2.executeUpdate();
					
					// MHSEから削除
					String sql3 = "DELETE FROM MHSE WHERE SHOPCD=?";
					pstmt3 = conn.prepareStatement(sql3);
					pstmt3.setString(1, SHOPCD);
					pstmt3.executeUpdate();
					
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
				
				response.sendRedirect(request.getContextPath() + "/index/shop");
			} else {
				response.sendRedirect(request.getContextPath() + "/my_page");
			}
		}
	}

}
