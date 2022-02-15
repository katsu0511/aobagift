<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<String> shop = (ArrayList<String>)request.getAttribute("shop"); %>

<main>
	<div class="container">
		
		<h2>ショップ情報編集</h2>
		
		<form id="MHSM" action="<%= request.getContextPath() %>/edit/shop" method="POST">
			
			<div class="tr">
				<label for="channel_name" class="th">チャネル名:</label>
				<div class="td">
					<input type="text" id="channel_name" class="back-gray" name="channel_name"
							value="<%= shop.get(2) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="shop_code" class="th">ショップコード:</label>
				<div class="td">
					<input type="text" id="shop_code" class="back-gray" name="shop_code"
							value="<%= shop.get(0) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="shop_name" class="th">ショップ名:<span>*</span></label>
				<div class="td">
					<input type="text" id="shop_name" name="shop_name"
							value="<%= shop.get(3) %>" autofocus required>
					<p id="shop_name_error1" class="error">ショップ名を入力してください</p>
				</div>
			</div>

			<div class="tr">
				<label for="shop_name_kana" class="th">ショップ名フリガナ:</label>
				<div class="td">
					<input type="text" id="shop_name_kana" name="shop_name_kana" value="<%= shop.get(4) %>"
							pattern="^([ァ-ンヴー|　| ]{1,})+$">
					<p>※カタカナ以外はエラーになります</p>
					<p id="shop_name_kana_error2" class="error">カタカナで入力してください</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="postcode1" class="th">郵便番号:</label>
				<div class="td">
					<input type="text" id="postcode1" class="postcode" name="zip1" maxlength="3"
							oninput="value = value.replace(/[^0-9]+/i,'');" pattern="[0-9]{3}"
							onkeyup="AjaxZip3.zip2addr('zip1', 'zip2', 'address1', 'address2');"
							<% if (!(shop.get(5) == null) && !(shop.get(5).isEmpty()) && shop.get(5).length() == 8) { %>
								value="<%= shop.get(5).substring(0,3) %>"
							<% } %>>
					-
					<input type="text" id="postcode2" class="postcode" name="zip2" maxlength="4"
							oninput="value = value.replace(/[^0-9]+/i,'');" pattern="[0-9]{4}"
							onkeyup="AjaxZip3.zip2addr('zip1', 'zip2', 'address1', 'address2');"
							<% if (!(shop.get(5) == null) && !(shop.get(5).isEmpty()) && shop.get(5).length() == 8) { %>
								value="<%= shop.get(5).substring(4,8) %>"
							<% } %>>
					<p>(例：123-4567)</p>
					<p id="postcode_error2" class="error">郵便番号の桁数が間違っています</p>
				</div>
			</div>

			<div class="tr">
				<label for="address1" class="th">都道府県:</label>
				<div class="td">
					<select id="address1" name="address1">
						<option value="">選択してください</option>
						<optgroup label="北海道・東北">
							<option value="北海道" <% if (shop.get(6).equals("北海道")) { %> selected <% } %>>北海道</option>
							<option value="青森県" <% if (shop.get(6).equals("青森県")) { %> selected <% } %>>青森県</option>
							<option value="岩手県" <% if (shop.get(6).equals("岩手県")) { %> selected <% } %>>岩手県</option>
							<option value="秋田県" <% if (shop.get(6).equals("秋田県")) { %> selected <% } %>>秋田県</option>
							<option value="宮城県" <% if (shop.get(6).equals("宮城県")) { %> selected <% } %>>宮城県</option>
							<option value="山形県" <% if (shop.get(6).equals("山形県")) { %> selected <% } %>>山形県</option>
							<option value="福島県" <% if (shop.get(6).equals("福島県")) { %> selected <% } %>>福島県</option>
						</optgroup>
						<optgroup label="北信越">
							<option value="新潟県" <% if (shop.get(6).equals("新潟県")) { %> selected <% } %>>新潟県</option>
							<option value="長野県" <% if (shop.get(6).equals("長野県")) { %> selected <% } %>>長野県</option>
							<option value="富山県" <% if (shop.get(6).equals("富山県")) { %> selected <% } %>>富山県</option>
							<option value="石川県" <% if (shop.get(6).equals("石川県")) { %> selected <% } %>>石川県</option>
							<option value="福井県" <% if (shop.get(6).equals("福井県")) { %> selected <% } %>>福井県</option>
						</optgroup>
						<optgroup label="関東">
							<option value="茨城県" <% if (shop.get(6).equals("茨城県")) { %> selected <% } %>>茨城県</option>
							<option value="栃木県" <% if (shop.get(6).equals("栃木県")) { %> selected <% } %>>栃木県</option>
							<option value="群馬県" <% if (shop.get(6).equals("群馬県")) { %> selected <% } %>>群馬県</option>
							<option value="千葉県" <% if (shop.get(6).equals("千葉県")) { %> selected <% } %>>千葉県</option>
							<option value="埼玉県" <% if (shop.get(6).equals("埼玉県")) { %> selected <% } %>>埼玉県</option>
							<option value="東京都" <% if (shop.get(6).equals("東京都")) { %> selected <% } %>>東京都</option>
							<option value="神奈川県" <% if (shop.get(6).equals("神奈川県")) { %> selected <% } %>>神奈川県</option>
						</optgroup>
						<optgroup label="中部">
							<option value="山梨県" <% if (shop.get(6).equals("山梨県")) { %> selected <% } %>>山梨県</option>
							<option value="静岡県" <% if (shop.get(6).equals("静岡県")) { %> selected <% } %>>静岡県</option>
							<option value="岐阜県" <% if (shop.get(6).equals("岐阜県")) { %> selected <% } %>>岐阜県</option>
							<option value="愛知県" <% if (shop.get(6).equals("愛知県")) { %> selected <% } %>>愛知県</option>
							<option value="三重県" <% if (shop.get(6).equals("三重県")) { %> selected <% } %>>三重県</option>
						</optgroup>
						<optgroup label="関西">
							<option value="滋賀県" <% if (shop.get(6).equals("滋賀県")) { %> selected <% } %>>滋賀県</option>
							<option value="奈良県" <% if (shop.get(6).equals("奈良県")) { %> selected <% } %>>奈良県</option>
							<option value="和歌山県" <% if (shop.get(6).equals("和歌山県")) { %> selected <% } %>>和歌山県</option>
							<option value="京都府" <% if (shop.get(6).equals("京都府")) { %> selected <% } %>>京都府</option>
							<option value="大阪府" <% if (shop.get(6).equals("大阪府")) { %> selected <% } %>>大阪府</option>
							<option value="兵庫県" <% if (shop.get(6).equals("兵庫県")) { %> selected <% } %>>兵庫県</option>
						</optgroup>
						<optgroup label="中国">
							<option value="鳥取県" <% if (shop.get(6).equals("鳥取県")) { %> selected <% } %>>鳥取県</option>
							<option value="岡山県" <% if (shop.get(6).equals("岡山県")) { %> selected <% } %>>岡山県</option>
							<option value="島根県" <% if (shop.get(6).equals("島根県")) { %> selected <% } %>>島根県</option>
							<option value="広島県" <% if (shop.get(6).equals("広島県")) { %> selected <% } %>>広島県</option>
							<option value="山口県" <% if (shop.get(6).equals("山口県")) { %> selected <% } %>>山口県</option>
						</optgroup>
						<optgroup label="四国">
							<option value="香川県" <% if (shop.get(6).equals("香川県")) { %> selected <% } %>>香川県</option>
							<option value="徳島県" <% if (shop.get(6).equals("徳島県")) { %> selected <% } %>>徳島県</option>
							<option value="愛媛県" <% if (shop.get(6).equals("愛媛県")) { %> selected <% } %>>愛媛県</option>
							<option value="高知県" <% if (shop.get(6).equals("高知県")) { %> selected <% } %>>高知県</option>
						</optgroup>
						<optgroup label="九州">
							<option value="福岡県" <% if (shop.get(6).equals("福岡県")) { %> selected <% } %>>福岡県</option>
							<option value="佐賀県" <% if (shop.get(6).equals("佐賀県")) { %> selected <% } %>>佐賀県</option>
							<option value="長崎県" <% if (shop.get(6).equals("長崎県")) { %> selected <% } %>>長崎県</option>
							<option value="大分県" <% if (shop.get(6).equals("大分県")) { %> selected <% } %>>大分県</option>
							<option value="熊本県" <% if (shop.get(6).equals("熊本県")) { %> selected <% } %>>熊本県</option>
							<option value="宮崎県" <% if (shop.get(6).equals("宮崎県")) { %> selected <% } %>>宮崎県</option>
							<option value="鹿児島県" <% if (shop.get(6).equals("鹿児島県")) { %> selected <% } %>>鹿児島県</option>
							<option value="沖縄県" <% if (shop.get(6).equals("沖縄県")) { %> selected <% } %>>沖縄県</option>
						</optgroup>
					</select>
				</div>
			</div>

			<div class="tr">
				<label for="address2" class="th">市区町村:</label>
				<div class="td">
					<input type="text" id="address2" name="address2" value="<%= shop.get(7) %>">
				</div>
			</div>

			<div class="tr">
				<label for="address3" class="th">番地1:</label>
				<div class="td">
					<input type="text" id="address3" name="address3" value="<%= shop.get(8) %>">
					<p>(例：番地、丁目)</p>
				</div>
			</div>

			<div class="tr">
				<label for="address4" class="th">番地2（建物名）:</label>
				<div class="td">
					<input type="text" id="address4" name="address4" value="<%= shop.get(9) %>">
				</div>
			</div>

			<div class="tr">
				<label for="number1" class="th">電話番号1:</label>
				<div class="td">
					<input type="text" id="number1" class="short" name="number1"
							value="<%= shop.get(10) %>" maxlength="11"
							oninput="value = value.replace(/[^0-9]+/i,'');" pattern="[0-9]{10,11}">
					<p>(例：0312345678)</p>
					<p id="number1_error2" class="error">電話番号1の桁数が間違っています</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="number2" class="th">電話番号2:</label>
				<div class="td">
					<input type="text" id="number2" class="short" name="number2"
							value="<%= shop.get(11) %>" maxlength="11"
							oninput="value = value.replace(/[^0-9]+/i,'');" pattern="[0-9]{10,11}">
					<p>(例：0312345678)</p>
					<p id="number2_error2" class="error">電話番号2の桁数が間違っています</p>
				</div>
			</div>

			<div class="tr">
				<label for="email" class="th">メールアドレス:<span>*</span></label>
				<div class="td">
					<input type="text" id="email" name="email" value="<%= shop.get(12) %>"
							oninput="value = value.replace(/[^a-zA-Z0-9\.@_-]+/i,'');"
							pattern="^[0-9a-zA-Z]+[\w\.-]+@[\w\.-]+\.\w{2,}$" required>
			    	<p id="email_error1" class="error">メールアドレスを入力してください</p>
			    	<p id="email_error2" class="error">正しいメールアドレスの形式で入力して下さい</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="bank_code" class="th">金融機関コード:</label>
				<div class="td">
					<input type="text" id="bank_code" class="short" name="bank_code" value="<%= shop.get(13) %>" maxlength="4"
							oninput="value = value.replace(/[^0-9]+/i,'');" pattern="[0-9]{4}">
					<p id="bank_code_error2" class="error">金融機関コードの桁数が間違っています</p>
				</div>
			</div>
          
			<div class="tr">
				<label for="bank" class="th">銀行名:</label>
				<div class="td">
					<input type="text" id="bank" class="short" name="bank"
							value="<%= shop.get(14) %>">
					銀行
				</div>
			</div>
			
			<div class="tr">
				<label for="branch_code" class="th">支店コード:</label>
				<div class="td">
					<input type="text" id="branch_code" class="short" name="branch_code" value="<%= shop.get(15) %>" maxlength="3"
							oninput="value = value.replace(/[^0-9]+/i,'');" pattern="[0-9]{3}">
					<p id="branch_code_error2" class="error">支店コードの桁数が間違っています</p>
				</div>
			</div>
          
          <div class="tr">
				<label for="bank_branch" class="th">銀行支店名:</label>
				<div class="td">
					<input type="text" id="bank_branch" class="short" name="bank_branch"
							value="<%= shop.get(16) %>">
				</div>
			</div>
			
			<div class="tr">
				<label for="account_type" class="th">口座区分:</label>
				<div class="td">
					<select id="account_type" class="short" name="account_type">
						<option value="">選択してください</option>
						<option value="1" <% if (shop.get(17).equals("1")) { %> selected <% } %>>普通</option>
						<option value="2" <% if (shop.get(17).equals("2")) { %> selected <% } %>>当座</option>
						<option value="3" <% if (shop.get(17).equals("3")) { %> selected <% } %>>総合</option>
					</select>
				</div>
			</div>
			
			<div class="tr">
				<label for="account_number" class="th">口座番号:</label>
				<div class="td">
					<input type="text" id="account_number" class="short" name="account_number"
							value="<%= shop.get(18) %>" maxlength="7"
							oninput="value = value.replace(/[^0-9]+/i,'');" pattern="[0-9]{7}">
					<p id="account_number_error2" class="error">口座番号の桁数が間違っています</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="acount_name" class="th">口座名義人:</label>
				<div class="td">
					<input type="text" id="acount_name" class="short" name="acount_name" value="<%= shop.get(19) %>" maxlength="30"
							pattern="[\uFF66-\uFF9F]*">
					<p>※半角カタカナ以外はエラーになります</p>
					<p id="acount_name_error2" class="error">半角カタカナで入力してください</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="spec_email" class="th">明細書送付先メールアドレス:</label>
				<div class="td">
					<input type="text" id="spec_email" name="spec_email" value="<%= shop.get(20) %>"
							oninput="value = value.replace(/[^a-zA-Z0-9\.@_-]+/i,'');"
							pattern="^[0-9a-zA-Z]+[\w\.-]+@[\w\.-]+\.\w{2,}$">
			    	<p id="spec_email_error2" class="error">正しいメールアドレスの形式で入力して下さい</p>
				</div>
			</div>

			<div class="tr">
				<label for="comment" class="th">コメント:</label>
				<div class="td">
					<textarea id="comment" name="comment"><%= shop.get(21) %></textarea>
				</div>
			</div>
			
			<div class="register_buttons">
				<input type="submit" id="submit" class="button" name="submit" value="保存" form="MHSM">
				<button type="button" class="button" onclick="history.back()">キャンセル</button>
			</div>
			
		</form>
	</div>
</main>

<script type="text/javascript">
$(function() {
	const shopNameKana = $('#shop_name_kana');
	const shopNameKanaError2 = $('#shop_name_kana_error2');
	shopNameKana.blur(function() {
		if ($(this).val() == '') {
			shopNameKanaError2.css('display','none');
		} else if (!$(this).val().match(/^[ア-ン]/g)) {
			shopNameKanaError2.css('display','block');
		} else {
			shopNameKanaError2.css('display','none');
		}
	});
	
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
	
	const specEmail = $('#spec_email');
	const specEmailError2 = $('#spec_email_error2');
	specEmail.blur(function() {
		if ($(this).val() == '') {
			specEmailError2.css('display','none');
		} else if (!$(this).val().match(/^[0-9a-zA-Z]+[\w\.-]+@[\w\.-]+\.\w{2,}$/)) {
			specEmailError2.css('display','block');
		} else {
			specEmailError2.css('display','none');
		}
	});
	
	const submit = $('#submit');
	const shopName = $('#shop_name');
	const shopNameError1 = $('#shop_name_error1');
	const emailError1 = $('#email_error1');
	
	submit.click(function() {
		if (shopName.val() == '') {
			shopNameError1.css('display','block');
		} else {
			shopNameError1.css('display','none');
		}
		
		if (email.val() == '') {
			emailError1.css('display','block');
		} else {
			emailError1.css('display','none');
		}

		if (shopName.val() == '') {
			shopName.focus();
		} else if (!shopNameKana.val().match(/^[ア-ン]/g) && shopNameKana.val() != '') {
			shopNameKana.focus();
		} else if (!postcode1.val().match(/[0-9]{3}/g) && postcode1.val() != '') {
			postcode1.focus();
		} else if (!postcode2.val().match(/[0-9]{4}/g) && postcode2.val() != '') {
			postcode2.focus();
		} else if (!number1.val().match(/[0-9]{10,11}/g) && number1.val() != '') {
			number1.focus();
		} else if (!number2.val().match(/[0-9]{10,11}/g) && number2.val() != '') {
			number2.focus();
		} else if (email.val() == '') {
			email.focus();
		} else if (!email.val().match(/^[0-9a-zA-Z]+[\w\.-]+@[\w\.-]+\.\w{2,}$/)) {
			email.focus();
		} else if (!bankCode.val().match(/[0-9]{4}/g) && bankCode.val() != '') {
			bankCode.focus();
		} else if (!branchCode.val().match(/[0-9]{3}/g) && branchCode.val() != '') {
			branchCode.focus();
		} else if (!accountNumber.val().match(/[0-9]{7}/g) && accountNumber.val() != '') {
			accountNumber.focus();
		} else if (!acountName.val().match(/^[\uFF66-\uFF9F]/g) && acountName.val() != '') {
			acountName.focus();
		} else if (!specEmail.val().match(/^[0-9a-zA-Z]+[\w\.-]+@[\w\.-]+\.\w{2,}$/) && specEmail.val() != '') {
			specEmail.focus();
		} else {
			if (!confirm('送信しますか？')) {
				return false;
			}
		}
	});
	
	$.fn.autoKana('#shop_name', '#shop_name_kana', {katakana:true});
});
</script>
	
<jsp:include page="../common/footer.jsp" flush="true"/>
