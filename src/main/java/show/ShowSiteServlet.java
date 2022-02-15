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
 * Servlet implementation class ShowSiteServlet
 */
@WebServlet("/show/site")
public class ShowSiteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShowSiteServlet() {
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
					
					request.getRequestDispatcher("/WEB-INF/app/show/show_site.jsp").forward(request, response);
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
