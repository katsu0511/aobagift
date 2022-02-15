package cite;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import home.AobagiftDAO;

/**
 * Servlet implementation class CiteRequesterServlet
 */
@WebServlet("/cite/requester")
public class CiteRequesterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CiteRequesterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		// 文字化け対策
				request.setCharacterEncoding("UTF-8");
				response.setContentType("text/html;charset=UTF-8");
				
				// 接続情報
				AobagiftDAO db = new AobagiftDAO();
				Connection conn = null;
				
				// SQL情報管理
				PreparedStatement pstmt1 = null;
				ResultSet rset1 = null;
				
				// REQUNMの取得
				String REQUNM = request.getParameter("id");
				
				try {
					// データベース接続情報取得
					conn = db.getConnection();
					
					// MHRMの情報取得
					String sql1 = "SELECT * FROM MHRM WHERE REQUNM=?";
					pstmt1 = conn.prepareStatement(sql1);
					pstmt1.setString(1, REQUNM);
					rset1 = pstmt1.executeQuery();
					String REQUCD = null;
					String ZIPCD1 = null;
					String ZIPCD2 = null;
					String STATNM = null;
					String CITYNM = null;
					String STRNO1 = null;
					String STRNO2 = null;
					String PHONE1 = null;
					String PHONE2 = null;
					String EMLADR = null;
					String BANKCD = null;
					String BANKNM = null;
					String BRNCCD = null;
					String BANKBR = null;
					String ACNTTY = null;
					String ACNTNU = null;
					String ACNTNM = null;
					
					if (rset1.next()) {
						REQUCD = rset1.getString(1);
						if (!rset1.getString(4).isEmpty()) {
							ZIPCD1 = rset1.getString(4).substring(0,3);
							ZIPCD2 = rset1.getString(4).substring(4,8);
						} else {
							ZIPCD1 = "";
							ZIPCD2 = "";
						}
						STATNM = rset1.getString(5);
						CITYNM = rset1.getString(6);
						STRNO1 = rset1.getString(7);
						STRNO2 = rset1.getString(8);
						PHONE1 = rset1.getString(9);
						PHONE2 = rset1.getString(10);
						EMLADR = rset1.getString(11);
						BANKCD = rset1.getString(12);
						BANKNM = rset1.getString(13);
						BRNCCD = rset1.getString(14);
						BANKBR = rset1.getString(15);
						ACNTTY = rset1.getString(16);
						ACNTNU = rset1.getString(17);
						ACNTNM = rset1.getString(18);
					}
					
					// レスポンス用JSON文字列生成
					String resData =
						"{\"REQUCD\":\"" + REQUCD +
						"\",\"REQUNM\":\"" + REQUNM +
						"\",\"ZIPCD1\":\"" + ZIPCD1 +
						"\",\"ZIPCD2\":\"" + ZIPCD2 +
						"\",\"STATNM\":\"" + STATNM +
						"\",\"CITYNM\":\"" + CITYNM +
						"\",\"STRNO1\":\"" + STRNO1 +
						"\",\"STRNO2\":\"" + STRNO2 +
						"\",\"PHONE1\":\"" + PHONE1 +
						"\",\"PHONE2\":\"" + PHONE2 +
						"\",\"EMLADR\":\"" + EMLADR +
						"\",\"BANKCD\":\"" + BANKCD +
						"\",\"BANKNM\":\"" + BANKNM +
						"\",\"BRNCCD\":\"" + BRNCCD +
						"\",\"BANKBR\":\"" + BANKBR +
						"\",\"ACNTTY\":\"" + ACNTTY +
						"\",\"ACNTNU\":\"" + ACNTNU +
						"\",\"ACNTNM\":\"" + ACNTNM +
						"\"}";

					// レスポンス処理
					response.setContentType("text/plain");
					response.setCharacterEncoding("utf8");
					PrintWriter out = response.getWriter();
					out.println(resData);
					
				} catch(Exception err) {
					((HttpServletResponse) request).sendError(HttpServletResponse.SC_BAD_REQUEST);
				} finally {
					try {
						pstmt1.close();
					} catch (SQLException e) { }
					
					try {
						conn.close();
					} catch (SQLException e) {  }
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
