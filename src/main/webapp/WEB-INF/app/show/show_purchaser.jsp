<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<String> pcinf = (ArrayList<String>)request.getAttribute("pcinf"); %>
<main>
	<div class="container">
		<h2>購入者情報</h2>
		<div class="show">
			<div class="show-tr">
				<div class="show-th">購入者コード:</div>
				<div class="show-td">
					<div class="show-con">
						<%= pcinf.get(0) %>
					</div>
				</div>
			</div>
			<div class="show-tr">
				<div class="show-th">購入者ロゴ:</div>
				<div class="show-td">
					<div class="show-con">
						<% if (pcinf.get(1) != null && !(pcinf.get(1).isEmpty())) { %>
							<img src="<%= request.getContextPath() %>/logo_corp/<%= pcinf.get(1) %>">
						<% } %>
					</div>
				</div>
			</div>
			<div class="show-tr">
				<div class="show-th">法人名:</div>
				<div class="show-td">
					<div class="show-con">
						<%= pcinf.get(2) %>
					</div>
				</div>
			</div>
			<div class="show-tr">
				<div class="show-th">法人名フリガナ:</div>
				<div class="show-td">
					<div class="show-con">
						<%= pcinf.get(3) %>
					</div>
				</div>
			</div>
			<div class="show-tr">
				<div class="show-th">郵便番号:</div>
				<div class="show-td">
					<div class="show-con">
						<%= pcinf.get(4) %>
					</div>
				</div>
			</div>
			<div class="show-tr">
				<div class="show-th">住所:</div>
				<div class="show-td">
					<div class="show-con">
						<%= pcinf.get(5) %>
						<%= pcinf.get(6) %>
						<%= pcinf.get(7) %>
						<%= pcinf.get(8) %>
					</div>
				</div>
			</div>
			<div class="show-tr">
				<div class="show-th">電話番号1:</div>
				<div class="show-td">
					<div class="show-con">
						<%= pcinf.get(9) %>
					</div>
				</div>
			</div>
			<div class="show-tr">
				<div class="show-th">電話番号2:</div>
				<div class="show-td">
					<div class="show-con">
						<%= pcinf.get(10) %>
					</div>
				</div>
			</div>
			<div class="show-tr">
				<div class="show-th">メールアドレス:</div>
				<div class="show-td">
					<div class="show-con">
						<%= pcinf.get(11) %>
					</div>
				</div>
			</div>
			<div class="show-tr">
				<div class="show-th">金融機関コード:</div>
				<div class="show-td">
					<div class="show-con">
						<%= pcinf.get(12) %>
					</div>
				</div>
			</div>
			<div class="show-tr">
				<div class="show-th">銀行名:</div>
				<div class="show-td">
					<div class="show-con">
						<% if (!pcinf.get(13).isEmpty()) { %>
							<%= pcinf.get(13) %>
							銀行
						<% } %>
					</div>
				</div>
			</div>
			<div class="show-tr">
				<div class="show-th">支店コード:</div>
				<div class="show-td">
					<div class="show-con">
						<%= pcinf.get(14) %>
					</div>
				</div>
			</div>
			<div class="show-tr">
				<div class="show-th">銀行支店名:</div>
				<div class="show-td">
					<div class="show-con">
						<%= pcinf.get(15) %>
					</div>
				</div>
			</div>
			<div class="show-tr">
				<div class="show-th">口座区分:</div>
				<div class="show-td">
					<div class="show-con">
						<% if (pcinf.get(16).equals("1")) { %>
							普通
						<% } else if (pcinf.get(16).equals("2")) { %>
							当座
						<% } else if (pcinf.get(16).equals("3")) { %>
							総合
						<% } %>
					</div>
				</div>
			</div>
			<div class="show-tr">
				<div class="show-th">口座番号:</div>
				<div class="show-td">
					<div class="show-con">
						<%= pcinf.get(17) %>
					</div>
				</div>
			</div>
			<div class="show-tr">
				<div class="show-th">口座名義人:</div>
				<div class="show-td">
					<div class="show-con">
						<%= pcinf.get(18) %>
					</div>
				</div>
			</div>
			<div class="show-tr">
				<div class="show-th">入力日時:</div>
				<div class="show-td">
					<div class="show-con">
						<%= pcinf.get(19) %>
					</div>
				</div>
			</div>
		</div>
		<div class="show_buttons">
			<form action="<%= request.getContextPath() %>/delete/purchaser?pccd=<%= pcinf.get(0) %>" method="post">
				<input type="submit" id="submit_btn" class="button" value="削除">
			</form>
			<a href="<%= request.getContextPath() %>/edit/purchaser?pccd=<%= pcinf.get(0) %>" class="button">編集</a>
			<button type="button" class="button" onclick="location.href='<%= request.getContextPath() %>/index/purchaser'">戻る</button>
		</div>
	</div>
</main>
<script type="text/javascript">
$(function() {
	const submit = $('#submit_btn');
	submit.click(function() {
		if (!confirm('削除しますか？')) {
			return false;
		}
	});
});
</script>
<jsp:include page="../common/footer.jsp" flush="true"/>
