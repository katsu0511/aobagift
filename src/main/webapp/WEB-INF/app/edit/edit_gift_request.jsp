<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<String> gift = (ArrayList<String>)request.getAttribute("gift"); %>
<% ArrayList<Map<String,String>> sites = (ArrayList<Map<String,String>>)request.getAttribute("sites"); %>

<main>
	<div class="container">
		
		<h2>ギフト依頼情報編集</h2>
		
		<form id="MHGM" action="<%= request.getContextPath() %>/edit/gift_request" method="POST" enctype="multipart/form-data">
		
			<div class="tr">
				<label for="gift_id" class="th">ギフトID:</label>
				<div class="td">
					<input type="text" id="gift_id" class="back-gray" name="gift_id"
							value="<%= gift.get(0) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="gift_name" class="th">ギフト名:</label>
				<div class="td">
					<input type="text" id="gift_name" class="back-gray" name="gift_name"
							value="<%= gift.get(1) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="requester_logo" class="th">ギフトロゴ:</label>
				<div class="td">
					<input type="text" id="requester_logo" class="back-gray" name="requester_logo" readonly
							<% if (gift.get(2) != null) { %>
								value="<%= gift.get(2) %>"
							<% } %>>
				</div>
			</div>
			
			<div class="tr">
				<label for="channel_code" class="th">チャネルコード:</label>
				<div class="td">
					<input type="text" id="channel_code" class="back-gray" name="channel_code"
							value="<%= gift.get(3) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="channel_name" class="th">チャネル名:</label>
				<div class="td">
					<input type="text" id="channel_name" class="back-gray" name="channel_name" readonly
							<% if (gift.get(4) != null) { %>
								value="<%= gift.get(4) %>"
							<% } %>>
				</div>
			</div>
			
			<div class="tr">
				<label for="requester_code" class="th">依頼者コード:</label>
				<div class="td">
					<input type="text" id="requester_code" class="back-gray" name="requester_code"
							value="<%= gift.get(5) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="requester_name" class="th">依頼者名:</label>
				<div class="td">
					<input type="text" id="requester_name" class="back-gray" name="requester_name"
							value="<%= gift.get(6) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="postcode1" class="th">郵便番号:</label>
				<div class="td">
					<input type="text" id="postcode1" class="postcode back-gray" name="zip1" readonly
							<% if (!(gift.get(7)==null) && !(gift.get(7).isEmpty()) && gift.get(7).length()==8) { %>
								value="<%= gift.get(7).substring(0,3) %>"
							<% } %>>
					-
					<input type="text" id="postcode2" class="postcode back-gray" name="zip2" readonly
							<% if (!(gift.get(7)==null) && !(gift.get(7).isEmpty()) && gift.get(7).length()==8) { %>
								value="<%= gift.get(7).substring(4,8) %>"
							<% } %>>
				</div>
			</div>

			<div class="tr">
				<label for="address1" class="th">都道府県:</label>
				<div class="td">
					<input type="text" id="address1" class="back-gray" name="address1"
							value="<%= gift.get(8) %>" readonly>
				</div>
			</div>

			<div class="tr">
				<label for="address2" class="th">市区町村:</label>
				<div class="td">
					<input type="text" id="address2" class="back-gray" name="address2"
							value="<%= gift.get(9) %>" readonly>
				</div>
			</div>

			<div class="tr">
				<label for="address3" class="th">番地1:</label>
				<div class="td">
					<input type="text" id="address3" name="address3" class="back-gray"
							value="<%= gift.get(10) %>" readonly>
				</div>
			</div>

			<div class="tr">
				<label for="address4" class="th">番地2（建物名）:</label>
				<div class="td">
					<input type="text" id="address4" class="back-gray" name="address4"
							value="<%= gift.get(11) %>" readonly>
				</div>
			</div>

			<div class="tr">
				<label for="number1" class="th">電話番号1:</label>
				<div class="td">
					<input type="text" id="number1" class="short back-gray" name="number1"
							value="<%= gift.get(12) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="number2" class="th">電話番号2:</label>
				<div class="td">
					<input type="text" id="number2" class="short back-gray" name="number2"
							value="<%= gift.get(13) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="email" class="th">メールアドレス:</label>
				<div class="td">
					<input type="text" id="email" class="back-gray" name="email"
							value="<%= gift.get(14) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="bank_code" class="th">金融機関コード:</label>
				<div class="td">
					<input type="text" id="bank_code" class="short back-gray" name="bank_code"
							value="<%= gift.get(15) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="bank" class="th">銀行名:</label>
				<div class="td">
					<input type="text" id="bank" class="short back-gray" name="bank"
							value="<%= gift.get(16) %>" readonly>
					銀行
				</div>
			</div>
			
			<div class="tr">
				<label for="branch_code" class="th">支店コード:</label>
				<div class="td">
					<input type="text" id="branch_code" class="short back-gray" name="branch_code"
							value="<%= gift.get(17) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="bank_branch" class="th">銀行支店名:</label>
				<div class="td">
					<input type="text" id="bank_branch" class="short back-gray" name="bank_branch"
							value="<%= gift.get(18) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="account_type" class="th">口座区分:</label>
				<div class="td">
					<input type="text" id="account_type" class="short back-gray" name="account_type" readonly
							<% if (gift.get(19).equals("1")) { %>
								value="普通"
							<% } else if (gift.get(19).equals("2")) { %>
								value="当座"
							<% } else if (gift.get(19).equals("3")) { %>
								value="総合"
							<% } %>>
				</div>
			</div>
			
			<div class="tr">
				<label for="account_number" class="th">口座番号:</label>
				<div class="td">
					<input type="text" id="account_number" class="short back-gray" name="account_number"
							value="<%= gift.get(20) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="acount_name" class="th">口座名義人:</label>
				<div class="td">
					<input type="text" id="acount_name" class="short back-gray" name="acount_name" 
							value="<%= gift.get(21) %>" readonly>
				</div>
			</div>
          
			<div class="tr">
				<label for="gift_price" class="th">ギフト価格:</label>
				<div class="td">
					<input type="text" id="gift_price" class="short back-gray" name="gift_price"
							value="<%= gift.get(22) %>" readonly>
					円
				</div>
			</div>
			
			<div class="tr">
				<label for="gift_logo" class="th">ギフト表示商品:</label>
				<div class="td">
					<input type="file" id="gift_logo" name="gift_logo" value="<%= gift.get(23) %>">
				</div>
			</div>
			
			<div class="tr">
				<label for="final_sale_date" class="th">販売終了日:</label>
				<div class="td">
					<input type="date" id="final_sale_date" name="final_sale_date" value="<%= gift.get(24) %>">
				</div>
			</div>
			
			<div class="tr">
				<label for="payee_type" class="th">支払い先区分:</label>
				<div class="td">
					<input type="text" id="payee_type" class="back-gray" name="payee_type" readonly
							<% if (gift.get(25).equals("1")) { %>
								value="ギフト作成依頼者"
							<% } else if (gift.get(25).equals("2")) { %>
								value="サイト作成依頼者"
							<% } else if (gift.get(25).equals("3")) { %>
								value="交換施設店舗"
							<% } else if (gift.get(25).equals("9")) { %>
								value="支払対象外"
							<% } %>>
				</div>
			</div>
			
			<div class="tr">
				<label for="site_id" class="th">Web交換用サイト:</label>
				<div class="td">
					<select id="site_id" name="site_id">
						<option value="">選択してください</option>
						<%	for (Map<String, String> site : sites) {	%>
							<option value=<%= site.get("SITEID") %>
											<% if (site.get("SITEID").equals(gift.get(26))) { %> selected <% } %>>
								<%= site.get("SITENM") %>
							</option>
						<% } %>
					</select>
				</div>
			</div>
			
			<div class="tr">
				<label for="comment" class="th">コメント:</label>
				<div class="td">
					<textarea id="comment" name="comment"><%= gift.get(27) %></textarea>
				</div>
			</div>
			
			<div class="register_buttons">
				<input type="submit" id="submit" class="button" name="submit" value="保存" form="MHGM">
				<button type="button" class="button" onclick="history.back()">キャンセル</button>
			</div>
			
		</form>
		
	</div>
</main>

<script type="text/javascript">
$(function() {
	const submit = $('#submit');
	submit.click(function() {
		if (!confirm('送信しますか？')) {
			return false;
		}
	});
});
</script>
	
<jsp:include page="../common/footer.jsp" flush="true"/>
