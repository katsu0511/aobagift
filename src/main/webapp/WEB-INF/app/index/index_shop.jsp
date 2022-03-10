<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<Map<String, String>> shops = (ArrayList<Map<String, String>>)request.getAttribute("shops"); %>
<% ArrayList<String> channels = (ArrayList<String>)request.getAttribute("channels"); %>

<main>
	<div class="container">
		<% if (shops.isEmpty()) { %>
			<div class="no-display">登録されているショップ情報がありません。</div>
			<div class="add-button">
				<a href="<%= request.getContextPath() %>/register/shop" class="button">新規追加</a>
				<a href="<%= request.getContextPath() %>/shop_import" class="button">インポート</a>
			</div>
		<% } else { %>
			<div class="display-title">
				<h2>ショップ一覧</h2>
			</div>
			<div class="add-button">
				<a href="<%= request.getContextPath() %>/register/shop" class="button">新規追加</a>
				<a href="<%= request.getContextPath() %>/shop_import" class="button">インポート</a>
			</div>
			<div class="searchs">
				<div class="search shop_search">
					<h3>検索:</h3>
					<select id="channel">
						<option value="">全てのチャネル</option>
						<%	for (String channel : channels) {	%>
							<option value="<%= channel %>">
								<%= channel %>
							</option>
						<% } %>
					</select>
				</div>
			</div>
			<div class="display">
				<div class="display-thead">
					<div class="display-th" style="width:20%;">ショップコード</div>
					<div class="display-th" style="width:40%;">チャネル名</div>
					<div class="display-th" style="width:40%;">ショップ名</div>
				</div>
			<% for (Map<String, String> shop : shops) { %>
				<div class="display-tbody visible">
					<div class="display-td" style="width:20%;">
						<%= shop.get("SHOPCD") %>
					</div>
					<div class="display-td channel_name" style="width:40%;">
						<%= shop.get("CHNLNM") %>
					</div>
					<div class="display-td" style="width:40%;">
						<a href="<%= request.getContextPath() %>/show/shop?id=<%= shop.get("SHOPCD") %>" class="display-con">
							<%= shop.get("SHOPNM") %>
						</a>
					</div>
				</div>
	    	<% } %>
			</div>
			<div class="add-button">
				<input type="button" id="submit" class="button" value="エクスポート">
			</div>
		<% } %>
	</div>
</main>

<script type="text/javascript">
$(function() {
	const channel = $('#channel');
	var exp_channel = '全て';
	channel.change(function() {
		const display_tbody = $('.display-tbody');
		const displayTbody = display_tbody.toArray();
		display_tbody.css('display','flex');
		display_tbody.addClass('visible');
		
		if (channel.val() != '') {
			exp_channel = '「' + channel.val() + '」';
			$.each(displayTbody,function() {
				var channel_name = $(this).children('.channel_name').text();
				var channelName = $.trim(channel_name);
				
				if (channel.val() != channelName) {
					$(this).css('display','none');
					$(this).removeClass('visible');
				}
			});
		} else {
			exp_channel = '全て';
		}
	});
	
	const submit = $('#submit');
	submit.click(function() {
		if (confirm(exp_channel + 'のショップ情報をエクスポートしますか？')) {
			var table1 = $('.display-thead .display-th').map(function(i) {
				const displayTh = $.trim($(this).text());
				return displayTh
			});
			var table2 = $('.display .display-tbody.visible').map(function(i) {
				return $(this).find('.display-td').map(function() {
					const displayTd = $.trim($(this).text());
					return displayTd
				});
			});
			
			if (table2.length > 0) {
				var bom = new Uint8Array([0xEF, 0xBB, 0xBF]);
				var csv = table1.toArray().join(',') + '\r\n' + table2.map(function(i, row){return row.toArray().join(',');}).toArray().join('\r\n');
				const blob = new Blob([bom, csv], {type: 'text/csv'});
				const link = document.createElement('a');
				link.href = URL.createObjectURL(blob);
				link.download = 'shops.csv';
				link.click();
			} else {
				alert(exp_channel + 'のショップ情報がありません。');
			}
		}
	});
});
</script>
	
<jsp:include page="../common/footer.jsp" flush="true"/>
