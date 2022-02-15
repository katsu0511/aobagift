<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<Map<String,String>> channels = (ArrayList<Map<String,String>>)request.getAttribute("channels"); %>

<main>
	<div class="container">
		
		<h2>ショップインポート</h2>
		
		<form id="MHSM" action="<%= request.getContextPath() %>/shop_import" method="POST" enctype="multipart/form-data">
		
			<div class="tr">
				<label for="channel_code" class="th">チャネル:<span>*</span></label>
				<div class="td">
					<select id="channel_code" name="channel_code" required>
						<option value="">選択してください</option>
						<%	for (Map<String, String> channel : channels) {	%>
							<option value=<%= channel.get("CHNLCD") %>>
								<%= channel.get("CHNLNM") %>
							</option>
						<% } %>
					</select>
					<p id="channel_code_error" class="error">チャネルを選択してください</p>
				</div>
			</div>
		
			<div class="tr">
				<label for="shop_list" class="th">ショップリストcsv:<span>*</span></label>
				<div class="td">
					<input type="file" id="shop_list" name="shop_list" required>
					<p>※ショップリストのcsvファイルを読み込みます</p>
					<p id="shop_list_error" class="error">csvファイルをアップロードしてください</p>
				</div>
			</div>
			
			<div class="register_buttons">
				<input type="submit" id="submit" class="button" name="submit" value="インポート" form="MHSM">
				<a href="<%= request.getContextPath() %>/index/shop" class="button">戻る</a>
			</div>
			
		</form>
	</div>
</main>

<script type="text/javascript">
$(function() {
	const submit = $('#submit');
	const channelCode = $('#channel_code');
	const channelCodeError = $('#channel_code_error');
	const shopList = $('#shop_list');
	const shopListError = $('#shop_list_error');
	
	submit.click(function() {
		if (channelCode.val() == '') {
			channelCodeError.css('display','block');
		} else {
			channelCodeError.css('display','none');
		}
		
		if (shopList.val() == '') {
			shopListError.css('display','block');
		} else {
			shopListError.css('display','none');
		}
		
		if (channelCode.val() == '') {
			channelCode.focus();
		} else if (shopList.val() == '') {
			shopList.focus();
		} else {
			if (!confirm('送信しますか？')) {
				return false;
			}
		}
	});
});
</script>
	
<jsp:include page="../common/footer.jsp" flush="true"/>
