package register;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
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
 * Servlet implementation class ShopImportServlet
 */
@WebServlet("/shop_import")
@MultipartConfig(
	maxFileSize=10000000,
	maxRequestSize=10000000,
	fileSizeThreshold=10000000
)
public class ShopImportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShopImportServlet() {
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
				
				PreparedStatement pstmt = null;
				ResultSet rset = null;
				
				try {
					// データベース接続情報取得
					conn = db.getConnection();
					
					// MHCMの情報を取得
					String sql = "SELECT CHNLCD,CHNLNM FROM MHCM ORDER BY CHNLCD ASC";
					pstmt = conn.prepareStatement(sql);
					rset = pstmt.executeQuery();
					ArrayList<Map<String, String>> channels = new ArrayList<Map<String, String>>();
					
					while (rset.next()) {
						Map<String, String> channel = new HashMap<>();
						channel.put("CHNLCD", rset.getString(1));
						channel.put("CHNLNM", rset.getString(2));
						channels.add(channel);
					}
					
					request.setAttribute("channels", channels);
					
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
				
				request.getRequestDispatcher("/WEB-INF/app/register/shop_import.jsp").forward(request, response);
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
			response.sendRedirect(request.getContextPath() + "/site.login");
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
				ResultSet rset1 = null;
				ResultSet rset2 = null;
				
				// 送信情報の取得
				String channel_code = request.getParameter("channel_code");
				Part shop_list = request.getPart("shop_list");
				BufferedReader br = null;

				try {
					// データベース接続情報取得
					conn = db.getConnection();
					
					// CHNLNMの取得
					String sql1 = "SELECT CHNLNM FROM MHCM WHERE CHNLCD=?";
					pstmt1 = conn.prepareStatement(sql1);
					pstmt1.setString(1, channel_code);
					rset1 = pstmt1.executeQuery();
					String channel_name = null;
					
					if (rset1.next()) {
						channel_name = rset1.getString(1);
					}
					
					// csv読み込み
					InputStream is = shop_list.getInputStream();
					InputStreamReader isr = new InputStreamReader(is);
					br = new BufferedReader(isr);
					String line;
					int row = 0;
					
					while ((line = br.readLine()) != null) {
						if (row == 0) {
							row++;
							continue;
						}
						
						String[] data = line.split(",");
						String comment = data.length == 20 ? data[19] : "";
						
						// SHOPCDを作成
						String sql2 = "SELECT SHOPCD FROM MHSM WHERE CHNLCD=? ORDER BY SHOPCD DESC LIMIT 1";
						pstmt2 = conn.prepareStatement(sql2);
						pstmt2.setString(1, channel_code);
						rset2 = pstmt2.executeQuery();
						String shopcd = null;
						
						if (rset2.next()) {
							shopcd = rset2.getString(1);
						} else {
							shopcd = channel_code + "S0000";
						}
						
						String num1 = shopcd.substring(6,10);
						int num2 = Integer.parseInt(num1);
						String num3 = String.format("%04d", num2 + 1);
						String shop_code = channel_code + "S" + num3;
						
						// SQL実行
						String sql3 = "INSERT INTO MHSM(SHOPCD,CHNLCD,CHNLNM,SHOPNM,SHOPNF,ZIPCOD,STATNM,CITYNM,STRNO1,STRNO2,PHONE1,PHONE2,EMLADR,BANKCD,BANKNM,BRNCCD,BANKBR,ACNTTY,ACNTNU,ACNTNM,SPCADR,COMMNT) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
						pstmt3 = conn.prepareStatement(sql3);
						pstmt3.setString(1, shop_code);
						pstmt3.setString(2, channel_code);
						pstmt3.setString(3, channel_name);
						pstmt3.setString(4, data[1]);
						pstmt3.setString(5, data[2]);
						pstmt3.setString(6, data[3]);
						pstmt3.setString(7, data[4]);
						pstmt3.setString(8, data[5]);
						pstmt3.setString(9, data[6]);
						pstmt3.setString(10, data[7]);
						pstmt3.setString(11, data[8]);
						pstmt3.setString(12, data[9]);
						pstmt3.setString(13, data[10]);
						pstmt3.setString(14, data[11]);
						pstmt3.setString(15, data[12]);
						pstmt3.setString(16, data[13]);
						pstmt3.setString(17, data[14]);
						pstmt3.setString(18, data[15]);
						pstmt3.setString(19, data[16]);
						pstmt3.setString(20, data[17]);
						pstmt3.setString(21, data[18]);
						pstmt3.setString(22, comment);
						pstmt3.executeUpdate();
					}

				} catch (Exception e) {
					System.out.println(e.getMessage());
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
						br.close();
					} catch (Exception e) {
						System.out.println(e.getMessage());
					}
				}
				
				response.sendRedirect(request.getContextPath() + "/index/shop");
			} else {
				response.sendRedirect(request.getContextPath() + "/my_page");
			}
		}
	}

}
