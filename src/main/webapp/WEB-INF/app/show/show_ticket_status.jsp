<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<Map<String, String>> gftckts = (ArrayList<Map<String, String>>)request.getAttribute("gftckts"); %>
<main>
	<div class="container">
<% if (gftckts.isEmpty()) { %>
		<div class="no-display">注文コードに該当するチケットがありません。</div>
<% } else { %>
		<div class="display-title">
			<h2>チケット状況一覧</h2>
		</div>
		<div class="display">
			<div class="display-thead">
				<div class="display-th" style="width:25%;">チケットコード</div>
				<div class="display-th" style="width:25%;">使用状況</div>
				<div class="display-th" style="width:50%;">チケットURL</div>
			</div>
<%   for (Map<String, String> gftckt : gftckts) { %>
			<div class="display-tbody">
				<div class="display-td" style="width:25%;"><%= gftckt.get("tcktcd") %></div>
				<div class="display-td" style="width:25%;"><% out.print(("0".equals(gftckt.get("status")))?"未使用":"使用済み"); %></div>
				<div class="display-td" style="width:50%;"><input type="text" value="<%= gftckt.get("url") %>" style="width:-webkit-fill-available;font-size:inherit;" readonly></div>
			</div>
<%   } %>
		</div>
<% } %>
		<div class="show_buttons">
			<button type="button" class="button" onclick="history.back()">戻る</button>
		</div>
	</div>
</main>
<script type="text/javascript">
</script>
<jsp:include page="../common/footer.jsp" flush="true"/>
