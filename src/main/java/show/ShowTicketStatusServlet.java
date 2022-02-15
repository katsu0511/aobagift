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
 * Servlet implementation class ShowTicketStatusServlet
 */
@WebServlet("/show/ticket_status")
public class ShowTicketStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShowTicketStatusServlet() {
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

					// ギフトチケット情報取得
					String sql1 = "SELECT TCKTCD,STATUS,URL FROM GFTCKT WHERE POCD=?";
					pstmt1 = conn.prepareStatement(sql1);
					pstmt1.setString(1,POCD);
					rset1 = pstmt1.executeQuery();
					ArrayList<Map<String, String>> gftckts = new ArrayList<Map<String, String>>();

					while (rset1.next()) {
						Map<String, String> rec = new HashMap<>();
						rec.put("tcktcd", rset1.getString(1));
						rec.put("status", rset1.getString(2));
						rec.put("url", rset1.getString(3));
						gftckts.add(rec);
					}
					request.setAttribute("gftckts", gftckts);

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

				request.getRequestDispatcher("/WEB-INF/app/show/show_ticket_status.jsp").forward(request, response);
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
