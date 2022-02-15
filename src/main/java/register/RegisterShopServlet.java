package register;

import java.io.IOException;
import java.net.URLEncoder;
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
 * Servlet implementation class RegisterShopServlet
 */
@WebServlet("/register/shop")
public class RegisterShopServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterShopServlet() {
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
				
				try {
					// データベース接続情報取得
					conn = db.getConnection();
					
					// MHCMの情報を取得
					String sql1 = "SELECT CHNLCD,CHNLNM FROM MHCM ORDER BY ETDTTM ASC";
					pstmt1 = conn.prepareStatement(sql1);
					rset1 = pstmt1.executeQuery();
					ArrayList<Map<String, String>> channels = new ArrayList<Map<String, String>>();
					
					while (rset1.next()) {
						Map<String, String> channel = new HashMap<>();
						channel.put("CHNLCD", rset1.getString(1));
						channel.put("CHNLNM", rset1.getString(2));
						channels.add(channel);
					}
					
					request.setAttribute("channels", channels);
					
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
				
				request.getRequestDispatcher("/WEB-INF/app/register/register_shop.jsp").forward(request, response);
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
				
				String sql = "INSERT INTO MHSM(SHOPCD,CHNLCD,CHNLNM,SHOPNM,SHOPNF,ZIPCOD,STATNM,CITYNM,STRNO1,STRNO2,PHONE1,PHONE2,EMLADR,BANKCD,BANKNM,BRNCCD,BANKBR,ACNTTY,ACNTNU,ACNTNM,SPCADR,COMMNT) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				PreparedStatement pstmt = null;
				
				// 送信情報の取得
				String shop_code = request.getParameter("shop_code");
				String channel_code = request.getParameter("channel_code");
				String channel_name = request.getParameter("channel_name");
				String shop_name = request.getParameter("shop_name");
				String shop_name_kana = request.getParameter("shop_name_kana");
				String postcode1 = request.getParameter("zip1");
				String postcode2 = request.getParameter("zip2");
				String postcode = (!postcode1.equals("") && !postcode2.equals("")) ? postcode1 + "-" + postcode2 : "";
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
				String spec_email = request.getParameter("spec_email");
				String comment = request.getParameter("comment");
				
				try {
					// データベース接続情報取得
					conn = db.getConnection();
					
					// MHSM実行準備
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, shop_code);
					pstmt.setString(2, channel_code);
					pstmt.setString(3, channel_name);
					pstmt.setString(4, shop_name);
					pstmt.setString(5, shop_name_kana);
					pstmt.setString(6, postcode);
					pstmt.setString(7, address1);
					pstmt.setString(8, address2);
					pstmt.setString(9, address3);
					pstmt.setString(10, address4);
					pstmt.setString(11, number1);
					pstmt.setString(12, number2);
					pstmt.setString(13, email);
					pstmt.setString(14, bank_code);
					pstmt.setString(15, bank);
					pstmt.setString(16, branch_code);
					pstmt.setString(17, bank_branch);
					pstmt.setString(18, account_type);
					pstmt.setString(19, account_number);
					pstmt.setString(20, acount_name);
					pstmt.setString(21, spec_email);
					pstmt.setString(22, comment);
					pstmt.executeUpdate();
					
					// エンコード
					shop_code = URLEncoder.encode(shop_code, "UTF-8");
					channel_code = URLEncoder.encode(channel_code, "UTF-8");
					channel_name = URLEncoder.encode(channel_name, "UTF-8");
					shop_name = URLEncoder.encode(shop_name, "UTF-8");
					shop_name_kana = URLEncoder.encode(shop_name_kana, "UTF-8");
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
					spec_email = URLEncoder.encode(spec_email, "UTF-8");
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
					response.sendRedirect(request.getContextPath() + "/index/shop");
				} else {
					response.sendRedirect(request.getContextPath() + "/register/shop");
				}
			} else {
				response.sendRedirect(request.getContextPath() + "/my_page");
			}
		}
	}

}
