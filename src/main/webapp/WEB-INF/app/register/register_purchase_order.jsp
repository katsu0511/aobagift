<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<Map<String,String>> mhgms = (ArrayList<Map<String,String>>)request.getAttribute("mhgms"); %>
<% ArrayList<Map<String,String>> pcinfs = (ArrayList<Map<String,String>>)request.getAttribute("pcinfs"); %>
<%
String mhgmJsonStr = "";
for (Map<String, String> mhgm : mhgms) {
	mhgmJsonStr += "\"" + mhgm.get("giftid") + "\":{\"giftpr\":\"" + mhgm.get("giftpr") + "\",\"siteid\":\"" + mhgm.get("siteid") + "\"},";
}
if (!mhgmJsonStr.isEmpty()) mhgmJsonStr = mhgmJsonStr.substring(0,mhgmJsonStr.length()-1);
mhgmJsonStr = "{"+mhgmJsonStr+"}";
%>
<main>
	<div class="container">
		<h2>ギフト注文入力</h2>
		<form name="PURCHASE">
			<div class="tr">
				<label for="pocode" class="th">注文コード:</label>
				<div class="td">
					<input type="text" id="pocode" name="POCODE" class="back-gray" value="<%= request.getAttribute("POCD") %>" readonly>
				</div>
			</div>
			<div class="tr">
				<label for="giftid" class="th">ギフトID:</label>
				<div class="td">
					<select id="giftid" class="check_target" name="GIFTID" required>
						<option value="">選択してください</option>
<%	for (Map<String, String> mhgm : mhgms) { %>
						<option value=<%= mhgm.get("giftid") %>><%= mhgm.get("giftid") %>（<%= mhgm.get("giftpr") %>円）</option>
<% } %>
					</select>
					<input type="hidden" id="amount" name="AMOUNT" value="">
					<p id="giftid_error" class="error">ギフトIDを入力してください</p>
					<p id="giftid_error2" class="error"></p>
				</div>
			</div>
			<div class="tr">
				<label for="siteid" class="th">サイトID:</label>
				<div class="td">
					<input type="text" id="siteiddsp" class="back-gray" value="サイト無し" readonly>
					<input type="hidden" id="siteid" name="SITEID" value="">
					<p id="siteid_error" class="error"></p>
					<p id="siteid_error2" class="error"></p>
				</div>
			</div>
			<div class="tr">
				<label for="pccode" class="th">購入者:</label>
				<div class="td">
					<select id="pccode" class="check_target" name="PCCODE" required>
						<option value="">選択してください</option>
<%	for (Map<String, String> pcinf : pcinfs) { %>
						<option value=<%= pcinf.get("pccd") %>><%= pcinf.get("pccd") %> <%= pcinf.get("corpnm") %></option>
<% } %>
					</select>
					<p id="pccode_error" class="error">購入者コードを入力してください</p>
					<p id="pccode_error2" class="error"></p>
				</div>
			</div>
			<div class="tr">
				<label for="period" class="th">有効期限:</label>
				<div class="td">
					<input type="date" id="period" name="PERIOD" class="check_target" required>
					<p id="period_error" class="error">年月日を入力してください</p>
					<p id="period_error2" class="error"></p>
				</div>
			</div>
			<div class="tr">
				<label for="tcktnum" class="th">チケット発行数:</label>
				<div class="td">
					<input type="text" id="tcktnum" name="TCKTNUM" class="check_target" maxlength="6" pattern="^[1-9]{1}[0-9]{0,5}$" required>
					<p id="tcktnum_error" class="error">チケット発行数を入力してください</p>
					<p id="tcktnum_error2" class="error">1 〜 999,999までの数字を入力してください</p>
				</div>
			</div>
			<div class="register_buttons">
				<input type="button" class="submit_btn button" name="ORDER" value="注文" onclick="purchaseOrder();">
				<button type="button" class="button" onclick="location.href='<%= request.getContextPath() %>/index/purchase'">戻る</button>
			</div>
		</form>
	</div>
</main>
<script type="text/javascript">
<!--
window.onload = function() {
	const elmGiftId = document.getElementById("giftid");
	const elmAmount = document.getElementById("amount");
	const elmSiteId = document.getElementById("siteid");
	const elmSiteIdDsp = document.getElementById("siteiddsp");
	let siteList = <%= mhgmJsonStr %>;
	elmGiftId.addEventListener("change",(event)=>{
		if (siteList[event.target.value]) {
			elmAmount.value = siteList[event.target.value].giftpr;
			elmSiteId.value = siteList[event.target.value].siteid;
			elmSiteIdDsp.value = siteList[event.target.value].siteid || "サイト無し";
		}
		else {
			elmAmount.value = "";
			elmSiteId.value = "";
			elmSiteIdDsp.value = "サイト無し";
		}
	});

	const elmPeriod = document.getElementById("period");
	let date = new Date();
	date.setDate(date.getDate()+90);
	let yyyy = date.getFullYear();
	let MM = ("0"+(date.getMonth()+1)).slice(-2);
	let dd = ("0"+date.getDate()).slice(-2);
	elmPeriod.value = yyyy+"-"+MM+"-"+dd;
}
function purchaseOrder() {
	let has_error = false;
	let elmList = document.PURCHASE.getElementsByClassName("check_target");
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
	if (!has_error && confirm('注文を確定します。\nよろしいですか？')) {
		let baseUrl = window.location.protocol + "//" + window.location.host + "/"
		let url = baseUrl + "gec/api/CreateTicket";
		let queryStr=
			 "POCODE="+document.PURCHASE.POCODE.value
			+"&GIFTID="+document.PURCHASE.GIFTID.value
			+"&SITEID="+document.PURCHASE.SITEID.value
			+"&PCCODE="+document.PURCHASE.PCCODE.value
			+"&AMOUNT="+document.PURCHASE.AMOUNT.value
			+"&PERIOD="+document.PURCHASE.PERIOD.value
			+"&TCKTNUM="+document.PURCHASE.TCKTNUM.value
			+"";
		let req = new XMLHttpRequest();
		req.open('POST',url);
		req.setRequestHeader('content-type','application/x-www-form-urlencoded;charset=UTF-8');
		req.responseType = "blob";
		req.send(queryStr);
		req.onload = function() {
			if (req.status !== 200) {
				alert("ギフト注文でエラーが発生しました。");
				return;
			}
			try {
				let blob = this.response;
				let fileName = "ticket_list.txt";
				if (window.navigator.msSaveBlob) {
					window.navigator.msSaveBlob(blob,fileName);
				}
				else {
					let url = URL.createObjectURL(blob);
					let link = document.createElement("a");
					document.body.appendChild(link);
					link.href = url;
					link.download = fileName;
					link.click();
					document.body.removeChild(link);
				}
				req.onload = "";
				req = "";
				alert("ギフト注文が完了しました。");
				location.href='/index/purchase';
			}
			catch (err) {
				alert("ギフトチケット一覧のダウンロードに失敗しました。");
			}
		}
	}
	return false;
}
//-->
</script>
<jsp:include page="../common/footer.jsp" flush="true"/>
