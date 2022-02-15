package show;

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
 * Servlet implementation class ShowPurchaseInfoServlet
 */
@WebServlet("/show/purchase_info")
public class ShowPurchaseInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShowPurchaseInfoServlet() {
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
				ResultSet rset1 = null;

				// 注文コードの取得
				String POCD = request.getParameter("POCD");

				try {
					// データベース接続情報取得
					conn = db.getConnection();

					// 注文情報取得
					String sql1 = "SELECT"
						+ " POINF.POCD AS POCD, POINF.GIFTID AS GIFTID, POINF.SITEID AS SITEID,"
						+ " POINF.PCCD AS PCCD, POINF.TCKTNUM AS TCKTNUM, POINF.VLDDT AS VLDDT,"
						+ " PCINF.CORPNM AS CORPNM"
						+ " FROM POINF LEFT JOIN PCINF ON POINF.PCCD=PCINF.PCCD"
						+ " WHERE POCD=?";
					pstmt1 = conn.prepareStatement(sql1);
					pstmt1.setString(1,POCD);
					rset1 = pstmt1.executeQuery();
					ArrayList<String> purchase_info = new ArrayList<>();
					if (rset1.next()) {
						for (int i = 1; i <= 7; i++){
							purchase_info.add(rset1.getString(i));
						}
					}
					request.setAttribute("purchase_info",purchase_info);

				} catch (SQLException e) {
					e.printStackTrace();

				} finally {
					try {
						pstmt1.close();
						conn.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}

				request.getRequestDispatcher("/WEB-INF/app/show/show_purchase_info.jsp").forward(request, response);
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
