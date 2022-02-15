package cite;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import home.AobagiftDAO;

/**
 * Servlet implementation class CiteChannelServlet
 */
@WebServlet("/cite/channel")
public class CiteChannelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CiteChannelServlet() {
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
		PreparedStatement pstmt3 = null;
		PreparedStatement pstmt4 = null;
		ResultSet rset1 = null;
		ResultSet rset2 = null;
		ResultSet rset3 = null;
		ResultSet rset4 = null;
		
		// CHNLCDの取得
		String CHNLCD = request.getParameter("id");
		
		try {
			// データベース接続情報取得
			conn = db.getConnection();
			
			// MHCMの情報取得
			String sql1 = "SELECT CHNLNM FROM MHCM WHERE CHNLCD=?";
			pstmt1 = conn.prepareStatement(sql1);
			pstmt1.setString(1, CHNLCD);
			rset1 = pstmt1.executeQuery();
			String CHNLNM = null;
			
			if (rset1.next()) {
				CHNLNM = rset1.getString(1);
			}
			
			// REQUCDを作成
			String sql2 = "SELECT REQUCD FROM MHRM WHERE CHNLCD=? ORDER BY REQUCD DESC LIMIT 1";
			pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setString(1, CHNLCD);
			rset2 = pstmt2.executeQuery();
			String requester_code = null;
			
			if (rset2.next()) {
				requester_code = rset2.getString(1);
			} else {
				requester_code = CHNLCD + "000";
			}
			
			String num1 = requester_code.substring(5,8);
			int num2 = Integer.parseInt(num1);
			String num3 = String.format("%03d", num2 + 1);
			String REQUCD = CHNLCD + num3;
			
			// MHRMの情報取得
			String sql3 = "SELECT REQUNM FROM MHRM WHERE CHNLCD=?";
			pstmt3 = conn.prepareStatement(sql3);
			pstmt3.setString(1, CHNLCD);
			rset3 = pstmt3.executeQuery();
			ArrayList<String> REQUNM = new ArrayList<>();
			
			while (rset3.next()) {
				REQUNM.add(rset3.getString(1));
			}
			
			// SITEの情報取得
			String sql4 = "SELECT SITENM FROM SITE WHERE CHNLCD=?";
			pstmt4 = conn.prepareStatement(sql4);
			pstmt4.setString(1, CHNLCD);
			rset4 = pstmt4.executeQuery();
			ArrayList<String> SITENM = new ArrayList<>();
			
			while (rset4.next()) {
				SITENM.add(rset4.getString(1));
			}
			
			
			
			// レスポンス用JSON文字列生成
			String resData =
				"{\"CHNLCD\":\"" + CHNLCD +
				"\",\"CHNLNM\":\"" + CHNLNM +
				"\",\"REQUCD\":\"" + REQUCD +
				"\",\"REQUNM\":\"" + REQUNM +
				"\",\"SITENM\":\"" + SITENM +
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
				pstmt3.close();
			} catch (SQLException e) { }
			
			try {
				pstmt4.close();
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
