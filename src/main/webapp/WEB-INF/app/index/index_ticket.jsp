<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<main>
	<div class="container">
		<h2>編集するチケット情報を検索</h2>
		<form name="SEARCH_FORM">
			<div class="tr">
				<label for="tcktcd" class="th">チケットコード：</label>
				<div class="td">
					<input type="text" id="tcktcd" class="check_target" name="TCKTCD" required autofocus>
					<p id="tcktcd_error" class="error">チケットコードを入力してください</p>
					<p id="tcktcd_error2" class="error"></p>
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
		form.action = "/aobagift/edit/ticket";
		form.method = "get";
		form.submit();
	}
}
//-->
</script>
<jsp:include page="../common/footer.jsp" flush="true"/>
