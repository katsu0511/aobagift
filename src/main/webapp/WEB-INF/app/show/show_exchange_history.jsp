<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*,java.util.*,java.text.*" %>
<jsp:include page="../common/header.jsp" flush="true"/>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<Map<String, String>> exchsts = (ArrayList<Map<String, String>>)request.getAttribute("exchsts"); %>
<main>
	<div class="container">


<% if (exchsts.isEmpty()) { %>
		<div class="no-display">注文コードに該当するチケットがありません。</div>
<% } else { %>
		<div class="display-title">
			<h2>チケット交換履歴一覧</h2>
		</div>
		<div class="display">
			<div class="display-thead">
				<div class="display-th" style="width:15%;">交換ID</div>
				<div class="display-th" style="width:20%;">チケットコード</div>
				<div class="display-th" style="width:15%;">交換方法</div>
				<div class="display-th" style="width:15%;">ショップコード</div>
				<div class="display-th" style="width:15%;">交換商品コード</div>
				<div class="display-th" style="width:20%;">交換日時</div>
			</div>
<%   for (Map<String, String> exchst : exchsts) { %>
			<div class="display-tbody">
				<div class="display-td" style="width:15%;"><%= exchst.get("excid") %></div>
				<div class="display-td" style="width:20%;"><%= exchst.get("tcktcd") %></div>
				<div class="display-td" style="width:15%;"><% out.print(("1".equals(exchst.get("excmthd")))?"ショップ交換":("2".equals(exchst.get("excmthd")))?"ネット交換":"不明"); %></div>
				<div class="display-td" style="width:15%;"><%= exchst.get("shopcd") %></div>
				<div class="display-td" style="width:15%;"><%= exchst.get("merccd") %></div>
				<div class="display-td" style="width:20%;"><%= exchst.get("excdt").replaceAll("([0-9]+)-([0-9]+)-([0-9]+) ([0-9]+):([0-9]+):([0-9]+)","$1年$2月$3日 $4時$5分$6秒") %></div>
			</div>
<%   } %>
		</div>
<% } %>
		<div class="show_buttons">
			<button type="button" class="button" onclick="history.back()">戻る</button>
		</div>
	</div>
</main>
<script type="text/javascript">
</script>
<jsp:include page="../common/footer.jsp" flush="true"/>
