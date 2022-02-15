<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<jsp:include page="../common/header.jsp" flush="true"/>

<main>
	<div class="container">
		<h2>管理者ログイン</h2>
	
		<form class="login-form" action="<%= request.getContextPath() %>/login" method="POST">
			<div class="login-img">
				<img src="<%= request.getContextPath() %>/img/aoba.png">
			</div>
			<div class="login-items">
				<div class="login-item">
					<label for="userId" class="login-label">
						ユーザーID:
					</label>
					<div class="login-input">
						<input type="text" id="userId" class="login-info" name="userId" autocomplete="off">
					</div>
				</div>
				
				<div class="login-item">
					<label for="password" class="login-label">
						パスワード:
					</label>
					<div class="login-input">
						<input type="password" id="password" class="login-info" name="password" autocomplete="off">
					</div>
				</div>
				
				<% if (request.getAttribute("errorMessage") != null && request.getAttribute("errorMessage") != "") { %>
					<div class="error-message">
						<%= request.getAttribute("errorMessage") %>
					</div>
				<% } %>
				
				<div class="login-item">
					<div class="login-input">
						<input type="submit" class="button" name="loginBtn" value="ログイン">
					</div>
				</div>
				
				<p class="login-link">
					<a href="<%= request.getContextPath() %>/site.login">サイトログイン</a>
				</p>
			</div>
		</form>
	</div>
</main>
	
<jsp:include page="../common/footer.jsp" flush="true"/>
