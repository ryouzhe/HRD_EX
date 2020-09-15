<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%@ include file="conn.jsp" %>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	int cnt = 0;

	try {
		sql = "SELECT COUNT(*) FROM product0824";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		if(rs.next()){
			cnt = rs.getInt(1);
		}
		
		sql = "SELECT productid, name, unitprice, unitsinstock FROM product0824";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
	} catch (Exception e) {
		System.out.println("DB SELECT FAIL");
		System.out.println("SQL:" + e.getMessage());
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="style.css">
<title>주문정보등록</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="nav.jsp"></jsp:include>
	<div class="section">
		<table style="width:100%; text-align:center;">
			<tr>
				<td><h3>주문정보 등록</h3></td>
			</tr>
		</table>
		<hr>
		<form name="fname" method="post" action="order_insert_proc.jsp">
			<table class="table_form" style="width:70%;">
				<tr>
					<td class="td_form" style="width:20%;"><b>주문일자</b></td>
					<td class="td_form" style="width:20%; text-align:left;"><input type="text" name="orderdate" size="20"></td>
					<td class="td_form" style="width:20%;"><b>주문자 이름</b></td>
					<td class="td_form" style="width:40%; text-align:left;"><input type="text" name="ordername" size="30"></td>
				</tr>
				<tr>
					<td class="td_form" style="width:20%;"><b>상품코드</b></td>
					<td class="td_form" style="width:20%; text-align:left;"><input type="text" name="productid" size="20" onchange="javascript:check_id()"></td>
					<td class="td_form" style="width:20%;"><b>상품영</b></td>
					<td class="td_form" style="width:40%; text-align:left;"><input type="text" name="productname" size="30"></td>
				</tr>
				<tr>
					<td class="td_form" style="width:20%;"><b>단가</b></td>
					<td class="td_form" style="width:20%; text-align:left;"><input type="text" name="unitprice" size="20"></td>
					<td class="td_form" style="width:20%;"><b>주문수량</b></td>
					<td class="td_form" style="width:40%; text-align:left;"><input type="text" name="orderqty" size="30" onchange="javascript:check_qty()"></td>
				</tr>
				<tr>
					<td class="td_form" style="width:20%;"><b>주문금액</b></td>
					<td class="td_form" style="width:20%; text-align:left;"><input type="text" name="totalprice" size="20"></td>
					<td class="td_form" style="width:20%;"><b>주문주소</b></td>
					<td class="td_form" style="width:40%; text-align:left;"><input type="text" name="orderaddress" size="50"></td>
				</tr>
				<tr>
					<td class="td_form" style="height:50px;" colspan="4">
						<input class="button1" type="button" value="목록">
						<input class="button1" type="button" value="저장" onclick="javascript:on_check()">
					</td>
				</tr>
			</table>
		</form>
		<hr>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
<script>
	var p_id = new Array();
	var p_name = new Array();
	var p_price = new Array();
	var p_stock = new Array();
	var i = 0;
	
	<%while(rs.next()){%>
		p_id[i] = "<%=rs.getString(1)%>";
		p_name[i] = "<%=rs.getString(2)%>";
		p_price[i] = <%=rs.getInt(3)%>;
		p_stock[i] = <%=rs.getInt(4)%>;
		i++;
	<%}%>
	function check_id(){
		var pid = document.fname.productid.value;
		for(i=0; i<<%=cnt%>; i++){
			if(pid == p_id[i]){
				document.fname.productname.value = p_name[i];
				document.fname.unitprice.value = p_price[i];
				return;
			}
		}
		alert("등록이 되지 않은 코드입니다.");
		document.fname.productid.value = "";
		document.fname.productname.value = "";
		document.fname.unitprice.value = "";
	}
	function check_qty(){
		var qty = parseInt(document.fname.orderqty.value);
		if(qty > p_stock[i]){
			alert("주문 수량이 재고 수량보다 많습니다.");
			document.fname.orderqty.value = "";
		}
		else{
			document.fname.totalprice.value = p_price[i]*qty;
		}
	}
	function on_check(){
		if(document.fname.orderdate.value == ""){
			alert("주문일자를 입력하세요.");
			document.fname.orderdate.focus();
		}
		else if(document.fname.ordername.value == ""){
			alert("주문자 이름을 입력하세요.");
			document.fname.ordername.focus();
		}
		else if(document.fname.productid.value == ""){
			alert("상품 코드를 입력하세요.");
			document.fname.productid.focus();
		}
		else if(document.fname.orderqty.value == ""){
			alert("주문수량을 입력하세요.");
			document.fname.orderqty.focus();
		}
		else if(document.fname.orderaddress.value == ""){
			alert("주문 주소를 입력하세요.");
			document.fname.orderaddress.focus();
		}
		else
			document.fname.submit();
	}
</script>
</html>