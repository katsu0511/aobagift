<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<Map<String, String>> poinfs = (ArrayList<Map<String, String>>)request.getAttribute("poinfs"); %>
<% ArrayList<Map<String, String>> gifts = (ArrayList<Map<String, String>>)request.getAttribute("gifts"); %>
<main>
	<div class="container">
		<h2>チケット情報照会</h2>
		<form name="SEARCH_FORM">
			<div class="tr">
				<label for="pocd" class="th">注文コード：</label>
				<div class="td">
					<select id="pocd" name="POCD" required autofocus>
						<option value="ALL">すべて</option>
<%	for (Map<String, String> poinf : poinfs) { %>
						<option value=<%= poinf.get("pocd") %>><%= poinf.get("pocd") %></option>
<% } %>
					</select>
					<p id="pocd_error" class="error"></p>
					<p id="pocd_error2" class="error"></p>
				</div>
			</div>
			<div class="tr">
				<label for="giftid" class="th">ギフトＩＤ：</label>
				<div class="td">
					<select id="giftid" name="GIFTID" required autofocus>
						<option value="ALL">すべて</option>
<%	for (Map<String, String> gift : gifts) { %>
						<option value=<%= gift.get("giftid") %>><%= gift.get("giftid") %></option>
<% } %>
					</select>
					<p id="giftid_error" class="error"></p>
					<p id="giftid_error2" class="error"></p>
				</div>
			</div>
			<div class="tr">
				<label class="th">交換状態：</label>
				<div class="td">
					<div><label for="excg_stat1" class="middle_size"><input type="radio" class="middle_size" id="excg_stat1" name="EXCG_STAT" value="0" checked>全て</label>　　<label for="excg_stat2" class="middle_size"><input type="radio" class="middle_size" id="excg_stat2" name="EXCG_STAT" value="1">未交換</label>　　<label for="excg_stat3" class="middle_size"><input type="radio" class="middle_size" id="excg_stat3" name="EXCG_STAT" value="2">交換済</label></div>
					<div>交換期間：<input type="date" class="middle_size" name="EXCG_BEGIN"> 〜 <input type="date" class="middle_size" name="EXCG_END"></div>
				</div>
			</div>
			<div class="tr">
				<label for="pocd" class="th">有効期限：</label>
				<div class="td">
					<div><input type="date" class="middle_size" name="PERIOD_BEGIN"> 〜 <input type="date" class="middle_size" name="PERIOD_END"></div>
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
function changeExchangeStatusList(evt) {
	if (evt.target.value === "2") {
		document.SEARCH_FORM.EXCG_BEGIN.disabled = false;
		document.SEARCH_FORM.EXCG_END.disabled = false;
	}
	else {
		document.SEARCH_FORM.EXCG_BEGIN.value = "";
		document.SEARCH_FORM.EXCG_END.value = "";
		document.SEARCH_FORM.EXCG_BEGIN.disabled = true;
		document.SEARCH_FORM.EXCG_END.disabled = true;
	}
}
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
		form.action = "/aobagift/show/ticket_info";
		form.method = "get";
		form.submit();
	}
}
function load() {
	document.SEARCH_FORM.EXCG_BEGIN.disabled = true;
	document.SEARCH_FORM.EXCG_END.disabled = true;
	document.getElementsByName("EXCG_STAT").forEach((elm)=>{
		elm.addEventListener("change",changeExchangeStatusList);
	});
}
window.onload = load;
//-->
</script>
<jsp:include page="../common/footer.jsp" flush="true"/>
