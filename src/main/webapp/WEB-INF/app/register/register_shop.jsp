<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<Map<String,String>> channels = (ArrayList<Map<String,String>>)request.getAttribute("channels"); %>

<main>
	<div class="container">
		
		<h2>ショップ登録</h2>
		
		<form id="MHSM" action="<%= request.getContextPath() %>/register/shop" method="POST">
		
			<input type="text" id="cite_channel_for_shop" value="<%= request.getContextPath() %>" style="display:none;">
			
			<div class="tr">
				<label for="channel" class="th brown">登録済チャネル呼出:<span>*</span></label>
				<div class="td">
					<select id="channel" name="channel" required>
						<option value="">選択してください</option>
						<%	for (Map<String, String> channel : channels) {	%>
							<option value=<%= channel.get("CHNLCD") %>>
								<%= channel.get("CHNLNM") %>
							</option>
						<% } %>
					</select>
					<p id="channel_error1" class="error">チャネルを選択してください</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="channel_code" class="th brown">チャネルコード:</label>
				<div class="td">
					<input type="text" id="channel_code" class="back-gray" name="channel_code" readonly>
				</div>
			</div>
		
			<div class="tr" style="display:none;">
				<label for="channel_name" class="th brown">チャネル名:</label>
				<div class="td">
					<input type="text" id="channel_name" class="back-gray" name="channel_name" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="shop_code" class="th yellow">ショップコード:</label>
				<div class="td">
					<input type="text" id="shop_code" class="back-gray" name="shop_code" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="shop_name" class="th yellow">ショップ名:<span>*</span></label>
				<div class="td">
					<input type="text" id="shop_name" name="shop_name" required>
					<p id="shop_name_error1" class="error">ショップ名を入力してください</p>
					<p id="shop_name_error2" class="error"></p>
				</div>
			</div>

			<div class="tr">
				<label for="shop_name_kana" class="th yellow">ショップ名フリガナ:</label>
				<div class="td">
					<input type="text" id="shop_name_kana" name="shop_name_kana"
							pattern="^([ァ-ンヴー|　| ]{1,})+$">
					<p>※カタカナ以外はエラーになります</p>
					<p id="shop_name_kana_error2" class="error">カタカナで入力してください</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="postcode1" class="th yellow">郵便番号:</label>
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
				<label for="address1" class="th yellow">都道府県:</label>
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
				<label for="address2" class="th yellow">市区町村:</label>
				<div class="td">
					<input type="text" id="address2" name="address2">
				</div>
			</div>

			<div class="tr">
				<label for="address3" class="th yellow">番地1:</label>
				<div class="td">
					<input type="text" id="address3" name="address3">
					<p>(例：番地、丁目)</p>
				</div>
			</div>

			<div class="tr">
				<label for="address4" class="th yellow">番地2（建物名）:</label>
				<div class="td">
					<input type="text" id="address4" name="address4">
				</div>
			</div>

			<div class="tr">
				<label for="number1" class="th yellow">電話番号1:</label>
				<div class="td">
					<input type="text" id="number1" class="short" name="number1" maxlength="11"
							oninput="value = value.replace(/[^0-9]+/i,'');" pattern="[0-9]{10,11}">
					<p>(例：0312345678)</p>
					<p id="number1_error2" class="error">電話番号1の桁数が間違っています</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="number2" class="th yellow">電話番号2:</label>
				<div class="td">
					<input type="text" id="number2" class="short" name="number2" maxlength="11"
							oninput="value = value.replace(/[^0-9]+/i,'');" pattern="[0-9]{10,11}">
					<p>(例：0312345678)</p>
					<p id="number2_error2" class="error">電話番号2の桁数が間違っています</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="email" class="th yellow">メールアドレス:<span>*</span></label>
				<div class="td">
					<input type="text" id="email" name="email"
							oninput="value = value.replace(/[^a-zA-Z0-9\.@_-]+/i,'');"
							pattern="^[0-9a-zA-Z]+[\w\.-]+@[\w\.-]+\.\w{2,}$" required>
			    	<p id="email_error1" class="error">メールアドレスを入力してください</p>
			    	<p id="email_error2" class="error">正しいメールアドレスの形式で入力して下さい</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="bank_code" class="th yellow">金融機関コード:</label>
				<div class="td">
					<input type="text" id="bank_code" class="short" name="bank_code" maxlength="4"
							oninput="value = value.replace(/[^0-9]+/i,'');" pattern="[0-9]{4}">
					<p id="bank_code_error2" class="error">金融機関コードの桁数が間違っています</p>
				</div>
			</div>
          
			<div class="tr">
				<label for="bank" class="th yellow">銀行名:</label>
				<div class="td">
					<input type="text" id="bank" class="short" name="bank">
					銀行
				</div>
			</div>
			
			<div class="tr">
				<label for="branch_code" class="th yellow">支店コード:</label>
				<div class="td">
					<input type="text" id="branch_code" class="short" name="branch_code" maxlength="3"
							oninput="value = value.replace(/[^0-9]+/i,'');" pattern="[0-9]{3}">
					<p id="branch_code_error2" class="error">支店コードの桁数が間違っています</p>
				</div>
			</div>
          
          <div class="tr">
				<label for="bank_branch" class="th yellow">銀行支店名:</label>
				<div class="td">
					<input type="text" id="bank_branch" class="short" name="bank_branch">
				</div>
			</div>
			
			<div class="tr">
				<label for="account_type" class="th yellow">口座区分:</label>
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
				<label for="account_number" class="th yellow">口座番号:</label>
				<div class="td">
					<input type="text" id="account_number" class="short" name="account_number" maxlength="7"
							oninput="value = value.replace(/[^0-9]+/i,'');" pattern="[0-9]{7}">
					<p id="account_number_error2" class="error">口座番号の桁数が間違っています</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="acount_name" class="th yellow">口座名義人:</label>
				<div class="td">
					<input type="text" id="acount_name" class="short" name="acount_name" maxlength="30"
							pattern="[\uFF66-\uFF9F]*">
					<p>※半角カタカナ以外はエラーになります</p>
					<p id="acount_name_error2" class="error">半角カタカナで入力してください</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="spec_email" class="th yellow">明細書送付先メールアドレス:</label>
				<div class="td">
					<input type="text" id="spec_email" name="spec_email"
							oninput="value = value.replace(/[^a-zA-Z0-9\.@_-]+/i,'');"
							pattern="^[0-9a-zA-Z]+[\w\.-]+@[\w\.-]+\.\w{2,}$">
			    	<p id="spec_email_error2" class="error">正しいメールアドレスの形式で入力して下さい</p>
				</div>
			</div>

			<div class="tr">
				<label for="comment" class="th yellow">コメント:</label>
				<div class="td">
					<textarea id="comment" name="comment"></textarea>
				</div>
			</div>
			
			<div class="register_buttons">
				<input type="submit" class="submit_btn button" name="submit" value="登録終了" form="MHSM">
				<input type="submit" class="submit_btn button" name="submit" value="引き続きショップ登録" form="MHSM">
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
	
	
	
	
	


	const submit = $('.submit_btn');
	const channel = $('#channel');
	const channelError1 = $('#channel_error1');
	const channelCode = $('#channel_code');
	const channelName = $('#channel_name');
	const shopCode = $('#shop_code');
	const shopName = $('#shop_name');
	const shopNameError1 = $('#shop_name_error1');
	const emailError1 = $('#email_error1');
	
	submit.click(function() {
		if (channel.val() == '') {
			channelError1.css('display','block');
		} else {
			channelError1.css('display','none');
		}
		
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

		if (channel.val() == '') {
			channel.focus();
		} else if (shopName.val() == '') {
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
	
	channel.change(function() {
		if (channel.val() == '') {
			channelCode.val('');
			channelName.val('');
			shopCode.val('');
		} else {
			channelCode.val('');
			channelName.val('');
			shopCode.val('');
			var req = new XMLHttpRequest();
			const citeChannelForShop = $('#cite_channel_for_shop');
			var url = citeChannelForShop.val() + "/cite/channel_for_shop?id=" + channel.val();
			req.open('GET',url);
			req.send();

			req.onreadystatechange = function() {
				if (req.readyState === 4 && req.status === 200) {
					let info = (req.responseText)?JSON.parse(req.responseText):null;
					if (info) {
						channelCode.val(info.CHNLCD);
						channelName.val(info.CHNLNM);
						shopCode.val(info.SHOPCD);
					}
				}
			}
		}
	});
	
	$.fn.autoKana('#shop_name', '#shop_name_kana', {katakana:true});
});
</script>
	
<jsp:include page="../common/footer.jsp" flush="true"/>
