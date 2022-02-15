<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<Map<String, String>> poinfs = (ArrayList<Map<String, String>>)request.getAttribute("poinfs"); %>
<main>
	<div class="container">
		<h2>チケット交換履歴照会</h2>
		<form name="SEARCH_FORM">
			<div class="tr">
				<label for="pocd" class="th">注文コード:</label>
				<div class="td">
					<select id="pocd" class="check_target" name="POCD" required autofocus>
						<option value="">選択してください</option>
<%	for (Map<String, String> poinf : poinfs) { %>
						<option value=<%= poinf.get("pocd") %>><%= poinf.get("pocd") %></option>
<% } %>
					</select>
					<p id="pocd_error" class="error">注文コードを入力してください</p>
					<p id="pocd_error2" class="error"></p>
				</div>
			</div>
			<div class="register_buttons">
				<input type="button" class="submit_btn button" name="SEARCH" value="検索" onclick="searchData();">
				<button type="button" class="button" onclick="location.href='<%= request.getContextPath() %>/index/purchase'">戻る</button>
			</div>
		</form>
	</div>
</main>
<script type="text/javascript">
<!--
function searchData() {
	let has_error = false;
	let form = document.SEARCH_FORM;
	let elmList = form.getElementsByClassName("check_target");
	for (let elm of elmList) {
		let elmErr1 = document.getElementById(elm.id+"_error");
		let elmErr2 = document.getElementById(elm.id+"_error2");
		elmErr1.style.display = "none";
		elmErr2.style.display = "none";
		if (elm.validity.valueMissing) {
			elmErr1.style.display = "block";
			has_error = true;
		}
		else if (elm.validity.patternMismatch) {
			elmErr2.style.display = "block";
			has_error = true;
		}
	}
	if (!has_error) {
		form.action = "/aobagift/show/exchange_history";
		form.method = "get";
		form.submit();
	}
}
//-->
</script>
<jsp:include page="../common/footer.jsp" flush="true"/>
