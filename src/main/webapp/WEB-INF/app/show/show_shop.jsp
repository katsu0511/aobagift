<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<String> shop = (ArrayList<String>)request.getAttribute("shop"); %>
   
<main>
	<div class="container">
		<div class="show">
		
			<div class="show-tr">
				<div class="show-th">チャネル名:</div>
				<div class="show-td">
					<div class="show-con">
						<%= shop.get(2) %>
					</div>
				</div>
			</div>
		
			<div class="show-tr">
				<div class="show-th">ショップコード:</div>
				<div class="show-td">
					<div class="show-con">
						<%= shop.get(0) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">ショップ名:</div>
				<div class="show-td">
					<div class="show-con">
						<%= shop.get(3) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">ショップ名フリガナ:</div>
				<div class="show-td">
					<div class="show-con">
						<%= shop.get(4) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">郵便番号:</div>
				<div class="show-td">
					<div class="show-con">
						<%= shop.get(5) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">住所:</div>
				<div class="show-td">
					<div class="show-con">
						<%= shop.get(6) %>
						<%= shop.get(7) %>
						<%= shop.get(8) %>
						<%= shop.get(9) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">電話番号1:</div>
				<div class="show-td">
					<div class="show-con">
						<%= shop.get(10) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">電話番号2:</div>
				<div class="show-td">
					<div class="show-con">
						<%= shop.get(11) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">メールアドレス:</div>
				<div class="show-td">
					<div class="show-con">
						<%= shop.get(12) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">金融機関コード:</div>
				<div class="show-td">
					<div class="show-con">
						<%= shop.get(13) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">銀行名:</div>
				<div class="show-td">
					<div class="show-con">
						<% if (!shop.get(14).isEmpty()) { %>
							<%= shop.get(14) %>
							銀行
						<% } %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">支店コード:</div>
				<div class="show-td">
					<div class="show-con">
						<%= shop.get(15) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">銀行支店名:</div>
				<div class="show-td">
					<div class="show-con">
						<%= shop.get(16) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">口座区分:</div>
				<div class="show-td">
					<div class="show-con">
						<% if (shop.get(17).equals("1")) { %>
							普通
						<% } else if (shop.get(17).equals("2")) { %>
							当座
						<% } else if (shop.get(17).equals("3")) { %>
							総合
						<% } %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">口座番号:</div>
				<div class="show-td">
					<div class="show-con">
						<%= shop.get(18) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">口座名義人:</div>
				<div class="show-td">
					<div class="show-con">
						<%= shop.get(19) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">明細書送付先メールアドレス:</div>
				<div class="show-td">
					<div class="show-con">
						<%= shop.get(20) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">コメント:</div>
				<div class="show-td">
					<div class="show-con">
						<%= shop.get(21) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">入力日時:</div>
				<div class="show-td">
					<div class="show-con">
						<%= shop.get(22) %>
					</div>
				</div>
			</div>
		</div>
		
		<div class="show_buttons">
			<form action="<%= request.getContextPath() %>/delete/shop?id=<%= shop.get(0) %>" method="post">
				<input type="submit" id="submit_btn" class="button" value="削除">
			</form>
			<a href="<%= request.getContextPath() %>/edit/shop?id=<%= shop.get(0) %>" class="button">編集</a>
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
