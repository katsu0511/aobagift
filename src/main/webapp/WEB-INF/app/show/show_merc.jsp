<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<String> merc = (ArrayList<String>)request.getAttribute("merc"); %>
<% ArrayList<Map<String,String>> exch_shops = (ArrayList<Map<String,String>>)request.getAttribute("exch_shops"); %>
<% ArrayList<Map<String,String>> shops = (ArrayList<Map<String,String>>)request.getAttribute("shops"); %>
   
<main>
	<div class="container">
		<div class="show">
		
			<input type="text" id="register_exchange" value="<%= request.getContextPath() %>" style="display:none;">
			<input type="text" id="delete_exchange" value="<%= request.getContextPath() %>" style="display:none;">
		
			<div class="show-tr">
				<div class="show-th">商品コード:</div>
				<div class="show-td">
					<div class="show-con merc-cd">
						<%= merc.get(0) %>
					</div>
				</div>
			</div>
		
			<div class="show-tr">
				<div class="show-th">サイト名:</div>
				<div class="show-td">
					<div class="show-con">
						<%= request.getAttribute("SITENM") %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">商品名:</div>
				<div class="show-td">
					<div class="show-con">
						<%= merc.get(2) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">商品ロゴ:</div>
				<div class="show-td">
					<div class="show-con">
						<% if (merc.get(3) != null) { %>
							<img src="<%= request.getContextPath() %>/logo_merc/<%= merc.get(3) %>">
						<% } %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">交換店舗:</div>
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
						
						<p id="shops_error" class="shop-list error">交換店舗は最大で20店舗までです</p>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">コメント:</div>
				<div class="show-td">
					<div class="show-con">
						<%= merc.get(4) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">入力日時:</div>
				<div class="show-td">
					<div class="show-con">
						<%= merc.get(5) %>
					</div>
				</div>
			</div>
		</div>
		
		<div class="show_buttons">
			<form action="<%= request.getContextPath() %>/delete/merc?id=<%= merc.get(0) %>" method="post">
				<input type="submit" id="submit_btn" class="button" value="削除">
			</form>
			<a href="<%= request.getContextPath() %>/edit/merc?id=<%= merc.get(0) %>" class="button">編集</a>
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
	const merc_cd = $.trim($('.merc-cd').text());
	const dialog = $('#dialog');
	
	submit.click(function() {
		if (!confirm('削除しますか？')) {
			return false;
		}
	});
	
	add.click(function() {
		if (shopCodes.val() == '') {
			return false;
		} else {
			if (exchCodes.children('option').length + shopCodes.val().length > 20) {
				alert('交換店舗は最大で20店舗までです');
				$('#shops_error').css('display','block');
				return false;
			} else {
				var req = new XMLHttpRequest();
				const registerExchange = $('#register_exchange');
				var url = registerExchange.val() + "/register/exchange";
				const shopCodesVal = shopCodes.val();
				req.open('POST',url);
				req.setRequestHeader('content-type', 'application/x-www-form-urlencoded;charset=UTF-8');
				req.send('id=' + merc_cd + '&shopcodes=' + shopCodesVal);

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
			const deleteExchange = $('#delete_exchange');
			var url = deleteExchange.val() + "/delete/exchange";
			const exchCodesVal = exchCodes.val();
			req.open('POST',url);
			req.setRequestHeader('content-type', 'application/x-www-form-urlencoded;charset=UTF-8');
			req.send('id=' + merc_cd + '&exchcodes=' + exchCodesVal);

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
