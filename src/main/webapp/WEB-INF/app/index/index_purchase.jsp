<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<main>
	<div class="container">
		<div class="top">
			<a href="<%= request.getContextPath() %>/register/purchaser" class="management">購入者情報入力</a>
			<a href="<%= request.getContextPath() %>/index/purchaser" class="management">購入者情報照会</a>
			<a href="<%= request.getContextPath() %>/register/purchase_order" class="management">注文情報入力</a>
			<a href="<%= request.getContextPath() %>/index/purchase_info" class="management">注文情報照会</a>
			<a href="<%= request.getContextPath() %>/index/ticket_info" class="management">チケット照会・出力</a>
			<a href="<%= request.getContextPath() %>/index/ticket" class="management">チケット編集</a>
			<a href="<%= request.getContextPath() %>/index/ticket_status" class="management" style="display:none;">チケット状況照会</a>
			<a href="<%= request.getContextPath() %>/index/exchange_history" class="management" style="display:none;">チケット交換履歴照会</a>
		</div>
	</div>
</main>
<jsp:include page="../common/footer.jsp" flush="true"/>
