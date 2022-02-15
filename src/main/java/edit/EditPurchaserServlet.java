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
 * Servlet implementation class EditPurchaserServlet
 */
@WebServlet("/edit/purchaser")
@MultipartConfig(
	maxFileSize=10000000,
	maxRequestSize=10000000,
	fileSizeThreshold=10000000
)
public class EditPurchaserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditPurchaserServlet() {
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

				// 購入者コードの取得
				String PCCD = request.getParameter("pccd");

				try {
					// データベース接続情報取得
					conn = db.getConnection();

					// 購入者情報取得
					String sql1 = "SELECT * FROM PCINF WHERE PCCD=?";
					pstmt1 = conn.prepareStatement(sql1);
					pstmt1.setString(1, PCCD);
					rset1 = pstmt1.executeQuery();
					ArrayList<String> pcinf = new ArrayList<>();

					if (rset1.next()) {
						for (int i = 1; i <= 20; i++){
							pcinf.add(rset1.getString(i));
						}
					}

					request.setAttribute("pcinf", pcinf);
					
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
				
				request.getRequestDispatcher("/WEB-INF/app/edit/edit_purchaser.jsp").forward(request, response);
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
				String pccd = request.getParameter("pccd");
				String corpnm = request.getParameter("corpnm");
				String corpnf = request.getParameter("corpnf");
				String postcode1 = request.getParameter("zip1");
				String postcode2 = request.getParameter("zip2");
				String address1 = request.getParameter("address1");
				String address2 = request.getParameter("address2");
				String address3 = request.getParameter("address3");
				String address4 = request.getParameter("address4");
				String number1 = request.getParameter("number1");
				String number2 = request.getParameter("number2");
				String email = request.getParameter("email");
				String bank_code = request.getParameter("bank_code");
				String bank = request.getParameter("bank");
				String branch_code = request.getParameter("branch_code");
				String bank_branch = request.getParameter("bank_branch");
				String account_type = request.getParameter("account_type");
				String account_number = request.getParameter("account_number");
				String acount_name = request.getParameter("acount_name");

				// 購入者ロゴのファイル名取得
				// ファイル名重複対策でファイル名の先頭に購入者コードを付与する
				Part part = request.getPart("corplg");
				String corplgOriginalFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
				String corplg = corplgOriginalFileName.isEmpty() ? "" : pccd + "_" + corplgOriginalFileName;

				PreparedStatement pstmt = null;
				try {
					// データベース接続情報取得
					conn = db.getConnection();

					// SQL
					String sqlCorplg = corplg.isEmpty() ? "" : ",CORPLG=?";
					String sql = "UPDATE PCINF SET CORPNM=?,CORPNF=?,ZIPCOD=?,STATNM=?,CITYNM=?,STRNO1=?,STRNO2=?,PHONE1=?,PHONE2=?,EMLADR=?,BANKCD=?,BANKNM=?,BRNCCD=?,BANKBR=?,ACNTTY=?,ACNTNU=?,ACNTNM=?"+sqlCorplg+" WHERE PCCD=?";

					// SQL実行
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, corpnm);
					pstmt.setString(2, corpnf);
					pstmt.setString(3, postcode1 + "-" + postcode2);
					pstmt.setString(4, address1);
					pstmt.setString(5, address2);
					pstmt.setString(6, address3);
					pstmt.setString(7, address4);
					pstmt.setString(8, number1);
					pstmt.setString(9, number2);
					pstmt.setString(10, email);
					pstmt.setString(11, bank_code);
					pstmt.setString(12, bank);
					pstmt.setString(13, branch_code);
					pstmt.setString(14, bank_branch);
					pstmt.setString(15, account_type);
					pstmt.setString(16, account_number);
					pstmt.setString(17, acount_name);
					if (corplg.isEmpty()) {
						pstmt.setString(18, pccd);
						pstmt.executeUpdate();
					}
					else {
						pstmt.setString(18, corplg);
						pstmt.setString(19, pccd);
						pstmt.executeUpdate();

						// 画像アップロード
						String path = getServletContext().getRealPath("/logo_corp");
						part.write(path + File.separator + corplg);
					}

					// エンコード
					pccd = URLEncoder.encode(pccd, "UTF-8");
					corplg = URLEncoder.encode(corplg, "UTF-8");
					corpnm = URLEncoder.encode(corpnm, "UTF-8");
					corpnf = URLEncoder.encode(corpnf, "UTF-8");
					postcode1 = URLEncoder.encode(postcode1, "UTF-8");
					postcode2 = URLEncoder.encode(postcode2, "UTF-8");
					address1 = URLEncoder.encode(address1, "UTF-8");
					address2 = URLEncoder.encode(address2, "UTF-8");
					address3 = URLEncoder.encode(address3, "UTF-8");
					address4 = URLEncoder.encode(address4, "UTF-8");
					number1 = URLEncoder.encode(number1, "UTF-8");
					number2 = URLEncoder.encode(number2, "UTF-8");
					email = URLEncoder.encode(email, "UTF-8");
					bank_code = URLEncoder.encode(bank_code, "UTF-8");
					bank = URLEncoder.encode(bank, "UTF-8");
					branch_code = URLEncoder.encode(branch_code, "UTF-8");
					bank_branch = URLEncoder.encode(bank_branch, "UTF-8");
					account_type = URLEncoder.encode(account_type, "UTF-8");
					account_number = URLEncoder.encode(account_number, "UTF-8");
					acount_name = URLEncoder.encode(acount_name, "UTF-8");

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
				response.sendRedirect(request.getContextPath() + "/index/purchaser");
			} else {
				response.sendRedirect(request.getContextPath() + "/my_page");
			}
		}
	}

}
