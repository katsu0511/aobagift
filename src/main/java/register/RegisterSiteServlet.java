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
import java.util.Calendar;
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
 * Servlet implementation class RegisterSiteServlet
 */
@WebServlet("/register/site")
@MultipartConfig(
	maxFileSize=10000000,
	maxRequestSize=10000000,
	fileSizeThreshold=10000000
)
public class RegisterSiteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterSiteServlet() {
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
				PreparedStatement pstmt3 = null;
				PreparedStatement pstmt4 = null;
				PreparedStatement pstmt5 = null;
				PreparedStatement pstmt6 = null;
				ResultSet rset1 = null;
				ResultSet rset2 = null;
				ResultSet rset3 = null;
				ResultSet rset4 = null;
				ResultSet rset5 = null;
				ResultSet rset6 = null;
				
				try {
					// データベース接続情報取得
					conn = db.getConnection();
					
					// 最後に登録されたSITEIDを取得
					String sql1 = "SELECT SITEID FROM SITE ORDER BY ETDTTM DESC LIMIT 1";
					pstmt1 = conn.prepareStatement(sql1);
					rset1 = pstmt1.executeQuery();
					String last_siteid = null;
					
					// 年月の取得
					Calendar calendar = Calendar.getInstance();
					int year = calendar.get(Calendar.YEAR) - 2020;
					if (year > 15) {
						year -= 16;
					}
					String year_hex = Integer.toHexString(year);
				    int month = calendar.get(Calendar.MONTH) + 1;
				    String month_hex = Integer.toHexString(month);
				    
				    // 検索結果があれば
					if (rset1.next()) {
						last_siteid = rset1.getString(1);
					} else {
						last_siteid = "S11000";
					}
					
					String lastid_year = last_siteid.substring(1,2);
					String lastid_month = last_siteid.substring(2,3);
					String lastid_num1 = last_siteid.substring(3,6);
					int lastid_num2 = Integer.parseInt(lastid_num1);
					String newid_num = String.format("%03d", lastid_num2 + 1);
					String SITEID = null;
				    
				    // SITEIDの生成
					if (!lastid_year.equals(year_hex)) {
						SITEID = "S" + year_hex + month_hex + "001";
					} else if (!lastid_month.equals(month_hex)) {
						SITEID = "S" + lastid_year + month_hex + "001";
					} else if (lastid_year.equals(year_hex) && lastid_month.equals(month_hex)) {
						SITEID = "S" + lastid_year + lastid_month + newid_num;
				    }
					
					request.setAttribute("SITEID", SITEID);
					
					
					
					
					// 最後に登録されたCHNLCDを取得
					String sql2 = "SELECT CHNLCD FROM MHCM ORDER BY CHNLCD DESC LIMIT 1";
					pstmt2 = conn.prepareStatement(sql2);
					rset2 = pstmt2.executeQuery();
					String chnlcd = null;
					
					// 検索結果があれば
					if (rset2.next()) {
						chnlcd = rset2.getString(1);
					} else {
						chnlcd = "C0000";
					}
					
					String num1 = chnlcd.substring(1,5);
					int num2 = Integer.parseInt(num1);
					String num3 = String.format("%04d", num2 + 1);
					String CHNLCD = "C" + num3;
					request.setAttribute("CHNLCD", CHNLCD);
					
					 // REQUCDの生成
					String REQUCD = CHNLCD + "001";
					request.setAttribute("REQUCD", REQUCD);
					
					
					
					// SITENMを取得
					String sql3 = "SELECT SITENM FROM SITE";
					pstmt3 = conn.prepareStatement(sql3);
					rset3 = pstmt3.executeQuery();
					ArrayList<String> sitenms = new ArrayList<String>();
					
					while (rset3.next()) {
						sitenms.add(rset3.getString(1));
					}
					
					request.setAttribute("sitenms", sitenms);
					
					
					
					// CHNLCD,CHNLNMを取得
					String sql4 = "SELECT CHNLCD,CHNLNM FROM MHCM ORDER BY ETDTTM ASC";
					pstmt4 = conn.prepareStatement(sql4);
					rset4 = pstmt4.executeQuery();
					ArrayList<Map<String, String>> channels = new ArrayList<Map<String, String>>();
					
					while (rset4.next()) {
						Map<String, String> channel = new HashMap<>();
						channel.put("CHNLCD", rset4.getString(1));
						channel.put("CHNLNM", rset4.getString(2));
						channels.add(channel);
					}
					
					request.setAttribute("channels", channels);
					
					
					
					// REQUCD,REQUNMを取得
					String sql5 = "SELECT REQUCD,REQUNM FROM MHRM ORDER BY ETDTTM ASC";
					pstmt5 = conn.prepareStatement(sql5);
					rset5 = pstmt5.executeQuery();
					ArrayList<Map<String, String>> requesters = new ArrayList<Map<String, String>>();
					
					while (rset5.next()) {
						Map<String, String> requester = new HashMap<>();
						requester.put("REQUCD", rset5.getString(1));
						requester.put("REQUNM", rset5.getString(2));
						requesters.add(requester);
					}
					
					request.setAttribute("requesters", requesters);
					
					
					
					// USERIDを取得
					String sql6 = "SELECT USERID FROM USER";
					pstmt6 = conn.prepareStatement(sql6);
					rset6 = pstmt6.executeQuery();
					ArrayList<String> userids = new ArrayList<String>();
					
					while (rset6.next()) {
						userids.add(rset6.getString(1));
					}
					
					request.setAttribute("userids", userids);
					
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
						pstmt3.close();
					} catch (SQLException e) { }
					
					try {
						pstmt4.close();
					} catch (SQLException e) { }
					
					try {
						pstmt5.close();
					} catch (SQLException e) { }
					
					try {
						pstmt6.close();
					} catch (SQLException e) { }
					
					try {
						conn.close();
					} catch (SQLException e) {  }
				}
				
				request.getRequestDispatcher("/WEB-INF/app/register/register_site.jsp").forward(request, response);
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
				
				// SQL
				PreparedStatement pstmt1 = null;
				PreparedStatement pstmt2 = null;
				PreparedStatement pstmt3 = null;
				PreparedStatement pstmt4 = null;
				PreparedStatement pstmt5 = null;
				PreparedStatement pstmt6 = null;
				ResultSet rset1 = null;
				ResultSet rset2 = null;
				boolean has_registered_chnlcd = false;
				boolean has_registered_requcd = false;
				
				// 送信情報の取得
				String site_id = request.getParameter("site_id");
				String site_name = request.getParameter("site_name");
				String channel_code = request.getParameter("channel_code");
				String channel_name = request.getParameter("channel_name");
				String requester_code = request.getParameter("requester_code");
				String requester_name = request.getParameter("requester_name");
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
				String user_id = request.getParameter("user_id");
				String password = request.getParameter("password2");
				String amount = request.getParameter("amount");
				String site_final_use = request.getParameter("site_final_use");
				String aoba_email = request.getParameter("aoba_email");
				String comment = request.getParameter("comment");
				// 依頼者ロゴのファイル名取得
				// ファイル名重複対策でファイル名の先頭にサイトIDを付与する
				Part part = request.getPart("requester_logo");
				String requesterLogoOriginalFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
				String requester_logo = requesterLogoOriginalFileName.isEmpty() ? "" : site_id + "_" + requesterLogoOriginalFileName;
				
				try {
					// データベース接続情報取得
					conn = db.getConnection();
					
					// CHNLCDの取得
					String sql1 = "SELECT CHNLCD FROM MHCM ORDER BY CHNLCD ASC";
					pstmt1 = conn.prepareStatement(sql1);
					rset1 = pstmt1.executeQuery();
					ArrayList<String> CHNLCDS = new ArrayList<>();
					
					while (rset1.next()) {
						CHNLCDS.add(rset1.getString(1));
					}
					
					for (String CHNLCD: CHNLCDS) {
						if (channel_code.equals(CHNLCD)) {
							has_registered_chnlcd = true;
						}
					}
					
					// REQUCDの取得
					String sql2 = "SELECT REQUCD FROM MHRM ORDER BY REQUCD ASC";
					pstmt2 = conn.prepareStatement(sql2);
					rset2 = pstmt2.executeQuery();
					ArrayList<String> REQUCDS = new ArrayList<>();
					
					while (rset2.next()) {
						REQUCDS.add(rset2.getString(1));
					}
					
					for (String REQUCD: REQUCDS) {
						if (requester_code.equals(REQUCD)) {
							has_registered_requcd = true;
						}
					}
					
					
					
					// SITEに保存
					// SQL
					String sql3 = "INSERT INTO SITE";
					if (requester_logo.isEmpty()) {
						sql3 += "(SITEID,SITENM,CHNLCD,CHNLNM,REQUCD,REQUNM,ZIPCOD,STATNM,CITYNM,STRNO1,STRNO2,PHONE1,PHONE2,EMLADR,BANKCD,BANKNM,BRNCCD,BANKBR,ACNTTY,ACNTNU,ACNTNM,USERID,PASSWD,AMOUNT,STSPDT,AOBEML,COMMNT) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					} else {
						sql3 += "(SITEID,SITENM,CHNLCD,CHNLNM,REQUCD,REQUNM,ZIPCOD,STATNM,CITYNM,STRNO1,STRNO2,PHONE1,PHONE2,EMLADR,BANKCD,BANKNM,BRNCCD,BANKBR,ACNTTY,ACNTNU,ACNTNM,USERID,PASSWD,AMOUNT,STSPDT,AOBEML,COMMNT,REQULG) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					}
					
					// SQL実行
					pstmt3 = conn.prepareStatement(sql3);
					pstmt3.setString(1, site_id);
					pstmt3.setString(2, site_name);
					pstmt3.setString(3, channel_code);
					pstmt3.setString(4, channel_name);
					pstmt3.setString(5, requester_code);
					pstmt3.setString(6, requester_name);
					pstmt3.setString(7, postcode);
					pstmt3.setString(8, address1);
					pstmt3.setString(9, address2);
					pstmt3.setString(10, address3);
					pstmt3.setString(11, address4);
					pstmt3.setString(12, number1);
					pstmt3.setString(13, number2);
					pstmt3.setString(14, email);
					pstmt3.setString(15, bank_code);
					pstmt3.setString(16, bank);
					pstmt3.setString(17, branch_code);
					pstmt3.setString(18, bank_branch);
					pstmt3.setString(19, account_type);
					pstmt3.setString(20, account_number);
					pstmt3.setString(21, acount_name);
					pstmt3.setString(22, user_id);
					pstmt3.setString(23, password);
					pstmt3.setString(24, amount);
					pstmt3.setString(25, site_final_use);
					pstmt3.setString(26, aoba_email);
					pstmt3.setString(27, comment);
					if (requester_logo.isEmpty()) {
						pstmt3.executeUpdate();
					}
					else {
						pstmt3.setString(28, requester_logo);
						pstmt3.executeUpdate();

						// 画像アップロード
						String path = getServletContext().getRealPath("/logo_requester");
						part.write(path + File.separator + requester_logo);
					}
					
					
					
					// USERに保存
					String sql4 = "INSERT INTO USER(USERID,PASSWD) VALUES(?,?)";
					pstmt4 = conn.prepareStatement(sql4);
					pstmt4.setString(1, user_id);
					pstmt4.setString(2, password);
					pstmt4.executeUpdate();
					
					// MHCMに保存
					if (!has_registered_chnlcd) {
						String sql5 = "INSERT INTO MHCM(CHNLCD,CHNLNM) VALUES(?,?)";
						pstmt5 = conn.prepareStatement(sql5);
						pstmt5.setString(1, channel_code);
						pstmt5.setString(2, channel_name);
						pstmt5.executeUpdate();
					}
					
					
					
					// MHRMに保存
					if (!has_registered_requcd) {
						String sql6 = "INSERT INTO MHRM(REQUCD,CHNLCD,REQUNM,ZIPCOD,STATNM,CITYNM,STRNO1,STRNO2,PHONE1,PHONE2,EMLADR,BANKCD,BANKNM,BRNCCD,BANKBR,ACNTTY,ACNTNU,ACNTNM) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
						pstmt6 = conn.prepareStatement(sql6);
						pstmt6.setString(1, requester_code);
						pstmt6.setString(2, channel_code);
						pstmt6.setString(3, requester_name);
						pstmt6.setString(4, postcode);
						pstmt6.setString(5, address1);
						pstmt6.setString(6, address2);
						pstmt6.setString(7, address3);
						pstmt6.setString(8, address4);
						pstmt6.setString(9, number1);
						pstmt6.setString(10, number2);
						pstmt6.setString(11, email);
						pstmt6.setString(12, bank_code);
						pstmt6.setString(13, bank);
						pstmt6.setString(14, branch_code);
						pstmt6.setString(15, bank_branch);
						pstmt6.setString(16, account_type);
						pstmt6.setString(17, account_number);
						pstmt6.setString(18, acount_name);
						pstmt6.executeUpdate();
					}
					
					
					
					// エンコード
					site_id = URLEncoder.encode(site_id, "UTF-8");
					site_name = URLEncoder.encode(site_name, "UTF-8");
					channel_code = URLEncoder.encode(channel_code, "UTF-8");
					channel_name = URLEncoder.encode(channel_name, "UTF-8");
					requester_code = URLEncoder.encode(requester_code, "UTF-8");
					requester_name = URLEncoder.encode(requester_name, "UTF-8");
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
					user_id = URLEncoder.encode(user_id, "UTF-8");
					password = URLEncoder.encode(password, "UTF-8");
					amount = URLEncoder.encode(amount, "UTF-8");
					site_final_use = URLEncoder.encode(site_final_use, "UTF-8");
					aoba_email = URLEncoder.encode(aoba_email, "UTF-8");
					comment = URLEncoder.encode(comment, "UTF-8");
					requester_logo = URLEncoder.encode(requester_logo, "UTF-8");
					
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
						pstmt3.close();
					} catch (SQLException e) { }
					
					try {
						pstmt4.close();
					} catch (SQLException e) { }
					
					try {
						if (!has_registered_chnlcd) {
							pstmt5.close();
						}
					} catch (SQLException e) { }
					
					try {
						if (!has_registered_requcd) {
							pstmt6.close();
						}
					} catch (SQLException e) { }
					
					try {
						conn.close();
					} catch (SQLException e) {  }
				}
				
				if (request.getParameter("submit").equals("登録終了")) {
					response.sendRedirect(request.getContextPath() + "/index/site");
				} else {
					response.sendRedirect(request.getContextPath() + "/register/site");
				}
			} else {
				response.sendRedirect(request.getContextPath() + "/my_page");
			}
		}
	}

}
