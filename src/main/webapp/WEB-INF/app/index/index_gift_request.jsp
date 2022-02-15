<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<Map<String, String>> gifts = (ArrayList<Map<String, String>>)request.getAttribute("gifts"); %>
<% ArrayList<String> channels = (ArrayList<String>)request.getAttribute("channels"); %>
<% ArrayList<String> requesters = (ArrayList<String>)request.getAttribute("requesters"); %>

<main>
	<div class="container">
		
		<% if (gifts.isEmpty()) { %>
			<div class="no-display">登録されているギフト依頼情報がありません。</div>
			<div class="add-button">
				<a href="<%= request.getContextPath() %>/register/gift_request" class="button">新規追加</a>
			</div>
		<% } else { %>
			<div class="display-title">
				<h2>ギフト依頼情報一覧</h2>
			</div>
			<div class="add-button">
				<a href="<%= request.getContextPath() %>/register/gift_request" class="button">新規追加</a>
			</div>
			<div class="searchs">
				<div class="search">
					<h3>チャネルで検索:</h3>
					<select id="channel">
						<option value="">全てのチャネル</option>
						<%	for (String channel : channels) {	%>
							<option value=<%= channel %>>
								<%= channel %>
							</option>
						<% } %>
					</select>
				</div>
				<div class="search">
					<h3>依頼者で検索:</h3>
					<select id="requester">
						<option value="">全ての依頼者</option>
						<%	for (String requester : requesters) {	%>
							<option value=<%= requester %>>
								<%= requester %>
							</option>
						<% } %>
					</select>
				</div>
			</div>
			<div class="display">
				<div class="display-thead">
					<div class="display-th" style="width:15%;">ギフトID</div>
					<div class="display-th" style="width:25%;">ギフト名</div>
					<div class="display-th" style="width:10%;">価格</div>
					<div class="display-th" style="width:25%;">チャネル名</div>
					<div class="display-th" style="width:25%;">依頼者名</div>
				</div>
			<% for (Map<String, String> gift : gifts) { %>
				<div class="display-tbody">
					<div class="display-td" style="width:15%;">
						<%= gift.get("GIFTID") %>
					</div>
					<div class="display-td" style="width:25%;">
						<a href="<%= request.getContextPath() %>/show/gift_request?id=<%= gift.get("GIFTID") %>" class="display-con">
							<%= gift.get("GIFTNM") %>
						</a>
					</div>
					<div class="display-td" style="width:10%;">
						<%= gift.get("GIFTPR") %>
						円
					</div>
					<div class="display-td channel_name" style="width:25%;">
						<%= gift.get("CHNLNM") %>
					</div>
					<div class="display-td requester_name" style="width:25%;">
						<%= gift.get("REQUNM") %>
					</div>
				</div>
	    	<% } %>
			</div>
		<% } %>
		
	</div>
</main>

<script type="text/javascript">
$(function() {
	const channel = $('#channel');
	const requester = $('#requester');
	const display_tbody = $('.display-tbody');
	const displayTbody = display_tbody.toArray();
	
	channel.change(function() {
		display_tbody.css('display','flex');
		requester.val('');
		if (channel.val() == '') {
			return false;
		} else {
			$.each(displayTbody,function() {
				var channel_name = $(this).children('.channel_name').text();
				var channelName = $.trim(channel_name);
				if (channel.val() != '' && channel.val() != channelName) {
					$(this).css('display','none');
				}
			});
		}
	}); 
	
	requester.change(function() {
		display_tbody.css('display','flex');
		channel.val('');
		if (requester.val() == '') {
			return false;
		} else {
			$.each(displayTbody,function() {
				var requester_name = $(this).children('.requester_name').text();
				var requesterName = $.trim(requester_name);
				if (requester.val() != '' && requester.val() != requesterName) {
					$(this).css('display','none');
				}
			});
		}
	});
});
</script>
	
<jsp:include page="../common/footer.jsp" flush="true"/>
