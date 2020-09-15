<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="style.css">
<title>상품등록</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="nav.jsp"></jsp:include>
	<div class="section">
		<table style="width: 100%;height: 10%;text-align: center;">
			<tr>
				<td><h3>상품 등록 화면</h3></td>
			</tr>
		</table>
		<hr>
		<form name="fname" method="post" action="product_insert_proc.jsp">
			<table class="table_form" style="width: 60%;">
				<tr>
					<td class="td_form" style="width: 30%;"><b>상품코드</b></td>
					<td class="td_form" style="text-align: left;"><input type="text" name="productid" size="40"></td>
				</tr>
				<tr>
					<td class="td_form" style="width: 30%;"><b>상품명</b></td>
					<td class="td_form" style="text-align: left;"><input type="text" name="name" size="40" onchange="javascript:check_name()"></td>
				</tr>
				<tr>
					<td class="td_form" style="width: 30%;"><b>가격</b></td>
					<td class="td_form" style="text-align: left;"><input type="text" name="unitprice" size="40" onchange="javascript:check_price()"></td>
				</tr>
				<tr>
					<td class="td_form" style="width: 30%;"><b>상세정보</b></td>
					<td class="td_form" style="text-align: left;"><input type="text" name="description" size="40"></td>
				</tr>
				<tr>
					<td class="td_form" style="width: 30%;"><b>제조사</b></td>
					<td class="td_form" style="text-align: left;"><input type="text" name="manufacturer" size="40"></td>
				</tr>
				<tr>
					<td class="td_form" style="width: 30%;"><b>분류</b></td>
					<td class="td_form" style="text-align: left;"><input type="text" name="category" size="40"></td>
				</tr>
				<tr>
					<td class="td_form" style="width: 30%;"><b>재고수</b></td>
					<td class="td_form" style="text-align: left;"><input type="text" name="unitsinstock" size="40"></td>
				</tr>
				<tr>
					<td class="td_form" style="width: 30%;"><b>상태</b></td>
					<td class="td_form" style="text-align: left;">
						<input type="radio" name="condition" value="신규제품">신구제품
						<input type="radio" name="condition" value="중고제품">중고제품
						<input type="radio" name="condition" value="재생제품">재생제품
					</td>
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
	function check_name(){
		var product_name = document.fname.name.value;
		if((product_name.length<4) || (product_name.length>50)){
			alert("[상품명]\n최소 4자에서 최대 50자까지 입력하세요.");
			document.fname.name.value = "";
			document.fname.name.focus();
		}
	}
	function check_price(){
		var price = document.fname.unitprice.value;
		if(isNaN(document.fname.unitprice.value)){
			alert("[가격]\n숫자만 입력하세요.");
			document.fname.unitprice.value = "";
			document.fname.unitprice.focus();
		}
		else if(price[0] == "-"){
			alert("[가격]\n음수를 입력할 수 없습니다.");
			document.fname.unitprice.value = "";
			document.fname.unitprice.focus();
		}
	}
	function on_check(){
		if(document.fname.productid.value == ""){
			alert("상품코드를 입력하세요.");
			document.fname.productid.focus();
		}
		else if(document.fname.name.value == ""){
			alert("상품명을 입력하세요.");
			document.fname.name.focus();
		}
		else if(document.fname.unitprice.value == ""){
			alert("가격를 입력하세요.");
			document.fname.unitprice.focus();
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