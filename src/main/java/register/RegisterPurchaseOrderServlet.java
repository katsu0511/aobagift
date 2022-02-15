package register;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
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
 * Servlet implementation class RegisterPurchaseOrderServlet
 */
@WebServlet("/register/purchase_order")
public class RegisterPurchaseOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterPurchaseOrderServlet() {
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
				PreparedStatement pstmt2 = null;
				PreparedStatement pstmt3 = null;
				ResultSet rset1 = null;
				ResultSet rset2 = null;
				ResultSet rset3 = null;

				try {
					// データベース接続情報取得
					conn = db.getConnection();

					// 年月の取得
					Calendar calendar = Calendar.getInstance();
					int year = calendar.get(Calendar.YEAR) - 2020;
					if (year > 15) {
						year -= 16;
					}
					String year_hex = Integer.toHexString(year);
				    int month = calendar.get(Calendar.MONTH) + 1;
				    String month_hex = Integer.toHexString(month);

					// 最後に登録された注文コードを取得
					String sql1 = "SELECT POCD FROM POINF ORDER BY POCD DESC LIMIT 1";
					pstmt1 = conn.prepareStatement(sql1);
					rset1 = pstmt1.executeQuery();

				    // 検索結果
					String last_pocd = null;
					if (rset1.next()) {
						last_pocd = rset1.getString(1);
					} else {
						last_pocd = "00000";
					}

					String lastid_year = last_pocd.substring(0,1);
					String lastid_month = last_pocd.substring(1,2);
					String lastid_num1 = last_pocd.substring(2,5);
					int lastid_num2 = Integer.parseInt(lastid_num1);
					String newid_num = String.format("%03d", lastid_num2 + 1);

				    // 注文コードの生成
					String POCD = null;
					if (!lastid_year.equals(year_hex)) {
						POCD = "" + year_hex + month_hex + "001";
					} else if (!lastid_month.equals(month_hex)) {
						POCD = "" + lastid_year + month_hex + "001";
					} else {
						POCD = "" + lastid_year + lastid_month + newid_num;
				    }
					request.setAttribute("POCD", POCD);

					// ギフト依頼情報のギフトID、価格、サイトIDを取得
					String sql2 = "SELECT GIFTID,GIFTPR,SITEID FROM MHGM ORDER BY GIFTID ASC";
					pstmt2 = conn.prepareStatement(sql2);
					rset2 = pstmt2.executeQuery();
					ArrayList<Map<String, String>> mhgms = new ArrayList<Map<String, String>>();
					while (rset2.next()) {
						String giftid = rset2.getString(1);
						String giftpr = rset2.getString(2);
						String siteid = rset2.getString(3);
						Map<String, String> rec = new HashMap<>();
						rec.put("giftid",giftid);
						rec.put("giftpr",giftpr);
						rec.put("siteid",siteid);
						// rec.put("siteid",StringUtils.isNullOrEmpty(siteid)?"":siteid);
						mhgms.add(rec);
					}
					request.setAttribute("mhgms", mhgms);

					// 購入者情報の購入者コードと法人名を取得
					String sql3 = "SELECT PCCD,CORPNM FROM PCINF ORDER BY PCCD ASC";
					pstmt3 = conn.prepareStatement(sql3);
					rset3 = pstmt3.executeQuery();
					ArrayList<Map<String, String>> pcinfs = new ArrayList<Map<String, String>>();
					while (rset3.next()) {
						String pccd = rset3.getString(1);
						String corpnm = rset3.getString(2);
						Map<String, String> rec = new HashMap<>();
						rec.put("pccd", pccd);
						rec.put("corpnm", corpnm);
						pcinfs.add(rec);
					}
					request.setAttribute("pcinfs", pcinfs);

				} catch (SQLException e) {
					e.printStackTrace();

				} finally {
					try {
						pstmt3.close();
					} catch (SQLException e) { }
					try {
						conn.close();
					} catch (SQLException e) {  }
				}

				// ギフト注文入力画面表示
				request.getRequestDispatcher("/WEB-INF/app/register/register_purchase_order.jsp").forward(request, response);
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
