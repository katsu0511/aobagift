<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<%
ArrayList<String> purchase_info = (ArrayList<String>)request.getAttribute("purchase_info");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
Date date = sdf.parse(purchase_info.get(5));
sdf.applyPattern("yyyy年MM月dd日");
String vlddt = sdf.format(date);
%>
<main>
	<div class="container">
		<h2>ギフト注文情報</h2>
<% if (purchase_info.isEmpty()) { %>
		<div class="no-display">該当するレコードが見つかりません。</div>
<% } else { %>
		<div class="show">
			<div class="show-tr">
				<div class="show-th">注文コード:</div>
				<div class="show-td"><div class="show-con"><%= purchase_info.get(0) %></div></div>
			</div>
			<div class="show-tr">
				<div class="show-th">ギフトID:</div>
				<div class="show-td"><div class="show-con"><%= purchase_info.get(1) %></div></div>
			</div>
			<div class="show-tr">
				<div class="show-th">サイトID:</div>
				<div class="show-td"><div class="show-con"><%= purchase_info.get(2) %></div></div>
			</div>
			<div class="show-tr">
				<div class="show-th">購入者:</div>
				<div class="show-td"><div class="show-con"><%= purchase_info.get(3) %> <%= purchase_info.get(6) %></div></div>
			</div>
			<div class="show-tr">
				<div class="show-th">チケット発行数:</div>
				<div class="show-td"><div class="show-con"><%= purchase_info.get(4) %></div></div>
			</div>
			<div class="show-tr">
				<div class="show-th">有効期限:</div>
				<div class="show-td"><div class="show-con"><%= vlddt %></div></div>
			</div>
		</div>
<% } %>
		<div class="show_buttons">
			<button type="button" class="button" onclick="location.href='<%= request.getContextPath() %>/index/purchase_info'">戻る</button>
		</div>
	</div>
</main>
<script type="text/javascript">
</script>
<jsp:include page="../common/footer.jsp" flush="true"/>
