<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<%
ArrayList<Map<String, String>> tickets = (ArrayList<Map<String, String>>)request.getAttribute("tickets");
ArrayList<Map<String, String>> payments = (ArrayList<Map<String, String>>)request.getAttribute("payments");
%>
<main>
	<div class="container">
<% if (tickets.isEmpty()) { %>
		<div class="no-display">検索条件に該当するチケット情報がありません。</div>
<% } else { %>
		<div class="display-title">
			<h2>チケット情報一覧</h2>
		</div>
		<div class="add-button">
			<a class="button" href="javascript:outputCsv('table2','支払情報一覧.csv');">チケット照会・出力・メンテ</a>
			<a type="button" class="button" href="javascript:outputCsv('table1','チケット情報一覧.csv');">納品データ照会・出力</a>
		</div>
		<div id="table1" class="display">
			<div class="display-thead">
				<div class="display-th" style="width:12%;font-size:1rem;">チケットコード</div>
				<div class="display-th" style="width:8%;font-size:1rem;">使用状況</div>
				<div class="display-th" style="width:10%;font-size:1rem;">交換方法</div>
				<div class="display-th" style="width:11%;font-size:1rem;">ショップコード</div>
				<div class="display-th" style="width:11%;font-size:1rem;">交換商品コード</div>
				<div class="display-th" style="width:14%;font-size:1rem;">交換日時</div>
				<div class="display-th" style="width:14%;font-size:1rem;">有効期限</div>
				<div class="display-th" style="width:20%;font-size:1rem;">チケットURL</div>
			</div>
<%   for (Map<String, String> ticket : tickets) { %>
			<div class="display-tbody">
				<div class="display-td" style="width:12%;font-size:1rem;"><%= ticket.get("tcktcd") %></div>
				<div class="display-td" style="width:8%;font-size:1rem;"><% String status=ticket.getOrDefault("status","0");out.print(("0".equals(status))?"未使用":"使用済み"); %></div>
				<div class="display-td" style="width:10%;font-size:1rem;"><% out.print(("1".equals(ticket.get("excmthd")))?"ショップ交換":("2".equals(ticket.get("excmthd")))?"ネット交換":("3".equals(ticket.get("excmthd")))?"管理者変更":"未交換"); %></div>
				<div class="display-td" style="width:11%;font-size:1rem;"><% out.print(("0".equals(status))?"":ticket.getOrDefault("shopcd","不明")); %></div>
				<div class="display-td" style="width:11%;font-size:1rem;"><% out.print(("0".equals(status))?"":ticket.getOrDefault("merccd","不明")); %></div>
				<div class="display-td" style="width:14%;font-size:1rem;"><% out.print(("0".equals(status))?"":ticket.getOrDefault("excdt","不明").replaceAll("([0-9]+)-([0-9]+)-([0-9]+) ([0-9]+):([0-9]+):([0-9]+)","$1年$2月$3日<br>$4時$5分$6秒")); %></div>
				<div class="display-td" style="width:14%;font-size:1rem;"><%= ticket.getOrDefault("vlddt","不明").replaceAll("([0-9]+)-([0-9]+)-([0-9]+)","$1年$2月$3日") %></div>
				<div class="display-td" style="width:20%;font-size:1rem;"><input type="text" value="<%= ticket.getOrDefault("url","不明") %>" style="width:-webkit-fill-available;height:calc(100% - 6px);font-size:inherit;" readonly></div>
			</div>
<%   } %>
		</div>
		<br>
		<div id="table2" class="display" style="display:none;">
			<div class="display-thead">
				<div class="display-th" style="font-size:1.2rem;">チケットコード</div>
				<div class="display-th" style="font-size:1.2rem;">購入者コード</div>
				<div class="display-th" style="font-size:1.2rem;">法人名</div>
				<div class="display-th" style="font-size:1.2rem;">ギフトID</div>
				<div class="display-th" style="font-size:1.2rem;">ポイント</div>
				<div class="display-th" style="font-size:1.2rem;">ギフト名称</div>
				<div class="display-th" style="font-size:1.2rem;">有効期限</div>
				<div class="display-th" style="font-size:1.2rem;">ギフト作成依頼者</div>
				<div class="display-th" style="font-size:1.2rem;">交換日時</div>
				<div class="display-th" style="font-size:1.2rem;">交換方法</div>
				<div class="display-th" style="font-size:1.2rem;">ショップコード</div>
				<div class="display-th" style="font-size:1.2rem;">支払区分</div>
				<div class="display-th" style="font-size:1.2rem;">支払先名</div>
				<div class="display-th" style="font-size:1.2rem;">銀行</div>
				<div class="display-th" style="font-size:1.2rem;">支店</div>
				<div class="display-th" style="font-size:1.2rem;">種別</div>
				<div class="display-th" style="font-size:1.2rem;">口座番号</div>
			</div>
<%   for (Map<String, String> payment : payments) { %>
			<div class="display-tbody">
				<div class="display-td" style="font-size:1.2rem;"><%= payment.getOrDefault("tcktcd","不明") %></div>
				<div class="display-td" style="font-size:1.2rem;"><%= payment.getOrDefault("pccd","不明") %></div>
				<div class="display-td" style="font-size:1.2rem;"><%= payment.getOrDefault("corpnm","不明") %></div>
				<div class="display-td" style="font-size:1.2rem;"><%= payment.getOrDefault("giftid","不明") %></div>
				<div class="display-td" style="font-size:1.2rem;"><%= payment.getOrDefault("giftpr","不明") %></div>
				<div class="display-td" style="font-size:1.2rem;"><%= payment.getOrDefault("giftnm","不明") %></div>
				<div class="display-td" style="font-size:1.2rem;"><%= payment.getOrDefault("vlddt","不明").replaceAll("([0-9]+)-([0-9]+)-([0-9]+)","$1年$2月$3日") %></div>
				<div class="display-td" style="font-size:1.2rem;"><%= payment.getOrDefault("chnlnm","不明") %></div>
				<div class="display-td" style="font-size:1.2rem;"><%= payment.getOrDefault("excdt","不明").replaceAll("([0-9]+)-([0-9]+)-([0-9]+) ([0-9]+):([0-9]+):([0-9]+)","$1年$2月$3日<br>$4時$5分$6秒") %></div>
				<div class="display-td" style="font-size:1.2rem;"><%= ("1".equals(payment.get("excmthd")))?"ショップ交換":("2".equals(payment.get("excmthd")))?"ネット交換":("3".equals(payment.get("excmthd")))?"管理者変更":"未交換" %></div>
				<div class="display-td" style="font-size:1.2rem;"><%= payment.getOrDefault("shopcd","不明") %></div>
				<div class="display-td" style="font-size:1.2rem;"><% int payety = Integer.parseInt(payment.getOrDefault("payety","0"));out.print((payety==1)?"ギフト作成依頼者":((payety==2)?"サイト作成依頼者":((payety==3)?"交換施設・店舗":"支払対象外")));%></div>
				<div class="display-td" style="font-size:1.2rem;"><%= payment.getOrDefault("paynm","不明") %></div>
				<div class="display-td" style="font-size:1.2rem;"><%= ("".equals(payment.get("banknm")))?"未登録":payment.get("banknm") %></div>
				<div class="display-td" style="font-size:1.2rem;"><%= ("".equals(payment.get("bankbr")))?"未登録":payment.get("bankbr") %></div>
				<div class="display-td" style="font-size:1.2rem;"><%= ("1".equals(payment.get("acntty")))?"普通":("2".equals(payment.get("acntty")))?"当座":("3".equals(payment.get("acntty")))?"総合":"未登録" %></div>
				<div class="display-td" style="font-size:1.2rem;"><%= ("".equals(payment.get("acntnu")))?"未登録":payment.get("acntnu") %></div>
			</div>
<%   } %>
		</div>
<% } %>
		<div class="show_buttons">
			<button type="button" class="button" onclick="location.href='<%= request.getContextPath() %>/index/ticket_info'">戻る</button>
		</div>
	</div>
</main>
<script type="text/javascript">
function outputCsv(table,fileName) {
	let buf="";
	let targetTable = document.getElementById(table);

	// ヘッダ部構築
	let header = targetTable.getElementsByClassName("display-thead")[0].children;
	let cntHead,maxHead;
	for (cntHead=0,maxHead=header.length; cntHead<maxHead; cntHead++) {
		buf += "\"" + header[cntHead].innerText + "\",";
	}
	if (cntHead>0) {
		buf = buf.slice(0,-1) + "\n";
	}

	// データ部構築
	let rows = targetTable.getElementsByClassName("display-tbody");
	let cntRows,maxCols;
	for (cntRows=0,maxRows=rows.length; cntRows<maxRows; cntRows++) {
		let cols = rows[cntRows].children;
		let cntCols;
		for (cntCols=0,maxCols=cols.length; cntCols<maxCols; cntCols++) {
			if (cols[cntCols].firstElementChild && cols[cntCols].firstElementChild.tagName.toLowerCase()==="input") {
				buf += "\"" + cols[cntCols].firstElementChild.value + "\",";
			}
			else {
				buf += "\"" + cols[cntCols].innerText + "\",";
			}
		}
		if (cntCols>0) {
			buf = buf.slice(0,-1) + "\n";
		}
	}
	// ダウンロード出力
	fileDownload(buf,fileName);
}
function fileDownload(buf,fileName) {
	// BOM（Excelでの文字化け対策）
	const bom = new Uint8Array([0xef,0xbb,0xbf]);

	// Blobでデータを作成
	const blob = new Blob([bom,buf],{type:"text/csv"});

	// IE10/11用(download属性が機能しないためmsSaveBlobを使用）
	if (window.navigator.msSaveBlob) {
		window.navigator.msSaveBlob(blob,fileName);
	}
	// その他ブラウザ（内部でダウンロードリンクを作成しクリックイベントを発生させてダウンロードを実行する）
	else {
		const url = (window.URL || window.webkitURL).createObjectURL(blob);
		const download = document.createElement("a");
		download.href = url;
		download.download = fileName;
		download.click();
		(window.URL || window.webkitURL).revokeObjectURL(url);
	}
}
</script>
<jsp:include page="../common/footer.jsp" flush="true"/>
