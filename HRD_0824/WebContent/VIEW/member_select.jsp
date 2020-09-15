<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<%@ include file="conn.jsp"%>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	int cnt = 0;

	try {
		sql = "SELECT COUNT(*) FROM member0824";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			cnt = rs.getInt(1);
		}

		sql = "SELECT id, password, name, gender, birth, mail, phone, address, TO_CHAR(timestamp,'YYYY-MM-DD') FROM member0824";
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
				<td><h3>회원 목록</h3></td>
			</tr>
		</table>
		<table style="width: 90%; text-align: left;">
			<tr>
				<td>총 <%=cnt%>명의 회원이 있습니다.
				</td>
			</tr>
		</table>
		<hr>
		<table class="table_form" style="width: 90%;">
			<tr>
				<td class="td_form"><b>아이디</b></td>
				<td class="td_form"><b>성명</b></td>
				<td class="td_form"><b>비밀번호</b></td>
				<td class="td_form"><b>성별</b></td>
				<td class="td_form"><b>생년월일</b></td>
				<td class="td_form"><b>이메일</b></td>
				<td class="td_form"><b>연락처</b></td>
				<td class="td_form"><b>주소</b></td>
				<td class="td_form"><b>입력일</b></td>
				<td class="td_form"><b>구분</b></td>
			</tr>
			<%while(rs.next()){ %>
			<tr>
				<td class="td_form"><%=rs.getInt(1) %></td>
				<td class="td_form"><%=rs.getString(3) %></td>
				<td class="td_form"><%=rs.getString(2) %></td>
				<td class="td_form"><%=rs.getString(4) %></td>
				<td class="td_form"><%=rs.getString(5) %></td>
				<td class="td_form"><%=rs.getString(6) %></td>
				<td class="td_form"><%=rs.getString(7) %></td>
				<td class="td_form"><%=rs.getString(8) %></td>
				<td class="td_form"><%=rs.getString(9) %></td>
				<td class="td_form"><a href="#">수정</a>/<a href="#">수정</a></td>
			</tr>
			<%} %>
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
		location.href = "member_insert.jsp";
	}
</script>
</html>