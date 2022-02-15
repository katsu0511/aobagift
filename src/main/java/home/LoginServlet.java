package home;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
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
			request.getRequestDispatcher("/WEB-INF/app/user/login.jsp").forward(request, response);
		} else {
			for (Map<String, String> user: users) {
				if (session.getAttribute("userId").equals(user.get("user_id")) &&
					session.getAttribute("password").equals(user.get("password"))) {
					exist_management = true;
				}
			}
			
			if (exist_management) {
				response.sendRedirect(request.getContextPath() + "/top");
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
		
		// 文字化け対策
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		// 送信情報の取得
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");

		// エラーメッセージ
		String errorMessage = null;
		
		// データベース接続管理クラスの変数宣言
		DBManager dbm = new DBManager();
		
		// ログインユーザー情報取得
		UserDTO user = dbm.getLoginUser(userId, password);
		
		Management mng = new Management();
		@SuppressWarnings("unchecked")
		ArrayList<Map<String, String>> mng_users = (ArrayList<Map<String, String>>) mng.ManagementUser();
		boolean exist_management = false;
			
		if (userId.equals("") || password.equals("")) {
			errorMessage = "ユーザーIDとパスワードを入力してください";
			request.setAttribute("errorMessage", errorMessage);
			request.getRequestDispatcher("/WEB-INF/app/user/login.jsp").forward(request, response);
		} else if (user != null) {
			for (Map<String, String> mng_user: mng_users) {
				if (userId.equals(mng_user.get("user_id")) && password.equals(mng_user.get("password"))) {
					exist_management = true;
				}
			}
			
			if (exist_management) {
				HttpSession session = request.getSession();
				session.setAttribute("userId", userId);
				session.setAttribute("password", password);
				
				userId = URLEncoder.encode(userId, "UTF-8");
				password = URLEncoder.encode(password, "UTF-8");
				
				response.sendRedirect(request.getContextPath() + "/top");
			} else {
				errorMessage = "このユーザーID、パスワードでは管理者ログインできません";
				request.setAttribute("errorMessage", errorMessage);
				request.getRequestDispatcher("/WEB-INF/app/user/login.jsp").forward(request, response);
			}
			
		} else {
			errorMessage = "ユーザーIDかパスワードが間違っています";
			request.setAttribute("errorMessage", errorMessage);
			request.getRequestDispatcher("/WEB-INF/app/user/login.jsp").forward(request, response);
		}
	}

}
