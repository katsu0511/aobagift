<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<String> gftckt = (ArrayList<String>)request.getAttribute("gftckt"); %>
<main>
	<div class="container">
<% if (gftckt.isEmpty()) { %>
		<div class="no-display">チケットコードに該当するチケット情報がありません。</div>
		<div class="show_buttons">
			<button type="button" class="button" onclick="location.href='<%= request.getContextPath() %>/index/ticket'">戻る</button>
		</div>
<% } else { %>
		<h2>チケット情報編集</h2>
		<form id="gftckt" action="<%= request.getContextPath() %>/edit/ticket" method="POST">
			<div class="tr">
				<label for="tcktcd" class="th">チケットコード：</label>
				<div class="td">
					<input type="text" id="tcktcd" class="back-gray" name="TCKTCD" value="<%= gftckt.get(0) %>" readonly>
				</div>
			</div>
			<div class="tr">
				<label for="status_before" class="th">変更前ステータス：</label>
				<div class="td"><input type="text" id="status_before" class="back-gray" value="<% if (gftckt.get(1).equals("0")) { %>未使用<% } else {%>使用済<% } %>" readonly></div>
			</div>
			<div class="tr">
				<label for="status_after" class="th">変更後ステータス：</label>
				<div class="td">
					<select id="status_after" class="short" name="STATUS">
						<option value="0" <% if (gftckt.get(1).equals("0")) { %> selected <% } %>>未使用</option>
						<option value="1" <% if (gftckt.get(1).equals("1")) { %> selected <% } %>>使用済</option>
					</select>
					<p id="status_after_error" class="error">変更していません</p>
					<p id="status_after_error2" class="error"></p>
				</div>
			</div>
			<div class="register_buttons">
				<input type="submit" id="submit" class="button" name="submit" value="保存" form="gftckt">
				<button type="button" class="button" onclick="location.href='<%= request.getContextPath() %>/index/ticket'">戻る</button>
			</div>
		</form>
<% } %>
	</div>
</main>
<script type="text/javascript">
<!--
function load() {
	addEventListener("submit",function(evt) {
		let elmErr1 = document.getElementById("status_after_error");
		let elmErr2 = document.getElementById("status_after_error2");
		elmErr1.style.display = "none";
		elmErr2.style.display = "none";

		let elm1 = document.getElementById("status_before");
		let elm2 = document.getElementById("status_after");
		if (elm1.value === elm2.options[elm2.selectedIndex].text) {
			evt.preventDefault();
			elmErr1.style.display = "block";
		}
		else {
			alert("チケット情報を変更しました。");
		}
	});
}
window.onload = load;
//-->
</script>
<jsp:include page="../common/footer.jsp" flush="true"/>
