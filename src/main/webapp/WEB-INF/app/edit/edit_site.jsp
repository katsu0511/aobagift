<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<String> site = (ArrayList<String>)request.getAttribute("site"); %>

<main>
	<div class="container">
		
		<h2>サイト情報編集</h2>
		
		<form id="SITE" action="<%= request.getContextPath() %>/edit/site" method="POST">
			
			<div class="tr">
				<label for="site_id" class="th">サイトID:</label>
				<div class="td">
					<input type="text" id="site_id" class="back-gray" name="site_id"
							value="<%= site.get(0) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="site_name" class="th">サイト名:</label>
				<div class="td">
					<input type="text" id="site_name" class="back-gray" name="site_name"
							value="<%= site.get(1) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="requester_logo" class="th">サイトロゴ:</label>
				<div class="td">
					<input type="text" id="requester_logo" class="back-gray" name="requester_logo" readonly
							<% if (site.get(2) != null) { %>
								value="<%= site.get(2) %>"
							<% } %>>
				</div>
			</div>
			
			<div class="tr">
				<label for="channel_code" class="th">チャネルコード:</label>
				<div class="td">
					<input type="text" id="channel_code" class="back-gray" name="channel_code"
							value="<%= site.get(3) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="channel_name" class="th">チャネル名:</label>
				<div class="td">
					<input type="text" id="channel_name" class="back-gray" name="channel_name"
							value="<%= site.get(4) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="requester_code" class="th">依頼者コード:</label>
				<div class="td">
					<input type="text" id="requester_code" class="back-gray" name="requester_code"
							value="<%= site.get(5) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="requester_name" class="th">依頼者名:</label>
				<div class="td">
					<input type="text" id="requester_name" class="back-gray" name="requester_name"
							value="<%= site.get(6) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="postcode1" class="th">郵便番号:</label>
				<div class="td">
					<input type="text" id="postcode1" class="postcode back-gray" name="zip1" readonly
							<% if (!(site.get(7)==null) && !(site.get(7).isEmpty()) && site.get(7).length()==8) { %>
								value="<%= site.get(7).substring(0,3) %>"
							<% } %>>
					-
					<input type="text" id="postcode2" class="postcode back-gray" name="zip2" readonly
							<% if (!(site.get(7)==null) && !(site.get(7).isEmpty()) && site.get(7).length()==8) { %>
								value="<%= site.get(7).substring(4,8) %>"
							<% } %>>
				</div>
			</div>
			
			<div class="tr">
				<label for="address1" class="th">都道府県:</label>
				<div class="td">
					<input type="text" id="address1" class="back-gray" name="address1"
							value="<%= site.get(8) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="address2" class="th">市区町村:</label>
				<div class="td">
					<input type="text" id="address2" class="back-gray" name="address2"
							value="<%= site.get(9) %>" readonly>
					<p id="address2_error" class="error">市区町村を入力してください</p>
				</div>
			</div>

			<div class="tr">
				<label for="address3" class="th">番地1:</label>
				<div class="td">
					<input type="text" id="address3" class="back-gray" name="address3"
							value="<%= site.get(10) %>" readonly>
				</div>
			</div>

			<div class="tr">
				<label for="address4" class="th">番地2（建物名）:</label>
				<div class="td">
					<input type="text" id="address4" class="back-gray" name="address4"
							value="<%= site.get(11) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="number1" class="th">電話番号1:</label>
				<div class="td">
					<input type="text" id="number1" class="short back-gray" name="number1"
							value="<%= site.get(12) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="number2" class="th">電話番号2:</label>
				<div class="td">
					<input type="text" id="number2" class="short back-gray" name="number2"
							value="<%= site.get(13) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="email" class="th">メールアドレス:</label>
				<div class="td">
					<input type="text" id="email" class="back-gray" name="email" value="<%= site.get(14) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="bank_code" class="th">金融機関コード:</label>
				<div class="td">
					<input type="text" id="bank_code" class="short back-gray" name="bank_code"
							value="<%= site.get(15) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="bank" class="th">銀行名:</label>
				<div class="td">
					<input type="text" id="bank" class="short back-gray" name="bank"
							value="<%= site.get(16) %>" readonly>
					銀行
				</div>
			</div>
			
			<div class="tr">
				<label for="branch_code" class="th">支店コード:</label>
				<div class="td">
					<input type="text" id="branch_code" class="short back-gray" name="branch_code"
							value="<%= site.get(17) %>" readonly>
				</div>
			</div>
          
          <div class="tr">
				<label for="bank_branch" class="th">銀行支店名:</label>
				<div class="td">
					<input type="text" id="bank_branch" class="short back-gray" name="bank_branch"
							value="<%= site.get(18) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="account_type" class="th">口座区分:</label>
				<div class="td">
					<input type="text" id="account_type" class="short back-gray" name="account_type" readonly
							<% if (site.get(19).equals("1")) { %>
								value="普通"
							<% } else if (site.get(19).equals("2")) { %>
								value="当座"
							<% } else if (site.get(19).equals("3")) { %>
								value="総合"
							<% } %>>
				</div>
			</div>
			
			<div class="tr">
				<label for="account_number" class="th">口座番号:</label>
				<div class="td">
					<input type="text" id="account_number" class="short back-gray" name="account_number"
							value="<%= site.get(20) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="acount_name" class="th">口座名義人:</label>
				<div class="td">
					<input type="text" id="acount_name" class="short back-gray" name="acount_name" 
							value="<%= site.get(21) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="user_id" class="th">ユーザーID:</label>
				<div class="td">
					<input type="text" id="user_id" class="back-gray" name="user_id"
							value="<%= site.get(22) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="password" class="th">パスワード:<span>*</span></label>
				<div class="td">
					<input type="password" id="password" name="password" value="<%= site.get(23) %>"
							pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
							oninput="value = value.replace(/[^0-9A-Za-z]+/i,'');" required>
					<p>※半角英数字8文字以上</p>
					<p>※アルファベットの大文字、小文字、数字を最低1文字ずつ入れてください。</p>
					<p id="password_error1" class="error">パスワードを入力してください</p>
					<p id="password_error2" class="error">正しいパスワードの形式で入力して下さい</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="password2" class="th">パスワード確認:<span>*</span></label>
				<div class="td">
					<input type="password" id="password2" name="password2" value="<%= site.get(23) %>"
							pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
							oninput="value = value.replace(/[^0-9A-Za-z]+/i,'');" required>
					<p id="password2_error1" class="error">パスワードを入力してください</p>
					<p id="password2_error2" class="error">同じパスワードを入力して下さい</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="amount" class="th">金額:</label>
				<div class="td">
					<input type="text" id="amount" class="back-gray" name="amount"
							value="<%= site.get(24) %>円" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="site_final_use" class="th">サイト新規使用停止日:</label>
				<div class="td">
					<input type="date" id="site_final_use" name="site_final_use" value="<%= site.get(25) %>">
				</div>
			</div>
			
			<div class="tr">
				<label for="aoba_email" class="th">青葉ギフト宛メールアドレス:<span>*</span></label>
				<div class="td">
					<input type="text" id="aoba_email" name="aoba_email" value="<%= site.get(26) %>"
							oninput="value = value.replace(/[^a-zA-Z0-9\.@_-]+/i,'');"
							pattern="^[0-9a-zA-Z]+[\w\.-]+@[\w\.-]+\.\w{2,}$" required>
			    	<p id="aoba_email_error1" class="error">青葉ギフト宛メールアドレスを入力してください</p>
			    	<p id="aoba_email_error2" class="error">正しいメールアドレスの形式で入力して下さい</p>
				</div>
			</div>

			<div class="tr">
				<label for="comment" class="th">コメント:</label>
				<div class="td">
					<textarea id="comment" name="comment"><%= site.get(27) %></textarea>
				</div>
			</div>
			
			<div class="register_buttons">
				<input type="submit" id="submit" class="button" name="submit" value="保存" form="SITE">
				<button type="button" class="button" onclick="history.back()">キャンセル</button>
			</div>
			
		</form>
	</div>
</main>

<script type="text/javascript">
$(function() {
	const password = $('#password');
	const passwordError2 = $('#password_error2');
	password.blur(function() {
		if ($(this).val() == '') {
			passwordError2.css('display','none');
		} else if (!$(this).val().match(/(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}/g)) {
			passwordError2.css('display','block');
		} else {
			passwordError2.css('display','none');
		}
	});
	
	const password2 = $('#password2');
	const password2Error2 = $('#password2_error2');
	password2.blur(function() {
		if ($(this).val() == '') {
			password2Error2.css('display','none');
		} else if ($(this).val() != password.val()) {
			password2Error2.css('display','block');
		} else {
			password2Error2.css('display','none');
		}
	});
	
	const aobaEmail = $('#aoba_email');
	const aobaEmailError2 = $('#aoba_email_error2');
	aobaEmail.blur(function() {
		if ($(this).val() == '') {
			aobaEmailError2.css('display','none');
		} else if (!$(this).val().match(/^[0-9a-zA-Z]+[\w\.-]+@[\w\.-]+\.\w{2,}$/)) {
			aobaEmailError2.css('display','block');
		} else {
			aobaEmailError2.css('display','none');
		}
	});
	
	const submit = $('#submit');
	const passwordError1 = $('#password_error1');
	const password2Error1 = $('#password2_error1');
	const aobaEmailError1 = $('#aoba_email_error1');
	
	submit.click(function() {
		if (password.val() == '') {
			passwordError1.css('display','block');
		} else {
			passwordError1.css('display','none');
		}
		
		if (password2.val() == '') {
			password2Error1.css('display','block');
		} else {
			password2Error1.css('display','none');
		}
		
		if (aobaEmail.val() == '') {
			aobaEmailError1.css('display','block');
		} else {
			aobaEmailError1.css('display','none');
		}

		if (password.val() == '') {
			password.focus();
		} else if (!password.val().match(/(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}/g)) {
			password.focus();
		} else if (password2.val() == '') {
			password2.focus();
		} else if (password2.val() != password.val()) {
			password2.focus();
			return false;
		} else if (aobaEmail.val() == '') {
			aobaEmail.focus();
		} else if (!aobaEmail.val().match(/^[0-9a-zA-Z]+[\w\.-]+@[\w\.-]+\.\w{2,}$/)) {
			aobaEmail.focus();
		} else {
			if (!confirm('送信しますか？')) {
				return false;
			}
		}
	});
});
</script>
	
<jsp:include page="../common/footer.jsp" flush="true"/>
