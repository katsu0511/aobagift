<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<String> site = (ArrayList<String>)request.getAttribute("site"); %>
   
<main>
	<div class="container">
		<div class="show">
			
			<div class="show-tr">
				<div class="show-th">サイトID:</div>
				<div class="show-td">
					<div class="show-con">
						<%= site.get(0) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">サイト名:</div>
				<div class="show-td">
					<div class="show-con">
						<%= site.get(1) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">サイトロゴ:</div>
				<div class="show-td">
					<div class="show-con">
						<% if (site.get(2) != null) { %>
							<img src="<%= request.getContextPath() %>/logo_requester/<%= site.get(2) %>">
						<% } %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">チャネルコード:</div>
				<div class="show-td">
					<div class="show-con">
						<%= site.get(3) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">チャネル名:</div>
				<div class="show-td">
					<div class="show-con">
						<%= site.get(4) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">依頼者コード:</div>
				<div class="show-td">
					<div class="show-con">
						<%= site.get(5) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">依頼者名:</div>
				<div class="show-td">
					<div class="show-con">
						<%= site.get(6) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">郵便番号:</div>
				<div class="show-td">
					<div class="show-con">
						<%= site.get(7) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">住所:</div>
				<div class="show-td">
					<div class="show-con">
						<%= site.get(8) %>
						<%= site.get(9) %>
						<%= site.get(10) %>
						<%= site.get(11) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">電話番号1:</div>
				<div class="show-td">
					<div class="show-con">
						<%= site.get(12) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">電話番号2:</div>
				<div class="show-td">
					<div class="show-con">
						<%= site.get(13) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">メールアドレス:</div>
				<div class="show-td">
					<div class="show-con">
						<%= site.get(14) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">金融機関コード:</div>
				<div class="show-td">
					<div class="show-con">
						<%= site.get(15) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">銀行名:</div>
				<div class="show-td">
					<div class="show-con">
						<% if (!site.get(16).isEmpty()) { %>
							<%= site.get(16) %>
							銀行
						<% } %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">支店コード:</div>
				<div class="show-td">
					<div class="show-con">
						<%= site.get(17) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">銀行支店名:</div>
				<div class="show-td">
					<div class="show-con">
						<%= site.get(18) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">口座区分:</div>
				<div class="show-td">
					<div class="show-con">
						<% if (site.get(19).equals("1")) { %>
							普通
						<% } else if (site.get(19).equals("2")) { %>
							当座
						<% } else if (site.get(19).equals("3")) { %>
							総合
						<% } %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">口座番号:</div>
				<div class="show-td">
					<div class="show-con">
						<%= site.get(20) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">口座名義人:</div>
				<div class="show-td">
					<div class="show-con">
						<%= site.get(21) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">ユーザーID:</div>
				<div class="show-td">
					<div class="show-con">
						<%= site.get(22) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">パスワード:</div>
				<div class="show-td">
					<div class="show-con">
						<% for (int i = 0; i < site.get(23).length(); i++){ %>
							●
						<% } %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">金額:</div>
				<div class="show-td">
					<div class="show-con">
						<%= site.get(24) %>円
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">サイト新規使用停止日:</div>
				<div class="show-td">
					<div class="show-con">
						<%= site.get(25) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">青葉ギフト宛メールアドレス:</div>
				<div class="show-td">
					<div class="show-con">
						<%= site.get(26) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">コメント:</div>
				<div class="show-td">
					<div class="show-con">
						<%= site.get(27) %>
					</div>
				</div>
			</div>
			
			<div class="show-tr">
				<div class="show-th">入力日時:</div>
				<div class="show-td">
					<div class="show-con">
						<%= site.get(28) %>
					</div>
				</div>
			</div>
		</div>
		
		<div class="show_buttons">
			<form action="<%= request.getContextPath() %>/delete/site?id=<%= site.get(0) %>" method="post">
				<input type="submit" id="submit_btn" class="button" value="削除">
			</form>
			<a href="<%= request.getContextPath() %>/edit/site?id=<%= site.get(0) %>" class="button">編集</a>
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
