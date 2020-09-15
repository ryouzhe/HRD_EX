<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<%@ include file="conn.jsp"%>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	int cnt = 0;
	int no = 1;
	try {
		sql = "SELECT COUNT(*) FROM product0824";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			cnt = rs.getInt(1);
		}

		sql = "SELECT * FROM product0824";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
	} catch (Exception e) {
		System.out.println("DB SELECT FAIL");
		System.out.println("SQL Exception:" + e.getMessage());
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="style.css">
<title>main</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="nav.jsp"></jsp:include>
	<div class="section">
		<table style="width: 100%; height: 10%; text-align: center;">
			<tr>
				<td><h3>상품 목록</h3></td>
			</tr>
		</table>
		<table style="width: 90%; text-align: left;">
			<tr>
				<td>총 <%=cnt%>개의 상품이 있습니다.
				</td>
			</tr>
		</table>
		<hr>
		<table class="table_form" style="width: 90%;">
			<tr>
				<td class="td_form"><b>no</b></td>
				<td class="td_form"><b>제품코드</b></td>
				<td class="td_form"><b>제품명</b></td>
				<td class="td_form"><b>단가</b></td>
				<td class="td_form"><b>상세정보</b></td>
				<td class="td_form"><b>제조사</b></td>
				<td class="td_form"><b>분류</b></td>
				<td class="td_form"><b>재고수</b></td>
				<td class="td_form"><b>상태</b></td>
				<td class="td_form"><b>구분</b></td>
			</tr>
			<%while(rs.next()){ %>
			<tr>
				<td class="td_form"><%=no %></td>
				<td class="td_form"><%=rs.getString(1) %></td>
				<td class="td_form"><%=rs.getString(2) %></td>
				<td class="td_form"><%=rs.getInt(3) %></td>
				<td class="td_form"><%=rs.getString(4) %></td>
				<td class="td_form"><%=rs.getString(6) %></td>
				<td class="td_form"><%=rs.getString(5) %></td>
				<td class="td_form"><%=rs.getInt(7) %></td>
				<td class="td_form"><%=rs.getString(8) %></td>
				<td class="td_form"><a href="#">수정</a>/<a href="#">수정</a></td>
			</tr>
			<%no++;} %>
		</table>
		<table style="width: 90%; text-align: center;">
			<tr>
				<td><input class="button1" type="button" value="작성" onclick="javascript:page_move()"></td>
			</tr>
		</table>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
<%
	if (pstmt != null)
		pstmt.close();
	if (rs != null)
		rs.close();
	if (conn != null)
		conn.close();
%>
<script>
	function page_move(){
		location.href = "product_insert.jsp";
	}
</script>
</html>