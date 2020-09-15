<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%@ include file="conn.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	String orderdate = request.getParameter("orderdate");
	String ordername = request.getParameter("ordername");
	String productid = request.getParameter("productid");
	String productname = request.getParameter("productname");
	String unitprice = request.getParameter("unitprice");
	String orderqty = request.getParameter("orderqty");
	String totalprice = request.getParameter("totalprice");
	String orderaddress = request.getParameter("orderaddress");	
	int stock = 0;
	int	qty = Integer.parseInt(orderqty);
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";	
	
	try{
		sql = "INSERT INTO order0824 VALUES(?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, orderdate);
		pstmt.setString(2, ordername);
		pstmt.setString(3, productid);
		pstmt.setInt(4, Integer.parseInt(unitprice));
		pstmt.setInt(5, Integer.parseInt(orderqty));
		pstmt.setString(6, orderaddress);
		pstmt.executeUpdate();
		pstmt.close();
		
		sql = "SELECT unitsinstock FROM product0824 WHERE productid=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, productid);
		rs = pstmt.executeQuery();
		if(rs.next()){
			stock = rs.getInt(1);
		}
		
		sql = "UPDATE product0824 SET unitsinstock=? WHERE productid=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, stock-qty);
		pstmt.setString(2, productid);
		pstmt.executeUpdate();
	}catch(Exception e){
		System.out.println("DB INSERT FAIL");
		System.out.println("SQL Exception:" + e.getMessage());
	}finally{
		if(rs != null)
			rs.close();
		if(pstmt != null)
			pstmt.close();
		if(conn != null)
			conn.close();
	}
%>
<script>
	alert("주문 등록 완료");
	location.href = "index.jsp";
</script>