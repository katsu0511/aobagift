<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<Map<String, String>> pcinfs = (ArrayList<Map<String, String>>)request.getAttribute("pcinfs"); %>
<main>
	<div class="container">
<% if (pcinfs.isEmpty()) { %>
		<div class="no-display">登録されている購入者情報がありません。</div>
		<div class="add-button">
			<a href="<%= request.getContextPath() %>/register/purchaser" class="button">新規追加</a>
		</div>
<% } else { %>
		<div class="display-title">
			<h2>購入者一覧</h2>
		</div>
		<div class="add-button">
			<a href="<%= request.getContextPath() %>/register/purchaser" class="button">新規追加</a>
		</div>
		<div class="display">
			<div class="display-thead">
				<div class="display-th" style="width:30%;">購入者コード</div>
				<div class="display-th" style="width:70%;">法人名</div>
			</div>
<%   for (Map<String, String> pcinf : pcinfs) { %>
			<div class="display-tbody">
				<div class="display-td" style="width:30%;"><%= pcinf.get("PCCD") %></div>
				<div class="display-td" style="width:70%;"><a href="<%= request.getContextPath() %>/show/purchaser?pccd=<%= pcinf.get("PCCD") %>" class="display-con"><%= pcinf.get("CORPNM") %></a></div>
			</div>
<%   } %>
		</div>
<% } %>
		<div class="register_buttons">
			<button type="button" class="button" onclick="location.href='<%= request.getContextPath() %>/index/purchase'">戻る</button>
		</div>
	</div>
</main>
<script type="text/javascript">
</script>
<jsp:include page="../common/footer.jsp" flush="true"/>
