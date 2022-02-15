<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<String> merc = (ArrayList<String>)request.getAttribute("merc"); %>

<main>
	<div class="container">
		
		<h2>商品編集</h2>
		
		<form id="MHMM" action="<%= request.getContextPath() %>/edit/merc" method="POST" enctype="multipart/form-data">
		
			<div class="tr">
				<label for="merc_code" class="th">商品コード:</label>
				<div class="td">
					<input type="text" id="merc_code" class="back-gray" name="merc_code"
							value="<%= merc.get(0) %>" readonly>
				</div>
			</div>
			
			<div class="tr">
				<label for="merc_name" class="th">商品名:<span>*</span></label>
				<div class="td">
					<input type="text" id="merc_name" name="merc_name" value="<%= merc.get(2) %>" required>
					<p id="merc_name_error1" class="error">商品名を入力してください</p>
				</div>
			</div>
			
			<div class="tr">
				<label for="merc_logo" class="th">商品画像:</label>
				<div class="td">
					<input type="file" id="merc_logo" name="merc_logo">
				</div>
			</div>

			<div class="tr">
				<label for="comment" class="th">コメント:</label>
				<div class="td">
					<textarea id="comment" name="comment"><%= merc.get(4) %></textarea>
				</div>
			</div>
			
			<div class="register_buttons">
				<input type="submit" id="submit" class="button" name="submit" value="保存" form="MHMM">
				<button type="button" class="button" onclick="history.back()">キャンセル</button>
			</div>
			
		</form>
	</div>
</main>

<script type="text/javascript">
$(function() {
	const submit = $('#submit');
	const mercName = $('#merc_name');
	const mercNameError1 = $('#merc_name_error1');
	
	submit.click(function() {
		if (mercName.val() == '') {
			mercNameError1.css('display','block');
		} else {
			mercNameError1.css('display','none');
		}
		
		if (mercName.val() == '') {
			mercName.focus();
		} else {
			if (!confirm('送信しますか？')) {
				return false;
			}
		}
	});
});
</script>
	
<jsp:include page="../common/footer.jsp" flush="true"/>
