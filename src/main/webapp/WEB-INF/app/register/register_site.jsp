<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<String> sitenms = (ArrayList<String>)request.getAttribute("sitenms"); %>
<% ArrayList<Map<String,String>> channels = (ArrayList<Map<String,String>>)request.getAttribute("channels"); %>
<% ArrayList<Map<String,String>> requesters = (ArrayList<Map<String,String>>)request.getAttribute("requesters"); %>
<% ArrayList<String> userids = (ArrayList<String>)request.getAttribute("userids"); %>

<main>
	<div class="container">
		
		<h2>サイト登録</h2>
		
		<form id="SITE" action="<%= request.getContextPath() %>/register/site" method="POST" enctype="multipart/form-data">
		
			<input type="text" id="cite_channel_context" value="<%= request.getContextPath() %>" style="display:none;">
			<input type="text" id="cite_requester_context" value="<%= request.getContextPath() %>" style="display:none;">
		
			<% for (String sitenm : sitenms) { %>
				<input type="text" class="sitenm_db" value="<%= sitenm %>" style="display:none;">
			<% } %>
		
			<% for (Map<String, String> channel : channels) { %>
				<div class="channel_db" style="display:none;">
					<input type="text" class="chnlcd" value="<%= channel.get("CHNLCD") %>">
					<input type="text" class="chnlnm" value="<%= channel.get("CHNLNM") %>">
				</div>
			<% } %>
			
			<% for (Map<String, String> requester : requesters) { %>
				<div class="requester_db" style="display:none;">
					<input type="text" class="requcd" value="<%= requester.get("REQUCD") %>">
					<input type="text" class="requnm" value="<%= requester.get("REQUNM") %>">
				</div>
			<% } %>
		
			<% for (String userid : userids) { %>
				<input type="text" class="userid_db" value="<%= userid %>" style="display:none;">
			<% } %>
			
			<div class="tr">
				<label for="site_id" class="th green">サイトID:</label>
				<div class="td">
					<input type="text" id="site_id" class="back-gray" name="site_id"
							value="<%= request.getAttribute("SITEID") %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="site_name" class="th green">サイト名:<span>*</span></label>
				<div class="td">
					<input type="text" id="site_name" name="site_name" required>
					<p id="site_name_error1" class="error">サイト名を入力してください</p>
					<p id="site_name_error3" class="error"></p>
				</div>
			</div>
			
			<div class="tr">
				<label for="requester_logo" class="th green">サイトロゴ:</label>
				<div id="requester_logo_td" class="td">
					<input type="file" id="requester_logo" name="requester_logo">
				</div>
			</div>
			
			<div class="tr">
				<label for="channel" class="th brown">登録済チャネル呼出:</label>
				<div class="td cite-td">
					<select id="channel" class="cite-sel" name="channel">
						<option value="">選択してください</option>
						<%	for (Map<String, String> channel : channels) {	%>
							<option value=<%= channel.get("CHNLCD") %>>
								<%= channel.get("CHNLNM") %>
							</option>
						<% } %>
					</select>
					<input type="button" id="cite_channel" class="cite button" name="cite_channel" value="呼出">
				</div>
			</div>
		
			<div class="tr">
				<label for="channel_code" class="th brown">チャネルコード:</label>
				<div class="td">
					<input type="text" id="channel_code" class="back-gray" name="channel_code"
							value="<%= request.getAttribute("CHNLCD") %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="channel_name" class="th brown">新規チャネル入力:<span>*</span></label>
				<div class="td">
					<input type="text" id="channel_name" name="channel_name" required>
					<p id="channel_name_error1" class="error">チャネル名を入力してください</p>
					<p id="channel_name_error3" class="error"></p>
				</div>
			</div>
			
			<div class="tr">
				<label for="requester" class="th lightgreen">登録済依頼者呼出:</label>
				<div class="td cite-td">
					<select id="requester" class="cite-sel" name="requester">
						<option value="">選択してください</option>
					</select>
					<input type="button" id="cite_requester" class="cite button" name="cite_requester" value="呼出">
				</div>
			</div>
			
			<div class="tr">
				<label for="requester_code" class="th lightgreen">依頼者コード:</label>
				<div class="td">
					<input type="text" id="requester_code" class="back-gray" name="requester_code" readonly
							value="<%= request.getAttribute("REQUCD") %>">
				</div>
			</div>
			
			<div class="tr">
				<label for="requester_name" class="th lightgreen">新規依頼者入力:<span>*</span></label>
				<div class="td">
					<input type="text" id="requester_name" name="requester_name" required>
					<p id="requester_name_error1" class="error">依頼者名を入力してください</p>
					<p id="requester_name_error3" class="error"></p>
				</div>
			</div>
			
			<div class="tr">
				<label for="postcode1" class="th lightgreen">郵便番号:</label>
				<div class="td">
					<input type="text" id="postcode1" class="postcode" name="zip1" maxlength="3"
							oninput="value = value.replace(/[^0-9]+/i,'');" pattern="[0-9]{3}"
							onkeyup="AjaxZip3.zip2addr('zip1', 'zip2', 'address1', 'address2');">
					-
					<input type="text" id="postcode2" class="postcode" name="zip2" maxlength="4"
							oninput="value = value.replace(/[^0-9]+/i,'');" pattern="[0-9]{4}"
							onkeyup="AjaxZip3.zip2addr('zip1', 'zip2', 'address1', 'address2');">
					<p>(例：123-4567)</p>
					<p id="postcode_error2" class="error">郵便番号の桁数が間違っています</p>
				</div>
			</div>

			<div class="tr">
				<label for="address1" class="th lightgreen">都道府県:</label>
				<div class="td">
					<select id="address1" name="address1">
						<option value="">選択してください</option>
						<optgroup label="北海道・東北">
							<option value="北海道">北海道</option>
							<option value="青森県">青森県</option>
							<option value="岩手県">岩手県</option>
							<option value="秋田県">秋田県</option>
							<option value="宮城県">宮城県</option>
							<option value="山形県">山形県</option>
							<option value="福島県">福島県</option>
						</optgroup>
						<optgroup label="北信越">
							<option value="新潟県">新潟県</option>
							<option value="長野県">長野県</option>
							<option value="富山県">富山県</option>
							<option value="石川県">石川県</option>
							<option value="福井県">福井県</option>
						</optgroup>
						<optgroup label="関東">
							<option value="茨城県">茨城県</option>
							<option value="栃木県">栃木県</option>
							<option value="群馬県">群馬県</option>
							<option value="千葉県">千葉県</option>
							<option value="埼玉県">埼玉県</option>
							<option value="東京都">東京都</option>
							<option value="神奈川県">神奈川県</option>
						</optgroup>
						<optgroup label="中部">
							<option value="山梨県">山梨県</option>
							<option value="静岡県">静岡県</option>
							<option value="岐阜県">岐阜県</option>
							<option value="愛知県">愛知県</option>
							<option value="三重県">三重県</option>
						</optgroup>
						<optgroup label="関西">
							<option value="滋賀県">滋賀県</option>
							<option value="奈良県">奈良県</option>
							<option value="和歌山県">和歌山県</option>
							<option value="京都府">京都府</option>
							<option value="大阪府">大阪府</option>
							<option value="兵庫県">兵庫県</option>
						</optgroup>
						<optgroup label="中国">
							<option value="鳥取県">鳥取県</option>
							<option value="岡山県">岡山県</option>
							<option value="島根県">島根県</option>
							<option value="広島県">広島県</option>
							<option value="山口県">山口県</option>
						</optgroup>
						<optgroup label="四国">
							<option value="香川県">香川県</option>
							<option value="徳島県">徳島県</option>
							<option value="愛媛県">愛媛県</option>
							<option value="高知県">高知県</option>
						</optgroup>
						<optgroup label="九州">
							<option value="福岡県">福岡県</option>
							<option value="佐賀県">佐賀県</option>
							<option value="長崎県">長崎県</option>
							<option value="大分県">大分県</option>
							<option value="熊本県">熊本県</option>
							<option value="宮崎県">宮崎県</option>
							<option value="鹿児島県">鹿児島県</option>
							<option value="沖縄県">沖縄県</option>
						</optgroup>
					</select>
				</div>
			</div>

			<div class="tr">
				<label for="address2" class="th lightgreen">市区町村:</label>
				<div class="td">
					<input type="text" id="address2" name="address2">
				</div>
			</div>

			<div class="tr">
				<label for="address3" class="th lightgreen">番地1:</label>
				<div class="td">
					<input type="text" id="address3" name="address3">
					<p>(例：番地、丁目)</p>
				</div>
			</div>

			<div class="tr">
				<label for="address4" class="th lightgreen">番地2（建物名）:</label>
				<div class="td">
					<input type="text" id="address4" name="address4">
				</div>
			</div>

			<div class="tr">
				<label for="number1" class="th lightgreen">電話番号1:</label>
				<div class="td">
					<input type="text" id="number1" class="short" name="number1" maxlength="11"
							oninput="value = value.replace(/[^0-9]+/i,'');" pattern="[0-9]{10,11}">
					<p>(例：0312345678)</p>
					<p id="number1_error2" class="error">電話番号1の桁数が間違っています</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="number2" class="th lightgreen">電話番号2:</label>
				<div class="td">
					<input type="text" id="number2" class="short" name="number2" maxlength="11"
							oninput="value = value.replace(/[^0-9]+/i,'');" pattern="[0-9]{10,11}">
					<p>(例：0312345678)</p>
					<p id="number2_error2" class="error">電話番号2の桁数が間違っています</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="email" class="th lightgreen">メールアドレス:</label>
				<div class="td">
					<input type="text" id="email" name="email"
							oninput="value = value.replace(/[^a-zA-Z0-9\.@_-]+/i,'');"
							pattern="^[0-9a-zA-Z]+[\w\.-]+@[\w\.-]+\.\w{2,}$">
			    	<p id="email_error2" class="error">正しいメールアドレスの形式で入力して下さい</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="bank_code" class="th lightgreen">金融機関コード:</label>
				<div class="td">
					<input type="text" id="bank_code" class="short" name="bank_code" maxlength="4"
							oninput="value = value.replace(/[^0-9]+/i,'');" pattern="[0-9]{4}">
					<p id="bank_code_error2" class="error">金融機関コードの桁数が間違っています</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="bank" class="th lightgreen">銀行名:</label>
				<div class="td">
					<input type="text" id="bank" class="short" name="bank">
					銀行
				</div>
			</div>
			
			<div class="tr">
				<label for="branch_code" class="th lightgreen">支店コード:</label>
				<div class="td">
					<input type="text" id="branch_code" class="short" name="branch_code" maxlength="3"
							oninput="value = value.replace(/[^0-9]+/i,'');" pattern="[0-9]{3}">
					<p id="branch_code_error2" class="error">支店コードの桁数が間違っています</p>
				</div>
			</div>
          
          <div class="tr">
				<label for="bank_branch" class="th lightgreen">銀行支店名:</label>
				<div class="td">
					<input type="text" id="bank_branch" class="short" name="bank_branch">
				</div>
			</div>
			
			<div class="tr">
				<label for="account_type" class="th lightgreen">口座区分:</label>
				<div class="td">
					<select id="account_type" class="short" name="account_type">
						<option value="">選択してください</option>
						<option value="1">普通</option>
						<option value="2">当座</option>
						<option value="3">総合</option>
					</select>
				</div>
			</div>
			
			<div class="tr">
				<label for="account_number" class="th lightgreen">口座番号:</label>
				<div class="td">
					<input type="text" id="account_number" class="short" name="account_number" maxlength="7"
							oninput="value = value.replace(/[^0-9]+/i,'');" pattern="[0-9]{7}">
					<p id="account_number_error2" class="error">口座番号の桁数が間違っています</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="acount_name" class="th lightgreen">口座名義人:</label>
				<div class="td">
					<input type="text" id="acount_name" class="short" name="acount_name" maxlength="30"
							pattern="[\uFF66-\uFF9F]*">
					<p>※半角カタカナ以外はエラーになります</p>
					<p id="acount_name_error2" class="error">半角カタカナで入力してください</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="user_id" class="th yellow">ユーザーID:<span>*</span></label>
				<div class="td">
					<input type="text" id="user_id" name="user_id" maxlength="32" pattern="^([a-zA-Z0-9]{6,})$"
							oninput="value = value.replace(/[^0-9A-Za-z]+/i,'');" autocomplete="off" required>
					<p>※半角英数字6文字以上</p>
					<p id="user_id_error1" class="error">ユーザーIDを入力してください</p>
					<p id="user_id_error2" class="error">正しいユーザーIDの形式で入力して下さい</p>
					<p id="user_id_error3" class="error"></p>
				</div>
			</div>
			
			<div class="tr">
				<label for="password" class="th yellow">パスワード:<span>*</span></label>
				<div class="td">
					<input type="password" id="password" name="password" maxlength="32"
							pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" autocomplete="off"
							oninput="value = value.replace(/[^0-9A-Za-z]+/i,'');" required>
					<p>※半角英数字8文字以上</p>
					<p>※アルファベットの大文字、小文字、数字を最低1文字ずつ入れてください。</p>
					<p id="password_error1" class="error">パスワードを入力してください</p>
					<p id="password_error2" class="error">正しいパスワードの形式で入力して下さい</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="password2" class="th yellow">パスワード確認:<span>*</span></label>
				<div class="td">
					<input type="password" id="password2" name="password2" maxlength="32"
							pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" autocomplete="off"
							oninput="value = value.replace(/[^0-9A-Za-z]+/i,'');" required>
					<p id="password2_error1" class="error">パスワードを入力してください</p>
					<p id="password2_error2" class="error">同じパスワードを入力して下さい</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="amount" class="th yellow">金額:<span>*</span></label>
				<div class="td">
					<input type="text" id="amount" class="short" name="amount" maxlength="6"
							oninput="value = value.replace(/[^0-9]+/i,'');" required>
					円
					<p id="amount_error1" class="error">価格を選択してください</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="site_final_use" class="th yellow">サイト新規使用停止日:</label>
				<div class="td">
					<input type="date" id="site_final_use" name="site_final_use">
				</div>
			</div>
			
			<div class="tr">
				<label for="aoba_email" class="th yellow">青葉ギフト宛メールアドレス:<span>*</span></label>
				<div class="td">
					<input type="text" id="aoba_email" name="aoba_email"
							oninput="value = value.replace(/[^a-zA-Z0-9\.@_-]+/i,'');"
							pattern="^[0-9a-zA-Z]+[\w\.-]+@[\w\.-]+\.\w{2,}$" required>
			    	<p id="aoba_email_error1" class="error">青葉ギフト宛メールアドレスを入力してください</p>
			    	<p id="aoba_email_error2" class="error">正しいメールアドレスの形式で入力して下さい</p>
				</div>
			</div>

			<div class="tr">
				<label for="comment" class="th yellow">コメント:</label>
				<div class="td">
					<textarea id="comment" name="comment"></textarea>
				</div>
			</div>
			
			<div class="register_buttons">
				<input type="submit" class="submit_btn button" name="submit" value="登録終了" form="SITE">
				<input type="submit" class="submit_btn button" name="submit" value="引き続き登録" form="SITE">
			</div>
			
		</form>
	</div>
</main>

<script type="text/javascript">
$(function() {
	const postcode1 = $('#postcode1');
	const postcode2 = $('#postcode2');
	const postcodeError2 = $('#postcode_error2');
	postcode1.blur(function() {
		if ($(this).val() == '') {
			postcodeError2.css('display','none');
		} else if (!$(this).val().match(/[0-9]{3}/g)) {
			postcodeError2.css('display','block');
		} else {
			postcodeError2.css('display','none');
		}
	});

	postcode2.blur(function() {
		if ($(this).val() == '') {
			postcodeError2.css('display','none');
		} else if (!$(this).val().match(/[0-9]{4}/g)) {
			postcodeError2.css('display','block');
		} else {
			postcodeError2.css('display','none');
		}
	});
	
	postcode1.keyup(function(){
		if(postcode1.val().length == 3) {
			postcode2.focus();
	    }
	});
	
	const number1 = $('#number1');
	const number1Error2 = $('#number1_error2');
	number1.blur(function() {
		if ($(this).val() == '') {
			number1Error2.css('display','none');
		} else if (!$(this).val().match(/[0-9]{10,11}/g)) {
			number1Error2.css('display','block');
		} else {
			number1Error2.css('display','none');
		}
	});
	
	const number2 = $('#number2');
	const number2Error2 = $('#number2_error2');
	number2.blur(function() {
		if ($(this).val() == '') {
			number2Error2.css('display','none');
		} else if (!$(this).val().match(/[0-9]{10,11}/g)) {
			number2Error2.css('display','block');
		} else {
			number2Error2.css('display','none');
		}
	});
	
	const email = $('#email');
	const emailError2 = $('#email_error2');
	email.blur(function() {
		if ($(this).val() == '') {
			emailError2.css('display','none');
		} else if (!$(this).val().match(/^[0-9a-zA-Z]+[\w\.-]+@[\w\.-]+\.\w{2,}$/)) {
			emailError2.css('display','block');
		} else {
			emailError2.css('display','none');
		}
	});
	
	const bankCode = $('#bank_code');
	const bankCodeError2 = $('#bank_code_error2');
	bankCode.blur(function() {
		if ($(this).val() == '') {
			bankCodeError2.css('display','none');
		} else if (!$(this).val().match(/[0-9]{4}/g)) {
			bankCodeError2.css('display','block');
		} else {
			bankCodeError2.css('display','none');
		}
	});
	
	const branchCode = $('#branch_code');
	const branchCodeError2 = $('#branch_code_error2');
	branchCode.blur(function() {
		if ($(this).val() == '') {
			branchCodeError2.css('display','none');
		} else if (!$(this).val().match(/[0-9]{3}/g)) {
			branchCodeError2.css('display','block');
		} else {
			branchCodeError2.css('display','none');
		}
	});
	
	const accountNumber = $('#account_number');
	const accountNumberError2 = $('#account_number_error2');
	accountNumber.blur(function() {
		if ($(this).val() == '') {
			accountNumberError2.css('display','none');
		} else if (!$(this).val().match(/[0-9]{7}/g)) {
			accountNumberError2.css('display','block');
		} else {
			accountNumberError2.css('display','none');
		}
	});
	
	const acountName = $('#acount_name');
	const acountNameError2 = $('#acount_name_error2');
	acountName.blur(function() {
		if ($(this).val() == '') {
			acountNameError2.css('display','none');
		} else if (!$(this).val().match(/^[\uFF66-\uFF9F]/g)) {
			acountNameError2.css('display','block');
		} else {
			acountNameError2.css('display','none');
		}
	});
	
	const userId = $('#user_id');
	const userIdError2 = $('#user_id_error2');
	userId.blur(function() {
		if ($(this).val() == '') {
			userIdError2.css('display','none');
		} else if (!$(this).val().match(/[a-zA-Z0-9]{6,}/g)) {
			userIdError2.css('display','block');
		} else {
			userIdError2.css('display','none');
		}
	});
	
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
	
	
	
	
	
	const submit = $('.submit_btn');
	const siteName = $('#site_name');
	const siteNameError1 = $('#site_name_error1');
	const channel = $('#channel');
	const channelCode = $('#channel_code');
	const channelName = $('#channel_name');
	const channelNameError1 = $('#channel_name_error1');
	const requester = $('#requester');
	const requesterCode = $('#requester_code');
	const requesterName = $('#requester_name');
	const requesterNameError1 = $('#requester_name_error1');
	const address1 = $('#address1');
	const address2 = $('#address2');
	const address3 = $('#address3');
	const address4 = $('#address4');
	const bank = $('#bank');
	const bankBranch = $('#bank_branch');
	const accountType = $('#account_type');
	const userIdError1 = $('#user_id_error1');
	const passwordError1 = $('#password_error1');
	const password2Error1 = $('#password2_error1');
	const amount = $('#amount');
	const amountError1 = $('#amount_error1');
	const aobaEmailError1 = $('#aoba_email_error1');
	
	const sitenm_db = $('.sitenm_db');
	const sitenmDb = sitenm_db.toArray();
	const channel_db = $('.channel_db');
	const channelDb = channel_db.toArray();
	const requester_db = $('.requester_db');
	const requesterDb = requester_db.toArray();
	const userid_db = $('.userid_db');
	const useridDb = userid_db.toArray();
	const siteNameError3 = $('#site_name_error3');
	const channelNameError3 = $('#channel_name_error3');
	const requesterNameError3 = $('#requester_name_error3');
	const userIdError3 = $('#user_id_error3');
	var has_registered1 = false;
	var has_registered2 = false;
	var has_registered3 = false;
	var has_registered4 = false;
	
	submit.click(function() {
		siteNameError3.css('display','none');
		channelNameError3.css('display','none');
		requesterNameError3.css('display','none');
		userIdError3.css('display','none');
		has_registered1 = false;
		has_registered2 = false;
		has_registered3 = false;
		has_registered4 = false;
		
		if (siteName.val() == '') {
			siteNameError1.css('display','block');
		} else {
			siteNameError1.css('display',' none');
		}
		
		if (channelName.val() == '') {
			channelNameError1.css('display','block');
		} else {
			channelNameError1.css('display',' none');
		}
		
		if (requesterName.val() == '') {
			requesterNameError1.css('display','block');
		} else {
			requesterNameError1.css('display',' none');
		}
		
		if (userId.val() == '') {
			userIdError1.css('display','block');
		} else {
			userIdError1.css('display','none');
		}
		
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
		
		if (amount.val() == '') {
			amountError1.css('display','block');
		} else {
			amountError1.css('display',' none');
		}
		
		if (aobaEmail.val() == '') {
			aobaEmailError1.css('display','block');
		} else {
			aobaEmailError1.css('display','none');
		}
		
		$.each(sitenmDb,function() {
			if (siteName.val() == $(this).val()) {
				siteNameError3.css('display','block');
				siteNameError3.text(siteName.val() + 'はすでに登録されています');
				has_registered1 = true;
			}
		});
		
		$.each(channelDb,function() {
			if (channelCode.val() != $(this).children(".chnlcd").val() &&
				channelName.val() == $(this).children(".chnlnm").val()) {
				channelNameError3.css('display','block');
				channelNameError3.text(channelName.val() + 'はチャネルコード : [' + $(this).children(".chnlcd").val() + ']ですでに登録されています。このチャネル名では新規登録はできません。');
				has_registered2 = true;
			}
		});
		
		$.each(requesterDb,function() {
			if (requesterCode.val() != $(this).children(".requcd").val() &&
				requesterName.val() == $(this).children(".requnm").val()) {
				requesterNameError3.css('display','block');
				requesterNameError3.text(requesterName.val() + 'は依頼者コード : [' + $(this).children(".requcd").val() + ']ですでに登録されています。この依頼者名では新規登録はできません。');
				has_registered3 = true;
			}
		});
		
		$.each(useridDb,function() {
			if (userId.val() == $(this).val()) {
				userIdError3.css('display','block');
				userIdError3.text(userId.val() + 'はすでに登録されています');
				has_registered4 = true;
			}
		});
		
		
		
		
		


		if (siteName.val() == '') {
			siteName.focus();
		} else if (channelName.val() == '') {
			channelName.focus();
		} else if (requesterName.val() == '') {
			requesterName.focus();
		} else if (!postcode1.val().match(/[0-9]{3}/g) && postcode1.val() != '') {
			postcode1.focus();
		} else if (!postcode2.val().match(/[0-9]{4}/g) && postcode2.val() != '') {
			postcode2.focus();
		} else if (!number1.val().match(/[0-9]{10,11}/g) && number1.val() != '') {
			number1.focus();
		} else if (!number2.val().match(/[0-9]{10,11}/g) && number2.val() != '') {
			number2.focus();
		} else if (!email.val().match(/^[0-9a-zA-Z]+[\w\.-]+@[\w\.-]+\.\w{2,}$/) && email.val() != '') {
			email.focus();
		} else if (!bankCode.val().match(/[0-9]{4}/g) && bankCode.val() != '') {
			bankCode.focus();
		} else if (!branchCode.val().match(/[0-9]{3}/g) && branchCode.val() != '') {
			branchCode.focus();
		} else if (!accountNumber.val().match(/[0-9]{7}/g) && accountNumber.val() != '') {
			accountNumber.focus();
		} else if (!acountName.val().match(/^[\uFF66-\uFF9F]/g) && acountName.val() != '') {
			acountName.focus();
		} else if (userId.val() == '') {
			userId.focus();
		} else if (!userId.val().match(/[a-zA-Z0-9]{6,}/g)) {
			userId.focus();
		} else if (password.val() == '') {
			password.focus();
		} else if (!password.val().match(/(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}/g)) {
			password.focus();
		} else if (password2.val() == '') {
			password2.focus();
		} else if (password2.val() != password.val()) {
			password2.focus();
			return false;
		} else if (amount.val() == '') {
			amount.focus();
		} else if (aobaEmail.val() == '') {
			aobaEmail.focus();
		} else if (!aobaEmail.val().match(/^[0-9a-zA-Z]+[\w\.-]+@[\w\.-]+\.\w{2,}$/)) {
			aobaEmail.focus();
		} else if (has_registered1) {
			alert('"' + siteName.val() + '" はすでに登録されています');
			siteName.focus();
			return false;
		} else if (has_registered2) {
			alert('"' + channelName.val() + '" はすでに登録されています');
			channelName.focus();
			return false;
		} else if (has_registered3) {
			alert('"' + requesterName.val() + '" はすでに登録されています');
			requesterName.focus();
			return false;
		} else if (has_registered4) {
			alert('"' + userId.val() + '" はすでに登録されています');
			userId.focus();
			return false;
		} else {
			if (!confirm('送信しますか？')) {
				return false;
			}
		}
	});
	
	$('#cite_channel').click(function() {
		if (channel.val() == '') {
			return false;
		} else {
			if (channel.val() != channelCode.val()) {
				requesterName.val('').attr('readonly',false).removeClass('back-gray');
				postcode1.val('').attr('readonly',false).removeClass('back-gray');
				postcode2.val('').attr('readonly',false).removeClass('back-gray');
				address1.val('').removeClass('disabled');
				address2.val('').attr('readonly',false).removeClass('back-gray');
				address3.val('').attr('readonly',false).removeClass('back-gray');
				address4.val('').attr('readonly',false).removeClass('back-gray');
				number1.val('').attr('readonly',false).removeClass('back-gray');
				number2.val('').attr('readonly',false).removeClass('back-gray');
				email.val('').attr('readonly',false).removeClass('back-gray');
				bankCode.val('').attr('readonly',false).removeClass('back-gray');
				bank.val('').attr('readonly',false).removeClass('back-gray');
				branchCode.val('').attr('readonly',false).removeClass('back-gray');
				bankBranch.val('').attr('readonly',false).removeClass('back-gray');
				accountType.val('').removeClass('disabled');
				accountNumber.val('').attr('readonly',false).removeClass('back-gray');
				acountName.val('').attr('readonly',false).removeClass('back-gray');
				var req = new XMLHttpRequest();
				const citeChannelContext = $('#cite_channel_context');
				var url = citeChannelContext.val() + "/cite/channel?id=" + channel.val();
				req.open('GET',url);
				req.send();

				req.onreadystatechange = function() {
					if (req.readyState === 4 && req.status === 200) {
						let info = (req.responseText)?JSON.parse(req.responseText):null;
						if (info) {
							channelCode.val(info.CHNLCD);
							channelName.val(info.CHNLNM).attr('readonly',true).addClass('back-gray');
							requesterCode.val(info.REQUCD);
							requester.empty();
							requester.append("<option value=\"\">選択してください</option>");
							
							if (info.REQUNM != '[]') {
								ary = info.REQUNM.split(',');
								$.each(ary, function(index, value){
									if (ary.length == 1) {
										var value = value.slice(1).slice(0, -1);
									} else if (ary.length > 1) {
										if (index == 0) {
											var value = value.slice(1);
										} else if (index == ary.length - 1) {
											var value = value.slice(0, -1);
										}	
									}
									
									var res = $.trim(value);
									requester.append("<option value=\"" + res + "\">" + res +"</option>");
								});	
							}
						}
					}
				}
			}
		}
	});
	
	$('#cite_requester').click(function() {
		if (requester.val() == '') {
			return false;
		} else {
			var req = new XMLHttpRequest();
			const citeRequesterContext = $('#cite_requester_context');
			var url = citeRequesterContext.val() + "/cite/requester?id=" + requester.val();
			req.open('GET',url);
			req.send();

			req.onreadystatechange = function() {
				if (req.readyState === 4 && req.status === 200) {
					let info = (req.responseText)?JSON.parse(req.responseText):null;
					if (info) {
						requesterCode.val(info.REQUCD);
						requesterName.val(info.REQUNM).attr('readonly',true).addClass('back-gray');
						postcode1.val(info.ZIPCD1).attr('readonly',true).addClass('back-gray');
						postcode2.val(info.ZIPCD2).attr('readonly',true).addClass('back-gray');
						address1.val(info.STATNM).addClass('disabled');
						address2.val(info.CITYNM).attr('readonly',true).addClass('back-gray');
						address3.val(info.STRNO1).attr('readonly',true).addClass('back-gray');
						address4.val(info.STRNO2).attr('readonly',true).addClass('back-gray');
						number1.val(info.PHONE1).attr('readonly',true).addClass('back-gray');
						number2.val(info.PHONE2).attr('readonly',true).addClass('back-gray');
						email.val(info.EMLADR).attr('readonly',true).addClass('back-gray');
						bankCode.val(info.BANKCD).attr('readonly',true).addClass('back-gray');
						bank.val(info.BANKNM).attr('readonly',true).addClass('back-gray');
						branchCode.val(info.BRNCCD).attr('readonly',true).addClass('back-gray');
						bankBranch.val(info.BANKBR).attr('readonly',true).addClass('back-gray');
						accountType.val(info.ACNTTY).addClass('disabled');
						accountNumber.val(info.ACNTNU).attr('readonly',true).addClass('back-gray');
						acountName.val(info.ACNTNM).attr('readonly',true).addClass('back-gray');
					}
				}
			}
		}
	});
});
</script>
	
<jsp:include page="../common/footer.jsp" flush="true"/>
