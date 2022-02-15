package show;

import java.io.IOException;
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
 * Servlet implementation class ShowTicketInfoServlet
 */
@WebServlet("/show/ticket_info")
public class ShowTicketInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShowTicketInfoServlet() {
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
				PreparedStatement pstmt1 = null;
				PreparedStatement pstmt2 = null;
				ResultSet rset1 = null;
				ResultSet rset2 = null;

				// 入力パラメータ取得
				String POCD = request.getParameter("POCD");						// 注文コード
				String GIFTID = request.getParameter("GIFTID");					// ギフトID
				String EXCG_STAT = request.getParameter("EXCG_STAT");			// 交換状態（0:すべて 1:未交換 2:交換済）
				String EXCG_BEGIN = request.getParameter("EXCG_BEGIN");
				if(!"".equalsIgnoreCase(EXCG_BEGIN)) EXCG_BEGIN+=" 00:00:00";	// 交換済状態時の検索開始日
				String EXCG_END = request.getParameter("EXCG_END");
				if(!"".equalsIgnoreCase(EXCG_END)) EXCG_END+=" 23:59:59";		// 交換済状態時の検索終了日
				String PERIOD_BEGIN = request.getParameter("PERIOD_BEGIN");		// 有効期限の検索開始日
				String PERIOD_END = request.getParameter("PERIOD_END");			// 有効期限の検索終了日

				// 出力データ
				String tcktcd,status,excdt,excmthd,shopcd;	// チケットコード,使用状況,交換日,交換方法,交換店舗のショップコード
				String pccd,giftid,vlddt;						// 購入者コード,ギフトID,有効期限日
				String corpnm;									// 法人名
				String giftpr,giftnm,payety;					// ギフト価格,ギフト名,支払い先区分
				String paynm,banknm,bankbr,acntty,acntnu;		// 依頼者名或いはショップ名,銀行名,銀行支店名,口座区分,口座番号
				String chnlnm;									// ギフト作成依頼者
				String merccd,url;								// 交換商品コード,チケットURL

				try {
					// データベース接続情報取得
					conn = db.getConnection();

					// ギフトチケット情報取得（CSV用）
					String where1 = ("ALL".equalsIgnoreCase(POCD))?"":" WHERE GFTCKT.POCD='"+POCD+"'";
					where1 += ("ALL".equalsIgnoreCase(GIFTID))?"":(where1.isEmpty()?" WHERE ":" AND ")+"POINF.GIFTID='"+GIFTID+"'";
					where1 += ("".equalsIgnoreCase(PERIOD_BEGIN))?"":(where1.isEmpty()?" WHERE ":" AND ")+"POINF.VLDDT>='"+PERIOD_BEGIN+"'";
					where1 += ("".equalsIgnoreCase(PERIOD_END))?"":(where1.isEmpty()?" WHERE ":" AND ")+"POINF.VLDDT<='"+PERIOD_END+"'";
					if ("1".equalsIgnoreCase(EXCG_STAT)) {
						where1 += (where1.isEmpty()?" WHERE ":" AND ")+"GFTCKT.STATUS='0'";
					}
					else if ("2".equalsIgnoreCase(EXCG_STAT)) {
						where1 += (where1.isEmpty()?" WHERE ":" AND ")+"GFTCKT.STATUS='1'";
						where1 += ("".equalsIgnoreCase(EXCG_BEGIN))?"":(where1.isEmpty()?" WHERE ":" AND ")+"EXCHST.EXCDT>='"+EXCG_BEGIN+"'";
						where1 += ("".equalsIgnoreCase(EXCG_END))?"":(where1.isEmpty()?" WHERE ":" AND ")+"EXCHST.EXCDT<='"+EXCG_END+"'";
					}
					String sql1
						= "SELECT"
						+ " GFTCKT.TCKTCD,GFTCKT.STATUS,EXCHST.EXCDT,EXCHST.EXCMTHD,EXCHST.SHOPCD"	// 1,2,3,4,5（チケットコード,使用状況,交換日,交換方法,交換店舗のショップコード）
						+ ",POINF.PCCD,POINF.GIFTID,POINF.SITEID,POINF.VLDDT"							// 6,7,8,9（購入者コード,ギフトID,サイトID,有効期限日）
						+ ",PCINF.CORPNM"																		// 10（法人名）
						+ ",MHGM.GIFTPR,MHGM.GIFTNM,MHGM.PAYETY"											// 11,12,13（ギフト価格,ギフト名,支払い先区分）
						+ ",MHGM.REQUNM,MHGM.BANKNM,MHGM.BANKBR,MHGM.ACNTTY,MHGM.ACNTNU"				// 14,15,16,17,18（ギフト作成依頼者：依頼者名,銀行名,銀行支店名,口座区分,口座番号）
						+ ",SITE.REQUNM,SITE.BANKNM,SITE.BANKBR,SITE.ACNTTY,SITE.ACNTNU"				// 19,20,21,22,23（サイト作成依頼者：依頼者名,銀行名,銀行支店名,口座区分,口座番号）
						+ ",MHSM.SHOPNM,MHSM.BANKNM,MHSM.BANKBR,MHSM.ACNTTY,MHSM.ACNTNU"				// 24,25,26,27,28（交換施設・店舗：ショップ名,銀行名,銀行支店名,口座区分,口座番号）
						+ " FROM GFTCKT"
						+ " LEFT JOIN POINF ON GFTCKT.POCD=POINF.POCD"
						+ " LEFT JOIN PCINF ON POINF.PCCD=PCINF.PCCD"
						+ " LEFT JOIN MHGM ON POINF.GIFTID=MHGM.GIFTID"
						+ " LEFT JOIN SITE ON POINF.SITEID=SITE.SITEID"
						+ " LEFT JOIN EXCHST ON GFTCKT.TCKTCD=EXCHST.TCKTCD"
						+ " LEFT JOIN MHSM ON EXCHST.SHOPCD=MHSM.SHOPCD"
						+ where1
						+ " ORDER BY GFTCKT.TCKTCD ASC";
					pstmt1 = conn.prepareStatement(sql1);
					rset1 = pstmt1.executeQuery();

					ArrayList<Map<String, String>> payments = new ArrayList<Map<String,String>>();
					while (rset1.next()) {
						tcktcd = rset1.getString(1);
						status = rset1.getString(2);
						excdt = rset1.getString(3);
						excmthd = rset1.getString(4);
						shopcd = rset1.getString(5);
						pccd = rset1.getString(6);
						giftid = rset1.getString(7);
						vlddt = rset1.getString(9);
						corpnm = rset1.getString(10);
						giftpr = rset1.getString(11);
						giftnm = rset1.getString(12);
						payety = rset1.getString(13);
						chnlnm = rset1.getString(14);

						// 支払区分により支払口座を決定 (ギフト作成依頼者)
						if ("1".equals(payety)) {
							paynm = rset1.getString(14);
							banknm = rset1.getString(15);
							bankbr = rset1.getString(16);
							acntty = rset1.getString(17);
							acntnu = rset1.getString(18);
						}
						// 支払区分により支払口座を決定 (サイト作成依頼者)
						else if ("2".equals(payety)) {
							paynm = rset1.getString(19);
							banknm = rset1.getString(20);
							bankbr = rset1.getString(21);
							acntty = rset1.getString(22);
							acntnu = rset1.getString(23);
						}
						// 支払区分により支払口座を決定 (交換施設・店舗)
						else if ("3".equals(payety)) {
							paynm = rset1.getString(24);
							banknm = rset1.getString(25);
							bankbr = rset1.getString(26);
							acntty = rset1.getString(27);
							acntnu = rset1.getString(28);
						}
						// 支払区分により支払口座を決定 (支払対象外)
						else {
							paynm = "";
							banknm = "";
							bankbr = "";
							acntty = "";
							acntnu = "";
						}

						Map<String, String> rec = new HashMap<>();
						// rec.put("tcktcd",StringUtils.isNullOrEmpty(tcktcd)?"":tcktcd);
						// rec.put("pccd",StringUtils.isNullOrEmpty(pccd)?"":pccd);
						// rec.put("corpnm",StringUtils.isNullOrEmpty(corpnm)?"":corpnm);
						// rec.put("giftid",StringUtils.isNullOrEmpty(giftid)?"":giftid);
						// rec.put("giftpr",StringUtils.isNullOrEmpty(giftpr)?"":giftpr);
						// rec.put("giftnm",StringUtils.isNullOrEmpty(giftnm)?"":giftnm);
						// rec.put("vlddt",StringUtils.isNullOrEmpty(vlddt)?"":vlddt);
						// rec.put("chnlnm",StringUtils.isNullOrEmpty(chnlnm)?"":chnlnm);
						// rec.put("excdt",StringUtils.isNullOrEmpty(excdt)?"":excdt);
						// rec.put("excmthd",StringUtils.isNullOrEmpty(excmthd)?"":excmthd);
						// rec.put("shopcd",StringUtils.isNullOrEmpty(shopcd)?"":shopcd);
						// rec.put("payety",StringUtils.isNullOrEmpty(payety)?"":payety);
						// rec.put("paynm",StringUtils.isNullOrEmpty(paynm)?"":paynm);
						// rec.put("banknm",StringUtils.isNullOrEmpty(banknm)?"":banknm);
						// rec.put("bankbr",StringUtils.isNullOrEmpty(bankbr)?"":bankbr);
						// rec.put("acntty",StringUtils.isNullOrEmpty(acntty)?"":acntty);
						// rec.put("acntnu",StringUtils.isNullOrEmpty(acntnu)?"":acntnu);
						rec.put("tcktcd",tcktcd);
						rec.put("pccd",pccd);
						rec.put("corpnm",corpnm);
						rec.put("giftid",giftid);
						rec.put("giftpr",giftpr);
						rec.put("giftnm",giftnm);
						rec.put("vlddt",vlddt);
						rec.put("chnlnm",chnlnm);
						rec.put("excdt",excdt);
						rec.put("excmthd",excmthd);
						rec.put("shopcd",shopcd);
						rec.put("payety",payety);
						rec.put("paynm",paynm);
						rec.put("banknm",banknm);
						rec.put("bankbr",bankbr);
						rec.put("acntty",acntty);
						rec.put("acntnu",acntnu);
						payments.add(rec);
					}
					request.setAttribute("payments",payments);

					// ギフトチケット情報取得（表示用）
					String where2 = ("ALL".equalsIgnoreCase(POCD))?"":" WHERE GFTCKT.POCD='"+POCD+"'";
					where2 += ("ALL".equalsIgnoreCase(GIFTID))?"":(where2.isEmpty()?" WHERE ":" AND ")+"POINF.GIFTID='"+GIFTID+"'";
					where2 += ("".equalsIgnoreCase(PERIOD_BEGIN))?"":(where2.isEmpty()?" WHERE ":" AND ")+"POINF.VLDDT>='"+PERIOD_BEGIN+"'";
					where2 += ("".equalsIgnoreCase(PERIOD_END))?"":(where2.isEmpty()?" WHERE ":" AND ")+"POINF.VLDDT<='"+PERIOD_END+"'";
					if ("1".equalsIgnoreCase(EXCG_STAT)) {
						where2 += (where2.isEmpty()?" WHERE ":" AND ")+"GFTCKT.STATUS='0'";
					}
					else if ("2".equalsIgnoreCase(EXCG_STAT)) {
						where2 += (where2.isEmpty()?" WHERE ":" AND ")+"GFTCKT.STATUS='1'";
						where2 += ("".equalsIgnoreCase(EXCG_BEGIN))?"":(where2.isEmpty()?" WHERE ":" AND ")+"EXCHST.EXCDT>='"+EXCG_BEGIN+"'";
						where2 += ("".equalsIgnoreCase(EXCG_END))?"":(where2.isEmpty()?" WHERE ":" AND ")+"EXCHST.EXCDT<='"+EXCG_END+"'";
					}
					String sql3
						= "SELECT GFTCKT.TCKTCD,GFTCKT.STATUS,EXCHST.EXCMTHD,EXCHST.SHOPCD,EXCHST.MERCCD,EXCHST.EXCDT,POINF.VLDDT,GFTCKT.URL"
						+ " FROM GFTCKT"
						+ " LEFT JOIN EXCHST ON GFTCKT.TCKTCD=EXCHST.TCKTCD"
						+ " LEFT JOIN POINF ON GFTCKT.POCD=POINF.POCD"
						+ where2
						+ " ORDER BY GFTCKT.TCKTCD ASC";
					pstmt2 = conn.prepareStatement(sql3);
					rset2 = pstmt2.executeQuery();

					ArrayList<Map<String, String>> tickets = new ArrayList<Map<String,String>>();
					while (rset2.next()) {
						tcktcd = rset2.getString(1);
						status = rset2.getString(2);
						excmthd = rset2.getString(3);
						shopcd = rset2.getString(4);
						merccd = rset2.getString(5);
						excdt = rset2.getString(6);
						vlddt = rset2.getString(7);
						url = rset2.getString(8);

						Map<String, String> rec = new HashMap<>();
						// rec.put("tcktcd",StringUtils.isNullOrEmpty(tcktcd)?"":tcktcd);
						// rec.put("status",StringUtils.isNullOrEmpty(status)?"":status);
						// rec.put("excmthd",StringUtils.isNullOrEmpty(excmthd)?"":excmthd);
						// rec.put("shopcd",StringUtils.isNullOrEmpty(shopcd)?"":shopcd);
						// rec.put("merccd",StringUtils.isNullOrEmpty(merccd)?"":merccd);
						// rec.put("excdt",StringUtils.isNullOrEmpty(excdt)?"":excdt);
						// rec.put("vlddt",StringUtils.isNullOrEmpty(vlddt)?"":vlddt);
						// rec.put("url",StringUtils.isNullOrEmpty(url)?"":url);
						rec.put("tcktcd",tcktcd);
						rec.put("status",status);
						rec.put("excmthd",excmthd);
						rec.put("shopcd",shopcd);
						rec.put("merccd",merccd);
						rec.put("excdt",excdt);
						rec.put("vlddt",vlddt);
						rec.put("url",url);
						tickets.add(rec);
					}
					request.setAttribute("tickets",tickets);

				} catch (SQLException e) {
					e.printStackTrace();

				} finally {
					try {
						pstmt1.close();
						pstmt2.close();
						conn.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}

				request.getRequestDispatcher("/WEB-INF/app/show/show_ticket_info.jsp").forward(request, response);
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
