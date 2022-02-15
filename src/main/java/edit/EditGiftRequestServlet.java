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
import java.util.HashMap;
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
 * Servlet implementation class EditGiftRequestServlet
 */
@WebServlet("/edit/gift_request")
@MultipartConfig(
	maxFileSize=10000000,
	maxRequestSize=10000000,
	fileSizeThreshold=10000000
)
public class EditGiftRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditGiftRequestServlet() {
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
				
				// SQL
				PreparedStatement pstmt1 = null;
				PreparedStatement pstmt2 = null;
				ResultSet rset1 = null;
				ResultSet rset2 = null;
				
				// GIFTIDの取得
				String GIFTID = request.getParameter("id");
				
				try {
					// データベース接続情報取得
					conn = db.getConnection();
					
					// MHGMの情報取得
					String sql1 = "SELECT * FROM MHGM WHERE GIFTID=?";
					pstmt1 = conn.prepareStatement(sql1);
					pstmt1.setString(1, GIFTID);
					rset1 = pstmt1.executeQuery();
					ArrayList<String> gift = new ArrayList<>();
					String CHNLCD = null;
					
					if (rset1.next()) {
						for (int i = 1; i <= 29; i++){
							gift.add(rset1.getString(i));
						}
						CHNLCD = rset1.getString(4);
					}
					
					request.setAttribute("gift", gift);
					
					
					
					// SITEの情報を取得
					String sql2 = "SELECT SITEID,SITENM FROM SITE WHERE CHNLCD=? ORDER BY ETDTTM ASC";
					pstmt2 = conn.prepareStatement(sql2);
					pstmt2.setString(1, CHNLCD);
					rset2 = pstmt2.executeQuery();
					ArrayList<Map<String, String>> sites = new ArrayList<Map<String, String>>();
					
					while (rset2.next()) {
						Map<String, String> site = new HashMap<>();
						site.put("SITEID", rset2.getString(1));
						site.put("SITENM", rset2.getString(2));
						sites.add(site);
					}
					
					request.setAttribute("sites", sites);
					
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
				
				request.getRequestDispatcher("/WEB-INF/app/edit/edit_gift_request.jsp").forward(request, response);
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
				
				PreparedStatement pstmt = null;
				
				// 送信情報の取得
				String gift_id = request.getParameter("gift_id");
				String final_sale_date = request.getParameter("final_sale_date");
				String site_id = request.getParameter("site_id");
				String comment = request.getParameter("comment");
				
				// ギフトロゴのファイル名取得
				// ファイル名重複対策でファイル名の先頭にギフトIDを付与する
				Part part = request.getPart("gift_logo");
				String giftLogoOriginalFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
				String gift_logo = giftLogoOriginalFileName.isEmpty() ? "" : gift_id + "_" + giftLogoOriginalFileName;
				
				try {
					// データベース接続情報取得
					conn = db.getConnection();
					
					// SQL実行
					if (gift_logo.isEmpty()) {
						String sql = "UPDATE MHGM SET SLFNDT=?,SITEID=?,COMMNT=? WHERE GIFTID=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, final_sale_date);
						pstmt.setString(2, site_id);
						pstmt.setString(3, comment);
						pstmt.setString(4, gift_id);
						pstmt.executeUpdate();
					} else {
						String sql = "UPDATE MHGM SET GIFTLG=?,SLFNDT=?,SITEID=?,COMMNT=? WHERE GIFTID=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, gift_logo);
						pstmt.setString(2, final_sale_date);
						pstmt.setString(3, site_id);
						pstmt.setString(4, comment);
						pstmt.setString(5, gift_id);
						pstmt.executeUpdate();
						
						// 画像アップロード
						String path = getServletContext().getRealPath("/logo_gift");
						part.write(path + File.separator + gift_logo);
					}
					
					// エンコード
					gift_logo = URLEncoder.encode(gift_logo, "UTF-8");
					final_sale_date = URLEncoder.encode(final_sale_date, "UTF-8");
					site_id = URLEncoder.encode(site_id, "UTF-8");
					comment = URLEncoder.encode(comment, "UTF-8");
					gift_id = URLEncoder.encode(gift_id, "UTF-8");
					
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
				
				String url = request.getContextPath() + "/show/gift_request?id=" + gift_id;
				response.sendRedirect(url);
			} else {
				response.sendRedirect(request.getContextPath() + "/my_page");
			}
		}
	}

}
