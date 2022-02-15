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
 * Servlet implementation class IndexTicketInfoServlet
 */
@WebServlet("/index/ticket_info")
public class IndexTicketInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IndexTicketInfoServlet() {
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
				ResultSet rset1 = null;
				ResultSet rset2 = null;

				try {
					// データベース接続情報取得
					conn = db.getConnection();

					// 注文情報の注文コードを取得
					String sql1 = "SELECT POCD FROM POINF ORDER BY POCD ASC";
					pstmt1 = conn.prepareStatement(sql1);
					rset1 = pstmt1.executeQuery();
					ArrayList<Map<String, String>> poinfs = new ArrayList<Map<String, String>>();

					while (rset1.next()) {
						String pocd = rset1.getString(1);
						Map<String, String> rec = new HashMap<>();
						rec.put("pocd", pocd);
						poinfs.add(rec);
					}
					request.setAttribute("poinfs", poinfs);

					// 注文情報のギフトIDを取得
					String sql2 = "SELECT DISTINCT GIFTID FROM POINF ORDER BY GIFTID ASC";
					pstmt2 = conn.prepareStatement(sql2);
					rset2 = pstmt2.executeQuery();
					ArrayList<Map<String, String>> gifts = new ArrayList<Map<String, String>>();

					while (rset2.next()) {
						String giftid = rset2.getString(1);
						Map<String, String> rec = new HashMap<>();
						rec.put("giftid", giftid);
						gifts.add(rec);
					}
					request.setAttribute("gifts", gifts);

				} catch (SQLException e) {
					e.printStackTrace();

				} finally {
					try {
						pstmt1.close();
					} catch (SQLException e) { }
					try {
						conn.close();
					} catch (SQLException e) {  }
				}

				// ギフト注文画面表示
				request.getRequestDispatcher("/WEB-INF/app/index/index_ticket_info.jsp").forward(request, response);
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
