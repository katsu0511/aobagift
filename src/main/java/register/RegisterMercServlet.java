package register;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import home.AobagiftDAO;
import home.Management;

/**
 * Servlet implementation class RegisterMercServlet
 */
@WebServlet("/register/merc")
@MultipartConfig(
	maxFileSize=10000000,
	maxRequestSize=10000000,
	fileSizeThreshold=10000000
)
public class RegisterMercServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterMercServlet() {
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
				
				// SQL
				PreparedStatement pstmt1 = null;
				PreparedStatement pstmt2 = null;
				ResultSet rset1 = null;
				ResultSet rset2 = null;
				
				try {
					// データベース接続情報取得
					conn = db.getConnection();
					
					// SITEID情報取得
					String sql1 = "SELECT SITEID FROM SITE WHERE USERID=? AND PASSWD=?";
					pstmt1 = conn.prepareStatement(sql1);
					String userId = (String) session.getAttribute("userId");
					String password = (String) session.getAttribute("password");
					pstmt1.setString(1, userId);
					pstmt1.setString(2, password);
					rset1 = pstmt1.executeQuery();
					String SITEID = null;
					
					if (rset1.next()) {
						SITEID = rset1.getString(1);
					}
					
					request.setAttribute("SITEID", SITEID);
					
					
					
					// MERCCD
					String sql2 = "SELECT MERCCD FROM MHMM WHERE SITEID=? ORDER BY MERCCD DESC LIMIT 1";
					pstmt2 = conn.prepareStatement(sql2);
					pstmt2.setString(1, SITEID);
					rset2 = pstmt2.executeQuery();
					String merccd = null;
					
					if (rset2.next()) {
						merccd = rset2.getString(1);
					} else {
						merccd = SITEID + "0000";
					}
					
					String num1 = merccd.substring(6,10);
					int num2 = Integer.parseInt(num1);
					String num3 = String.format("%04d", num2 + 1);
					String MERCCD = SITEID + num3;
					
					request.setAttribute("MERCCD", MERCCD);
					
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
				
				request.getRequestDispatcher("/WEB-INF/app/register/register_merc.jsp").forward(request, response);
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
				
				// SQL
				PreparedStatement pstmt = null;
				
				// 送信情報の取得
				String merc_code = request.getParameter("merc_code");
				String site_id = request.getParameter("site_id");
				String merc_name = request.getParameter("merc_name");
				String comment = request.getParameter("comment");
				
				// 商品ロゴのファイル名取得
				// ファイル名重複対策でファイル名の先頭に商品コードを付与する
				Part part = request.getPart("merc_logo");
				String mercLogoOriginalFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
				String merc_logo = mercLogoOriginalFileName.isEmpty() ? "" : merc_code + "_" + mercLogoOriginalFileName;
				
				try {
					// データベース接続情報取得
					conn = db.getConnection();
					
					// SQL
					String sql = "INSERT INTO MHMM";
					if (merc_logo.isEmpty()) {
						sql += "(MERCCD,SITEID,MERCNM,COMMNT) VALUES(?,?,?,?)";
					}
					else {
						sql += "(MERCCD,SITEID,MERCNM,COMMNT,MERCLG) VALUES(?,?,?,?,?)";
					}
					
					// SQL実行
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, merc_code);
					pstmt.setString(2, site_id);
					pstmt.setString(3, merc_name);
					pstmt.setString(4, comment);
					if (merc_logo.isEmpty()) {
						pstmt.executeUpdate();
					}
					else {
						pstmt.setString(5, merc_logo);
						pstmt.executeUpdate();

						// 画像アップロード
						String path = getServletContext().getRealPath("/logo_merc");
						part.write(path + File.separator + merc_logo);
					}
					
					// エンコード
					merc_code = URLEncoder.encode(merc_code, "UTF-8");
					site_id = URLEncoder.encode(site_id, "UTF-8");
					merc_name = URLEncoder.encode(merc_name, "UTF-8");
					merc_logo = URLEncoder.encode(merc_logo, "UTF-8");
					comment = URLEncoder.encode(comment, "UTF-8");
					
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
				
				if (request.getParameter("submit").equals("登録終了")) {
					response.sendRedirect(request.getContextPath() + "/index/merc");
				} else {
					response.sendRedirect(request.getContextPath() + "/register/merc");
				}
			}
		}
	}

}
