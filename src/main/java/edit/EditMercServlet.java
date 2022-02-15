package edit;

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
 * Servlet implementation class EditMercServlet
 */
@WebServlet("/edit/merc")
@MultipartConfig(
	maxFileSize=10000000,
	maxRequestSize=10000000,
	fileSizeThreshold=10000000
)
public class EditMercServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditMercServlet() {
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
				PreparedStatement pstmt = null;
				ResultSet rset = null;
				
				// MERCCDの取得
				String MERCCD = request.getParameter("id");
				
				try {
					// データベース接続情報取得
					conn = db.getConnection();
					
					// MHMM情報を取得
					String sql = "SELECT * FROM MHMM WHERE MERCCD=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, MERCCD);
					rset = pstmt.executeQuery();
					ArrayList<String> merc = new ArrayList<>();
					
					if (rset.next()) {
						for (int i = 1; i < 6; i++){
							merc.add(rset.getString(i));
						}
					}
					
					request.setAttribute("merc", merc);
					
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
				
				request.getRequestDispatcher("/WEB-INF/app/edit/edit_merc.jsp").forward(request, response);
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
					
					if (merc_logo.isEmpty()) {
						// MHMM情報変更
						String sql = "UPDATE MHMM SET MERCNM=?,COMMNT=? WHERE MERCCD=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, merc_name);
						pstmt.setString(2, comment);
						pstmt.setString(3, merc_code);
						pstmt.executeUpdate();
					} else {
						// MHMM情報変更
						String sql = "UPDATE MHMM SET MERCNM=?,MERCLG=?,COMMNT=? WHERE MERCCD=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, merc_name);
						pstmt.setString(2, merc_logo);
						pstmt.setString(3, comment);
						pstmt.setString(4, merc_code);
						pstmt.executeUpdate();
						
						// 画像アップロード
						String path = getServletContext().getRealPath("/logo_merc");
						part.write(path + File.separator + merc_logo);
					}
					
					// エンコード
					merc_code = URLEncoder.encode(merc_code, "UTF-8");
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
				
				String url = request.getContextPath() + "/show/merc?id=" + merc_code;
				response.sendRedirect(url);
			}
		}
	}

}
