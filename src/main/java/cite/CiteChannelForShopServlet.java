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
 * Servlet implementation class CiteChannelForShopServlet
 */
@WebServlet("/cite/channel_for_shop")
public class CiteChannelForShopServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CiteChannelForShopServlet() {
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
		PreparedStatement pstmt2 = null;
		ResultSet rset1 = null;
		ResultSet rset2 = null;
		
		// CHNLCDの取得
		String CHNLCD = request.getParameter("id");
		
		try {
			// データベース接続情報取得
			conn = db.getConnection();
			
			// MHCMの情報取得
			String sql1 = "SELECT * FROM MHCM WHERE CHNLCD=?";
			pstmt1 = conn.prepareStatement(sql1);
			pstmt1.setString(1, CHNLCD);
			rset1 = pstmt1.executeQuery();
			String CHNLNM = null;
			
			if (rset1.next()) {
				CHNLNM = rset1.getString(2);
			}
			
			
			
			// SHOPCDを作成
			String sql2 = "SELECT SHOPCD FROM MHSM WHERE CHNLCD=? ORDER BY SHOPCD DESC LIMIT 1";
			pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setString(1, CHNLCD);
			rset2 = pstmt2.executeQuery();
			String shop_code = null;
			
			if (rset2.next()) {
				shop_code = rset2.getString(1);
			} else {
				shop_code = CHNLCD + "S0000";
			}
			
			String num1 = shop_code.substring(6,10);
			int num2 = Integer.parseInt(num1);
			String num3 = String.format("%04d", num2 + 1);
			String SHOPCD = CHNLCD + "S" + num3;
			

			// レスポンス用JSON文字列生成
			String resData =
				"{\"CHNLCD\":\"" + CHNLCD +
				"\",\"CHNLNM\":\"" + CHNLNM +
				"\",\"SHOPCD\":\"" + SHOPCD +
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
				pstmt2.close();
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
