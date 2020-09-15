<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%@ include file="conn.jsp" %>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	int max_id = 0;	
	
	try{
		sql = "SELECT MAX(id) FROM member0824";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		if(rs.next()){
			max_id = rs.getInt(1);
			max_id++;
		}
	}catch(Exception e){
		System.out.println("DB SELECT FAIL");
		System.out.println("SQL Exception:" + e.getMessage());
	}finally{
		if(pstmt != null)
			pstmt.close();
		if(rs != null)
			rs.close();
		if(conn != null)
			conn.close();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="style.css">
<title>회원가입</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="nav.jsp"></jsp:include>
	<div class="section">
		<table style="width: 100%;height: 10%;text-align: center;">
			<tr>
				<td><h3>회원 가입 등록 화면</h3></td>
			</tr>
		</table>
		<hr>
		<form name="fname" method="post" action="member_insert_proc.jsp">
			<table class="table_form" style="width: 60%;">
				<tr>
					<td class="td_form" style="width: 30%;"><b>아이디</b></td>
					<td class="td_form" style="text-align: left;"><input type="text" name="id" size="40">(마지막 번호+1)</td>
				</tr>
				<tr>
					<td class="td_form" style="width: 30%;"><b>성명</b></td>
					<td class="td_form" style="text-align: left;"><input type="text" name="name" size="40"></td>
				</tr>
				<tr>
					<td class="td_form" style="width: 30%;"><b>비밀번호</b></td>
					<td class="td_form" style="text-align: left;"><input type="password" name="password" size="40"></td>
				</tr>
				<tr>
					<td class="td_form" style="width: 30%;"><b>비밀번호확인</b></td>
					<td class="td_form" style="text-align: left;"><input type="password" name="pwd_check" size="40" onchange="javascript:pw_check()"></td>
				</tr>
				<tr>
					<td class="td_form" style="width: 30%;"><b>성별</b></td>
					<td class="td_form" style="text-align: left;">
						<input type="radio" name="gender" value="남성">남성
						<input type="radio" name="gender" value="여성">여성
					</td>
				</tr>
				<tr>
					<td class="td_form" style="width: 30%;"><b>생일</b></td>
					<td class="td_form" style="text-align: left;">
						<input type="number" name="YY" min="1920" max="2020" value="2000" step="1" onchange="javascript:check_year()">년
						<select name="MM" onchange="javascript:check_month()">
						<%for(int i=1; i<=12; i++){ %>
							<option value="<%=i %>"><%=i %></option>
						<%} %>
						</select>월
						<select id="DAY" name="DD">
							<option>-</option>
						</select>일
					</td>
				</tr>
				<tr>
					<td class="td_form" style="width: 30%;"><b>이메일</b></td>
					<td class="td_form" style="text-align: left;">
						<input type="text" name="mail_addr" size="20">@
						<input type="text" name="domain_addr" size="20" disabled>
						<select name="domain" onchange="javascript:select_domain()">
							<option value="1">선택하세요</option>
							<option value="2">직접입력</option>
							<option value="3">naver.com</option>
							<option value="4">hanmail.net</option>
							<option value="5">gmail.com</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="td_form" style="width: 30%;"><b>연락처</b></td>
					<td class="td_form" style="text-align: left;"><input type="text" name="phone" size="40"></td>
				</tr>
				<tr>
					<td class="td_form" style="width: 30%;"><b>주소</b></td>
					<td class="td_form" style="text-align: left;"><input type="text" name="address" size="60"></td>
				</tr>
				<tr>
					<td class="td_form" colspan="2">
						<input class="button1" type="button" value="등록" onclick="javascript:on_check()">
						<input class="button1" type="button" value="취소" onclick="javascript:page_move()">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
<script>
	var next_id = "<%=max_id%>";
	document.fname.id.value = next_id;
	
	var year_flag = 1;
	var month_flag = 0;
	
	function check_year(){
		if(parseInt(document.fname.YY.value)%4 == 0)
			year_flag = 1;
		else
			year_flag = 0;
	}
	function check_month(){
		if(parseInt(document.fname.MM.value)%2 == 0)
			month_flag = 1;
		else
			month_flag = 0;
		add_DD(year_flag, month_flag);
	}
	function add_DD(yy,mm){
		var day_select = document.getElementById("DAY");
		day_select.options.length = 0;
		
		if(yy == 0 && mm == 0){
			for(var i=0; i<=30; i++){
				var opt = document.createElement("option");
				opt.setAttribute("value", i+1);
				opt.setAttribute("label", i+1);
				day_select.appendChild(opt);
			}
		}
		else if(yy == 0 && mm == 1){
			if(document.fname.MM.value == "2"){
				for(var i=0; i<=28; i++){
					var opt = document.createElement("option");
					opt.setAttribute("value", i+1);
					opt.setAttribute("label", i+1);
					day_select.appendChild(opt);
				}
			}
			else{
				for(var i=0; i<=29; i++){
					var opt = document.createElement("option");
					opt.setAttribute("value", i+1);
					opt.setAttribute("label", i+1);
					day_select.appendChild(opt);
				}
			}
		}
		else if(yy == 1 && mm == 0){
			for(var i=0; i<=30; i++){
				var opt = document.createElement("option");
				opt.setAttribute("value", i+1);
				opt.setAttribute("label", i+1);
				day_select.appendChild(opt);
			}
		}
		else if(yy == 1 && mm == 1){
			if(document.fname.MM.value == "2"){
				for(var i=0; i<=27; i++){
					var opt = document.createElement("option");
					opt.setAttribute("value", i+1);
					opt.setAttribute("label", i+1);
					day_select.appendChild(opt);
				}
			}
			else{
				for(var i=0; i<=29; i++){
					var opt = document.createElement("option");
					opt.setAttribute("value", i+1);
					opt.setAttribute("label", i+1);
					day_select.appendChild(opt);
				}
			}
		}
	}
	function select_domain(){
		if(document.fname.domain.value == 2){
			document.fname.domain_addr.disabled = false;
			document.fname.domain_addr.value = "";
			document.fname.domain_addr.focus();
		}
		else if(document.fname.domain.value == 3){
			document.fname.domain_addr.disabled = false;
			document.fname.domain_addr.value = "naver.com";
		}
		else if(document.fname.domain.value == 4){
			document.fname.domain_addr.disabled = false;
			document.fname.domain_addr.value = "hanmail.net";
		}
		else if(document.fname.domain.value == 5){
			document.fname.domain_addr.disabled = false;
			document.fname.domain_addr.value = "gmail.com";
		}
	}
	function pw_check(){
		var pw = document.fname.password.value;
		if(pw != document.fname.pwd_check.value){
			alert("비밀번호가 일치하지 않습니다.");
			document.fname.pwd_check.value = "";
		}
	}
	function on_check(){
		if(document.fname.id.value == ""){
			alert("아이디를 입력하세요.");
			document.fname.id.focus();
		}
		else if(document.fname.name.value == ""){
			alert("이름을 입력하세요.");
			document.fname.name.focus();
		}
		else if(document.fname.password.value == ""){
			alert("비밀번호를 입력하세요.");
			document.fname.password.focus();
		}
		else if(document.fname.pwd_check.value == ""){
			alert("비밀번호 확인을 입력하세요.");
			document.fname.pwd_check.focus();
		}
		else if(document.fname.gender.value == ""){
			alert("성별을 선택하세요.");
			document.fname.gender.focus();
		}
		else{
			document.fname.submit();
		}
	}
	function page_move(){
		location.href = "index.jsp";
	}
</script>
</html>