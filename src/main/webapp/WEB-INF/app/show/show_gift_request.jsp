<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<String> gift = (ArrayList<String>)request.getAttribute("gift"); %>
<% ArrayList<Map<String,String>> exch_shops = (ArrayList<Map<String,String>>)request.getAttribute("exch_shops"); %>
<% ArrayList<Map<String,String>> shops = (ArrayList<Map<String,String>>)request.getAttribute("shops"); %>
   
<main>
	<div class="container">
		<div class="show">
		
			<input type="text" id="register_onsite_exchange" value="<%= request.getContextPath() %>" style="display:none;">
			<input type="text" id="delete_onsite_exchange" value="<%= request.getContextPath() %>" style="display:none;">
		
			<div class="show-tr">
				<div class="show-th">ギフトID:</div>
				<div class="show-td">
					<div class="show-con gift-id">
						<%= gift.get(0) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">ギフト名:</div>
				<div class="show-td">
					<div class="show-con">
						<%= gift.get(1) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">ギフトロゴ:</div>
				<div class="show-td">
					<div class="show-con">
						<% if (gift.get(2) != null) { %>
							<img src="<%= request.getContextPath() %>/logo_requester/<%= gift.get(2) %>">
						<% } %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">チャネルコード:</div>
				<div class="show-td">
					<div class="show-con">
						<%= gift.get(3) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">チャネル名:</div>
				<div class="show-td">
					<div class="show-con">
						<%= gift.get(4) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">依頼者コード:</div>
				<div class="show-td">
					<div class="show-con">
						<%= gift.get(5) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">依頼者名:</div>
				<div class="show-td">
					<div class="show-con">
						<%= gift.get(6) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">郵便番号:</div>
				<div class="show-td">
					<div class="show-con">
						<%= gift.get(7) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">住所:</div>
				<div class="show-td">
					<div class="show-con">
						<%= gift.get(8) %>
						<%= gift.get(9) %>
						<%= gift.get(10) %>
						<%= gift.get(11) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">電話番号1:</div>
				<div class="show-td">
					<div class="show-con">
						<%= gift.get(12) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">電話番号2:</div>
				<div class="show-td">
					<div class="show-con">
						<%= gift.get(13) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">メールアドレス:</div>
				<div class="show-td">
					<div class="show-con">
						<%= gift.get(14) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">金融機関コード:</div>
				<div class="show-td">
					<div class="show-con">
						<%= gift.get(15) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">銀行名:</div>
				<div class="show-td">
					<div class="show-con">
						<% if (!gift.get(16).isEmpty()) { %>
							<%= gift.get(16) %>
							銀行
						<% } %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">支店コード:</div>
				<div class="show-td">
					<div class="show-con">
						<%= gift.get(17) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">銀行支店名:</div>
				<div class="show-td">
					<div class="show-con">
						<%= gift.get(18) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">口座区分:</div>
				<div class="show-td">
					<div class="show-con">
						<% if (gift.get(19).equals("1")) { %>
							普通
						<% } else if (gift.get(19).equals("2")) { %>
							当座
						<% } else if (gift.get(19).equals("3")) { %>
							総合
						<% } %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">口座番号:</div>
				<div class="show-td">
					<div class="show-con">
						<%= gift.get(20) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">口座名義人:</div>
				<div class="show-td">
					<div class="show-con">
						<%= gift.get(21) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">ギフト価格:</div>
				<div class="show-td">
					<div class="show-con">
						<%= gift.get(22) %>
						円
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">ギフト表示商品:</div>
				<div class="show-td">
					<div class="show-con">
						<% if (gift.get(23) != null) { %>
							<img src="<%= request.getContextPath() %>/logo_gift/<%= gift.get(23) %>">
						<% } %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">販売終了日:</div>
				<div class="show-td">
					<div class="show-con">
						<%= gift.get(24) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">支払い先区分:</div>
				<div class="show-td">
					<div class="show-con">
						<% if (gift.get(25).equals("1")) { %>
							ギフト作成依頼者
						<% } else if (gift.get(25).equals("2")) { %>
							サイト作成依頼者
						<% } else if (gift.get(25).equals("3")) { %>
							交換施設店舗
						<% } else if (gift.get(25).equals("9")) { %>
							支払対象外
						<% } %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">Web交換用サイト:</div>
				<div class="show-td">
					<div class="show-con">
						<% if (request.getAttribute("SITENM") != null && request.getAttribute("SITENM") != "") { %>
							<%= request.getAttribute("SITENM") %>
						<% } %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">店舗交換可能なショップ:</div>
				<div class="show-td">
					<div class="show-con">
						<p class="shop-list">
							<% for (int i = 0; i < exch_shops.size(); i++) { %>
								<% if (i == exch_shops.size() - 1) { %>
									<%= exch_shops.get(i).get("SHOPNM") %>
								<% } else { %>
									<%= exch_shops.get(i).get("SHOPNM") %>,
								<% } %>
							<% } %>
						</p>
						
						<div class="exch_form">
							<select id="shop_codes" name="shop_codes" multiple>
								<%	for (Map<String, String> shop : shops) {	%>
									<option value=<%= shop.get("SHOPCD") %>
													<% for (Map<String, String> exch_shop : exch_shops) { %>
														<% if (shop.get("SHOPNM").equals(exch_shop.get("SHOPNM"))) { %>
															disabled
														<% } %>
													<% } %>
													>
										<%= shop.get("SHOPNM") %>
									</option>
								<% } %>
							</select>
							<input type="button" id="add" class="button" value="追加">
						</div>
						
						<div class="exch_form">
							<select id="exch_codes" name="exch_codes" multiple>
								<%	for (Map<String, String> exch_shop : exch_shops) {	%>
									<option value=<%= exch_shop.get("SHOPCD") %>>
										<%= exch_shop.get("SHOPNM") %>
									</option>
								<% } %>
							</select>
							<input type="button" id="del" class="button" value="削除">
						</div>
						
						<p id="shops_error" class="shop-list error">店舗交換可能なショップは最大で1000個までです</p>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">コメント:</div>
				<div class="show-td">
					<div class="show-con">
						<%= gift.get(27) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">入力日時:</div>
				<div class="show-td">
					<div class="show-con">
						<%= gift.get(28) %>
					</div>
				</div>
			</div>
		</div>
		
		<div class="show_buttons">
			<form action="<%= request.getContextPath() %>/delete/gift_request?id=<%= gift.get(0) %>" method="post">
				<input type="submit" id="submit_btn" class="button" value="削除">
			</form>
			<a href="<%= request.getContextPath() %>/edit/gift_request?id=<%= gift.get(0) %>" class="button">編集</a>
		</div>
		
	</div>
</main>

<script type="text/javascript">
$(function() {
	const submit = $('#submit_btn');
	const add = $('#add');
	const del = $('#del');
	const shopCodes = $('#shop_codes');
	const exchCodes = $('#exch_codes');
	const gift_id = $.trim($('.gift-id').text());
	
	submit.click(function() {
		if (!confirm('削除しますか？')) {
			return false;
		}
	});
	
	add.click(function() {
		if (shopCodes.val() == '') {
			return false;
		} else {
			if (exchCodes.children('option').length + shopCodes.val().length > 1000) {
				alert('店舗交換可能なショップは最大で1000個までです');
				$('#shops_error').css('display','block');
				return false;
			} else {
				var req = new XMLHttpRequest();
				const registerOnsiteExchange = $('#register_onsite_exchange');
				var url = registerOnsiteExchange.val() + "/register/onsite_exchange";
				const shopCodesVal = shopCodes.val();
				req.open('POST',url);
				req.setRequestHeader('content-type', 'application/x-www-form-urlencoded;charset=UTF-8');
				req.send('id=' + gift_id + '&shopcodes=' + shopCodesVal);

				req.onreadystatechange = function() {
					if (req.readyState === 4 && req.status === 200) {
						alert('店舗が追加されました。');
						location.reload();
					}
				}
			}
		}
	});
	
	del.click(function() {
		if (exchCodes.val() == '') {
			return false;
		} else {
			var req = new XMLHttpRequest();
			const deleteOnsiteExchange = $('#delete_onsite_exchange');
			var url = deleteOnsiteExchange.val() + "/delete/onsite_exchange";
			const exchCodesVal = exchCodes.val();
			req.open('POST',url);
			req.setRequestHeader('content-type', 'application/x-www-form-urlencoded;charset=UTF-8');
			req.send('id=' + gift_id + '&exchcodes=' + exchCodesVal);

			req.onreadystatechange = function() {
				if (req.readyState === 4 && req.status === 200) {
					alert('店舗が削除されました。');
					location.reload();
				}
			}
		}
	});
});
</script>
	
<jsp:include page="../common/footer.jsp" flush="true"/>
