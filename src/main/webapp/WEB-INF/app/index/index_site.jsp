<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<Map<String, String>> sites = (ArrayList<Map<String, String>>)request.getAttribute("sites"); %>
<% ArrayList<String> channels = (ArrayList<String>)request.getAttribute("channels"); %>
<% ArrayList<String> requesters = (ArrayList<String>)request.getAttribute("requesters"); %>

<main>
	<div class="container">
		
		<% if (sites.isEmpty()) { %>
				<div class="no-display">登録されているサイト情報がありません。</div>
				<div class="add-button">
					<a href="<%= request.getContextPath() %>/register/site" class="button">新規追加</a>
				</div>
		<% } else { %>
				<div class="display-title">
					<h2>サイト一覧</h2>
				</div>
				<div class="add-button">
					<a href="<%= request.getContextPath() %>/register/site" class="button">新規追加</a>
				</div>
				<div class="searchs">
					<div class="search">
						<h3>チャネルで検索:</h3>
						<select id="channel">
							<option value="">全てのチャネル</option>
							<%	for (String channel : channels) {	%>
								<option value="<%= channel %>">
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
								<option value="<%= requester %>">
									<%= requester %>
								</option>
							<% } %>
						</select>
					</div>
				</div>
				<div class="display">
					<div class="display-thead">
						<div class="display-th" style="width:20%;">サイトID</div>
						<div class="display-th" style="width:30%;">サイト名</div>
						<div class="display-th" style="width:25%;">チャネル名</div>
						<div class="display-th" style="width:25%;">サイト依頼者名</div>
					</div>
			<% for (Map<String, String> site : sites) { %>
					<div class="display-tbody">
						<div class="display-td" style="width:20%;">
							<%= site.get("SITEID") %>
						</div>
						<div class="display-td" style="width:30%;">
							<a href="<%= request.getContextPath() %>/show/site?id=<%= site.get("SITEID") %>" class="display-con">
								<%= site.get("SITENM") %>
							</a>
						</div>
						<div class="display-td channel_name" style="width:25%;">
							<%= site.get("CHNLNM") %>
						</div>
						<div class="display-td requester_name" style="width:25%;">
							<%= site.get("REQUNM") %>
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
