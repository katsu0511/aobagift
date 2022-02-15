<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../common/header.jsp" flush="true"/>

<main>
	<div class="container">
		<h3>チャネル名：<%= request.getAttribute("CHNLNM") %></h3>
		<h2>サイト名：<%= request.getAttribute("SITENM") %></h2>
		<a href="<%= request.getContextPath() %>/index/merc" class="management" style="margin:0 auto;">商品一覧</a>
		<div class="login-img" style="margin-top:30px;">
			<img src="<%= request.getContextPath() %>/img/aoba.png">
		</div>
	</div>
</main>
	
<jsp:include page="../common/footer.jsp" flush="true"/>
