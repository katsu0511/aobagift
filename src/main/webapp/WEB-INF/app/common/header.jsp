<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
	<title>青葉ギフト</title>
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/style.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>

	<header style="background-image: url('<%= request.getContextPath() %>/img/header.jpg');">
		<div class="container">
			<h1>
				<% if (session.getAttribute("userId") != null && session.getAttribute("password") != null) { %>
					<% if (!request.getServletPath().equals("/WEB-INF/app/top/top.jsp") && !request.getServletPath().equals("/WEB-INF/app/top/my_page.jsp")) { %>
						<button type="button" class="back-btn" onclick="history.back()">＜</button>
					<% } %>
				<% } %>
				AOBA
			</h1>
			<% if (session.getAttribute("userId") != null && session.getAttribute("password") != null) { %>
				<form class="header-btn" action="<%= request.getContextPath() %>/logout" method="POST">
					<% if (!request.getServletPath().equals("/WEB-INF/app/top/top.jsp") && !request.getServletPath().equals("/WEB-INF/app/top/my_page.jsp")) { %>
						<a href="<%= request.getContextPath() %>/top" class="button">ホーム</a>
					<% } %>
					<button type="submit" class="button">ログアウト</button>
				</form>
			<% } %>
		</div>
	</header>