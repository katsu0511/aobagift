<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<Map<String, String>> mercs = (ArrayList<Map<String, String>>)request.getAttribute("mercs"); %>

<main>
	<div class="container">
		
		<% if (mercs.isEmpty()) { %>
			<div class="no-display">登録されている商品情報がありません。</div>
			<div class="add-button">
				<a href="<%= request.getContextPath() %>/register/merc?id=<%= request.getAttribute("SITEID") %>" class="button">新規追加</a>
			</div>
		<% } else { %>
			<div class="display-title">
				<h2>商品一覧</h2>
			</div>
			<div class="add-button">
				<a href="<%= request.getContextPath() %>/register/merc?id=<%= request.getAttribute("SITEID") %>" class="button">新規追加</a>
			</div>
			<div class="display">
				<div class="display-thead">
					<div class="display-th" style="width:30%;">商品コード</div>
					<div class="display-th" style="width:70%;">商品名</div>
				</div>
			<% for (Map<String, String> merc : mercs) { %>
				<div class="display-tbody">
					<div class="display-td" style="width:30%;">
						<%= merc.get("MERCCD") %>
					</div>
					<div class="display-td" style="width:70%;">
						<a href="<%= request.getContextPath() %>/show/merc?id=<%= merc.get("MERCCD") %>" class="display-con">
							<%= merc.get("MERCNM") %>
						</a>
					</div>
				</div>
	    	<% } %>
			</div>
		<% } %>
		
	</div>
</main>
	
<jsp:include page="../common/footer.jsp" flush="true"/>
