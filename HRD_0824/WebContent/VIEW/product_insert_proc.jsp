<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%@ include file="conn.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	String productid = request.getParameter("productid");
	String name = request.getParameter("name");
	String unitprice = request.getParameter("unitprice");
	String description = request.getParameter("description");
	String category = request.getParameter("category");
	String manufacturer = request.getParameter("manufacturer");
	String unitsinstock = request.getParameter("unitsinstock");
	String condition = request.getParameter("condition");	

	PreparedStatement pstmt = null;
	String sql = "";
	
	try{
		sql = "INSERT INTO product0824 VALUES(?,?,?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, productid);
		pstmt.setString(2, name);
		pstmt.setInt(3, Integer.parseInt(unitprice));
		pstmt.setString(4, description);
		pstmt.setString(5, category);
		pstmt.setString(6, manufacturer);
		pstmt.setInt(7, Integer.parseInt(unitsinstock));
		pstmt.setString(8, condition);
		pstmt.executeUpdate();
	}catch(Exception e){
		System.out.println("DB INSERT FAIL");
		System.out.println("SQL Exception:" + e.getMessage());
	}finally{
		if(pstmt != null)
			pstmt.close();
		if(conn != null)
			conn.close();
	}
%>
<script>
	alert("상품 등록 완료");
	location.href = "index.jsp";
</script>