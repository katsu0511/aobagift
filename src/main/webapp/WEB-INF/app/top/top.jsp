<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../common/header.jsp" flush="true"/>

<main>
	<div class="container">
		
		<div class="top">
			<a href="<%= request.getContextPath() %>/index/gift_request" class="management">ギフト作成・照会</a>
			<a href="<%= request.getContextPath() %>/index/site" class="management">サイト作成・照会</a>
			<a href="<%= request.getContextPath() %>/index/shop" class="management">ショップ作成・照会・出力</a>
			<a href="<%= request.getContextPath() %>/index/purchase" class="management">チケット作成・照会・出力</a>
		</div>
		<img src="<%= request.getContextPath() %>/img/aoba.png">
		
	</div>
</main>
	
<jsp:include page="../common/footer.jsp" flush="true"/>
