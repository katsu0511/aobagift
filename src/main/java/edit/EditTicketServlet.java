package edit;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
 * Servlet implementation class EditTicketServlet
 */
@WebServlet("/edit/ticket")
public class EditTicketServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditTicketServlet() {
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

				PreparedStatement pstmt1 = null;
				ResultSet rset1 = null;

				// チケットコードの取得
				String TCKTCD = request.getParameter("TCKTCD");

				try {
					// データベース接続情報取得
					conn = db.getConnection();

					// 購入者情報取得
					String sql1 = "SELECT TCKTCD,STATUS FROM GFTCKT WHERE TCKTCD=?";
					pstmt1 = conn.prepareStatement(sql1);
					pstmt1.setString(1, TCKTCD);
					rset1 = pstmt1.executeQuery();
					ArrayList<String> gftckt = new ArrayList<>();

					if (rset1.next()) {
						for (int i = 1; i <= 2; i++){
							gftckt.add(rset1.getString(i));
						}
					}

					request.setAttribute("gftckt", gftckt);
					
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
				
				request.getRequestDispatcher("/WEB-INF/app/edit/edit_ticket.jsp").forward(request, response);
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

				// 入力情報の取得
				String tcktcd = request.getParameter("TCKTCD");
				String status = request.getParameter("STATUS");

				PreparedStatement pstmt1 = null;
				PreparedStatement pstmt2 = null;
				PreparedStatement pstmt3 = null;
				ResultSet rset2 = null;

				try {
					// データベース接続情報取得
					conn = db.getConnection();

					// SQL
					String sql1 = "UPDATE GFTCKT SET STATUS=? WHERE TCKTCD=?";
					String sql2 = "SELECT COUNT(*) FROM EXCHST WHERE TCKTCD=?";
					String sql3A = "UPDATE EXCHST SET EXCMTHD='3',SHOPCD='',MERCCD='',EXCDT=? WHERE TCKTCD=?";
					String sql3B = "INSERT INTO EXCHST(TCKTCD,EXCMTHD,SHOPCD,MERCCD,EXCDT) VALUES(?,'3','','',?)";
					String sql3C = "DELETE FROM EXCHST WHERE TCKTCD=?";

					// ギフトチケットテーブル更新のSQLを実行
					pstmt1 = conn.prepareStatement(sql1);
					pstmt1.setString(1, status);
					pstmt1.setString(2, tcktcd);
					pstmt1.executeUpdate();

					if ("1".equals(status)) {
						// 更新日時取得
						LocalDateTime date = LocalDateTime.now();
						DateTimeFormatter dtformat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
						String update = dtformat.format(date);

						// 交換履歴テーブル更新のSQLを実行
						pstmt2 = conn.prepareStatement(sql2);
						pstmt2.setString(1, tcktcd);
						rset2 = pstmt2.executeQuery();
						if (rset2.next()) {
							if (rset2.getInt(1) > 0) {
								pstmt3 = conn.prepareStatement(sql3A);
								pstmt3.setString(1, update);
								pstmt3.setString(2, tcktcd);
							}
							else {
								pstmt3 = conn.prepareStatement(sql3B);
								pstmt3.setString(1, tcktcd);
								pstmt3.setString(2, update);
							}
							pstmt3.executeUpdate();
						}
					}
					else {
						// 交換履歴テーブルからレコードを削除するSQLを実行
						pstmt3 = conn.prepareStatement(sql3C);
						pstmt3.setString(1, tcktcd);
						pstmt3.executeUpdate();
					}

					// エンコード
					tcktcd = URLEncoder.encode(tcktcd, "UTF-8");
					status = URLEncoder.encode(status, "UTF-8");

				} catch (SQLException e) {
					e.printStackTrace();

				} finally {
					try {
						if(pstmt1!=null) pstmt1.close();
						if(pstmt2!=null) pstmt2.close();
						if(pstmt3!=null) pstmt3.close();
					} catch (SQLException e) { }
					try {
						conn.close();
					} catch (SQLException e) {  }
				}
				response.sendRedirect(request.getContextPath() + "/index/ticket");
			} else {
				response.sendRedirect(request.getContextPath() + "/my_page");
			}
		}
	}

}
